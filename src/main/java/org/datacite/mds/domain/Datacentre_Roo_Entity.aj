// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.datacite.mds.domain;

import java.lang.Integer;
import java.lang.Long;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.datacite.mds.domain.Datacentre;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Datacentre_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Datacentre.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Datacentre.id;
    
    @Version
    @Column(name = "version")
    private Integer Datacentre.version;
    
    public Long Datacentre.getId() {
        return this.id;
    }
    
    public void Datacentre.setId(Long id) {
        this.id = id;
    }
    
    public Integer Datacentre.getVersion() {
        return this.version;
    }
    
    public void Datacentre.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Datacentre.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Datacentre.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Datacentre attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Datacentre.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public Datacentre Datacentre.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Datacentre merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager Datacentre.entityManager() {
        EntityManager em = new Datacentre().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Datacentre.countDatacentres() {
        return ((Number) entityManager().createQuery("select count(o) from Datacentre o").getSingleResult()).longValue();
    }
    
    public static Datacentre Datacentre.findDatacentre(Long id) {
        if (id == null) return null;
        return entityManager().find(Datacentre.class, id);
    }
    
}
