package com.efeiyi.ec.website.order.service.impl;

import cn.beecloud.BCEumeration;
import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import cn.beecloud.bean.BCPayParameter;
import com.efeiyi.ec.balance.model.BalanceRecord;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.order.service.BalanceManager;
import com.efeiyi.ec.website.order.service.CouponManager;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.PrepaidCardManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/3.
 */
@Service
public class PaymentManagerImpl implements PaymentManager {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Autowired
    private CouponManager couponManager;

    @Autowired
    private BalanceManager balanceManager;

    @Autowired
    private PrepaidCardManager prepaidCardManager;

    static {
        BeeCloud.registerApp("130498c1-8928-433b-a01d-c26420f41818", "49fc6d9c-fd5d-4e9c-9ff6-f2d5ef1a1a3e"); //正式环境
//        BeeCloud.registerApp("e7004ae3-5634-4b9f-998d-c4319fbea7b0", "24511f9a-0b63-4fa0-82c6-6a6ffe38371d");//测试环境
    }

    @Override
    public String alipay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue() * 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.ALI_WEB, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setReturnUrl(PConst.NEWWEBURL + "/order/paysuccess/" + purchaseOrderPaymentDetails.getId());

        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            return bcPayResult.getHtml();
        } else {
            System.out.println(bcPayResult.getErrMsg());
            return "error";
        }
    }


    @Override
    public String alipayWap(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue() * 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.ALI_WAP, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setReturnUrl(PConst.NEWWEBURL + "/order/paysuccess/" + purchaseOrderPaymentDetails.getId());

        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            return bcPayResult.getHtml();
        } else {
            System.out.println(bcPayResult.getErrMsg());
            return "error";
        }
    }

    @Override
    public String alipayWap(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, String returnUrl) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue() * 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.ALI_WAP, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setReturnUrl(PConst.NEWWEBURL + returnUrl);

        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            return bcPayResult.getHtml();
        } else {
            System.out.println(bcPayResult.getErrMsg());
            return "error";
        }
    }

    @Override
    public void payCallback(String purchaseOrderPaymentDetailsId, String transactionNumber) {

        //更新支付记录的交易号
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetailsId);
        purchaseOrderPaymentDetails.setTransactionNumber(transactionNumber);
        //@TODO 修改订单状态
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getId());

        if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
            //同时修改子订单状态
            for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                purchaseOrderTemp.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        }

        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //改变订单状态为待收货状态
        baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
    }


    @Override
    public Object wxpay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount, String openid) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue() * 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.WX_JSAPI, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setOpenId(openid);
        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            JSONObject jsonObject = JSONObject.fromObject(bcPayResult.getWxJSAPIMap());
            return jsonObject;
        } else {
            return null;
        }
    }

    @Override
    public String wxNativePay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue() * 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.WX_NATIVE, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setBillTimeout(120);
        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            String codeUrl = bcPayResult.getCodeUrl();
            return codeUrl;
        } else {
            return bcPayResult.getErrMsg();
        }
    }

    private String getTitle(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails) {
        String title = "";
        if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().size() > 1) {
            title = "e飞蚁-" + purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().get(0).getProductModel().getName() + " " + "等多件";
        } else if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().size() == 1) {
            title = "e飞蚁-" + purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().get(0).getProductModel().getName();
        }
        if (title.length() > 16) {
            title = title.substring(0, 13) + "...";
        }
        return title;
    }

    @Override
    public PurchaseOrderPaymentDetails initPurchaseOrderPayment(PurchaseOrder purchaseOrder) throws Exception {
        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPaymentAmount(purchaseOrder.getTotal());
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        purchaseOrderPayment.setPayWay(purchaseOrder.getPayWay());
        purchaseOrderPayment.setSerial(autoSerialManager.nextSerial("payment"));
        User user = (User) baseManager.getObject(User.class.getName(), AuthorizationUtil.getMyUser().getId());
        purchaseOrderPayment.setUser(user);
        baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
        purchaseOrderPaymentDetails.setMoney(checkOrderTotal(purchaseOrder.getTotal().subtract(calculatePrepaidCardRecord(purchaseOrder.getId()))));
        purchaseOrderPaymentDetails.setPayWay(purchaseOrder.getPayWay());
        purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
        baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        return purchaseOrderPaymentDetails;
    }


    private BigDecimal calculatePrepaidCardRecord(String purchaseOrderId) {
        PrepaidCardRecord prepaidCardRecord = prepaidCardManager.getPrepaidCardRecordByOrderId(purchaseOrderId, PrepaidCardRecord.STATUS_USED);
        if (prepaidCardRecord == null) {
            return BigDecimal.valueOf(0);
        }
        return prepaidCardRecord.getValue();
    }

    private BigDecimal checkOrderTotal(BigDecimal total) {
        if (total.floatValue() > 0) {
            return total;
        } else {
            return BigDecimal.valueOf(0);
        }
    }

    //初始化订单支付，包括支付记录，支付记录详情等
    @Override
    public PurchaseOrderPaymentDetails initPurchaseOrderPayment(PurchaseOrder purchaseOrder, String balance, String couponId) throws Exception {
        Float balance1 = Float.parseFloat(balance);
        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPaymentAmount(purchaseOrder.getTotal());
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        //purchaseOrderPayment.setPayWay(purchaseOrder.getPayWay());
        purchaseOrderPayment.setSerial(autoSerialManager.nextSerial("payment"));
        String userid = AuthorizationUtil.getMyUser().getId();
        User user = (User) baseManager.getObject(User.class.getName(), userid);
        purchaseOrderPayment.setUser(user);
        baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
        //支付详情
        Coupon coupon = null;
        if (null != couponId && !"".equals(couponId)) {
            coupon = couponManager.confirmCoupon(couponId);
            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
            purchaseOrderPaymentDetails.setCoupon(coupon);
            purchaseOrderPaymentDetails.setMoney(new BigDecimal(coupon.getCouponBatch().getPrice()));
            purchaseOrderPaymentDetails.setPayWay(PurchaseOrder.YOUHUIQUAN);
            purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
            baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        }
        if (null != balance1 && balance1 > 0 && balanceManager.checkBalance(balance1)) {
            BalanceRecord balanceRecord = balanceManager.useBalance(balance1);
            balanceRecord.setKey(purchaseOrder.getId());
            baseManager.saveOrUpdate(BalanceRecord.class.getName(), balanceRecord);

            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
            purchaseOrderPaymentDetails.setPayWay(PurchaseOrder.YUE);
            purchaseOrderPaymentDetails.setMoney(new BigDecimal(balance1));
            purchaseOrderPaymentDetails.setCreateDateTime(new Date());
            purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
            baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);

            if (null != couponId && !"".equals(couponId)) {
                int r = new BigDecimal(balance1).compareTo(purchaseOrder.getTotal().subtract(new BigDecimal(coupon.getCouponBatch().getPrice())));
                if (r == 0) {
                    return purchaseOrderPaymentDetails;
                }
            } else {
                int r = new BigDecimal(balance1).compareTo(purchaseOrder.getTotal());
                if (r == 0) {
                    return purchaseOrderPaymentDetails;
                }
            }
        }
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
        if (null != couponId && !"".equals(couponId)) {
            if (balance1 > 0) {
                purchaseOrderPaymentDetails.setMoney((purchaseOrder.getTotal().subtract(new BigDecimal(coupon.getCouponBatch().getPrice()))).subtract(new BigDecimal(balance)));
            } else {
                purchaseOrderPaymentDetails.setMoney(purchaseOrder.getTotal().subtract(new BigDecimal(coupon.getCouponBatch().getPrice())));
            }
        } else {
            if (balance1 > 0) {
                purchaseOrderPaymentDetails.setMoney(purchaseOrder.getTotal().subtract(new BigDecimal(balance)));
            } else {
                purchaseOrderPaymentDetails.setMoney(purchaseOrder.getTotal());
            }
        }
        purchaseOrderPaymentDetails.setPayWay(purchaseOrder.getPayWay()
        );
        purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
        baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        return purchaseOrderPaymentDetails;
    }
}
