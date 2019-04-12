<!DOCTYPE html>
{assign var="appName" value=$app->configuration->appName}
<html>
	<head>
{*may not be needed*}		<meta charset="utf-8">
{*may not be needed*}    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>{if $pageTitle}{$pageTitle|escape} &mdash; {/if}{$appName|escape}</title>
		<base href="{$baseUrl|escape}/">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, shrink-to-fit=no">
		<!--Import Google Icon Font-->
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="assets/scss/app.scss.css">
		<!-- <link rel="stylesheet" type="text/css" href="assets/css/app.css"> -->
		<link rel="stylesheet" type="text/css" href="assets/css/fontawesome-all.min.css">
		<link rel="stylesheet" href="assets/js/highlight/styles/monokai-sublime.css">
		<link rel="stylesheet" type="text/css" media="print" href="assets/css/app-print.css">
		<!-- <link rel="stylesheet" type="text/css" href="assets/css/ie.css" media="screen"> -->
		<!-- <link href='//fonts.googleapis.com/css?family=Montserrat:400,700|Lato:400,700,900' rel='stylesheet' type='text/css'> -->
		<link rel="stylesheet" id="Lato-css" href="https://fonts.googleapis.com/css?family=Lato%3A1%2C100%2C300%2C400%2C400italic%2C700&amp;ver=4.9.9" type="text/css" media="all">
		<link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.ico" />
		<script>document.write('<link rel="stylesheet" type="text/css" href="assets/css/app-js.css" media="screen">');</script>
	</head>

	<body>
		<a href="#mainContent" class="sr-only sr-only-focusable">Skip Navigation</a>
		<!-- <header class="at {if !$viewer || $homePage}pb-3{/if}"> -->

		<header class="at" >
			<span id="goToTop" class="hidden" aria-hidden="true"></span>
		    <nav class="navbar navbar-light flex-md-nowrap">
		    	<div class="navbar-brand col-sm-3 col-md-2 bg-light {if $minimized}brand-minimized{/if}">
			      	<a class="pr-3" href="{$baseUrl}" >
			      		<img src="assets/images/AT-Syllabus-Icon-600x403-20pxBorder.png" height="35" class="d-inline-block align-middle" alt="Syllabus Logo" id="brandLogo"><span class="sidebar-text pl-2 brand-text">Syllabus</span></a>
					{if $viewer}<i class="fa fa-chevron-left d-block-inline" id="sidebarToggle"></i>{/if}
					<!-- <i class="fa fa-chevron-right hidden" id="sidebarToggle2"></i> -->
				</div>
		      	<!-- <input class="form-control form-control-dark w-25 " type="text" placeholder="Search" aria-label="Search"> -->
		      	<ul class="navbar-nav p-2 ml-auto">
				{if $viewer}
					{if $pAdmin}
					<li class="nav-item">
						<a class="nav-link" href="admin"><i class="fas fa-cog"></i> Administrate</a>
					</li>
					{/if}
			
				{else}
					<li class="nav-item">
						<a class="login-button nav-link" href="{$app->baseUrl('login')}">Login</a>
					</li>
				{/if} 
				</ul>
				{if $viewer}
					<form method="post" action="logout" class="form logout-form p-2">
						<button class="btn btn-outline-secondary logout " type="submit" name="command[logout]" id="logout-button" value="Logout">Logout</button>
					</form>
				{/if}
		    </nav>

		</header>		



		{if $app->siteSettings->siteNotice}
		<div class="site-notice action notice">
			{$app->siteSettings->siteNotice}
		</div> 
		{/if}

		{if $flashContent}
		<div id="user-message" class="alert alert-{$flashClass} alert-dismissable my-3 rounded-0 fade show" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<div class="primary">{$flashContent}</div>
		</div> 
		{/if}

		{if $userMessageList}
		<div id="user-message" class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			{foreach item="msg" from=$userMessageList}
			<div class="primary">{$msg.primary}</div>
			{foreach item="detail" from=$msg.details}<div class="detail">{$detail}</div>{/foreach}
			{/foreach}
		</div> 
		{/if}

		<div class="container-fluid">
			<div class="row">
				{if $viewer}
				<!-- TODO: put this in a partial template and generate links programmatically -->
				<nav class="col-md-2 d-none d-md-block sidebar bg-light {if $minimized}sidebar-minimized{/if}" id="sidebar">
					<div class="sidebar-sticky">
						<br><br><br>
						<ul class="nav flex-column">
							<li class="nav-item mb-5">
								<a class="nav-link" href="syllabi">
									<h6 class="sidebar-heading mt-4 mb-1 text-muted">
										<i class="fas fa-user fa-2x ml-2"></i>
									</h6>
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="syllabi">
									<h6 class="sidebar-heading d-flex justify-content-between align-items-center mt-4 mb-1 text-muted">
										<span><i class="my-syllabi fas fa-home fa-2x pr-2"></i> <span class="sidebar-text">My Syllabi</span></span>
									</h6>
								</a>
								<ul class="nav flex-column pl-3">
									<li class="nav-item">
										<a class="nav-link" href="syllabus/new">
											<span class="sidebar-text">Create New Syllabus</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="syllabi">
											<span class="sidebar-text">Overview</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="syllabi?mode=course">
											<span class="sidebar-text">Courses</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="syllabi?mode=submission">
											<span class="sidebar-text">Submissions</span>
										</a>
									</li>
								</ul>
							</li>
						</ul>

						<ul class="nav flex-column">
							<li class="nav-item">
								<a class="nav-link" href="#">
									<h6 class="sidebar-heading d-flex justify-content-between align-items-center mt-4 mb-1 text-muted">
										<span><i class="fas fa-school fa-2x pr-2"></i> <span class="sidebar-text">My Groups</span></span>
									</h6>
								</a>
								<ul class="nav flex-column pl-3">
									<li class="nav-item">
										<a class="nav-link" href="#">
											<span class="sidebar-text">English</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#">
											<span class="sidebar-text">Liberal & Creative Arts</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#">
											<span class="sidebar-text">CEETL</span>
										</a>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
				{/if}
				
				
				{if $headerPartial}
				<!-- <main role="main" class="col-md-9 col-lg-10 px-3 mt-0" id="mainContent"> -->
				<main role="main" class="col px-3 mt-0" id="mainContent">
					{include file=$headerPartial headerVars=$headerVars}
				{else}
				<!-- <main role="main" class="col-md-9 col-lg-10 px-3 mt-3" id="mainContent"> -->
				<main role="main" class="col px-3 mt-3" id="mainContent">
				{/if}
					<!-- MAIN CONTENT -->
					{include file=$contentTemplate}
				</main>

			</div>
		</div>       


		{if !$viewer}
		<div id="login-box" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3>Choose Login Method</h3>
					</div>
					<div class="modal-body">
						<p>Loading login options&hellip;</p>
					</div>
				</div>
			</div>
		</div>
		{/if}

		<footer class="sticky-footer fixed-bottom">
			<nav class="navbar at-footer">
				<div class="footer-row-1 container-fluid">
					<div class="container">
						<div class="row">
							<div class="info col">
								<h1>Maintained by <a href="http://at.sfsu.edu" class="title">Academic Technology</a></h1>
								<p>Academic Technology supports and advances effective learning, teaching, scholarship, and community service with technology.</p>
							</div>
							<div class="learn-more col">
								<div class="row">
									<div class="half col">
										<h2>We Also Work On</h2>
										<ul class="list-unstyled">
											<li><a href="https://ilearn.sfsu.edu/">iLearn</a></li>
											<li><a href="http://at.sfsu.edu/labspace">Labspace</a></li>
											<li><a href="http://at.sfsu.edu/coursestream">CourseStream</a></li>
										</ul>
									</div>
									<div class="half col">
										<h2>Need Help?</h2>
										<ul>
											<li>(415) 405-5555</li>
											<li><a href="mailto:ilearn@sfsu.edu">ilearn@sfsu.edu</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="footer-row-2 container-fluid">
					<div class="container">
						<div class="row">
							<div id="contact-university" class="col">
								<a href="http://www.sfsu.edu/"> <img src="assets/images/logo.png" alt="San Francisco State University Logo" width="50" class="logo"></a>
								<ul class="list-unstyled">
									<li><a href="http://www.sfsu.edu/">San Francisco State University</a></li>
									<li class="first"><a href="http://www.calstate.edu/">A California State University Campus</a></li>
								</ul>
							</div>
							<div id="contact-local" class="col">
								<ul class="list-unstyled">
									<li><strong>Academic Technology</strong></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</footer>

		<script> 
			var CKEDITOR_BASEPATH = "{$baseUrl|escape}/assets/js/ckeditor/"; 
			window.CKEDITOR_BASEPATH = CKEDITOR_BASEPATH;
		</script>
		<script src="assets/js/app.js"></script>


		{if $analyticsCode}{literal}
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			ga('create', '{/literal}{$analyticsCode}{literal}', 'auto');
			ga('send', 'pageview');
		</script>
		{/literal}{/if}

	</body>
</html>
