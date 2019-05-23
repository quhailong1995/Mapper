package ${package};

import ${tableClass.fullClassName};
import org.springframework.util.StringUtils;
import tk.mybatis.mapper.code.Style;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;
import tk.mybatis.mapper.weekend.Weekend;
import tk.mybatis.mapper.weekend.WeekendCriteria;
import java.util.List;

/**
 * create by yeah.一页 ${generateDate}
 */
@Service(interfaceClass=${tableClass.shortClassName})
public class ${tableClass.shortClassName}${serviceImplSuffix} extends BaseServiceService<${tableClass.shortClassName}> implements ${tableClass.shortClassName}Service {

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
    public ${tableClass.shortClassName} selectOne(${tableClass.shortClassName} entity) throws Exception {
        List<${tableClass.shortClassName}> list = getList(entity);
        return !list.isEmpty()?list.get(0):null;
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
                criteria.andEqualTo(${tableClass.shortClassName}::getCode,entity.getNm().trim());
            }
            if(StringUtils.hasText(entity.getName())){
                criteria.andLike(${tableClass.shortClassName}::getName,"%"+entity.getName()+"%");
            }
            if(StringUtils.hasText(entity.getIds())){
            List<Object>list=Arrays.asList(entity.getIds().split("\\,")).stream().filter(Objects::nonNull).map(Long::valueOf).collect(Collectors.toList());
                criteria.andIn(${tableClass.shortClassName}::getId,list);
            }
        }
        criteria.andEqualTo(${tableClass.shortClassName}::getEditFlag,0);
        weekend.setOrderByClause(StringUtil.convertByStyle(
                StringUtils.isEmpty(entity.getSortName())?"111 asc":(entity.getSortField().trim() + " "+entity.getSortType()),
                Style.camelhump));
        return weekend;
    }

    @Override
    public int updateByExample(${tableClass.shortClassName} entity){
        return mapper.updateByExampleSelective(entity,getExample(entity));
    }

    @Override
    public int deleteByExample(${tableClass.shortClassName} entity) {
        return mapper.deleteByExample(getExample(entity));
    }
}