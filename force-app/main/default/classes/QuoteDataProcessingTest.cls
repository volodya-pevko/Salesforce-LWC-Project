@isTest
private with sharing class QuoteDataProcessingTest {

    // Creating one Quote with 2 QuoteLines and 2 Products
    @testSetup static void setup() {

        Quote__c testQuote = new Quote__c(Name = 'TestQuote');
        insert testQuote;       

        List<Product2> testProducts = new List<Product2>();
        for(Integer i=0;i<2;i++) {
            testProducts.add(new Product2(Name = 'TestProduct'+i, Price__c = 3));          
        }
        insert testProducts;

        List<Quote_Line__c> testQuoteLines = new List<Quote_Line__c>();
        for(Integer i=0;i<2;i++) {
            testQuoteLines.add(new Quote_Line__c(Name = 'TestQuoteLine'+i, Quote__c = testQuote.Id, Product__c = testProducts[i].Id, Amount__c = 2));
        }
        insert testQuoteLines;
    }
        
    @isTest static void testForOneQuote() {

        Test.startTest();
        Double res = QuoteDataProcessing.countTotalPrice([SELECT Id FROM Quote__c WHERE Name='TestQuote' LIMIT 1].Id);
        Test.stopTest();

        System.assertEquals(12, res);
    }

    @isTest static void testRelatedProducts(){

        Test.startTest();
        List<Quote_Line__c> relatedQLs = QuoteDataProcessing.relatedProducts([SELECT Id FROM Quote__c WHERE Name='TestQuote' LIMIT 1].Id);
        Test.stopTest();
        
        System.assertEquals('TestProduct0', relatedQLs[0].Product__r.Name);
        System.assertEquals(3, relatedQLs[1].Product__r.Price__c);
        System.assertEquals(2, relatedQLs[0].Amount__c);
    }
}
