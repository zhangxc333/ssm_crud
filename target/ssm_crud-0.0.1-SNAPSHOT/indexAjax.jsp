<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工查询列表</title>
<!-- 
web的路径：
不以/斜杠开始的路径为相对路径，以当前的路径为基准找资源，经常任意出错。
以/斜杆开始的路径为绝对路径，以服务器的路径（http://localhost:3306）为准，
	需要加上项目名称http://localhost:3306/crud
 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- Bootstrap -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="static/jQuery-1.12.4/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<div class="container">
		<!-- line:1 -->
		<div class="row">
			<div class="col-md-4">
				 <h1>SSM_CRUD</h1>
			</div>
		</div>
		<!-- line:2 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_btn">删除</button>
			</div>
		</div>
		<!-- line:3 -->
		<div class="row">
			 <table class="table table-hover" id="emps_table">
			 <thead>
				  <tr>
				    <th><input type="checkbox" id="checkbox_all"></th>
				    <th>#</th>
				    <th>name</th>
				    <th>gender</th>
				    <th>email</th>
				    <th>department</th>
				    <th>option</th>
				  </tr>
			  </thead>
			  <tbody>
			  
			  </tbody>
			  
			</table>
		</div>
		<!-- line:4 -->
		<div class="row">
			<div class="col-md-6" id = "page_info">
				 
			</div>
			<div class="col-md-6" id="page_nav">
				
			</div>
		</div>
	</div>
	
	<!-- Modal:员工新增窗口 -->
	<!-- 
	id:用于前端代码的调用
	name：用于后端处理数据（这里与Employee对象的属性相对应）
	mpName=hello&gender=M&email=642401016%40qq.xom&cId=1
	 -->
	<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
		  	<form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="empName" name="empName" placeholder="empName">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
		    		<label class="col-sm-2 control-label">gender</label>
					<div class="col-sm-10">
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender" value="M" checked="checked">男
						</label>
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender" value="F">女
						</label>
					</div>
				</div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="email" name="email" placeholder="email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">department</label>
				    <div class="col-sm-4">
				     	<select class="form-control" name="cId">

						</select>
				    </div>
				  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="add_emp_save">保存</button>
	      </div>
	    </div>
	  </div>
	</div>


	<!-- Modal2:员工修改窗口 -->
	<div class="modal fade" id="emp_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
	      </div>
	      <div class="modal-body">
		  	<form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="update_static"></p>
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
		    		<label class="col-sm-2 control-label">gender</label>
					<div class="col-sm-10">
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender" value="M" checked="checked">男
						</label>
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender" value="F">女
						</label>
					</div>
				</div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="update_email" name="email" placeholder="email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">department</label>
				    <div class="col-sm-4">
				     	<select class="form-control" name="cId">

						</select>
				    </div>
				  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="update_emp_btn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script type="text/javascript">
		
	//页面加载完成后，直接发送一个ajax请求，查询分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/empsAjax",
				data:"pn=" + pn,
				type:"GET",
				success:function(msg){
					// console.log(msg); 将返回信息msg显示在控制台
					//1、解析并显示员工信息
					build_emps_table(msg);
					//2、解析并显示分页信息
					buile_page_info(msg);
					//3、解析并显示导航信息
					build_page_nav(msg);
				}
			});
		}
		
		function build_emps_table(msg){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = msg.extend.pageInfo.list;
			$.each(emps, function(index, item){

				var checkbox = $("<td><input type='checkbox' class='checkbox_item'></td>");
				var empId = $("<td></td>").append(item.empId);
				var empName = $("<td></td>").append(item.empName);
				var gender = $("<td></td>").append(item.gender=="M"?"男":"女");
				var email = $("<td></td>").append(item.email);
				var departmentName = $("<td></td>").append(item.department.deptName);
	
				var dltButton =  $("<button></button>").addClass("btn btn-primary btn-sm update_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
				//给按钮添加自定义属性。
				dltButton.attr("emp_id", item.empId);
				var updButton = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				updButton.attr("emp_id", item.empId);
				var option = $("<td></td>").append(dltButton).append(" ").append(updButton);
				
				$("<tr></tr>").append(checkbox).append(empId).append(empName).append(gender)
					.append(email).append(departmentName).append(option).appendTo("#emps_table tbody");
			});		
		}
		function buile_page_info(msg){
			$("#page_info").empty();
			//当前为第 页，总页数为 ,总数量为 
			$("#page_info").append("当前为第" + msg.extend.pageInfo.pageNum + "页，总页数为" 
					+ msg.extend.pageInfo.pages + ",总数量为 " + msg.extend.pageInfo.total + ".");
			//下文出现的全局变量，用于后续页面的查询
			pageNum = msg.extend.pageInfo.pageNum;
		}
		function build_page_nav(msg){
			//page_nav
			$("#page_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(msg.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(msg.extend.pageInfo.pageNum -1);
				});
			}
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(msg.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(msg.extend.pageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(msg.extend.pageInfo.pages);
				});
			}
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(msg.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(msg.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav");
		}
		
		//表单重置函数
		function form_reset(element){
			//jquery没有.reset()方法，需要使用dom的方法。
			$(element)[0].reset();
			$(element).find(".help-block").text("");
			$(element).find("*").removeClass("has-error has-success");
			
		}
		
		function select_dept(element){
			
			$.ajax({
				url:"${APP_PATH}/dept",
				type:"GET",
				success:function(msg){
					//console.log(msg);
					//department: Array(2) 0: {deptId: 1, deptName: "开发部"} 1: {deptId: 2, deptName: "测试部"}
					$(element).empty();
					$.each(msg.extend.department, function(index, item){
						var option = $("<option></option>").append(item.deptName).attr("value", item.deptId);
						$(element).append(option);				
					});
				}
			});
		}
		
		//新建按钮触发功能
		$("#emp_add_btn").click(function(){
			//重置表单数据、及添加的类型
			form_reset("#emp_add_modal form");
			//静态框触发之前，查询发送ajax请求，查询部门信息
			select_dept("#emp_add_modal select");

			//单击新增按钮，触发静态框
			$("#emp_add_modal").modal({
				backdrop: "static"
			});
		});
		
		//保存新建数据
		$("#add_emp_save").click(function(){
			//1、在数据保存之前，添加格式校验信息
 			if(!validate_add_empFormat()){
				return false;
 			}
			
			//判断用户名是否通过同名检查，同名之后不能保存
			if($("#add_emp_save").attr("check_name") == "error"){
				return false;
			}
			
			//alert($("#emp_add_modal form").serialize());	
			//empName=hello&gender=M&email=642401016%40qq.xom&cId=1
			$.ajax({
				url:"${APP_PATH}/empsAjax",
				type:"POST",
				data:$("#emp_add_modal form").serialize(),
				success:function(result){
					if(result.code == 100){
					//员工保存成功
					//alert(msg.msg);
					//1、关闭模态框
					$('#emp_add_modal').modal('hide');
					//2、返回最后一页
					to_page(9999);
					}else{
						//JSR后端校验结果显示
						if(result.extend.fieldError.email != null){
							validate_emp_show("#email", "error", "邮件格式不正确")
						}
						if(result.extend.fieldError.empName != null){
							validate_emp_show("#empName", "error", "姓名格式不正确")
						}
					}
				}
			});
			
		});
		
		//封装格式验证方法
		function validate_add_empFormat(){
			
			var empName = $("#empName").val();		
			var regName = /((^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$))/;
			
			if(!regName.test(empName)){
				//alert("姓名格式不正确，请输入3-6位的字符数字，或者2-5位的中文。");
				validate_emp_show("#empName", "error", "姓名格式不正确，请输入3-6位的字符数字，或者2-5位的中文。")
				return false;
			}else{
				validate_emp_show("#empName", "success", "")
			}

			var emile = $("#email").val();		
			var regEmile = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmile.test(emile)){
				validate_emp_show("#email", "error", "邮件格式不正确")
				 return false;
			}else{
				validate_emp_show("#email", "success", "")
			}
			
				return true;
		}
		
		//封装统一的验证显示方法
		function validate_emp_show(element, status, msg){
			//每次显示前，清除原有的"has-error has-success"信息
			$(element).parent().removeClass("has-error has-success");
			
			if(status == "error"){
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}
			if(status == "success"){
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			}
			
		}
		
		//名称重名验证
		$("#empName").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				type:"POST",
				data:"empName=" + empName,
				success:function(msg){
					
					if(msg.code == 100){
						validate_emp_show("#empName", "success", "用户名可用");
						$("#add_emp_save").attr("check_name", "success")
					}
					if(msg.code == 200){
						validate_emp_show("#empName", "error", msg.extend.validate_msg);
						$("#add_emp_save").attr("check_name", "error")
					}
				}
			});
			
		});
		
		//单击加载修改模态框
		//on()方法绑定事件：按钮是通过jquery之后添加，不能直接使用.click()点击事件
		$(document).on("click", ".update_btn", function(){
			//查出数据显示在模态框中
			getEmp($(this).attr("emp_id"));
			//查出部门信息
			select_dept("#emp_update_modal select");
			//启动模态框
			$("#emp_update_modal").modal({
				backdrop: "static"
			});
			
			//在模态框上的修改按钮上添加emp_id属性
			$("#update_emp_btn").attr("emp_id", $(this).attr("emp_id"));
		});

		//查询数据，并显示
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/empAjax/" + id,
				type:"GET",
				success:function(message){
					var employee = message.extend.emp;
					$("#update_static").text(employee.empName);
					$("#update_email").val(employee.email);
					$("#emp_update_modal input[name=gender]").val([employee.gender]);
					$("#emp_update_modal select").val([employee.cId]);
				}
			});
		}
		
		//全局变量，pageNum在查询页面的时候赋值
		var pageNum;
		$("#update_emp_btn").click(function(){
			$.ajax({
				url:"${APP_PATH}/empAjax/" + $("#update_emp_btn").attr("emp_id"),
				data:$("#emp_update_modal form").serialize(),
				type:"PUT",
				success:function(message){
					//保存完成后
					//1、关闭模态框
					$('#emp_update_modal').modal('hide');
					//2、查询到当前页
					to_page(pageNum);
					
				}
			});
			
		});
		
		//删除
		//on()方法绑定事件：按钮是通过jquery之后添加，不能直接使用.click()点击事件
		$(document).on("click", ".delete_btn", function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			
			if(confirm("是否确定删除 " + empName + " ?")){
				$.ajax({
					url:"${APP_PATH}/empAjax/" +  $(this).attr("emp_id"),
					type:"DELETE",
					success:function(message){
						alert(message.msg);
						to_page(pageNum);
					}
					
				});
				
			}else{
			}
		});
		
		//全选/全不选
		$("#checkbox_all").click(function(){
			//prop获取dom原生的属性；attr获取自定义的属性
			$(".checkbox_item").prop("checked",$(this).prop("checked"));
		});
		
		//item等于总数时，全选框自动勾选
		$(document).on("click", ".checkbox_item", function(){
			//:checked 匹配所有被选中的checkbox个数
			var flag = $(".checkbox_item:checked").length == $(".checkbox_item").length;
			$("#checkbox_all").prop("checked",flag);
			
		});
		
		//批量删除
		$("#emp_delete_btn").click(function(){
			var empName = "";
			var empIds = "";
			$.each($(".checkbox_item:checked"),function(){
				empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
				empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			empName = empName.substring(0,empName.length-1);
			empIds = empIds.substring(0,empIds.length-1);
			
			if(confirm("是否批量删除" + empName + " ?")){
				$.ajax({
					url:"${APP_PATH}/empAjax/" +  empIds,
					type:"DELETE",
					success:function(message){
						alert(message.msg);
						to_page(pageNum);
					}
					
				});
			}
		});
		
	</script>

</body>
</html>