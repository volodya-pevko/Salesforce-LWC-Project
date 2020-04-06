public with sharing class QuoteDataProcessing {

    @AuraEnabled(cacheable=true)
    public static Double countTotalPrice(String quoteId){

        List<Quote_Line__c> amountsAndPrices = [SELECT Product__r.Price__c, Amount__c FROM Quote_Line__c WHERE Quote__c = :quoteId];

        Double totalPrice = 0;
        for(Quote_Line__c ql: amountsAndPrices){
            totalPrice += ql.Amount__c * ql.Product__r.Price__c;
        }

        return totalPrice;
    }

    @AuraEnabled(cacheable=true)
    public static List<Quote_Line__c> relatedProducts(String quoteId){
        
        return [SELECT Product__r.Name, Product__r.Price__c, Amount__c FROM Quote_Line__c WHERE Quote__c = :quoteId];
    }
}
