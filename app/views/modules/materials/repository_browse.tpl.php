<table summary="List of Material items in the repository" cellspacing="0" cellpadding="0">
    <thead>
        <tr>
        <th scope="col" style="width: 20px;"><span class="icon"><span class="icon edit inline-block"></span><span class="text">Edit</span></span></th>
        <th scope="col" style="width: 20px;"><span class="icon"><span class="icon remove inline-block"></span><span class="text">Delete</span></span></th>
        <th scope="col">Material Title</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$m.items item=i}
        <tr>
            <td>
                <a href="repository/edit/{$k}/{$i.material_id}" class="icon">
                    <span class="icon edit inline-block"></span>
                    <span class="text">Edit</span>
                </a>
            </td>
            <td>
                <a href="repository/delete/{$k}/{$i.material_id}" class="icon">
                    <span class="icon remove inline-block"></span>
                    <span class="text">Delete</span>
                </a>
            </td>
            <td>{$i.material_title}</td>
        </tr>
        {/foreach}
    </tbody>
</table>