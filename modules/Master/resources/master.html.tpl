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
		<!-- <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
		<link rel="stylesheet" type="text/css" href="assets/scss/app.scss.css">
		<!-- <link rel="stylesheet" type="text/css" href="assets/css/fontawesome-all.min.css"> -->
		<link type="text/css" href="assets/css/all.css" rel="stylesheet">
		<!-- <script defer src="assets/js/all.js"></script> -->
		<link rel="stylesheet" href="assets/js/highlight/styles/monokai-sublime.css">
		<link rel="stylesheet" type="text/css" media="print" href="assets/css/app-print.css">
		
		<link href='//fonts.googleapis.com/css?family=Montserrat:400,700|Lato:400,700,900' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" id="Lato-css" href="https://fonts.googleapis.com/css?family=Lato%3A1%2C100%2C300%2C400%2C400italic%2C700&amp;ver=4.9.9" type="text/css" media="all">
		<link href="https://fonts.googleapis.com/css?family=Vollkorn+SC&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Vollkorn&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Old+Standard+TT&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
		<!-- <link rel="shortcut icon" type="image/x-icon" href="assets/icons/logo-3-128.png" /> -->
		<link rel="shortcut icon" type="image/x-icon" href="assets/icons/logo_square_128-01.png"  />

		<meta property="og:title" content="Syllabus Tool at SF State" />
		<meta property="og:description" content="There is a new way to create and share your syllabus with your students! Users are encouraged to explore the new Syllabus application, build out syllabi, or transfer content from the existing tool into the new one." />
		<meta name="twitter:title" content="Syllabus Tool at SF State">
		<meta name="twitter:description" content="There is a new way to create and share your syllabus with your students! Users are encouraged to explore the new Syllabus application, build out syllabi, or transfer content from the existing tool into the new one.">

		<meta property="og:image"
		      content="assets/icons/logo_square_128-01.png" />

		<meta name="twitter:image:src"
		      content="assets/icons/logo_square_128-01.png">

		<script>document.write('<link rel="stylesheet" type="text/css" href="assets/css/app-js.css" media="screen">');</script>
	</head>

<body>
	<a href="#mainContent" class="sr-only sr-only-focusable">Skip Navigation</a>

    <div class="wrapper" id="mainTemplate">
	{if $viewer}
        <!-- Sidebar  -->
        <nav id="sidebar" class="bg-dark {if $sidebarMinimized}active{/if}">
            <div class="sidebar-header bg-light navbar">
            	<div class="navbar-brand d-block-inline  d-flex justify-content-between">
                <a class="" href="{$baseUrl}{if $viewer}/syllabi{/if}">
					<img src="assets/icons/logo_square_512-01.png" width="48" height="48" class="d-inline-block mr-3" alt="Syllabus Logo" id="brandLogo"><span class="sidebar-text pr-2 brand-text">Syllabus</span></a>
				</div>
            </div>

			<ul class="list-unstyled components">

				{if $ilearnReturnUrl}
				<li class="">
					<a class="nav-category border-bottom mt-0 d-flex justify-content-center text-dark bg-info" href="{$ilearnReturnUrl}" id="sidebarMySyllabi">
						<i class="fas fa-external-link-alt pt-2"></i><span class="sidebar-text pl-1"> Return to iLearn</span>
					</a>
				</li>
				{/if}

				<li class="mt-3">
					<a class="nav-category" href="syllabi" id="sidebarMySyllabi">
						<img class="my-syllabi" src="assets/icons/menu-my-syllabi.svg" width="44"> <span class="pl-2 sidebar-text">My Syllabi</span>
					</a>
					{if $pFaculty || $pProgramAdmin || !$isStudent}
					<ul class="list-unstyled">
						<li class="{if $page == 'start'}active{/if}">
							<a class="sub-link" href="syllabus/start">
								<span class="sidebar-text">Create New Syllabus</span>
							</a>
						</li>
						<li class="{if $page == 'overview'}active{/if}">
							<a class="sub-link" href="syllabi?mode=overview">
								<span class="sidebar-text">Overview</span>
							</a>
						</li>
						<li class="{if $page == 'courses'}active{/if}">
							<a class="sub-link" href="syllabi?mode=courses">
								<span class="sidebar-text">Courses</span>
							</a>
						</li>
