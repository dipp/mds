package org.datacite.mds.web.ui.controller;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.datacite.mds.domain.AllocatorOrDatacentre;
import org.datacite.mds.service.MagicAuthStringService;
import org.datacite.mds.util.Utils;
import org.datacite.mds.util.ValidationUtils;
import org.datacite.mds.web.ui.model.ChangePasswordModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/resources/change_password")
@Controller
public class ChangePasswordController {
    
    Logger log4j = Logger.getLogger(ChangePasswordController.class);

    @Autowired
    private MagicAuthStringService magicAuthStringService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @RequestMapping(method = RequestMethod.GET)
    public String createForm(@RequestParam(value = "symbol", required = true) String symbol,
            @RequestParam(value = "auth", required = true) String auth, Model model) {
        AllocatorOrDatacentre user = Utils.findAllocatorOrDatacentreBySymbol(symbol);
        if (!magicAuthStringService.isValidAuthString(user, auth)) {
            return "password/expired";
        }
        model.addAttribute("password", new ChangePasswordModel());
        return "password/change";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String changePassword(@ModelAttribute("password") @Valid ChangePasswordModel changePasswordModel,
            BindingResult result, @RequestParam(value = "symbol", required = true) String symbol,
            @RequestParam(value = "auth", required = true) String auth, Model model) {
        AllocatorOrDatacentre user = Utils.findAllocatorOrDatacentreBySymbol(symbol);
        if (!magicAuthStringService.isValidAuthString(user, auth)) {
            return "password/expired";
        }
        if (result.hasErrors()) {
            model.addAttribute("password", changePasswordModel);
            ValidationUtils.copyFieldErrorToObject(result, "equal");
            log4j.debug("form has error: password not changed");
            return "password/change";
        }
        
        user.setPassword(passwordEncoder.encodePassword(changePasswordModel.getFirst(),null));
        user.merge();
        log4j.debug("password succesfully changed for '" + symbol + "'");
        
        return "password/success";
    }
}
