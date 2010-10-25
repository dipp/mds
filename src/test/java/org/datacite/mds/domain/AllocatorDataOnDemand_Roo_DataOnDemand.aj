// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.datacite.mds.domain;

import java.util.List;
import java.util.Random;
import org.datacite.mds.domain.Allocator;
import org.springframework.stereotype.Component;

privileged aspect AllocatorDataOnDemand_Roo_DataOnDemand {
    
    declare @type: AllocatorDataOnDemand: @Component;
    
    private Random AllocatorDataOnDemand.rnd = new java.security.SecureRandom();
    
    private List<Allocator> AllocatorDataOnDemand.data;
    
    public Allocator AllocatorDataOnDemand.getNewTransientAllocator(int index) {
        org.datacite.mds.domain.Allocator obj = new org.datacite.mds.domain.Allocator();
        obj.setContactEmail("contactEmail_" + index);
        java.lang.String contactName = "contactName_" + index;
        if (contactName.length() > 80) {
            contactName  = contactName.substring(0, 80);
        }
        obj.setContactName(contactName);
        java.lang.Integer doiQuotaAllowed = new Integer(index);
        if (doiQuotaAllowed < 0 || doiQuotaAllowed > 999999999) {
            doiQuotaAllowed = 999999999;
        }
        obj.setDoiQuotaAllowed(doiQuotaAllowed);
        java.lang.Integer doiQuotaUsed = new Integer(index);
        if (doiQuotaUsed < 0 || doiQuotaUsed > 999999999) {
            doiQuotaUsed = 999999999;
        }
        obj.setDoiQuotaUsed(doiQuotaUsed);
        obj.setIsActive(new Boolean(true));
        java.lang.String name = "name_" + index;
        if (name.length() > 255) {
            name  = name.substring(0, 255);
        }
        obj.setName(name);
        java.lang.String password = "password_" + index;
        if (password.length() > 30) {
            password  = password.substring(0, 30);
        }
        obj.setPassword(password);
        obj.setRoleName("roleName_" + index);
        obj.setSymbol("symbol_" + index);
        return obj;
    }
    
    public Allocator AllocatorDataOnDemand.getSpecificAllocator(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size() - 1)) index = data.size() - 1;
        Allocator obj = data.get(index);
        return Allocator.findAllocator(obj.getId());
    }
    
    public Allocator AllocatorDataOnDemand.getRandomAllocator() {
        init();
        Allocator obj = data.get(rnd.nextInt(data.size()));
        return Allocator.findAllocator(obj.getId());
    }
    
    public boolean AllocatorDataOnDemand.modifyAllocator(Allocator obj) {
        return false;
    }
    
    public void AllocatorDataOnDemand.init() {
        data = new java.util.ArrayList<org.datacite.mds.domain.Allocator>();
        for (int i = 0; i < 10; i++) {
            org.datacite.mds.domain.Allocator obj = getNewTransientAllocator(i);
            obj.persist();
            data.add(obj);
        }
    }
    
}
