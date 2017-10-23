public with sharing class LabelGithubRestService {
	private final static String TOKEN = 'a6cf982c08991a8439056b772fc0918723c04b45';
	private final static String API_BASE_URL = 'https://api.github.com/repos/artem-melnikov/git-integration/labels';

	//create label
	@future(callout=true)
	public static void createLabel(String name, String color){
		String endpoint = API_BASE_URL+'?access_token='+TOKEN,
		method = 'POST',
		body = creationBody(name, color);
		HttpResponse res = httpRequestFunction(endpoint, method, body);
	}


	//updating label
	@future(callout=true)
	public static void updateLabel(String oldName, String newName, String newColor){
		String endpoint = API_BASE_URL+'/'+oldName+'?access_token='+TOKEN,
		method = 'POST',
		body = creationBody(newName,newColor);
		HttpResponse res = httpRequestFunction(endpoint, method, body);
	}


	//deleting label
	@future(callout=true)
	public static void deleteLabel(String name){
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