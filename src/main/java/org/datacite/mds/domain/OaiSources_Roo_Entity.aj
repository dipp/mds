// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.datacite.mds.domain;

import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.datacite.mds.domain.OaiSources;
import org.springframework.transaction.annotation.Transactional;

privileged aspect OaiSources_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager OaiSources.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long OaiSources.id;
    
    @Version
    @Column(name = "version")
    private Integer OaiSources.version;
    
    public Long OaiSources.getId() {
        return this.id;
    }
    
    public void OaiSources.setId(Long id) {
        this.id = id;
    }
    
    public Integer OaiSources.getVersion() {
        return this.version;
    }
    
    public void OaiSources.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void OaiSources.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void OaiSources.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            OaiSources attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void OaiSources.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public OaiSources OaiSources.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        OaiSources merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager OaiSources.entityManager() {
        EntityManager em = new OaiSources().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long OaiSources.countOaiSourceses() {
        return entityManager().createQuery("select count(o) from OaiSources o", Long.class).getSingleResult();
    }
    
    public static List<OaiSources> OaiSources.findAllOaiSourceses() {
        return entityManager().createQuery("select o from OaiSources o", OaiSources.class).getResultList();
    }
    
    public static OaiSources OaiSources.findOaiSources(Long id) {
        if (id == null) return null;
        return entityManager().find(OaiSources.class, id);
    }
    
    public static List<OaiSources> OaiSources.findOaiSourcesEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from OaiSources o", OaiSources.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
