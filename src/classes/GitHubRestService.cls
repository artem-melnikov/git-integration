public with sharing class GitHubRestService implements RestServiceInterface {

	public GitHubRestService() {
		
	}

	public void request(BaseProvider.BaseRequest request){
		System.debug('GitHubRestService');
		System.Type classType = Type.forName(request.className);
        GitHubRestServiceInterface classInstance = (GitHubRestServiceInterface) classType.newInstance();

		classInstance.request(request);
	}
}