{assign var=realSection value=$section->version->resolveSection()}
<!-- Container Section - View --> 
<div class="form-group row">
    <div class="col">
        <h4>{$realSection->title}</h4>
    </div>
</div>
<div class="form-group row">
    <div class="col">
        {$realSection->description}
    </div>
</div>
<!-- End Container Section - View -->