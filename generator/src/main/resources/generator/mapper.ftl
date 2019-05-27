package ${package};

import ${tableClass.fullClassName};
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * create by yeah.一页 ${generateDate}
 */
public interface ${tableClass.shortClassName}${mapperSuffix} extends Mapper<${tableClass.shortClassName}>,MySqlMapper<${tableClass.shortClassName}> {
    List<${tableClass.shortClassName}> getListJoinOther(${tableClass.shortClassName} ${tableClass.variableName});
    int updateBatch(List<${tableClass.shortClassName}> list);
}




