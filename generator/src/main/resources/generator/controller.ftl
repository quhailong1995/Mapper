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

    @GetMapping("page")
    public Object page(MyPage<${tableClass.shortClassName}> page, ${tableClass.shortClassName} entity) throws Exception {
        return Res.success(${tableClass.variableName}Service.selectByPage(page, entity));
    }

    @GetMapping("list")
    public Object list(${tableClass.shortClassName} entity) throws Exception {
        return Res.success(${tableClass.variableName}Service.getList(entity));
    }

    @GetMapping("info")
    public Object info(Long id) throws Exception {
        return Res.success(${tableClass.variableName}Service.selectByKey(id));
    }

    @PostMapping("edit")
    public Object edit(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        UserInfo userInfo = YuiSecurityUtils.getUserInfo();
        return Res.success(${tableClass.variableName}Service.addOrUpdate(entity, userInfo!=null?userInfo.getUsername():null));
    }

    @GetMapping("del")
    public Object del(String ids) throws Exception {
        return Res.success(${tableClass.variableName}Service.delByIds(ids,${tableClass.shortClassName}.class));
    }

    @PostMapping("updateByExample")
    public Object update(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        return Res.success(${tableClass.variableName}Service.updateByExample(entity));
    }

    @GetMapping("get")
    public Object get(${tableClass.shortClassName} entity) throws Exception {
        return Res.success(${tableClass.variableName}Service.selectOne(entity));
    }
}    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
@DateTimeFormat(pattern = "yyyy-MM-dd")