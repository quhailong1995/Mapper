package ${package};

import ${tableClass.fullClassName};
import org.springframework.util.StringUtils;

/**
 * create by yeah.一页 ${generateDate}
 */
public interface ${tableClass.shortClassName}${serviceImplSuffix} extends BaseServiceService<${tableClass.shortClassName}> implements ${tableClass.shortClassName}Service {

    @Override
    public int addOrUpdate(${tableClass.shortClassName} entity, String operator) throws Exception {
        if (entity.getId() != null) {
            entity.setUpdBy(operator);
            return super.update(entity);
        } else {
            entity.setCrtBy(operator);
            entity.setUpdBy(operator);
            return add(entity);
        }
    }

    @Override
    public List<${tableClass.shortClassName}> getList(${tableClass.shortClassName} entity) throws Exception {
        return super.selectByExample(getExample(entity));
    }

    @Override
    public Page<${tableClass.shortClassName}> selectByPage(Page<${tableClass.shortClassName}> page, ${tableClass.shortClassName} entity) throws Exception {
        return super.selectByPage(page,getExample(entity));
    }

    @Override
    public Example getExample(${tableClass.shortClassName} entity) {
        Weekend<${tableClass.shortClassName}> weekend = Weekend.of(${tableClass.shortClassName}.class);
        WeekendCriteria<${tableClass.shortClassName},Object> criteria= weekend.weekendCriteria();
        if(entity!=null){
            if(StringUtils.hasText(String.valueOf(entity.getId()))){
                criteria.andEqualTo(${tableClass.shortClassName}::getId,entity.getId());
            }
            if(StringUtils.hasText(entity.getCode())){
                criteria.andLike(${tableClass.shortClassName}::getCode,entity.getCode());
            }
            if(StringUtils.hasText(entity.getName())){
                criteria.andLike(${tableClass.shortClassName}::getName,entity.getName());
            }
            if(StringUtils.hasText(entity.getIds())){
            List<Object>list=Arrays.asList(entity.getIds().split("\\,")).stream().filter(Objects::nonNull).map(Long::valueOf).collect(Collectors.toList());
                criteria.andNotIn(${tableClass.shortClassName}::getId,list);
            }
        }
        criteria.andEqualTo(${tableClass.shortClassName}::getEditFlag,0);
        weekend.setOrderByClause(StringUtil.convertByStyle(
                StringUtils.isEmpty(entity.getSortField())?"111 asc":(entity.getSortField().trim() + " "+entity.getSortType()),
                Style.camelhump));
        return weekend;
    }
}