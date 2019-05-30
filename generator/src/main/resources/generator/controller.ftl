package ${package};

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import ${tableClass.fullClassName};

<#assign dateTime = .now>
/**
* create by |yeah.一页|qq->1324459373| ${dateTime?string["yyyy/MM/dd HH:mm:ss"]}
*/
@RestController
@RequestMapping("/+/${tableClass.variableName}/")
public class ${tableClass.shortClassName}Controller {

    @Reference
    private ${tableClass.shortClassName}Service ${tableClass.variableName}Service;

    @RequestMapping(value = "page" , method = RequestMethod.GET)
    public Object page(Page<${tableClass.shortClassName}> page, ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.variableName}Service.selectByPage(page, entity));
    }

    @RequestMapping(value = "list" , method = RequestMethod.GET)
    public Object list(${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.variableName}Service.getList(entity));
    }

    @RequestMapping(value = "info" , method = RequestMethod.GET)
    public Object info(Long id) throws Exception {
        return R.success(${tableClass.variableName}Service.selectByKey(id));
    }

    @RequestMapping(value = "edit" , method = RequestMethod.POST)
    public Object edit(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.variableName}Service.addOrUpdate(entity, YUISecurityUtils.getUsername()));
    }

    @RequestMapping(value = "del" , method = RequestMethod.GET)
    public Object del(String ids) throws Exception {
        return R.success(${tableClass.variableName}Service.delByIds(ids,${tableClass.shortClassName}.class));
    }

    @RequestMapping(value = "updateByExample" , method = RequestMethod.POST)
    public Object update(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.variableName}Service.updateByExample(entity));
    }

    @RequestMapping(value = "get" , method = RequestMethod.GET)
    public Object get(${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.variableName}Service.selectOne(entity));
    }
}