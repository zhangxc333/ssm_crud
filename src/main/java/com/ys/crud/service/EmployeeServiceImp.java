package com.ys.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ys.crud.bean.Employee;
import com.ys.crud.bean.EmployeeExample;
import com.ys.crud.bean.EmployeeExample.Criteria;
import com.ys.crud.dao.EmployeeMapper;

@Service
public class EmployeeServiceImp implements EmployeeService{

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getEmps() {
		
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void savaEmps(Employee employee) {
		
		employeeMapper.insertSelective(employee);
		
	}

	public boolean chechUser(String name) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(name);
		long countByExample = employeeMapper.countByExample(example);
		return countByExample == 0;
	}

	public Employee getEmp(int id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteEmp(int id) {
		employeeMapper.deleteByPrimaryKey(id);
		
	}

	public void deleteEmps(List<Integer> list) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
		
	}

}
