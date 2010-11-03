// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.datacite.mds.web;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.datacite.mds.domain.Allocator;
import org.datacite.mds.domain.Datacentre;
import org.datacite.mds.domain.Prefix;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect DatacentreController_Roo_Controller {
    
    @Autowired
    private GenericConversionService DatacentreController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String DatacentreController.create(@Valid Datacentre datacentre, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("datacentre", datacentre);
            addDateTimeFormatPatterns(model);
            return "datacentres/create";
        }
        datacentre.persist();
        return "redirect:/datacentres/" + encodeUrlPathSegment(datacentre.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String DatacentreController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("datacentre", Datacentre.findDatacentre(id));
        model.addAttribute("itemId", id);
        return "datacentres/show";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String DatacentreController.update(@Valid Datacentre datacentre, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("datacentre", datacentre);
            addDateTimeFormatPatterns(model);
            return "datacentres/update";
        }
        datacentre.merge();
        return "redirect:/datacentres/" + encodeUrlPathSegment(datacentre.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String DatacentreController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("datacentre", Datacentre.findDatacentre(id));
        addDateTimeFormatPatterns(model);
        return "datacentres/update";
    }
    
    @RequestMapping(params = { "find=BySymbolEquals", "form" }, method = RequestMethod.GET)
    public String DatacentreController.findDatacentresBySymbolEqualsForm(Model model) {
        return "datacentres/findDatacentresBySymbolEquals";
    }
    
    @RequestMapping(params = "find=BySymbolEquals", method = RequestMethod.GET)
    public String DatacentreController.findDatacentresBySymbolEquals(@RequestParam("symbol") String symbol, Model model) {
        model.addAttribute("datacentres", Datacentre.findDatacentresBySymbolEquals(symbol).getResultList());
        return "datacentres/list";
    }
    
    @RequestMapping(params = { "find=ByNameLike", "form" }, method = RequestMethod.GET)
    public String DatacentreController.findDatacentresByNameLikeForm(Model model) {
        return "datacentres/findDatacentresByNameLike";
    }
    
    @RequestMapping(params = "find=ByNameLike", method = RequestMethod.GET)
    public String DatacentreController.findDatacentresByNameLike(@RequestParam("name") String name, Model model) {
        model.addAttribute("datacentres", Datacentre.findDatacentresByNameLike(name).getResultList());
        return "datacentres/list";
    }
    
    @ModelAttribute("allocators")
    public Collection<Allocator> DatacentreController.populateAllocators() {
        return Allocator.findAllAllocators();
    }
    
    void DatacentreController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("datacentre_created_date_format", DateTimeFormat.patternForStyle("FF", LocaleContextHolder.getLocale()));
        model.addAttribute("datacentre_updated_date_format", DateTimeFormat.patternForStyle("FF", LocaleContextHolder.getLocale()));
    }
    
    private String DatacentreController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
