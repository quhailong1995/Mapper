package yui.comn.utils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 
 * 分页查询结果
 * 
 * @author yi.yuy
 *
 */
public class Page<T> implements Serializable{

    private static final long serialVersionUID = 4145463737270879555L;

    private int pageNum = 1;
    
    private int pageSize=10;
    
    private Integer total;
    
    private List<T> result = new ArrayList<T>();
    
    private Map<String,?> summary;
    
    public Page() {}
    
    /** 构造方法  */
    public Page(int pageNum, int pageSize) {
        setPageNum(pageNum);
        setPageSize(pageSize);
    }
    
    public Page(int pageNum, int pageSize, Integer total) {
        setPageNum(pageNum);
        setPageSize(pageSize);
        this.total = total;
    }
    
    public Page(int pageNum, int pageSize, List<T> result) {
        setPageNum(pageNum);
        setPageSize(pageSize);
        this.result = result;
    }

    public Page(List<T> result) {
        this.result = result;
    }
    
    public Page(int pageNum, int pageSize, Integer total, List<T> result) {
        setPageNum(pageNum);
        setPageSize(pageSize);
        this.total = total;
        this.result = result;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }

    public Map<String, ?> getSummary() {
        return summary;
    }

    public void setSummary(Map<String, ?> summary) {
        this.summary = summary;
    }
    
}
