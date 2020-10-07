<%@ include file="/WEB-INF/jsp/template/tags.jsp"%>
<%@ include file="/WEB-INF/jsp/template/header.jsp"%>

<body class="middle-content page-login">
	<!-- TOP BAR -->
	<nav class="top-bar navbar-fixed-top" role="navigation">
		<div class="row">
			<div class="col-md-4 col-sm-4 col-xs-7">
				<div class="logo pull-left">
					<img src="resources/img/synopsys_wht.png"/>
					&nbsp; &nbsp;
					<i class="fa fa-university fa-logo"></i> <span class="logo-text">SIG Insecure Bank </span>
				</div>
			</div>
			
		</div>
	</nav>
	<!-- END TOP BAR -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-5 col-sm-offset-1 col-lg-4 col-lg-offset-2">
				<div class="content-box-bordered login-box box-with-help">
					<h1>Log in to your account</h1>
					<c:if test="${param.authenticationFailure == true}">
						<div class="alert alert-warning fade in">
							<i class="icon ion-alert-circled"></i>
							<strong>Invalid username or password</strong> 
						</div>
					</c:if>
					<c:if test="${param.logout == true}">
						<div class="alert alert-warning fade in">
							<i class="icon ion-alert-circled"></i>
							<strong>You have successfully logged out.</strong> 
						</div>
					</c:if>					
					<form action="" method="POST" accept-charset="utf-8" class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3b" class="control-label sr-only">Email</label>
							<div class="col-sm-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="icon ion-person"></i></span>
									<input name="username" class="form-control" id="inputUsername" placeholder="Username" autofocus="autofocus">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3b" class="control-label sr-only">Password</label>
							<div class="col-sm-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="icon ion-locked"></i></span>
									<input name="password" type="password" class="form-control" id="inputPassword" placeholder="Password">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-7">
								<button type="submit" class="btn btn-primary btn-block">Sign in</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-sm-5 col-lg-4">
				<div class="login-copytext">
					<h2>Welcome!</h2>
					<p> Log in to access your checking, savings, credit cards, and mortgage accounts.</p>
					<h2>Financial Security</h2>
					<p>Check balances, make transfers, make payments, and make toast. Is it secure?
					Absolutely not! Can you pay your rocket fuel bill quickly? Of course!</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/queen-form-layouts.js"></script>

</body>
<style>
.fa-logo {
	color: #fff;
	font-size: 18px;
}

.logo-text {
	color: #fff;
	font-family: 'Oswald';
	font-size: 16px;	
}


</style>	
<%@ include file="/WEB-INF/jsp/template/footer.jsp"%>
