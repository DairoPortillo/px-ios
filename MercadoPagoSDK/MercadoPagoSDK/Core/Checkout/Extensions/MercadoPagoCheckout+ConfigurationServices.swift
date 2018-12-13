//
//  MercadoPagoCheckout+ConfigurationServices.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 10/12/18.
//

import Foundation


extension MercadoPagoCheckout {
    
    func getPayerCostsConfiguration() {
        viewModel.pxNavigationHandler.presentLoading()
        
        guard let paymentMethod = self.viewModel.paymentData.getPaymentMethod() else {
            return
        }
        
        let bin = self.viewModel.cardToken?.getBin()
        
        var diffPricingString: String? = nil
        if let differentialPricing = self.viewModel.checkoutPreference.differentialPricing?.id {
            diffPricingString = String(describing: differentialPricing)
        }
        self.viewModel.mercadoPagoServicesAdapter.getSummaryAmount(bin: bin, amount: self.viewModel.amountHelper.amountToPay, issuer: self.viewModel.paymentData.getIssuer(), paymentMethodId: paymentMethod.id, payment_type_id: paymentMethod.paymentTypeId, differentialPricingId: diffPricingString, site: self.viewModel.checkoutPreference.site,  marketplace: self.viewModel.checkoutPreference.marketplace, discountParamsConfiguration: self.viewModel.getAdvancedConfiguration().discountParamsConfiguration, payer: self.viewModel.checkoutPreference.payer, defaultInstallments: self.viewModel.checkoutPreference.getDefaultInstallments(), callback: { [weak self] (summaryAmount) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.viewModel.payerCosts = summaryAmount.selectedAmountConfiguration.payerCostConfiguration?.payerCosts
            if let discountConfig = summaryAmount.selectedAmountConfiguration.discountConfiguration {
                strongSelf.viewModel.setDiscount(discountConfig)
            }
            //else{
            //    strongSelf.viewModel.clearDiscount()
           // }
            if let payerCosts = strongSelf.viewModel.payerCosts {
                let defaultPayerCost = strongSelf.viewModel.checkoutPreference.paymentPreference.autoSelectPayerCost(payerCosts)
                if let defaultPC = defaultPayerCost {
                    strongSelf.viewModel.updateCheckoutModel(payerCost: defaultPC)
                }
            }
            
            
            if let defaultPC = summaryAmount.selectedAmountConfiguration.payerCostConfiguration?.selectedPayerCost {
                strongSelf.viewModel.updateCheckoutModel(payerCost: defaultPC)
            }
            
            
            
            strongSelf.executeNextStep()

            
            }, failure: {[weak self] (error) in
                
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.viewModel.errorInputs(error: MPSDKError.convertFrom(error, requestOrigin: ApiUtil.RequestOrigin.GET_INSTALLMENTS.rawValue), errorCallback: { [weak self] () in
                    self?.getPayerCostsConfiguration()
                })
                strongSelf.executeNextStep()
                
        })
    }

}
