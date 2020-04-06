@isTest
public with sharing class EmailSenderTest {
    @TestSetup
    static void setup(){

        Lead lead = new Lead(LastName='Test Lead', Company = 'Company', Email = 'spptestacc@gmail.com');
        insert lead;
        Quote__c quote = new Quote__c(Name = 'Test Quote', Lead__c = lead.Id);
        insert quote;
    }

    // Checking email invocations number
    @isTest static void testRelatedProducts(){

        Test.startTest();
        EmailSender.sendEmail([SELECT Id FROM Quote__c WHERE Name = 'Test Quote'].Id);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        System.assertEquals(1, invocations, 'An email has not been sent');
    }
}
