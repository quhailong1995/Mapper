<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${tableClass.shortClassName}${mapperSuffix}">
    <select id="getListJoinOther"  parameterType="${tableClass.fullClassName}"  resultType="${tableClass.fullClassName}">
        SELECT
        <#if tableClass.allFields??>
            <#list tableClass.allFields as field>${tableClass.tableName}.${field.columnName},</#list>
        </#if>
        FROM ${tableClass.tableName}
        <where>
            and t1.EDIT_FLAG=0
        <#if tableClass.allFields??>
         <#list tableClass.allFields as field>
            <if test="${field.fieldName}!=null and ${field.fieldName}!=''">and ${tableClass.tableName}.${field.columnName}=<#noparse>#{</#noparse>${field.fieldName}<#noparse>}</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
        </#if>
        </where>
        <choose>
			<when test="sortField!=null">order by <#noparse>${sortField} ${sortType}</#noparse> </when>
            <otherwise>order by upd_tm desc</otherwise>
        </choose>
    </select>

    <update id="updateBatch" parameterType="java.util.List">
        <foreach collection="list" item="item" index="index" open="" close="" separator=";">
            update ${tableClass.tableName}
            <set>
         <#if tableClass.allFields??>
         <#list tableClass.allFields as field>
                <if test="item.${field.fieldName}!=null">and ${field.columnName}=<#noparse>#{item.</#noparse>${field.fieldName}<#noparse>}</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
         </#if>
            </set>
            where id=<#noparse>#{item.id}</#noparse>
        </foreach>
    </update>

</mapper>
