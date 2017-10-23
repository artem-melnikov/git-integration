public with sharing class LabelGithubRestService implements GitHubRestServiceInterface{
	private final String CREATE_LABEL = 'createLabel';
	private final String UPDATE_LABEL = 'updateLabel';
	private final String DELETE_LABEL = 'deleteLabel';

	private final static String TOKEN = '84d679f0cba4040f078e1b711350cc0efcde8fa4';
	private final static String API_BASE_URL = 'https://api.github.com/repos/artem-melnikov/git-integration/labels';

	public void request(BaseProvider.BaseRequest request){
		System.debug('LabelGithubRestService');

		Map<String, Object> paramsMap = (Map<String, Object>)JSON.deserializeUntyped(request.params);

        if (request.methodName == CREATE_LABEL) {
            createLabel((String)paramsMap.get('name'), (String)paramsMap.get('color'));
        }
        if (request.methodName == UPDATE_LABEL) {
            updateLabel((String)paramsMap.get('oldName'), (String)paramsMap.get('name'), (String)paramsMap.get('color'));
        }
		if (request.methodName == DELETE_LABEL) {
            deleteLabel((String)paramsMap.get('name'));
        }
	}


	//create label
	@future(callout=true)
	private static void createLabel(String name, String color){
		String endpoint = API_BASE_URL+'?access_token='+TOKEN,
		method = 'POST',
		body = creationBody(name, color);
		HttpResponse res = httpRequestFunction(endpoint, method, body);
	}


	//updating label
	@future(callout=true)
	private static void updateLabel(String oldName, String newName, String newColor){
		String endpoint = API_BASE_URL+'/'+oldName+'?access_token='+TOKEN,
		method = 'POST',
		body = creationBody(newName,newColor);
		HttpResponse res = httpRequestFunction(endpoint, method, body);
	}

	//deleting label
	@future(callout=true)
	private static void deleteLabel(String name){
		String endpoint = API_BASE_URL+'/'+name+'?access_token='+TOKEN,
		method = 'DELETE',
		body = '';
	 HttpResponse res = httpRequestFunction(endpoint, method, body);
	}


	//request function
	private static HttpResponse httpRequestFunction(String endpoint, String methodName, String body){
		system.debug('ENDPOINT: '+ endpoint);
		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint);
		req.setMethod(methodName);
		if(body!=''){
			req.setBody(body);
		}

		Http http = new Http();
		HttpResponse res = http.send(req);
		system.debug('STATUS: '+ res.getStatusCode()+'\t'+res.getStatus());
		return res;
	}


	//function which create body of request
	private static String creationBody(String name, String color){
		Map<String,String> body = new Map<String,String>();
		body.put('name', name);
		body.put('color', color);
		return JSON.serialize(body);
	}
}