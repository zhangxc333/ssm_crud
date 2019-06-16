package com.ys.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ys.crud.bean.Department;
import com.ys.crud.bean.Msg;
import com.ys.crud.service.DepartmentServiceImp;

@Controller
public class DepartmentController {

	@Autowired
	DepartmentServiceImp departmentServiceImp;
	
	@ResponseBody
	@RequestMapping("/dept")
	public Msg getDept() {
		
		List<Department> dept = departmentServiceImp.getDept();
		
		return Msg.success().add("department", dept);
		
	}
}
