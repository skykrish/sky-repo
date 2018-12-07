/********************************************************************************************
*   Class               :       BalCompCallOutManager                                       *
*   Created Date        :       17/09/2018                                                  *           
*   Description         :       Generic Call Out class based on http request                *
*   Created By          :       SRM                                                         *                       
*   Version             :       1.0                                                         *            
/*******************************************************************************************/
public class BalCompCallOutManager {

    private String apiNo = 'Balance Compensation Details';
    private String umfd = 'Update Balance Compensation Details';
    private transient HttpRequest req;
    private transient HttpResponse res;
    private integer maxLength = 131071;


    public BalCompCallOutManager() {}

    /**
    * コンストラクタ
    * @param umfd     errorSituation
    * @param apiNo     typeOfCallout
    */
    public BalCompCallOutManager(String umfd, String apiNo) {
        this.umfd = umfd;
        this.apiNo = apiNo;
    }

    /**
    * sendSafe() - wrapper of http.send()
    * <p>
    * httpリクエストを送信します。<br>
    * タイムアウト(408 or CalloutException)が発生した場合、3回リトライします。
    * </p>
    *
    * @param req    HttpRequest
    * @return HttpResponse
    */
    public HttpResponse sendRequest(HttpRequest req) {

        this.req = req;
        Http http = new Http();
        HttpResponse res = null;

        for (Integer retry = 1; ; retry++) {
            try {
                System.debug('***request****'+req);
                System.debug('***request accept****'+req.getHeader('accept'));
                System.debug('***request contenttype****'+req.getHeader('Content-Type'));
                res = http.send(req);
                if(res != null){
                    System.debug('***response****'+res);
                    for(String str : res.getHeaderKeys()){
                        System.debug('***response '+str+'****'+res.getHeader(str));
                    }
                }
                this.res=res;

                Integer status = res.getStatusCode();
                System.debug('***response****'+res);
                if (status >=200 && status < 300) {
                    System.debug( '--- OK code ' + status + ': '+ res.getStatus() );
                    break;
                } else if (status == 403) {
                    System.debug( '--- Forbidden code ' + status + ': '+ res.getStatus() );
                    registerError('Forbidden', 'Code: ' + res.getStatusCode(), res.getStatus());
                    break;
                } else if (status == 503) {
                    System.debug( '--- Service Unavailable code ' + status + ': '+ res.getStatus() );
                    registerError('Service Unavailable', 'Code: ' + res.getStatusCode(), res.getStatus());
                    break;
                }

                if (status != 408 || retry > 3) {
                    System.debug( Logginglevel.ERROR, '--- Error code ' + status + ': '+ res.getStatus() );
                    registerError(retry > 3 ? 'Timeout' : 'Http Error', 'Code: ' + res.getStatusCode(), res.getStatus());
                    return null;
                }

                // 408: timeout
                System.debug( Logginglevel.WARN, '--- Retry: ' + retry );

            } catch (CalloutException e) {
                if (e.getMessage().indexOf( 'timed out' ) < 0 || retry > 3) {
                    System.debug( Logginglevel.ERROR, '--- CalloutException: '+ e.getMessage() );
                    registerError(retry > 3 ? 'Timeout' : 'Apex Exception', e.getTypeName(), e.getMessage());
                    return null;
                }

                // timeout
                System.debug( Logginglevel.WARN, '--- Retry: ' + retry );
            } catch (Exception e) {
                System.debug( Logginglevel.ERROR, '--- Exception: '+ e.getMessage() );
                registerError('Apex Exception', e.getTypeName(), e.getMessage());
                return null;
            }
        }

        return res;
    }

    public void registerError(String te, String ec, String ed) {

        ApiCalloutErrors__c err = new ApiCalloutErrors__c();

        err.timeOccurred__c   = System.now();
        err.notes__c = '';

        // AO Button / Shop Update / Account Update / Checkout Settings Update
        err.errorSituation__c = umfd /* umfd */;

        // RPP Core Sync Company API /  RPP Core Sync Shop API / RPP Biz Sync Checkout Settings API
        err.typeOfCallout__c  = apiNo /* apiNo */;

        // Application Error / Timeout / Http Error / Apex Exception
        err.typeOfError__c    = te;

        Integer i = ec.indexOf( 'System.');
        if (i >= 0) ec = ec.substring( i + 7 );
        if (ec.length() > 20) ec = ec.substring( 0, 16 ) + '...';
        err.errorCode__c  = ec;

        if ( null != ed && ed.length() > 200 )  ed = ed.substring( 0, 195 ) + ' ...';
        err.errorDetail__c    = ed;

        if (req != null) {
            err.request__c = (this.req.toString()+'\n'+this.req.getBody()).left(this.maxLength);
            system.debug('req.getBody().left(this.maxLength) : ' + req.getBody().left(this.maxLength));
        }
		system.debug('** res = ' + res);
        if (res != null && res.getStatusCode() != 0) {
            err.response__c = (this.res.toString()+'\n'+this.res.getBodyAsBlob().toString()).left(this.maxLength);
            system.debug('this.res.getBody().left(this.maxLength) : ' + this.res.getBodyAsBlob().toString().left(this.maxLength));
        }
        
        err.func_nm__c = 'Balance Compensation';
        system.debug('****** err = ' + err);
        
        insert err;
    }
    
    
     /**
    *   Send Request for API call
    *   @input  String apiNo
    *   @input  String methodStr
    *   @input  String paramStr
    *   @input  List bcList
    *   @output HttpResponse
    *
    **/ 
 
    public HttpResponse sendRequest(String methodStr, String paramStr) {
        system.debug('BalCompAPIRequestGenerator apiNo = ' + apiNo);
        system.debug('BalCompAPIRequestGenerator methodStr = ' + methodStr);
        system.debug('BalCompAPIRequestGenerator paramStr = ' + paramStr);
        
        String endpoint = getEndPoint(apiNo);
        system.debug('BalCompAPIRequestGenerator endpoint = ' + endpoint);
        
        HttpRequest req = new HttpRequest();
        try {
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
            req.setHeader(BalCompConstants.ACCEPT, BalCompConstants.ACCEPT_TYPE);

            if (getMethod(methodStr) == BalCompConstants.METHID_GET) {
                endpoint = getEndPoint(apiNo) + paramStr;
                req.setEndpoint(endpoint);              
            } else {
                req.setEndpoint(endpoint);
                req.setBody(paramStr);
            }   

            req.setMethod(getMethod(methodStr));            
            res = sendRequest(req);
        } catch(CallOutException ce){
            throw ce;
        }
        
        return res;
    }     
     
     /**
    *   Get Endpoint url base on apiId & BalCompUrl Label
    *   @input  String apiId
    *   @output String (Endpoint url)
    *
    **/ 
    public String getEndPoint(String apiId) {
        
        bal_comp_api__c bcapi = bal_comp_api__c.getValues(apiId);
        String apiUrl = bcapi.Api_Url__c;
        System.debug('apiUrl:'+apiUrl);        
        return Label.BalCompUrl + apiUrl;
    }

     /**
    *   Get method based on String
    *   @input  String methodStr
    *   @output String (Method Name)
    *
    **/ 
    public String getMethod(String methodStr) {
        if (methodStr != null && methodStr == BalCompConstants.METHID_GET)
            methodStr = BalCompConstants.METHID_GET;
        else if (methodStr != null && methodStr == BalCompConstants.METHID_POST)
            methodStr = BalCompConstants.METHID_POST;  
    
        return methodStr;
    }
    
    
}