package yui.bss.mgr.base.online.v2;

import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;
import yui.bss.mgr.base.online.v2.BaseService;
import yui.comn.utils.Page;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public abstract class BaseServiceImpl<T> implements BaseService<T> {
	@Autowired
    protected Mapper<T> mapper;

   
    @Override
    public T selectByKey(Object key) throws Exception {
    	return mapper.selectByPrimaryKey(key);
    }
    
    @Override
    public T selectOne(T entity) throws Exception {
    	return mapper.selectOne(entity);
    }
    @Override
    public int selectCount(T t) throws Exception {
    	return mapper.selectCount(t);
    }
    @Override
    public boolean exists(T entity)throws Exception{
    	return mapper.selectCount(entity)>0?true:false;
    }
    @Override
    public int add(T entity) throws Exception {
    	return mapper.insertSelective(entity);
    }
    
    @Override
    public abstract int addOrUpdate(T entity, String oerator) throws Exception ;
    
   
    public int update(T entity)throws Exception{
    	return mapper.updateByPrimaryKeySelective(entity);
    }
    @Override
    public int del(Object key) throws Exception {
    	return mapper.deleteByPrimaryKey(key);
    }
    
    @Override
    public int delByIds(String ids,Class<T> clazz) throws Exception {
		List<Object>list=Arrays.asList(ids.split("\\,")).stream().filter(Objects::nonNull).map(Long::valueOf).collect(Collectors.toList());
		Example example=new Example(clazz);
		Criteria criteria=example.createCriteria();
		criteria.andIn("id", list);
		return mapper.deleteByExample(example)>0?1:0;
		
    }
    
    @Override
    public List<T> selectByExample(Object example) throws Exception {
    	return mapper.selectByExample(example);
    }
    /**
     * 根据对象生成Example查询对象
     * @param t 实体对象
     * @return Example
     */
    public abstract Example getExample(T t);
    	
    @Override
    public Page<T> selectByPage(Page<T> page, Example example ) throws Exception {
    	PageHelper.offsetPage((page.getPageNum()==0?0:page.getPageNum() - 1)*page.getPageSize(), page.getPageSize());
		com.github.pagehelper.PageInfo<T> pageInfo = new com.github.pagehelper.PageInfo<>(selectByExample(example));
		page.setResult(pageInfo.getList());// 设置查询结果
		page.setTotal(Integer.parseInt(pageInfo.getTotal() + ""));// 设置总记录数
		return page;
    }

    @Override
    public Page<T> getPageCommon(Page<T> page , List<T> list) {
        com.github.pagehelper.PageInfo<T> pageInfo = new com.github.pagehelper.PageInfo<>(list);
        page.setResult(pageInfo.getList());
        page.setTotal(Integer.parseInt(pageInfo.getTotal() + ""));
        return page;
    }

}
