public with sharing class LabelGithubRestService {
	private static String token = '3f109efdde8064ea6d6d027d222c47979c05b95d';

	//create label
	public static void createLabel(String name, String color){
		Map<String,String> body = new Map<String,String>();
		body.put('name', name);
		body.put('color', color);

		String endpoint = 'https://api.github.com/repos/artem-melnikov/git-integration/labels?access_token='+token,
		method = 'POST',
		bodyJSON = JSON.serialize(body);


		httpRequestFunction(endpoint, method, bodyJSON);
	}
	//updating label
	public static void updateLabel(String oldName, String newName, String newColor){
		Map<String,String> body = new Map<String,String>();
		body.put('name', newName);
		body.put('color', newColor);

		String endpoint = 'https://api.github.com/repos/artem-melnikov/git-integration/labels/'+oldName+'?access_token='+token,
		method = 'POST',
		bodyJSON = JSON.serialize(body);

		httpRequestFunction(endpoint, method, bodyJSON);
	}
	//deleting label
	public static void deleteLabel(String name){
		String endpoint = 'https://api.github.com/repos/artem-melnikov/git-integration/labels/'+name+'?access_token='+token,
		method = 'DELETE',
		bodyJSON = '';

		httpRequestFunction(endpoint, method, bodyJSON);
	}
	//request function
	@future(callout=true)
	private static void httpRequestFunction(String endpoint, String methodName, String body){
		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint);
		req.setMethod(methodName);
		if(body!=''){
			req.setBody(body);
		}

		Http http = new Http();
		HttpResponse res = http.send(req);
		system.debug('STATUS: '+res.getStatusCode());
	}
}