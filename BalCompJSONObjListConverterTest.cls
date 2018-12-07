/*************************************************************************************
*   Class               :       BalCompJSONObjListConverterTest                      *
*   Created Date        :       23/11/2018                                           *           
*   Description         :       Test class for BalCompJSONObjListConverterTest       *
*************************************************************************************/
@istest
private class BalCompJSONObjListConverterTest { 
     
    @istest
    static void testJSONObjListConverter_Mypage(){
        BalCompConstants BalCompCon =  new BalCompConstants();
        BalCompMessageConstant bcMsgConst = new BalCompMessageConstant();        
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<Map<String, String>> data = new List<Map<String, String>>();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1000';
		Integer listCount = 1;	
	
    	test.startTest();
		
		bcMap.put('edy_no', '1234567890987654');
		bcMap.put('tri_date', '10/12/2018');
		bcMap.put('tri_time', '10:15:45');
		data.add(bcMap);
		String jsonDataStr = JSON.serializePretty(data);
		String encodedjsondata = EncodingUtil.urlEncode(jsonDataStr, 'UTF-8');
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', encodedjsondata);
		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getMyPageUsageHistory(res);			

        test.stopTest();
    }
    
    @istest
    static void testJSONObjListConverter_Mypage_Data_Null(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HTTPResponse res = new HttpResponse();
		String processCode = '3000';
		Integer listCount = 0;	
	
    	test.startTest();

		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', '');
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getMyPageUsageHistory(res);			

        test.stopTest();
    }    
    
    @istest
    static void testJSONObjListConverter_BlockList(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HTTPResponse res = new HttpResponse();
		String processCode = '1000';
	
    	test.startTest();

		resultMap.put('result_code', processCode);
		resultMap.put('data', '');
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getBlockListRegdn(res);			

        test.stopTest();
    }    


    @istest
    static void testJSONObjListConverter_UseStop(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<Map<String, String>> data = new List<Map<String, String>>();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1000';
		Integer listCount = 1;	
	
    	test.startTest();
		
		bcMap.put('edy_no', '3001400099999991');
		bcMap.put('app_no', '123451');
		bcMap.put('sf_app_no', '98765432101');
		bcMap.put('sf_provisional_no', '1');
		bcMap.put('result_code', '0000');
		data.add(bcMap);
		String jsonDataStr = JSON.serializePretty(data);
		String encodedjsondata = EncodingUtil.urlEncode(jsonDataStr, 'UTF-8');
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', encodedjsondata);
		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getRestResult(res);

        test.stopTest();
    }

    @istest
    static void testJSONObjListConverter_UseStop_Data_Null(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '3000';
		Integer listCount = 0;	
	
    	test.startTest();
		
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', '');
		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getRestResult(res);

        test.stopTest();
    }
    
    
    @istest
    static void testJSONObjListConverter_TransLog_LogType_2(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<Map<String, String>> data = new List<Map<String, String>>();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1000';
		Integer listCount = 1;	
	
    	test.startTest();
		
		bcMap.put('app_no', '120');
		bcMap.put('app_kbn', '01');
		bcMap.put('edy_no', '1234567890987654');
		bcMap.put('card_seq', '12345');
		bcMap.put('log_type', '2');
		bcMap.put('tri_date', '20160603');
		bcMap.put('tri_time', '121212');
		bcMap.put('tri_amt', '10000');
		bcMap.put('trsname', '加盟店A');
		bcMap.put('edy_term_id', '12345678');
		bcMap.put('edy_term_seq', '1234567890');
		bcMap.put('easy_id', '12345678901');
		bcMap.put('mem_no', '20');
		bcMap.put('corporateid', '12345678');
		
		data.add(bcMap);
		String jsonDataStr = JSON.serializePretty(data);
		String encodedjsondata = EncodingUtil.urlEncode(jsonDataStr, 'UTF-8');
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', encodedjsondata);		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getTransactionLogSearchResult(res);

        test.stopTest();
    }

    @istest
    static void testJSONObjListConverter_TransLog_LogType_4(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<Map<String, String>> data = new List<Map<String, String>>();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1000';
		Integer listCount = 1;	
	
    	test.startTest();
		
		bcMap.put('app_no', '120');
		bcMap.put('app_kbn', '02');
		bcMap.put('edy_no', '1234567890987654');
		bcMap.put('card_seq', '12345');
		bcMap.put('log_type', '4');
		bcMap.put('tri_date', '20160603');
		bcMap.put('tri_time', '121212');
		bcMap.put('tri_amt', '10000');
		bcMap.put('trsname', '加盟店A');
		bcMap.put('edy_term_id', '12345678');
		bcMap.put('edy_term_seq', '1234567890');
		bcMap.put('easy_id', '12345678901');
		bcMap.put('mem_no', '20');
		bcMap.put('corporateid', '12345678');
		
		data.add(bcMap);
		String jsonDataStr = JSON.serializePretty(data);
		String encodedjsondata = EncodingUtil.urlEncode(jsonDataStr, 'UTF-8');
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', encodedjsondata);		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getTransactionLogSearchResult(res);

        test.stopTest();
    }

    @istest
    static void testJSONObjListConverter_TransLog_LogType_32(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<Map<String, String>> data = new List<Map<String, String>>();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, String> bcMap = new Map<String, String>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1000';
		Integer listCount = 1;	
	
    	test.startTest();
		
		bcMap.put('app_no', '120');
		bcMap.put('app_kbn', '03');
		bcMap.put('edy_no', '1234567890987654');
		bcMap.put('card_seq', '12345');
		bcMap.put('log_type', '32');
		bcMap.put('tri_date', '20160603');
		bcMap.put('tri_time', '121212');
		bcMap.put('tri_amt', '10000');
		bcMap.put('trsname', '加盟店A');
		bcMap.put('edy_term_id', '12345678');
		bcMap.put('edy_term_seq', '1234567890');
		bcMap.put('easy_id', '12345678901');
		bcMap.put('mem_no', '20');
		bcMap.put('corporateid', '12345678');
		
		data.add(bcMap);
		String jsonDataStr = JSON.serializePretty(data);
		String encodedjsondata = EncodingUtil.urlEncode(jsonDataStr, 'UTF-8');
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', encodedjsondata);		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getTransactionLogSearchResult(res);

        test.stopTest();
    }
    
    @istest
    static void testJSONObjListConverter_TransLog_Data_Null(){
		ResponseWrapper resWrapper = new ResponseWrapper();
        List<List<Map<String, String>>> results = new List<List<Map<String, String>>>();
        Map<String, Object> resultMap = new Map<String, Object>();
		HttpResponse res = new HttpResponse();
		String processCode = '1001';
		Integer listCount = 0;	
	
    	test.startTest();
		
		resultMap.put('result_code', processCode);
		resultMap.put('data_count', listCount);
		resultMap.put('data', '');		
		resWrapper.results = resultMap;
		res.setHeader('Content-Type', 'application/json');
        res.setBody(JSON.serializePretty(resWrapper));
		BalCompJSONObjListConverter balCompJSONObjList = new BalCompJSONObjListConverter();
		balCompJSONObjList.getTransactionLogSearchResult(res);

        test.stopTest();
    }

    
	//wrapping Bean
    public class ResponseWrapper {
        public Map<String, Object> results;
       
        public ResponseWrapper(){
           
        }       
    }
    
}