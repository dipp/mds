package org.datacite.mds.validation.constraints.impl;

import java.util.Arrays;
import java.util.List;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.datacite.mds.domain.Allocator;
import org.datacite.mds.domain.Datacentre;
import org.datacite.mds.validation.constraints.Symbol;
import org.datacite.mds.validation.constraints.Symbol.Type;

public class SymbolValidator implements ConstraintValidator<Symbol, String> {

    List<Type> types;
    boolean hasToExist;

    public void initialize(Symbol constraintAnnotation) {
        types = Arrays.asList(constraintAnnotation.value());
        hasToExist = constraintAnnotation.hasToExist();
    }

    public boolean isValid(String symbol, ConstraintValidatorContext context) {
        context.disableDefaultConstraintViolation();
        if (hasToExist) {
            return exists(symbol, context);
        } else {
            return !isMalformed(symbol, context);
        }
    }

    public boolean isMalformed(String symbol, ConstraintValidatorContext context) {
        for (Type t : types) {
            if (Symbol.PATTERNS.get(t).matcher(symbol).matches()) {
                return false;
            } else {
                String message = "{org.datacite.mds.validation.constraints.Symbol." + t.name() + ".message}";
                context.buildConstraintViolationWithTemplate(message).addConstraintViolation();
            }
        }
        return true;
    }

    public boolean exists(String symbol, ConstraintValidatorContext context) {
        if (types.contains(Type.ALLOCATOR)) {
            if (Allocator.findAllocatorsBySymbolEquals(symbol).getResultList().size() > 0) {
                return true;
            }
        }
        if (types.contains(Type.DATACENTRE)) {
            if (Datacentre.findDatacentresBySymbolEquals(symbol).getResultList().size() > 0) {
                return true;
            }
        }

        context.buildConstraintViolationWithTemplate("{org.datacite.mds.validation.constraints.Symbol.notfound}")
                .addConstraintViolation();
        return false;
    }
}