<!-- 						<li class="{if $page == 'submissions'}active{/if}">
							<a class="sub-link" href="syllabi?mode=submissions">
								<span class="sidebar-text">Submissions</span>
							</a>
						</li> -->
						{if !$privilegedOrganizations['departments'] && !empty($privilegedOrganizations['groups']) && !$pAdmin}
						{assign var=groups value=$privilegedOrganizations['groups']}
						{assign var=addedAsSubLink value=true}
						<li class="{if $page == 'groups'}active{/if}">
							<a class="sub-link" href="groups/{$groups->id}">
								<span class="sidebar-text">{$groups->name}</span>
							</a>
						</li>
						{/if}
					</ul>
					{/if}
				</li>
			</ul>
			{if $pFaculty || $pProgramAdmin || !$isStudent}
			{if $privilegedOrganizations['departments'] || $pAdmin}
			<ul class="list-unstyled components my-orgs">
				<li class="">
					<a class="nav-category" href="departments" id="sidebarMyOrganizations">
						<img class="my-orgs fa-school" src="assets/icons/menu-my-orgs.svg" width="38"> <span class="pl-2 sidebar-text">My Organizations</span>
					</a>
					{assign var=departments value=$privilegedOrganizations['departments']}
					<ul class="list-unstyled">
					{if !empty($departments) && count($departments) == 1}
						{foreach $departments as $dept}
						<li class="{if $page == 'departments'}active{/if}">
							<a class="sub-link" href="departments/{$dept->id}">
								<span class="sidebar-text">
									{$dept->name}
								</span>
							</a>
						</li>
						{/foreach}
					{/if}
					{assign var=groups value=$privilegedOrganizations['groups']}
					{if !empty($groups)}
						<li class="{if $page == 'groups'}active{/if}">
							<a class="sub-link" href="groups/{$groups->id}">
								<span class="sidebar-text">
									{$groups->name}
								</span>
							</a>
						</li>
					{/if}
					</ul>
				</li>
			</ul>
			{elseif !empty($privilegedOrganizations['groups']) && !$addedAsSubLink}
				{assign var=groups value=$privilegedOrganizations['groups']}
				<ul class="list-unstyled">
					<li class="">
						<li class="{if $page == 'groups'}active{/if}">
							<a class="sub-link" href="groups/{$groups->id}">
								<span class="sidebar-text">
									{$groups->name}
								</span>
							</a>
						</li>
					</li>				
				</ul>
			{/if}
			{/if}
        </nav>
		<!-- End sidebar -->
    {/if}


        <!-- Page Content  -->
        <div id="content">
			<header class="at">
				<span id="goToTop" class="hidden" aria-hidden="true"></span>
				<!-- <div class="container-fluid"> -->
				<nav class="navbar navbar-expand-lg navbar-light">
				{if $viewer}
					<div class="navbar-brand d-block-inline mr-auto mobile-brand">
	                	<a class="" href="{$baseUrl}{if $viewer}/syllabi{/if}">
						<img src="assets/icons/logo_square_512-01.png" width="48" height="48" class="d-inline-block mr-2" alt="Syllabus Logo" id="brandLogo"></a>
					</div>
                    <button type="button" id="mainSidebarCollapse" class="btn btn-secondary ml-2">
                        <i class="fas fa-align-left"></i>
                        <span>Toggle Sidebar</span>
                    </button>
					<button class="navbar-toggler mr-3 ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
				{else}
					<div class="navbar-brand d-block-inline mr-auto">
	                	<a class="" href="{$baseUrl}{if $viewer}/syllabi{/if}">
						<img src="assets/icons/logo_square_512-01.png" width="48" height="48" class="d-inline-block mr-2" alt="Syllabus Logo" id="brandLogo"> <span class="sidebar-text pr-2 brand-text">Syllabus</span></a>
					</div>
				{/if}
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto">
						{if $viewer}
							{if !$hasProfile}
							<li class="nav-item">
								<span class="navbar-text mr-3">Hello, {$userContext->account->firstName|escape}</span>
							</li>
							{else}
							<li class="nav-item">
								<a class="nav-link" href="profile/{$viewer->id}">
									<span class="navbar-text mx-2 d-block">
										<i class="fas fa-user-cog pr-1 align-middles"></i>
										{$userContext->account->firstName|escape}
									</span>
								</a>
							</li>
							{/if}
							{if $pAdmin}
							<li class="nav-item">
								<a class="nav-link" href="admin"><i class="fas fa-cog"></i> Administrate</a>
							</li>
							{/if}

							<li class="nav-item mobile-link border-top">
								<a class="nav-link" href="syllabi">
									My Syllabi
								</a>
							</li>
						{if $pFaculty || $pProgramAdmin || !$isStudent}
							<li class="nav-item mobile-link {if $page == 'start'}active{/if}">
								<a class="nav-link" href="syllabus/start">
									Create New Syllabus
								</a>
							</li>
							<li class="nav-item mobile-link {if $page == 'overview'}active{/if}">
								<a class="nav-link" href="syllabi?mode=overview">
									Overview
								</a>
							</li>
							<li class="nav-item mobile-link {if $page == 'courses'}active{/if}">
								<a class="nav-link" href="syllabi?mode=courses">
									Courses
								</a>
							</li>
