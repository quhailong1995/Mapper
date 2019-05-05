package ${package};

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ${tableClass.fullClassName};

@RestController
@RequestMapping("/temp/${tableClass.shortClassName}/")
public class ${tableClass.shortClassName}Controller {

    @Reference
    private ${tableClass.shortClassName}Service ${tableClass.shortClassName}Service;

    @RequestMapping(value = "page" , method = RequestMethod.GET)
    public R<Object> page(Page<${tableClass.shortClassName}> page, ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.shortClassName}Service.selectByPage(page, entity));
    }

    @RequestMapping(value = "list" , method = RequestMethod.GET)
    public R<Object> list(${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.shortClassName}Service.getList(entity));
    }

    @RequestMapping(value = "info" , method = RequestMethod.GET)
    public R<Object> info(Long id) throws Exception {
        return R.success(${tableClass.shortClassName}Service.selectByKey(id));
    }

    @RequestMapping(value = "edit" , method = RequestMethod.POST)
    public R<Object> edit(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.shortClassName}Service.addOrUpdate(entity, YUISecurityUtils.getUsername()));
    }
    @RequestMapping(value = "del" , method = RequestMethod.GET)
    public R<Object> del(@RequestBody ${tableClass.shortClassName} entity) throws Exception {
        return R.success(${tableClass.shortClassName}Service.updateByExample(entity));
    }
}