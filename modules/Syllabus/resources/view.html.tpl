<div class="row viewer-main-container">

	<nav class="navbar navbar-expand-lg navbar-dark mobile-anchor-links" id="stickyNavbar">

		<button class="navbar-toggler mr-3 d-block mx-auto text-light p-3" type="button" data-toggle="collapse" data-target="#anchorLinksCollapse" aria-controls="anchorLinksCollapse" aria-expanded="false" aria-label="Toggle navigation">
			<i class="fas fa-anchor mr-2"></i> Jump to section...
		</button>

		<div class="collapse navbar-collapse" id="anchorLinksCollapse">
			<!-- <span class="navbar-text mr-3 text-light"><strong>{$syllabus->title}</strong></span> -->
			<ul class="navbar-nav ml-auto">
				<li class="nav-item sidebar-anchor-item">
					<a class="nav-link my-3" href="{$smarty.server.REQUEST_URI}#goToTop">
					<strong class="text-info"><i class="fas fa-arrow-up pr-2"></i> Go To Top</strong>
					</a>
				</li>
			{foreach $sectionVersions as $i => $sectionVersion}
				{if ($sectionVersion->resolveSection()->id != $realSection->id) && $sectionVersion->isAnchored}
					{assign var=ext value=$sectionVersion->extension}
					{assign var=extName value=$ext::getExtensionName()}
				<li class="nav-item sidebar-anchor-item">
					<a class="nav-link" href="{$smarty.server.REQUEST_URI}#section{$extName}{$i}">
					{if $sectionVersion->title}{$sectionVersion->title}{else}{$ext->getDisplayName()}{/if}
					</a>
				</li>
				{/if}				
			{/foreach}

			</ul>
		</div>
	</nav>

	<!-- <nav class="col-md-2 col-sm-12 col-xs-12 d-sm-block ml-auto anchor-links-sidebar-left bg-white text-dark"> -->
	<nav class="col-2 ml-auto anchor-links-sidebar-left bg-white text-dark mt-3">
		<div class="sidebar-sticky mt-5 py-3">
			<ul class="nav flex-column  text-right text-primary">
				<li class="nav-item sidebar-anchor-item">
					<a class="nav-link" href="{$smarty.server.REQUEST_URI}#goToTop">
					<strong>Go To Top</strong> <i class="fas fa-arrow-up pl-2"></i> 
					</a>
				</li>
			{foreach $sectionVersions as $i => $sectionVersion}
				{if ($sectionVersion->resolveSection()->id != $realSection->id) && $sectionVersion->isAnchored}
					{assign var=ext value=$sectionVersion->extension}
					{assign var=extName value=$ext::getExtensionName()}
				<li class="nav-item sidebar-anchor-item">
					<a class="nav-link" href="{$smarty.server.REQUEST_URI}#section{$extName}{$i}">
					{if $sectionVersion->title}{$sectionVersion->title}{else}{$ext->getDisplayName()}{/if}
					</a>
				</li>
				{/if}				
			{/foreach}
			</ul>
		</div>
	</nav>

	<!-- <main role="main" class="col-lg-10 col-sm-12 col-xs-12 ml-sm-auto mt-0 px-3"> -->
	<main role="main" class="col-lg-10 col-md-12 col-sm-12 ml-sm-auto mt-0 px-3" id="viewerContainer">
		<div class="row m-3">
			<div class="left col-lg-6 mt-3">
				{foreach $breadcrumbList as $crumb}
				<span class="breadcrumb-item {if $crumb@last}active{elseif $crumb@first}first{/if}">
					{if $crumb@last}
						{$crumb.text}
					{else}
						{l text=$crumb.text href=$crumb.href}
					{/if}
				</span>
				{/foreach}
			</div>
			<div class="text-right col-lg-6 px-2 mt-3">
				{if $editable}<span class=""><a class="btn btn-secondary btn-sm" href="syllabus/{$syllabus->id}">Back to Edit</a></span>{/if}
				<span class="text-muted mx-2 d-inline-block">
					<small>Last updated: {$syllabus->modifiedDate->format('F jS, Y - h:i a')}</small>
				</span>
				<span class="d-inline-block">
					<a href="{$routeBase}syllabus/{$syllabus->id}/print"><i class="fas fa-print"></i> Print</a>
				</span>
				<span class="ml-3 d-inline-block">
					<a href="{$routeBase}syllabus/{$syllabus->id}/word"><i class="far fa-file-word"></i> Download as Word</a>
				</span>
			</div>	
		</div>

		<div class="syllabus-viewer p-lg-5 p-md-3 p-sm-2 p-xs-1" id="syllabusViewer">		

			{foreach $sectionVersions as $i => $sectionVersion}
				{assign var=ext value=$sectionVersion->extension}
			<div class="section-container pt-3 my-5 {if !$sectionVersion@first}border-top{/if}">
				<h2 class="section-title" id="section{$ext::getExtensionName()}{$i}">
					{if $sectionVersion->title}
						{$sectionVersion->title}
					{else}
						{$ext->getDisplayName()}
					{/if}
				</h2>
				{if $sectionVersion->description}
					<p class="section-description ">{$sectionVersion->description}</p>
				{/if}

				<div class="section-content pt-3 dont-break-out" style="max-width:100%;">
					{include file="{$ext->getOutputFragment()}"}
				</div>

			</div>
			{/foreach}

		</div>
	</main>
	<div class="col-lg-1 col-md-0 spacer"></div>

</div>