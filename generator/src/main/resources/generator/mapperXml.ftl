<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperPackage}.${tableClass.shortClassName}${mapperSuffix}">
    <select id="getListJoinOther"  parameterType="${tableClass.fullClassName}"  resultType="${tableClass.fullClassName}">
        SELECT
        <#if tableClass.allFields??>
            <#list tableClass.allFields as field>t1.${field.columnName},</#list>
        </#if>
        FROM ${tableClass.tableName} t1
        <where>
            and ${tableClass.tableName}.EDIT_FLAG=0
        <#if tableClass.allFields??>
         <#list tableClass.allFields as field>
            <if test="${field.fieldName}!=null and ${field.fieldName}!=''">and t1.${field.columnName}=<#noparse>#{</#noparse>${field.fieldName}<#noparse>}</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
        </#if>
            <if test="cd!=null">and instr(t1.cd,'<#noparse>${cd}</#noparse>')</if><!-- 根据商品编码查询 -->
        </where>
        <choose>
			<when test="sortName!=null">order by <#noparse>${sortName} ${sortType}</#noparse> </when>
            <otherwise>order by crt_tm desc</otherwise>
        </choose>
    </select>

    <update id="updateBatch" parameterType="java.util.List">
        <foreach collection="list" item="item" index="index" open="" close="" separator=";">
            update ${tableClass.tableName}
            <set>
         <#if tableClass.allFields??>
         <#list tableClass.allFields as field>
                <if test="item.${field.fieldName}!=null"> ${field.columnName}=<#noparse>#{item.</#noparse>${field.fieldName}<#noparse>},</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
         </#if>
            </set>
            where id=<#noparse>#{item.id}</#noparse>
        </foreach>
    </update>


    <!-- UNION使用例子  -->
    <select id="getResultList" parameterType="yui.bss.model.vo.online.OnlinePersCourseVo" resultType="yui.bss.model.vo.online.OnlinePersCourseVo">
        select t1.ONLINE_COURSE_PK courseId,t3.is_pass pass,t3.exam_status examStatus,t3.perc coursePerc,t3.user_id userId,1 as type,t1.ONLINE_COURSE_PK "course.onlineCoursePk",
        t1.NM  "course.nm",t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
        from t_online_course t1 join  t_post_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
        left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
        <if test="employeeId!=null">and  t3.employee_id=<#noparse>#{employeeId}</#noparse></if><!-- 根据编号查询 -->
        <if test="pass!=null and pass==0">and is_pass=<#noparse>#{pass}</#noparse></if><!--根据考试通过状态查询-->
        <where>
            <if test="postId!=null">and t2.post_id=<#noparse>#{postId}</#noparse></if> <!-- 根据岗位编号查询 -->
            <if test="pass!=null and pass==1">and is_pass=<#noparse>#{pass}</#noparse></if><!--根据考试通过状态查询-->
        </where>
        UNION  <!-- 选修课程  -->
        select t1.ONLINE_COURSE_PK courseId,t3.is_pass pass,t3.exam_status examStatus,t3.perc coursePerc,t3.user_id userId,2 as type,t1.ONLINE_COURSE_PK "course.onlineCoursePk",
        t1.NM "course.nm",t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
        from t_online_course t1 join  t_corp_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
        left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
        <if test="employeeId!=null">and  t3.employee_id=<#noparse>#{employeeId}</#noparse></if><!-- 根据编号查询 -->
        <if test="pass!=null and pass==0">and is_pass=<#noparse>#{pass}</#noparse></if><!--根据考试通过状态查询-->
        <where>
            <if test="corpId!=null">and t2.corp_id=<#noparse>#{corpId}</#noparse></if> <!-- 根据企业编号编号 -->
            <if test="pass!=null and pass==1">and is_pass=<#noparse>#{pass}</#noparse></if><!--根据考试通过状态查询-->
        </where>
    </select>

    <select id="getList" parameterType="yui.bss.model.vo.online.OnlinePersCourseVo" resultType="yui.bss.model.vo.online.OnlinePersCourseVo">

        <choose>
            <when test="type!=null and type==1">
                SELECT t1.ONLINE_COURSE_PK "course.onlineCoursePk", t2.course_id courseId,t1.NM "course.nm", perc coursePerc,
                t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura", t1.img_url "course.imgUrl",perc
                FROM t_online_course t1 join  t_post_course_link t2 on t1.ONLINE_COURSE_PK = t2.course_id
                left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
                <if test="employeeId!=null">and  t3.employee_id=<#noparse>#{employeeId}</#noparse></if><!-- 根据编号查询 -->
                <if test="userId!=null">and t3.user_id=<#noparse>#{userId}</#noparse></if><!-- 根据员工账号查询 -->
                <where>
                    <if test="postId!=null"> AND t2.post_id = <#noparse>#{postId}</#noparse></if>  <!-- 根据岗位编号查询 -->
                </where>
            </when>
            <otherwise>
                select t1.NM "course.nm", t1.ONLINE_COURSE_PK "course.onlineCoursePk",t2.course_id courseId,perc coursePerc,
                t1.LESSON_QTY "course.LessonQty", t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
                FROM t_online_course t1 join  t_corp_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
                left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
                <if test="employeeId!=null">and  t3.employee_id=<#noparse>#{employeeId}</#noparse></if><!-- 根据编号查询 -->
                <if test="userId!=null">and t3.user_id=<#noparse>#{userId}</#noparse></if><!-- 根据员工账号查询 -->
                <where>
                    <if test="corpId!=null">and t2.corp_id=<#noparse>#{corpId}</#noparse></if> <!-- 根据企业编号编号 -->
                </where>
            </otherwise>
        </choose>
    </select>

</mapper>
