<!-- Materials Section -->
<div class="card card-outline-secondary rounded-0">
<div class="card-body sort-container" id="materialsSection">

    {if $realSection->materials}

        {foreach $realSection->materials as $i => $material}
            {assign var=materialId value="{$material->id}"}
            {assign var=sortOrder value="{str_pad($i+1, 3, '0', STR_PAD_LEFT)}"}
<div class="container-fluid mb-2" id="materialContainer{$materialId}">
    <div class="row sort-item">
        <div class="tab-content col-11 px-0" id="toggleEditViewTab{$i}">
            <div class="tab-pane fade border" id="nav-edit-{$i}" role="tabpanel" aria-labelledby="nav-edit-{$i}-tab">
                <div class="mb-2 mx-0 d-flex flex-row bg-light p-3 dragdrop-handle">
                    <i class="fas fa-bars text-dark" data-toggle="tooltip" data-placement="top" title="Click and drag to change the order."></i>
                </div>
               
                <input type="hidden" name="section[real][{$materialId}][sortOrder]" value="{$sortOrder}" class="sort-order-value" id="form-field-{$i+1}-sort-order">
                <div class="d-flex justify-content-end">
                    <button type="submit" aria-label="Delete" class="btn btn-link text-danger my-0 mx-2" 
                    {if $groupForm}
                        name="command[deleteitem][Syllabus_Materials_Material][{$materialId}]" 
                    {else}
                        name="command[deletesectionitem][Syllabus_Materials_Material][{$materialId}]" 
                    {/if}
                    id="{$materialId}">
                        <i class="fas fa-trash-alt mr-1"></i>Delete
                    </button>
                </div>
                <div class="form-group title row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">Title</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" name="section[real][{$materialId}][title]" value="{$material->title}">
                    </div>
                </div>
                <div class="form-group url row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">URL</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" name="section[real][{$materialId}][url]" value="{$material->url}">
                    </div>
                </div>
                <div class="form-group newWindow row px-3">
                    <label class="col-lg-3 newWindow col-form-label form-control-label">Open link in new window?</label>
                    <div class="col-lg-9">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="section[real][{$materialId}][newWindow]" id="materialWindow{$i}Yes" value="true" {if $material->newWindow}checked{/if}>
                            <label class="form-check-label" for="materialWindow{$i}Yes">Yes</label>
                        </div>
                        <div class="form-check form-check-inline ml-3">
                            <input class="form-check-input" type="radio" name="section[real][{$materialId}][newWindow]" id="materialWindow{$i}No" value="false" {if !$material->newWindow}checked{/if}>
                            <label class="form-check-label" for="materialWindow{$i}No">No</label>
                        </div>
                    </div>
                </div>
                <div class="form-group authors row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">Author(s)</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" name="section[real][{$materialId}][authors]" value="{$material->authors}">
                    </div>
                </div>
                <div class="form-group publisher row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">Publisher</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" name="section[real][{$materialId}][publisher]" value="{$material->publisher}">
                    </div>
                </div>
                <div class="form-group isbn row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">ISBN</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" name="section[real][{$materialId}][isbn]" value="{$material->isbn}">
                    </div>
                </div>
                <div class="form-group required row px-3">
                    <label class="col-lg-3 col-form-label form-control-label">Required?</label>
                    <div class="col-lg-9">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="section[real][{$materialId}][required]" id="material{$i}Yes" value="true" {if $material->required}checked{/if}>
                            <label class="form-check-label" for="material{$i}Yes">Yes</label>
                        </div>
                        <div class="form-check form-check-inline ml-3">
                            <input class="form-check-input" type="radio" name="section[real][{$materialId}][required]" id="material{$i}No" value="false" {if !$material->required}checked{/if}>
                            <label class="form-check-label" for="material{$i}No">No</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade show active d-inline-block w-100 px-3" id="nav-view-{$i}" role="tabpanel" aria-labelledby="nav-view-{$i}-tab">
                <div class="row py-2 bg-light border dragdrop-handle rounded">
                    <div class="col-1 dragdrop-handle align-middle">
                        <i class="fas fa-bars text-dark" data-toggle="tooltip" data-placement="top" title="Click and drag to change the order."></i>
                    </div>
                    <div class="col-1 text-truncate"><strong>#{$i+1}</strong></div>
                    <div class="col-3 text-truncate"><strong>Title: </strong>{$material->title|truncate:50}</div>
                    <div class="col-2 text-truncate ">
                        <strong>URL: </strong><a href="{$material->url}">{$material->url|strip_tags:true|truncate:30}</a>
                    </div>
                    <div class="col-2 text-truncate">{$material->authors|truncate:50}</div>
                    <div class="col-1 text-truncate">{$material->publisher|truncate:50}</div>
                    <div class="col-1 text-truncate">{$material->isbn|truncate:50}</div>
                    <div class="col-1 text-truncate">
                        {if $material->required}<span class="text-danger">Required</span>{/if}
                    </div>
                </div>   
            </div>
        </div>
        <div class="nav nav-tabs col-1 toggle-edit d-inline-block border-0" role="tablist">
            <a class="btn btn-sm btn-info py-2" id="nav-edit-{$i}-tab" data-toggle="tab" href="#nav-edit-{$i}" role="tab" aria-controls="nav-edit-{$i}" aria-selected="false">Edit #{$i+1}</a>
            <a class="btn btn-sm btn-secondary py-2 active" id="nav-view-{$i}-tab" data-toggle="tab" href="#nav-view-{$i}" role="tab" aria-controls="nav-view-{$i}" aria-selected="true">Minimize #{$i+1}</a>
        </div>
    </div>
