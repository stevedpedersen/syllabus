{assign var=extName value=$sectionExtension::getExtensionName()}
{assign var=displayName value=$sectionExtension->getDisplayName()}
{if $currentSectionVersion}
	{assign var=sectionVersionId value=$currentSectionVersion->id}
{else}
	{assign var=sectionVersionId value='new'}
{/if}

<div class="sort-item editor-{$extName} border border-warning active-section-editor rounded-0 p-1 mt-3" id="section{$extName}Edit">

{if $isUpstreamSection}
<div class="alert alert-warning">
	This section is inherited from a previous syllabus. Leave this section unedited if you want to continue inheriting changes from that section.
</div>
{elseif $hasDownstreamSection}
<div class="alert alert-warning">
	This section has been inherited by your other syllabi. Any changes made here will be reflected in the other syllabi.
</div>
{/if}

	<div class="d-block-inline bg-light p-2 section-collapse-link dragdrop-handle" data-toggle="collapse" href="#{$extName}CollapseEdit" aria-expanded="false" aria-controls="{$extName}CollapseEdit">
		<i class="fas fa-bars fa-2x dragdrop-handle mr-2" data-toggle="tooltip" data-placement="top" title="Click and drag to change the order."></i>
		<a class="d-block-inline p-3" data-toggle="collapse" href="#{$extName}CollapseEdit"><div class="text-left d-inline-block" id="{$extName}Heading">
			<span class="mb-0 section-title">
				<strong>{if $currentSectionVersion->title}{$currentSectionVersion->title}{else}{$displayName}{/if}</strong><small><i class="fas fa-chevron-down text-dark pl-2"></i></small>
			</span></div></a>
		{if $currentSectionVersion->description}<small class="text-dark">{$currentSectionVersion->description}</small>{/if}
		{if $currentSectionVersion}<span class="float-right"><small class="badge badge-default">Section Version #{$currentSectionVersion->normalizedVersion}</small></span>{/if}
	</div>

	{if $sectionExtension->getAddonFormFragment()}
		{include file="{$sectionExtension->getAddonFormFragment()}"}
	{/if}

	{if $genericSection->sortOrder}
		{assign var=editingSectionSortOrder value="{$genericSection->sortOrder}"}
	{else}
		{assign var=editingSectionSortOrder value="{$syllabusVersion->sectionCount + 1}"}
	{/if}

	<input type="hidden" name="section[versionId]" value="{$sectionVersionId}">
	<input type="hidden" name="section[realClass][{$sectionVersionId}]" value="{$realSectionClass}">
	<input type="hidden" name="section[extKey][{$sectionVersionId}]" value="{$sectionExtension->getExtensionKey()}">
	<input type="hidden" name="section[properties][sortOrder][{$sectionVersionId}]" value="{$editingSectionSortOrder}" 
		class="sort-order-value" id="form-field-{$editingSectionSortOrder}-sort-order">
	<input type="hidden" name="section[properties][log][{$sectionVersionId}]" value="{$genericSection->log}">

	<div class="collapse multi-collapse show section-collapsible" id="{$extName}CollapseEdit">
		<div class="section-metadata bg-light">
	        <div class="text-center mb-3">
	            <h4 class="">{if $genericSection->title}{$genericSection->title}{else}{$displayName}{/if} Title & Description Text</h4>
	        </div>
	        <div class="form-group row">
	            <label class="col-lg-3 col-form-label form-control-label">Section Title & Sidebar Link Name</label>
	            <div class="col-lg-9">
	                <input class="form-control" type="text" name="section[generic][{$sectionVersionId}][title]" value="{if $currentSectionVersion->title}{$currentSectionVersion->title}{else}{$displayName}{/if}">
					<small id="{$extName}HelpBlock" class="form-text text-muted ml-1">
						The title field here will be the main header for the section, as well as the link text displayed on the right sidebar. The description will be the section intro if set. {if !$sectionExtension->getHelpText()} {$sectionExtension->getHelpText()}{/if}
					</small>
					<div class="form-check ml-1">
						<input name="section[properties][isAnchored][{$sectionVersionId}]" class="form-check-input" type="checkbox" id="sectionIsAnchored" 
						{if !$currentSectionVersion || $genericSection->isAnchored}checked value="true"{/if}>
						<label class="form-check-label" for="sectionIsAnchored">
							Include title in sidebar quick-links.
						</label>
					</div>
	            </div>
	        </div>
	        <div class="form-group row">
	            <label class="col-lg-3 col-form-label form-control-label">Section Description</label>
	            <div class="col-lg-9">
	                <input class="form-control" type="text" name="section[generic][{$sectionVersionId}][description]" value="{if $currentSectionVersion->description}{$currentSectionVersion->description}{/if}">
	            </div>
	        </div>
	    </div>
		<div class="real-section-editor">{include file="{$sectionExtension->getEditFormFragment()}"}</div>
	</div>

	<div class="card-footer">
		<div class="form-group row pt-3">
		{if $genericSection->readOnly == 'true' || $genericSection->readOnly == true || $genericSection->inherited || $organization}
			{assign var=isReadOnly value=true}
		{else}
			{assign var=isReadOnly value=false}
		{/if}
	        <label class="col-lg-3 col-form-label form-control-label" for="sectionSettings1">Section Settings</label>
	        <div class="col-lg-9">
	        	<div class="row p-3">
	            	<div class="col-6">
						{if $organization}
						<div id="readOnlyHelpBlock" class="form-text ml-1 invalid-feedback">
							If unchecked, instructors who use this template and edit it will no longer see any changes that are made to this section of the template.
						</div>
						{/if}
	                    <input class="form-check-input" name="section[properties][readOnly][{$sectionVersionId}]" type="checkbox" id="makeReadOnly"
	                    {if $isReadOnly}checked value="true"{/if}>
						<label class="form-check-label form-control-label pl-1" for="makeReadOnly">
							Make section read-only?
						</label>
					</div>
				</div>
	        </div>
		</div>
	    <div class="form-group row pt-3 mt-5 border-top">
	        <label class="col-lg-3 col-form-label form-control-label"></label>
	        <div class="col-lg-9">
				<div class="d-flex">
	                <input class="btn btn-success" type="submit" name="command[savesection]" value="Save Section" />
	                <a href="{$smarty.server.REQUEST_URI}" class="btn btn-outline-warning mx-1">Cancel</a>
	                <input class="btn btn-danger ml-auto" type="submit" name="command[deletesection]" value="Delete Section" />				
				</div>
	        </div>
	    </div>
	</div>
</div>