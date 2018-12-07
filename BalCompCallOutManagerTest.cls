/*************************************************************************************
*   Class               :       BalCompCallOutManagerTest                            *
*   Created Date        :       19/11/2018                                           *           
*   Description         :       Test class for BalCompCallOutManager                 *
*************************************************************************************/
@istest
// This is GIT checking
private class BalCompCallOutManagerTest {    
    
    @istest
    static void testBalCompCallOutGet(){
	    string methodStr = 'GET';
	    String param = '?service_id=XXXX&access_key=XXXX&operator_kbn=2&easy_id=788745874587';
	    String className = 'BalCompMyPage';
	    String apiNo = '208020';        
        try{            

            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(250);             
            res.setBody('Test');            
            mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208020';
	        bcApi.Api_Url__c='applicationStatusMockGet';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();

        } catch(Exception e) {
            
        }   
    }    
 
     @istest
    static void testBalCompCallOutGet_403(){
	    string methodStr = 'GET';
	    String param = '?service_id=XXXX&access_key=XXXX&operator_kbn=2&easy_id=788745874587';
	    String className = 'BalCompMyPage';
	    String apiNo = '208020';        
        try{            

            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(403);             
            res.setBody('Test');            
            mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208020';
	        bcApi.Api_Url__c='applicationStatusMockGet';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();

        } catch(Exception e) {
            
        }   
    }
    
    @istest
    static void testBalCompCallOutGet_503(){
	    string methodStr = 'GET';
	    String param = '?service_id=XXXX&access_key=XXXX&operator_kbn=2&easy_id=788745874587';
	    String className = 'BalCompMyPage';
	    String apiNo = '208020';        
        try{            

            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(503);             
            res.setBody('Test');            
            mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208020';
	        bcApi.Api_Url__c='applicationStatusMockGet';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();

        } catch(Exception e) {
            
        }   
    }          


    @istest
    static void testBalCompCallOutGet_400(){
	    string methodStr = 'GET';
	    String param = '?service_id=XXXX&access_key=XXXX&operator_kbn=2&easy_id=788745874587';
	    String className = 'BalCompMyPage';
	    String apiNo = '208020';        
        try{            

            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(400);             
            res.setBody('Test');            
            mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208020';
	        bcApi.Api_Url__c='applicationStatusMockGet';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();

        } catch(Exception e) {
            
        }   
    }          

    @istest
    static void testBalCompCallOutPost(){
	    string methodStr = 'POST';
	    String param = 'service_id=XXXXX&access_key=XXXXX&apt_kbn=2&operator_kbn=2&operate_id=ABC123&count=1&edy_no_1=5478945612312544&easy_id_1=0123451&overall_comment_1=%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A&usestop_comment_1=&ipaddr_for_payguard_1=&useragent_for_payguard_1=&sf_app_no_1=201811020101';
	    String className = 'UseStopMobile';
	    String apiNo = '208040';        
        try{
            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(250);             
            res.setBody('Test');            
            mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208040';
	        bcApi.Api_Url__c='usageStopMobile';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();


        } catch(Exception e) {
            
        }   
    }
    
    
    @istest
    static void testBalCompCallOutPost_Exception(){
	    string methodStr = 'POST';
	    String param = 'service_id=XXXXX&access_key=XXXXX&apt_kbn=2&operator_kbn=2&operate_id=ABC123&count=1&edy_no_1=5478945612312544&easy_id_1=0123451&overall_comment_1=%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A&usestop_comment_1=&ipaddr_for_payguard_1=&useragent_for_payguard_1=&sf_app_no_1=201811020101';
	    String className = 'UseStopMobile';
	    String apiNo = '208040';        
        try{
            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(250);             
            res.setBody('Test');            
            //mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208040';
	        bcApi.Api_Url__c='usageStopMobile';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();


        } catch(Exception e) {
            
        }   
    }
     
    @istest
    static void testBalCompCallOutPost_CallOutException(){
	    string methodStr = 'POST';
	    String param = 'service_id=XXXXX&access_key=XXXXX&apt_kbn=2&operator_kbn=2&operate_id=ABC123&count=1&edy_no_1=5478945612312544&easy_id_1=0123451&overall_comment_1=%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A&usestop_comment_1=&ipaddr_for_payguard_1=&useragent_for_payguard_1=&sf_app_no_1=201811020101';
	    String className = 'UseStopMobile';
	    String apiNo = '208040';        
        try{
            MockHttpResponseGenerator mock = new MockHttpResponseGenerator();
            
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);             
            res.setBody('Test');            
            //mock.setRes(res);
            Test.setMock(HttpCalloutMock.class, mock);
            BalCompCallOutManager balCompCallout = new BalCompCallOutManager();         	
            BalCompCallOutManager balCompCalloutMgr = new BalCompCallOutManager(className, apiNo);

	        bal_comp_api__c bcApi = new bal_comp_api__c();
	        bcApi.Name = '208040';
	        bcApi.Api_Url__c='useStopMobile';
	        insert bcApi;            

            test.startTest();             
            balCompCalloutMgr.sendRequest(methodStr, param);
            test.stopTest();


        } catch(Exception e) {
            
        }   
    }   
}
