package com.ys.crue.test;


import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
/**
 * 
 * 测试mybatis中dao层
 * 
 * 推荐spring的项目可以使用spring的测试单元，可以自动注入我们需要的组件。(而不需要使用mybatis的方法)
 * 
 * 1、导入spring-test模块对应的的jar
 * 2、利用ContentConfiguration 指定spring配置文件的位置
 * 3、Runwith,把所有的test交由SpringJUnit4ClassRunner.class处理
 * 4、直接注入mapper接口
 * 
 * @author 姚顺
 *
 */

import com.ys.crud.bean.Employee;
import com.ys.crud.dao.DepartmentMapper;
import com.ys.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/applicationContext.xml")
public class MybatisMapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;

	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
		System.out.println(employee);
		
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 500; i++) {
//			String substring = UUID.randomUUID().toString().substring(0, 5);
//			mapper.insertSelective(new Employee(null, substring, "F", substring + "@ys.con", 1));
//		}
//		
	}
}
