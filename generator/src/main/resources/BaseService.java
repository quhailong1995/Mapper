package yui.bss.baoyin.mgr.ext;

import tk.mybatis.mapper.entity.Example;
import yui.comn.utils.MyPage;

import java.util.List;
public interface BaseService<T> {
	/**
	 * 根据主键查询数据
	 * @param key 主键
	 * @return T
	 */
	T selectByKey(Object key)throws Exception;
	/**
	 * 根据条件查询数据是否存在
	 * @param t 查询对象
	 * @return boolean true:fase
	 * @throws Exception
	 */
	boolean exists(T t)throws Exception;
	/**
	 * 根据条件查询一条记录
	 * @param t 查询对象
	 * @return T
	 * @throws Exception
	 */
	T selectOne(T t)throws Exception;
	/**
	 * 根据条件查询总记录数
	 * @param t 查询对象
	 * @return T
	 * @throws Exception
	 */
	int selectCount(T t)throws Exception;
	/**
	 * 新增
	 * @param entity 新增对象
	 * @return int
	 * @throws Exception
	 */
	int add(T entity)throws Exception;
	/**
	 * 新增或修改数据
	 * @param entity 操作实体
	 * @param oerator 操作人
	 * @return int
	 * @throws Exception
	 */
	int addOrUpdate(T entity, String oerator)throws Exception;

	/**
	 * 更新
	 * @param entity 编辑对象
	 * @return int
	 * @throws Exception
	 */
	int update(T entity)throws Exception;
	/**
	 * 根据主键删除数据
	 * @param key 主键
	 * @return int
	 * @throws Exceptionn
	 */
	int del(Object key)throws Exception;
	/**
	 * 根据编号删除数据
	 * @param ids 多个编号以","分割
	 * @param clazz 类名
	 * @return int
	 * @throws Exception
	 */
	int delByIds(String ids, Class<T> clazz)throws Exception;
	/**
	 * 根据条件查询数据
	 * @param example 查询对象
	 * @return List<T>
	 * @throws Exception
	 */
	List<T>selectByExample(Object example)throws Exception;
	/**
	 * 根据条件查询数据数据
	 * @param entity 查询对象
	 * @return List<T>
	 * @throws Exception
	 */
	List<T>getList(T entity)throws Exception;
	/**
	 * 分页查询数据
	 * @param page 分页对象
	 * @param entity 查询对象
	 * @return PageInfo<T>
	 * @throws Exception
	 */
	MyPage<T> selectByPage(MyPage<T> page, T entity)throws Exception;

	/**
	 * 分页查询数据
	 * @param page 分页对象
	 * @param example 查询条件对象
	 * @return PageInfo<T>
	 * @throws Exception
	 */
	MyPage<T>selectByPage(MyPage<T> page, Example example)throws Exception;


	MyPage<T> getPageCommon(MyPage<T> page, List<T> list) ;

}
