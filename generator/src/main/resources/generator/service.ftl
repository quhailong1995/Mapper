package ${package};

import ${tableClass.fullClassName};

/**
 * create by yeah.一页 ${generateDate}
 */
public interface ${tableClass.shortClassName}${serviceSuffix} extends BaseService<${tableClass.shortClassName}> {
    int updateByExample(${tableClass.shortClassName} entity);
    int deleteByExample(${tableClass.shortClassName} entity);
}




