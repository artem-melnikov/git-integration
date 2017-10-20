public with sharing class Label {

	//request methods
	@future(callout=true)
	public static void createLabel(String name, String color, String labelId){
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://api.github.com/repos/artem-melnikov/status-component/labels?access_token=c15488b2dcb3c7fcb80bc502c054edb7babbe6ee');
		req.setMethod('POST');
		Map<String,String> body = new Map<String,String>();
		body.put('name', name);
		body.put('color', color);
		String bodyJSON = JSON.serialize(body);
		system.debug('body: '+bodyJSON);
		req.setBody(bodyJSON);
		Label__c label = new Label__c(Id=labelId);

		Http http = new Http();
		HTTPResponse res = http.send(req);
		system.debug(res.getStatusCode());
		if(res.getStatusCode()==422){
			delete label;
		}
	}

	@future(callout=true)
	public static void deleteLabel(String name){
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://api.github.com/repos/artem-melnikov/status-component/labels/'+name+'?access_token=c15488b2dcb3c7fcb80bc502c054edb7babbe6ee');
		req.setMethod('DELETE');
		Http http = new Http();
		HTTPResponse res = http.send(req);
	}

	@future(callout=true)
	public static void updateLabel(String oldName, String newName, String color){
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://api.github.com/repos/artem-melnikov/status-component/labels/'+oldName+'?access_token=c15488b2dcb3c7fcb80bc502c054edb7babbe6ee');
		req.setMethod('POST');

		Map<String,String> body = new Map<String,String>();
		body.put('name', newName);
		body.put('color', color);
		String bodyJSON = JSON.serialize(body);
		req.setBody(bodyJSON);

		Http http = new Http();
		HTTPResponse res = http.send(req);
	}
}