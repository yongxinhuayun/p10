package com.efeiyi.ec.master.model;

import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by zhao on 2016/10/9.
 * 关联MasterWork&&Product
 */
@Entity
@Table(name = "master_work_product")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterWorkProduct implements Serializable{
    private String id;
    private MasterWork masterWork;
    private Product product;
    private String status;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_work_id")
    public MasterWork getMasterWork() {
        return masterWork;
    }

    public void setMasterWork(MasterWork masterWork) {
        this.masterWork = masterWork;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "MasterWorkProduct{" +
                "id='" + id + '\'' +
                '}';
    }
}
