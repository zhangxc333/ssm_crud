package com.ys.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ys.crud.bean.Employee;
import com.ys.crud.bean.Msg;
import com.ys.crud.service.EmployeeServiceImp;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeServiceImp employeeServiceImp;
	
	@RequestMapping("/emps")
	public ModelAndView getEmps(@RequestParam(value = "pn", defaultValue = "1")int pn) {
		
	    ModelAndView modelAndView = new ModelAndView("result");
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeServiceImp.getEmps();
		//PageInfo中包含导航数的构造函数
		PageInfo info = new PageInfo(list, 5);
		//将相关数据封装到pageInfo中，pageIngo自身也具有很强的数据处理能力
		modelAndView.addObject("pageInfo", info);
		return modelAndView;		
	}
	
	//@Responsebody 表示以json的形式返回数据，另外还需在pom.xml文件中引入jackson jar包
	@ResponseBody
	@RequestMapping("/empsAjax")
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1")int pn) {
		
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeServiceImp.getEmps();
		PageInfo info = new PageInfo(list, 5);
		return Msg.success().add("pageInfo", info);		
	}
	
	
	/**
	 * 支持JSR303数据校验
	 * 1、导入hiubernate-validator jar包
	 * 2、
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/empsAjax", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("fieldError", map);
			
		}else {
			employeeServiceImp.savaEmps(employee);
			return Msg.success();
		}

	}
	
	@RequestMapping(value = "/checkUser", method = RequestMethod.POST)
	@ResponseBody
	public Msg checkUser(String empName) {
		//名称格式的后端校验
		String regex = "(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
		if(!empName.matches(regex)) {
			return Msg.fail().add("validate_msg", "名字格式因为3-16位的数字和字符，或者2-5位的中文");
		}
		//数据库用户名重复校验
		boolean b = employeeServiceImp.chechUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("validate_msg", "名字不可用");
		}
		
	}
	
	@RequestMapping(value="/empAjax/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")int id) {
		Employee emp = employeeServiceImp.getEmp(id);
		return Msg.success().add("emp", emp);
	}

	/*
	 * 	empId根据id更新员工，这里的empId要与employee对象中的id名称对应，否者不能自动封装，
	 * 	类似于表单中属性的name名称
	 */
	@ResponseBody
	@RequestMapping(value = "/empAjax/{empId}", method = RequestMethod.PUT)
	public Msg updateEmp(Employee employee) {
		//System.out.println(employee);
		employeeServiceImp.updateEmp(employee);
		
		return Msg.success().add("emp", employee);
		
	}

	@ResponseBody
	@RequestMapping(value = "/empAjax/{empIds}", method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("empIds") String empIds) {
		if(empIds.contains("-")) {
			List<Integer> list = new ArrayList<Integer>();
			String[] split = empIds.split("-");
			for (String string : split) {
				list.add(Integer.parseInt(string));
			}
			employeeServiceImp.deleteEmps(list);
			return Msg.success();
			
		}else {
			int empId = Integer.parseInt(empIds);
			//System.out.println(employee);
			employeeServiceImp.deleteEmp(empId);
			return Msg.success();
			
		}
	}
	
}
