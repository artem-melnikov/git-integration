global with sharing class BaseProvider {
	public BaseProvider() {
		
	}

	public void request(String serviceName, String className, String methodName, String params){
		system.debug('BaseProvider');
		BaseRequest req = new BaseRequest(serviceName,className,methodName,params);

		System.Type classType = Type.forName(req.serviceName);
        RestServiceInterface classInstance = (RestServiceInterface) classType.newInstance();

		classInstance.request(req);
	}

	public class BaseRequest{
		public String serviceName;
		public String className;
		public String methodName;
		public String params;

		public BaseRequest(String serviceName, String className, String methodName, String params){
			this.serviceName = serviceName;
			this.className = className;
			this.methodName = methodName;
			this.params = params;
		}
	}
}