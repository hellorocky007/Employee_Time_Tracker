package Util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JSONResponse {
    private JSONObject responseJson;

    public JSONResponse() {
        responseJson = new JSONObject();
    }

    @SuppressWarnings("unchecked")
	public void setError(String error) {
        responseJson.put("error", error);
    }

    @SuppressWarnings("unchecked")
	public void setTasks(JSONArray tasks) {
        responseJson.put("tasks", tasks);
    }

    public String getJSONResponse() {
        return responseJson.toJSONString();
    }
}