<!-- 							<li class="nav-item mobile-link {if $page == 'submissions'}active{/if}">
								<a class="nav-link" href="syllabi?mode=submissions">
									Submissions
								</a>
							</li> -->
							{if $privilegedOrganizations || $pAdmin}
								<li class="nav-item mobile-link border-top">
									<a class="nav-link" href="organizations" id="sidebarMyOrganizations">
										My Organizations
									</a>
								</li>
								{assign var=departments value=$privilegedOrganizations['departments']}
								{if (!empty($departments) && count($departments) > 1) || $pAdmin}
									<li class="nav-item mobile-link {if $page == 'departments'}active{/if}">
										<a class="nav-link" href="departments">
											Departments
										</a>
									</li>
								{elseif !empty($departments) && count($departments) == 1}
									{foreach $departments as $dept}
									<li class="nav-item mobile-link {if $page == 'departments'}active{/if}">
										<a class="nav-link" href="departments/{$dept->id}">
											{$dept->name}
										</a>
									</li>
									{/foreach}
								{/if}
								{assign var=groups value=$privilegedOrganizations['groups']}
								{if !empty($groups)}
								<li class="nav-item mobile-link {if $page == 'groups'}active{/if}">
									<a class="nav-link" href="groups/{$groups->id}">
										{$groups->name}
									</a>
								</li>
								{/if}
							{/if}
						{/if}
						{else}
							<li class="nav-item login">
								<a class="login-button nav-link" href="{$app->baseUrl('login')}">Login</a>
							</li>
						{/if} 
						</ul>
					{if $viewer}
						<form method="post" action="logout" class="form logout-form p-2 ">
							<button class="btn btn-outline-secondary logout " type="submit" name="command[logout]" id="logout-button" value="Logout">Logout</button>
						</form>
					{/if}
					</div>
				</nav>
		        <div class="bc">
					{if $breadcrumbList}
					<div class="container-fluid">
						<div class="col">
						<ol class="at breadcrumb">
							{foreach name="breadcrumbs" item="crumb" from=$breadcrumbList}
							<li{if $smarty.foreach.breadcrumbs.last} class="active"{elseif $smarty.foreach.breadcrumbs.first} class="first"{/if}>
								{if $crumb@last}
									{$crumb.text}
								{else}
									{l text=$crumb.text href=$crumb.href}
								{/if}
							</li>
							{/foreach}
						</ol>
						</div>
					</div>
					{/if}
		        </div>
		    	<!-- </div> -->
			</header>	

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

			{if $headerPartial}

			<main role="main" class="col mb-3 {if !$viewer}pl-0 pr-0 mt-0{else}pr-3 mt-0{/if}" id="mainContent">
				{include file=$headerPartial headerVars=$headerVars}
			{else}

			<main role="main" class="col mb-3 {if !$viewer}pl-0 pr-0 mt-0{else}pr-3 mt-0{/if}" id="mainContent">
			{/if}

				{if $flashContent}
				<div id="user-message" class="alert alert-{$flashClass} alert-dismissable mb-3 fade show" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<div class="primary">{$flashContent}</div>
				</div>
				{/if}
				{if $app->siteSettings->siteNotice}
				<div class="site-notice action notice">
					{$app->siteSettings->siteNotice}
				</div> 
				{/if}   

				<!-- MAIN CONTENT -->
				{include file=$contentTemplate}
			</main>
        </div>
    
    </div>


	<footer class="sticky-footer fixed-bottom" id="footer">
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
