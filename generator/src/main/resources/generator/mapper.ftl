package ${package};

import ${tableClass.fullClassName};
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MysqlMapper;

/**
 * create by yeah.一页 ${generateDate}
 */
public interface ${tableClass.shortClassName}${mapperSuffix} extends Mapper<${tableClass.shortClassName}>,MysqlMapper<${tableClass.shortClassName}> {

}




