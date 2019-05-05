 
package yui.comn.utils;

import java.util.HashMap;
import java.util.Map;

public class R<T> extends HashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	private boolean success;// 是否成功

	public R() {
		put("status", 200);
		put("message", "success");
		put("success",true);
	}

	public boolean isSuccess() {
		return success;
	}

	public R<T> setSuccess(boolean success) {
		this.success = success;
		return this;
	}
	public static <T> R<T> error() {
		return error("201","false");
	}

 
	

	public static <T> R<T> error(String message) {
		return error("201", message);
	}

	public static <T> R<T> error(String status, String message) {
		return new R<T>()
			.setSuccess(false)
			.put("status", status)
			.put("message", message);
	}

	@SuppressWarnings({ "unchecked","rawtypes" })
	public static <T> R<T> success(T obj) {
		R<T> r = new R<T>();
		if(obj!=null) {
			if ( obj.getClass().getSimpleName().equals(Map.class.getSimpleName())) {
				r.putAll((Map<String, Object>) obj);
			} else if (obj!=null && obj.getClass().getSimpleName().equals(Integer.class.getSimpleName())) {
				int num = (Integer) obj;
				r.put("message", num == 0 ? "操作失败" : "操作成功").put("success", true);
			}else if(obj!=null && obj.getClass().getSimpleName().equalsIgnoreCase(Page.class.getSimpleName())) {
				Page page=(Page)obj;
				Map<String,Object>itemMap=new HashMap<String, Object>();
				itemMap.put("items", page.getResult());
				r.put("data", itemMap);
				itemMap=new HashMap<String, Object>();//创建新的对象
				itemMap.put("total", page.getTotal());//设置记录数
				itemMap.put("pageSize", page.getPageSize());//设置每页记录数
				itemMap.put("pageNum", page.getPageNum());//设置当前页数
				r.put("page", itemMap).put("status",200).put("success", true);
			}else{
				r.put("data",obj);
			}
		}else {
			r.put("data","[]");
		}
		return r;
		
	}

	public static <T> R<T> success() {
		return R.success(null);
	}

	
	@Override
	public  R<T> put(String key, Object value) {
		super.put(key, value);
		return this;
	}
}
