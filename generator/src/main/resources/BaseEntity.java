package yui.bss.model.vo.online.v2;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.io.Serializable;
import java.sql.Timestamp;
@Setter
@Getter
public class BaseEntity implements Serializable {
	private static final long serialVersionUID = -7621708226544002072L;
	@Id
	@GeneratedValue(generator="JDBC")
	@Column(name="id")
	@JsonView(BaseApi.class)
	private Long id;// 编号
	private Integer editFlag;// 是否删除 0-否 1-是
	private Timestamp crtTm;// 创建时间
	private Timestamp updTm;// 修改时间
	private String crtBy;// 创建人
	private String updBy;// 编辑人
	@Transient
	private String sortName;// 排序字段
	@Transient
	private String sortType = "asc";// 排序方式 asc desc
	
	interface BaseApi{}
}
