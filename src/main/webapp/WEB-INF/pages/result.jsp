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
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- line:3 -->
		<div class="row">
			 <table class="table table-hover">
			  <tr>
			    <th>#</th>
			    <th>name</th>
			    <th>gender</th>
			    <th>email</th>
			    <th>department</th>
			    <th>option</th>
			  </tr>
			  <c:forEach items="${pageInfo.list }" var="emp">
			  <tr>
			    <th>${emp.empId }</th>
			    <th>${emp.empName }</th>
			    <th>${emp.gender == "M" ? "男" : "女" }</th>
			    <th>${emp.email }</th>
			    <th>${emp.department.deptName }</th>
			    <th>
					<button class="btn btn-primary btn-sm">
					 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					修改
					</button>
					<button class="btn btn-danger btn-sm">
					 <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					删除
					</button>
				</th>
			  </tr>
			  </c:forEach>
			</table>
		</div>
		<!-- line:4 -->
		<div class="row">
			<div class="col-md-6">
				 <h5>当前为第${pageInfo.pageNum }页，总页数为${pageInfo.pages },总数量为${pageInfo.total }</h5>
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li><a href="${APP_PATH }/emps?pn=${1 }">首页</a></li>
				    <c:if test="${pageInfo.hasPreviousPage }">
				    <li>
				      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1 }" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums }" var="navigatePages">
					    <c:if test="${navigatePages == pageInfo.pageNum }">
					    <li class="active"><a href="#">${navigatePages }</a></li>
					    </c:if>
					    <c:if test="${navigatePages != pageInfo.pageNum }">
					    <li><a href="${APP_PATH }/emps?pn=${navigatePages }">${navigatePages }</a></li>
					    </c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage }">
				    <li>
				      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1 }" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				    </c:if>
				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">尾页</a></li>
				  </ul>
				</nav> 
			</div>
		</div>
	</div>

</body>
</html>