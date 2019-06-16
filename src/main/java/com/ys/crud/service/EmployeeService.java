package com.ys.crud.service;

import java.util.List;

import com.ys.crud.bean.Employee;

public interface EmployeeService {
	List<Employee> getEmps();

	void savaEmps(Employee employee);
	
	boolean chechUser(String name);
	
	Employee getEmp(int id);
	
	void updateEmp(Employee employee);
	
	void deleteEmp(int id);
	
	void deleteEmps(List<Integer> list);
}
