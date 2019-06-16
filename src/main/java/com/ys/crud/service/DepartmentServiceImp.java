package com.ys.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ys.crud.bean.Department;
import com.ys.crud.dao.DepartmentMapper;

@Service
public class DepartmentServiceImp implements DepartmentService{
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getDept() {
		// TODO Auto-generated method stub
		return departmentMapper.selectByExample(null);
	}


}
