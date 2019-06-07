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
            and ${tableClass.tableName}.EDIT_FLAG=0
        <#if tableClass.allFields??>
         <#list tableClass.allFields as field>
            <if test="${field.fieldName}!=null and ${field.fieldName}!=''">and ${tableClass.tableName}.${field.columnName}=<#noparse>#{</#noparse>${field.fieldName}<#noparse>}</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
        </#if>
            <if test="cd!=null">and instr(t1.cd,'<#noparse>${cd}</#noparse>')</if><!-- 根据商品编码查询 -->
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
                <if test="item.${field.fieldName}!=null"> ${field.columnName}=<#noparse>#{item.</#noparse>${field.fieldName}<#noparse>},</#noparse></if><#if field.remarks??><!--${field.remarks}--></#if>
         </#list>
         </#if>
            </set>
            where id=<#noparse>#{item.id}</#noparse>
        </foreach>
    </update>


    <!-- UNION使用例子  -->
    <select id="getResultList" parameterType="yui.bss.model.vo.online.OnlinePersCourseVo" resultType="yui.bss.model.vo.online.OnlinePersCourseVo">
        select t1.ONLINE_COURSE_PK courseId,t3.is_pass pass,t3.exam_status examStatus,t3.perc coursePerc,t3.user_id userId,t1.type,t1.ONLINE_COURSE_PK "course.onlineCoursePk",
        t1.NM  "course.nm",t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
        from t_online_course t1 join  t_post_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
        left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
        <if test="employeeId!=null">and  t3.employee_id=#{employeeId}</if><!-- 根据编号查询 -->
        <where>
            <if test="postId!=null">and t2.post_id=#{postId}</if> <!-- 根据岗位编号查询 -->
            <if test="pass!=null">and is_pass=#{pass}</if><!--根据考试通过状态查询-->
        </where>
        UNION  <!-- 选修课程  -->
        select t1.ONLINE_COURSE_PK courseId,t3.is_pass pass,t3.exam_status examStatus,t3.perc coursePerc,t3.user_id userId,t1.type,t1.ONLINE_COURSE_PK "course.onlineCoursePk",
        t1.NM "course.nm",t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
        from t_online_course t1 join  t_corp_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
        left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
        <if test="employeeId!=null">and  t3.employee_id=#{employeeId}</if><!-- 根据编号查询 -->
        <where>
            <if test="corpId!=null">and t2.corp_id=#{corpId}</if> <!-- 根据企业编号编号 -->
            <if test="pass!=null">and is_pass=#{pass}</if><!--根据考试通过状态查询-->
        </where>
    </select>

    <select id="getList" parameterType="yui.bss.model.vo.online.OnlinePersCourseVo" resultType="yui.bss.model.vo.online.OnlinePersCourseVo">

        <choose>
            <when test="type!=null and type==1">
                SELECT t1.ONLINE_COURSE_PK "course.onlineCoursePk", t2.course_id courseId,t1.NM "course.nm", perc coursePerc,
                t1.LESSON_QTY "course.LessonQty",t1.LESSON_DURA "course.lessonDura", t1.img_url "course.imgUrl",perc
                FROM t_online_course t1 join  t_post_course_link t2 on t1.ONLINE_COURSE_PK = t2.course_id
                left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id <!-- 三表join关联查询【双条件排重匹配】使用例子  -->
                <if test="employeeId!=null">and  t3.employee_id=#{employeeId}</if><!-- 根据编号查询 -->
                <if test="userId!=null">and t3.user_id=#{userId}</if><!-- 根据员工账号查询 -->
                <where>
                    <if test="postId!=null"> AND t2.post_id = #{postId}</if>  <!-- 根据岗位编号查询 -->
                </where>
            </when>
            <otherwise>
                select t1.NM "course.nm", t1.ONLINE_COURSE_PK "course.onlineCoursePk",t2.course_id courseId,perc coursePerc,
                t1.LESSON_QTY "course.LessonQty", t1.LESSON_DURA "course.lessonDura",t1.img_url "course.imgUrl"
                FROM t_online_course t1 join  t_corp_course_link t2  on t1.ONLINE_COURSE_PK=t2.course_id
                left join t_online_pers_course t3 on t1.ONLINE_COURSE_PK=t3.course_id and t3.course_id=t2.course_id
                <if test="employeeId!=null">and  t3.employee_id=#{employeeId}</if><!-- 根据编号查询 -->
                <if test="userId!=null">and t3.user_id=#{userId}</if><!-- 根据员工账号查询 -->
                <where>
                    <if test="corpId!=null">and t2.corp_id=#{corpId}</if> <!-- 根据企业编号编号 -->
                </where>
            </otherwise>
        </choose>
    </select>

</mapper>