</div>
        {/foreach}

    {/if}
        {if $realSection->materials}
            {assign var=i value="{count($realSection->materials)}"}
            {assign var=sortOrder value="{count($realSection->materials)}"}
        {else}
            {assign var=i value="0"}
            {assign var=sortOrder value="1"}
        {/if}
        {assign var=materialId value="new-{$i}"}

            
<div class="sort-item mt-3 border p-2" id="newSortItem{$i}">
    <div class="mb-2 d-flex flex-row bg-white p-2 dragdrop-handle">
        <i class="fas fa-bars text-dark" data-toggle="tooltip" data-placement="top" title="Click and drag to change the order."></i>
    <!-- <span class="mx-auto">Note, this new item will only be saved if you fill out information in the fields.</span> -->
    </div>
   
    <input type="hidden" name="section[real][{$materialId}][sortOrder]" value="{$sortOrder}" class="sort-order-value" id="form-field-{$sortOrder}-sort-order">
    <div class="form-group title row">
        <label class="col-lg-3 title col-form-label form-control-label">Title</label>
        <div class="col-lg-9">
            <input class="form-control" type="text" name="section[real][{$materialId}][title]" value="">
        </div>
    </div>
    <div class="form-group url row">
        <label class="col-lg-3 url col-form-label form-control-label">URL</label>
        <div class="col-lg-9">
            <input class="form-control" type="text" name="section[real][{$materialId}][url]" value="">
        </div>
    </div>
    <div class="form-group newWindow row">
        <label class="col-lg-3 newWindow col-form-label form-control-label">Open link in new window?</label>
        <div class="col-lg-9">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="section[real][{$materialId}][newWindow]" id="materialWindow{$i}Yes" value="true" {if $material->newWindow}checked{/if}>
                <label class="form-check-label" for="materialWindow{$i}Yes">Yes</label>
            </div>
            <div class="form-check form-check-inline ml-3">
                <input class="form-check-input" type="radio" name="section[real][{$materialId}][newWindow]" id="materialWindow{$i}No" value="false" {if !$material->newWindow}checked{/if}>
                <label class="form-check-label" for="materialWindow{$i}No">No</label>
            </div>
        </div>
    </div>
    <div class="form-group authors row">
        <label class="col-lg-3 authors col-form-label form-control-label">Author(s)</label>
        <div class="col-lg-9">
            <input class="form-control" type="text" name="section[real][{$materialId}][authors]" value="">
        </div>
    </div>
    <div class="form-group publisher row">
        <label class="col-lg-3 publisher col-form-label form-control-label">Publisher</label>
        <div class="col-lg-9">
            <input class="form-control" type="text" name="section[real][{$materialId}][publisher]" value="">
        </div>
    </div>
    <div class="form-group isbn row">
        <label class="col-lg-3 isbn col-form-label form-control-label">ISBN</label>
        <div class="col-lg-9">
            <input class="form-control" type="text" name="section[real][{$materialId}][isbn]" value="">
        </div>
    </div>
    <div class="form-group required row">
        <label class="col-lg-3 required col-form-label form-control-label">Required?</label>
        <div class="col-lg-9">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="section[real][{$materialId}][required]" id="material{$i}Yes" value="true" {if $material->required}checked{/if}>
                <label class="form-check-label" for="material{$i}Yes">Yes</label>
            </div>
            <div class="form-check form-check-inline ml-3">
                <input class="form-check-input" type="radio" name="section[real][{$materialId}][required]" id="material{$i}No" value="false" {if !$material->required}checked{/if}>
                <label class="form-check-label" for="material{$i}No">No</label>
            </div>
        </div>
    </div>
</div>  
            
{if !$importableSections}
    <div class="form-group d-flex flex-row-reverse mt-4">
{else}
    <div class="form-group d-flex justify-content-between mt-4">
        {include file="{$sectionExtension->getImportFragment()}"}
{/if}
        <input class="btn btn-light" id="addMaterialsSectionItemBtn" type="submit" name="command[addsectionitem][{$realSectionClass}]" value="+ Add Another Material" />
    </div>
{if !$groupEditor}
    <div class="form-group row px-3 mt-5">
        <label class="col-lg-3 col-form-label form-control-label">Additional Information</label>
        <div class="col-lg-9">
            <textarea class="form-control wysiwyg wysiwyg-syllabus-full" type="text" name="section[real][additionalInformation]" rows="5">{$realSection->additionalInformation}</textarea>
        </div>
    </div>
{/if}
</div>
</div>
<!-- End Materials Section -->