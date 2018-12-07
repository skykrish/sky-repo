/********************************************************************************************
*   Class               :       BalCompJSONObjListConverter                                 *
*   Created Date        :       19/09/2018                                                  *           
*   Description         :       This class will convert Response JSON to Object List        *
*   Created By          :       SRM                                                         *                       
*   Version             :       1.0                                                         *            
/*******************************************************************************************/
public with sharing class BalCompJSONObjListConverter { 
    public EdyUsageHistory edyUsageHis                  {get; set;}
    public List<EdyUsageHistory> edyUsageHisList        {get; set;}  
    
    public TransLogResult transLogResult                {get; set;}
    public List<TransLogResult> transLogList            {get; set;}  
    
    public RestResult restResult                        {get; set;}
    public List<RestResult> restResultList              {get; set;}
    
    public BlockListResult blockListResult              {get; set;}
    public List<BlockListResult> blockListResultList    {get; set;}
    
    public BalCompJSONObjListConverter() {        
        transLogList    = new List<TransLogResult>();
    }
 

    /**
    *   Convert HttpResponse to BlockListResult List
    *   @input  HttpResponse
    *   @output List<BlockListResult>
    *
    **/ 
    public List<BlockListResult> getBlockListRegdn (HttpResponse res) {
        blockListResultList = new List<BlockListResult>();
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        System.debug('**results **' + results);
        Map<String, Object> datavalMap = (Map<String, Object>)results.get(BalCompConstants.EDY_BC_RES_RESULTS);
        System.debug('**datavalMap **' + datavalMap);    
    
        blockListResult = new BlockListResult();
        blockListResult.process_code = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
        system.debug('************ blockListResult ::: ' + blockListResult);    
        blockListResultList.add(blockListResult);   

        return blockListResultList;
    }
    
    /**
    *   Convert HttpResponse to EdyUsageHistory List
    *   @input  HttpResponse
    *   @output List<EdyUsageHistory>
    *
    **/ 
    
    public List<EdyUsageHistory> getMyPageUsageHistory (HttpResponse res) {

        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        System.debug('**results **' + results);
        Map<String, Object> datavalMap = (Map<String, Object>)results.get(BalCompConstants.EDY_BC_RES_RESULTS);
        System.debug('**datavalMap **' + datavalMap);
        List<Object> dataList;
        Map<String, Object> dataMap;
        String tryDate = '';
        String tryTime = '';
        edyUsageHisList = new List<EdyUsageHistory>();    
        
        //EncodingUtil.urlDecode(encodedjsondata, 'UTF-8')    
        
        for (String attrib : datavalMap.keyset()) {
            if (attrib == BalCompConstants.EDY_BC_RES_DATA) {               
                if (datavalMap.get(attrib) != null && datavalMap.get(attrib) != BalCompConstants.EDY_BC_EMPTY_STRING) {
                    dataList = (List<Object>) JSON.deserializeUntyped(EncodingUtil.urlDecode((datavalMap.get(attrib).toString()), 'UTF-8'));
                    integer recCount = 1;
                    System.debug('**dataList **' + dataList);
                    //System.debug('**dataList Sixe **' + dataList.size());
                    for (Object objMap : dataList) {                    
                        dataMap = (Map<String, Object>) objMap;
                        System.debug('**dataMap **' + dataMap);
                        //System.debug('**dataMap Size ** = ' + dataMap.size());
    
                        edyUsageHis = new EdyUsageHistory();                        
                        edyUsageHis.process_code = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                        edyUsageHis.data_count = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
    
                        edyUsageHis.edy_no = (String) dataMap.get(BalCompConstants.EDY_BC_EDY_NO);
                        tryDate = (String) dataMap.get(BalCompConstants.EDY_BC_RES_LAST_TRY_DATE);
                        tryTime = (String) dataMap.get(BalCompConstants.EDY_BC_RES_LAST_TRY_TIME);                        
                        edyUsageHis.tri_date_time = tryDate + BalCompConstants.EDY_BC_SINGLE_SPACE + tryTime;
                        System.debug('************************* tri_date_time ** = ' + edyUsageHis.tri_date_time);
                        
                        edyUsageHisList.add(edyUsageHis);
                    }
                } else {
                    // When no data entry found or any error scenario                    
                    edyUsageHis                = new EdyUsageHistory();
                    edyUsageHis.process_code   = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                    edyUsageHis.data_count     = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
                    
                    edyUsageHisList.add(edyUsageHis);
                }
            }
        }
        System.debug('*******edyUsageHisList*******'+edyUsageHisList);
        return edyUsageHisList;
    }
        

    
    /**
    *   Convert HttpResponse to getRestResult List
    *   @input  HttpResponse
    *   @output List<RestResult>
    *   @usage stop (mobile)
    *   @usage stop (sato, nega)
    *   @nega -  usage stop cancel
    *   @final judgement
    *   @manual judgement
    *   @merchant bal comp
    *
    **/ 
    
    public List<RestResult> getRestResult (HttpResponse res) {

        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        System.debug('**results **' + results);
        Map<String, Object> datavalMap = (Map<String, Object>)results.get(BalCompConstants.EDY_BC_RES_RESULTS);
        System.debug('**datavalMap **' + datavalMap);
        List<Object> dataList;
        Map<String, Object> dataMap;
        String tryDate = '';
        String tryTime = '';
        restResultList = new List<RestResult>();        
        
        for (String attrib : datavalMap.keyset()) {
            if (attrib == BalCompConstants.EDY_BC_RES_DATA) {               
                if (datavalMap.get(attrib) != null && datavalMap.get(attrib) != BalCompConstants.EDY_BC_EMPTY_STRING) {
                    dataList = (List<Object>) JSON.deserializeUntyped(EncodingUtil.urlDecode((datavalMap.get(attrib).toString()), 'UTF-8'));
                    integer recCount = 1;
                    System.debug('**dataList **' + dataList);
                    for (Object objMap : dataList) {                    
                        dataMap = (Map<String, Object>) objMap;
                        System.debug('**dataMap **' + dataMap);
                        restResult = new RestResult();
                        restResult.process_code = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                        restResult.data_count = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
                        
                        restResult.result_code = (String) dataMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                        // usage stop (mobile)
                        // usage stop (sato, nega)
                        // nega -  usage stop cancel
                        restResult.edy_no = (String) dataMap.get(BalCompConstants.EDY_BC_EDY_NO);
                        // usage stop (mobile)
                        // usage stop (sato, nega)
                        // nega -  usage stop cancel
                        // final judgement
                        // manual judgement
                        // merchant bal comp
                        restResult.app_no = (String) dataMap.get(BalCompConstants.EDY_BC_APP_NO);
                        // usage stop (sato, nega)
                        restResult.sf_provisional_no = (String) dataMap.get(BalCompConstants.EDY_BC_SF_PROVISIONAL_NO);
                        // usage stop (mobile)
                        restResult.sf_app_no = (String) dataMap.get(BalCompConstants.EDY_BC_SF_APP_NO);
    
                        restResultList.add(restResult);
                    }
                
                  
                } else {
                    // When no data entry found or any error scenario                    
                    restResult                = new RestResult();
                    restResult.process_code   = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                    restResult.data_count     = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
                    
                    restResultList.add(restResult);
                }
            }
        }
        System.debug('*******restResultList*******'+restResultList);
        //System.debug('*******restResultList Size*******'+restResultList.size());
 
        return restResultList;
    } 

    /**
    *   Convert HttpResponse to TransactionLogSearchResult List
    *   @input  HttpResponse
    *   @output List<TransLogResult>
    *
    **/ 
    public List<TransLogResult> getTransactionLogSearchResult(HttpResponse res) {
        
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        System.debug('**results **' + results);
        Map<String, Object> datavalMap = (Map<String, Object>)results.get(BalCompConstants.EDY_BC_RES_RESULTS);
        System.debug('**datavalMap **' + datavalMap);
        List<Object> dataList;
        Map<String, Object> dataMap;
        transLogList = new List<TransLogResult>();         
        
        //EncodingUtil.urlDecode(encodedjsondata, 'UTF-8')
        
        for (String attrib : datavalMap.keyset()) {
            system.debug('***attrib :: ' + attrib);
            
            if (attrib == BalCompConstants.EDY_BC_RES_DATA) {
                system.debug('***datavalMap.get(attrib) = ' + String.valueOf(datavalMap.get(attrib)));               
                if (datavalMap.get(attrib) != null && datavalMap.get(attrib) != BalCompConstants.EDY_BC_EMPTY_STRING) {
                    dataList = (List<Object>) JSON.deserializeUntyped(EncodingUtil.urlDecode((datavalMap.get(attrib).toString()), 'UTF-8'));
                    integer recCount = 1;
                    System.debug('**dataList **' + dataList);
                    //System.debug('**dataList Sixe **' + dataList.size());
                    for (Object objMap : dataList) {                    
                        dataMap = (Map<String, Object>) objMap;
                        System.debug('**dataMap **' + dataMap);
                        //System.debug('**dataMap Size ** = ' + dataMap.size());
    
                        transLogResult = new TransLogResult();
                        transLogResult.process_code = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                        transLogResult.data_count = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
    
                        transLogResult.app_no = (String) dataMap.get(BalCompConstants.EDY_BC_APP_NO);
                        transLogResult.app_kbn = (String) dataMap.get(BalCompConstants.EDY_BC_APP_KBN);
                        
                         if(transLogResult.app_kbn == '01') {
                           transLogResult.app_kbn = '加盟店';                             
                        } else if(transLogResult.app_kbn == '02') {
                            transLogResult.app_kbn = 'モバイル ';       
                        } else if(transLogResult.app_kbn == '03'){
                           transLogResult.app_kbn = 'ネガプラス';       
                        }
                        
                        transLogResult.edy_no = (String) dataMap.get(BalCompConstants.EDY_BC_EDY_NO);
                        transLogResult.card_seq = (String) dataMap.get(BalCompConstants.EDY_BC_CARD_SEQ);

                        transLogResult.log_type = (String) dataMap.get(BalCompConstants.EDY_BC_LOG_TYPE);
                        
                        if(transLogResult.log_type == '2') {
                           transLogResult.log_type = 'チャージ';                             
                        } else if(transLogResult.log_type == '4') {
                            transLogResult.log_type = 'Edyギフト';       
                        } else if(transLogResult.log_type == '32'){
                           transLogResult.log_type = '利用';       
                        }
                        transLogResult.tri_date = (String) dataMap.get(BalCompConstants.EDY_BC_RES_LAST_TRY_DATE);
                        transLogResult.tri_time = (String) dataMap.get(BalCompConstants.EDY_BC_RES_LAST_TRY_TIME);
                        transLogResult.tri_amt = (String) dataMap.get(BalCompConstants.EDY_BC_TRI_AMT);

                        transLogResult.trsname = (String) dataMap.get(BalCompConstants.EDY_BC_TRSNAME);
                        transLogResult.edy_term_id = (String) dataMap.get(BalCompConstants.EDY_BC_EDY_TERM_ID);
                        transLogResult.edy_term_seq = (String) dataMap.get(BalCompConstants.EDY_BC_EDY_TERM_SEQ);
                        transLogResult.easy_id = (String) dataMap.get(BalCompConstants.EDY_BC_EASY_ID);

                        transLogResult.corporateid = (String) dataMap.get(BalCompConstants.EDY_BC_CORPORATEID);
                        transLogResult.mem_no = (String) dataMap.get(BalCompConstants.EDY_BC_MEM_NO);
                        
                        //System.debug('************************* tri_date_time ** = ' + edyUsageHis.tri_date_time);
                        
                        transLogList.add(transLogResult);
                    }
                } else {
                    // When no data entry found or any error scenario                    
                    transLogResult                 = new TransLogResult();
                    transLogResult.process_code    = (String) datavalMap.get(BalCompConstants.EDY_BC_RES_RESULT_CODE);
                    transLogResult.data_count      = String.valueOf(datavalMap.get(BalCompConstants.EDY_BC_RES_LIST_COUNT));
                    
                    transLogList.add(transLogResult);
                }
            }
        }
        
        System.debug('*******transLogList*******'+transLogList);

        return transLogList;
    }  
}