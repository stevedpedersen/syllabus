{assign var=realSection value=$sectionVersion->resolveSection()}
<div class="real-section-content grades">
	{if $realSection->grades}
	<table class="table table-responsive table-sm table-striped">
		<thead class="thead-dark">
			<tr>
				<th scope="col">{$realSection->header1}</th>
				<th scope="col">{$realSection->header2}</th>
				{if $realSection->columns == 3}<th scope="col">{$realSection->header3}</th>{/if}
			</tr>
		</thead>
		<tbody>
		{foreach $realSection->grades as $i => $grade}
			<tr>
				<td>{$grade->column1}</td>
				<td>{$grade->column2}</td>
				{if $realSection->columns == 3}<td>{$grade->column3}</td>{/if}
			</tr>
		{/foreach}
		</tbody>
	</table>
	{/if}

	{if $realSection->additionalInformation}
	<div class="col">
		{$realSection->additionalInformation}
	</div>
	{/if}
</div>