<div class="editor-main-controls editor-main-controls-{$position|lcfirst} {if $position == 'Top'}mb-3{else}mt-3{/if} form-inline bg-light" id="editorMainControls{$position}">

<div class="row">
	{if $syllabus->inDataSource}
	<div class="editor-controls-left col-xl-9">
		<div class="row">
			<div class="col-md-3 d-block">
				<h3 class="mt-0 mb-4 pt-0 mr-3 text-uppercase" style="text-decoration:underline;">Add Section:</h3>
				{if $position == 'Top'}
				<div class="editor-controls-header">
				{else}
				<div class="editor-controls-left">
				{/if}
				{if $organization}
					<span class="text-dark">
						<strong>[{$organization->name} Template]</strong>
					</span>
				{elseif $viewer->id != $syllabus->createdById}
					<span class="text-dark">
						<strong>[{$syllabus->createdBy->fullName}'s Syllabus]</strong>
					</span>				
				{/if}
				</div>
			</div>
			<div class="col-md-9">
			{foreach $sectionExtensions as $ext}
				{assign var=canHaveMultiple value=true}
				{foreach $sectionVersions as $sv}
					{if $sv->extension->getExtensionKey() == $ext->getExtensionKey() && !$ext->canHaveMultiple()}{assign var=canHaveMultiple value=false}{/if}
				{/foreach}
				{assign var=activeSection value=false}
				{if $sectionExtension && $sectionExtension->getExtensionName() == $ext->getExtensionName()}{assign var=activeSection value=true}{/if}


				{strip}
				{if !$canHaveMultiple && !$activeSection}
					<button class="px-2 mb-2 py-0 btn btn-outline-muted disabled" disabled type="submit" name="add" value="{$ext->getExtensionName()}" form="addSection" data-toggle="tooltip" data-placement="bottom" title="You can only have one instance of this section type.">
					<img src="{$ext->getLightIcon()}" class="img-fluid mr-1" style="max-height:1.5em;margin-bottom:1px;">
						<span class="text-muted pr-1">{$ext->getDisplayName()}</span>
					</button>
				{elseif $ext->getExtensionKey() == 'learning_outcomes_id NO LONGER DISABLED'}
<!-- 					<button class="px-2 mb-2 py-0 btn btn-outline-secondary" data-toggle="modal" data-target="#sloModal" form="">
					<img src="{$ext->getDarkIcon()}" class="img-fluid mr-1" style="max-height:1.5em;margin-bottom:1px;">
						<span class="available pr-1">{$ext->getDisplayName()}</span>
					</button> -->
				{else}
					<button class="px-2 mb-2 py-0 btn {if !$activeSection}btn-outline-secondary{else}btn-secondary text-white{/if}" type="submit" name="add" value="{$ext->getExtensionName()}" form="addSection">
					<img src="{$ext->getDarkIcon()}" class="img-fluid mr-1" style="max-height:1.5em;margin-bottom:1px;">
						<span class="available pr-1">{$ext->getDisplayName()}</span>
					</button>
				{/if}
				{/strip}

			{/foreach}
			</div>
		</div>
	</div>
	{/if}
	
	<div class="{if $syllabus->inDataSource}col-xl-3{else}col-xl-12{/if} text-right d-block">
		<div class="editor-controls-right d-inline-block py-3 text-center">
			<button class="btn btn-success  my-1" type="submit" name="command[savesyllabus]" id="globalSave{$postion}" form="viewSections">
				Save
			</button>
			<div class="dropdown d-inline">
				<a class="btn btn-dark dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					Options
				</a>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					<a class="dropdown-item" id="viewFromEditor" href="{$routeBase}syllabus/{$syllabus->id}/view">
						<i class="far fa-eye  mr-3 text-dark"></i> View
					</a>
				{if !$organization && $hasCourseSection}
<!-- 					<div class="dropdown-divider"></div>
					<a href="syllabus/{$syllabus->id}/share" class="dropdown-item">
						<i class="fas fa-share-square  mr-3 text-primary"></i> Share
					</a> -->
				{/if}
					<div class="dropdown-divider"></div>
					<a href="syllabus/{$syllabus->id}/word" class="dropdown-item">
						<i class="far fa-file-word  mr-3 text-dark"></i> Export
					</a>
					<div class="dropdown-divider"></div>
					<a href="syllabus/{$syllabus->id}/print" class="dropdown-item">
						<i class="fas fa-print  mr-3 "></i> Print
					</a>
					<div class="dropdown-divider"></div>
					<a href="{$routeBase}syllabus/startwith/{$syllabus->id}" class="dropdown-item">
						<i class="far fa-copy mr-3 text-secondary"></i> Clone
					</a>
					<div class="dropdown-divider"></div>
					<a href="syllabus/{$syllabus->id}/share#grantEditAccess" class="dropdown-item">
						<i class="fas fa-user-edit mr-3 text-info"></i>Add Editor
					</a>
				{if $syllabus->inDataSource}
					<div class="dropdown-divider"></div>
					<a sr-only="Delete" class="dropdown-item" id="viewFromEditor" href="{$routeBase}syllabus/{$syllabus->id}/delete">
						<i class="fas fa-trash  mr-3 text-danger"></i> Delete
					</a>
				{/if}
				</div>
			</div>

			<a href="{$routeBase}{if $syllabus->inDataSource}syllabus/{$syllabus->id}{else}{$smarty.server.REQUEST_URI}{/if}" class="btn btn-default my-1">Cancel</a>
		</div>
	</div>

</div> <!-- End row -->

</div>