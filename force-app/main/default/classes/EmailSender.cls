// Class for sending message to Lead, related to Quote__c
public with sharing class EmailSender {
    @AuraEnabled(cacheable=true)
    public static String sendEmail(String quoteId){

        Quote__c quoteFields = [SELECT Name, Lead__c FROM Quote__c WHERE Id = :quoteID];
        Lead leadFields = [SELECT LastName, Email FROM Lead WHERE Id = :quoteFields.Lead__c];
        List<Quote_Line__c> relatedProducts = QuoteDataProcessing.relatedProducts(quoteId);

        // Only one email is to be sent
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{leadFields.Email});
        mail.setBccAddresses(new String[]{leadFields.Email});
        mail.setBccSender(true);

        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Quote details');

        // Generating html with quote details
        mail.setHtmlBody(generateHtmlBody(quoteID, quoteFields.Name, leadFields.LastName, relatedProducts));
        Messaging.SendEmailResult [] resultList = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

        if(resultList[0].isSuccess()){
            return 'Email was successfully sent.';
        }
        else {
            List<Messaging.SendEmailError> errorList = resultList[0].getErrors();
            return errorList[0].getMessage();
        }
    }

    // Method generates string with html template showing quote details, related products and total quote price
    @AuraEnabled(cacheable=true)
    public static string generateHtmlBody(String quoteID, String quoteName, String leadLastName, List<Quote_Line__c> relatedProducts){

        String htmlBody = '<h1>Here are your quote details in html format:</h1><br/>' +
                          '<h2>Quote name:'+quoteName+'</h2><br/>'+
                          '<h2>Lead name:'+leadLastName+'</h2><br/><br/>'+
                          '<table border="1">'+
                          '<caption>Products in quote table</caption>'+
                          '<tr>'+
                          '<th>Name</th>'+
                          '<th>Amount</th>'+
                          '<th>Price</th>'+
                          '</tr>';
  
        // Table with related products details
        for(Quote_Line__c ql: relatedProducts){
            htmlBody += '<tr><td>'+ql.Product__r.Name+'</td><td>'+ql.Amount__c+'</td><td>'+ql.Product__r.Price__c+'</td></tr>';
        }

        htmlBody += '</table><br/><br/>';
        htmlBody += '<h2>Total quote price:'+QuoteDataProcessing.countTotalPrice(quoteId)+'</h2><br/>';
        return htmlBody;
    }
}
