package ${package};

import ${tableClass.fullClassName};

/**
 * create by |yeah.一页|qq->1324459373| ${generateDate}
 */
public interface ${tableClass.shortClassName}${serviceSuffix} extends BaseService<${tableClass.shortClassName}> {
    int updateByExample(${tableClass.shortClassName} entity);
    int deleteByExample(${tableClass.shortClassName} entity, ${tableClass.shortClassName} exampleEntity);
}




