<?php

class Syllabus_Syllabus_AdminController extends Syllabus_Master_AdminController
{
    public static function getRouteMap ()
    {
        return [
            'admin/syllabus/resources' => ['callback' => 'campusResources'],
        ];
    }

	public function beforeCallback ($callback)
	{
		parent::beforeCallback($callback);
		$this->requirePermission('admin');
	}
    
    public function campusResources ()
    {
        $files = $this->schema('Syllabus_Files_File');
        $campusResources = $this->schema('Syllabus_Syllabus_CampusResource');
        $allResources = $campusResources->find(
            $campusResources->deleted->isFalse()->orIf($campusResources->deleted->isNull()),
            ['orderBy' => ['sortOrder', 'title']]
        );
        $bottommostPosition = -1;
        if ($allResources)
        {
            $bottommostPosition = array_values(array_slice($allResources, -1))[0]->sortOrder;    
        }
        
        if ($this->request->wasPostedByUser())
        {
            $data = $this->request->getPostParameters();
            switch ($this->getPostCommand())
            {
                case 'upload':
                    $file = $files->createInstance();
                    $file->createFromRequest($this->request, 'file');
                    
                    if ($file->isValid())
                    {
                        $file->uploadedBy = $this->getAccount();
                        $file->moveToPermanentStorage();
                        $file->save();
                    }
                    
                    $this->template->errors = $file->getValidationMessages();
                    break;
                
                case 'save':    
                    $resource = $campusResources->createInstance();
                    $resource->sortOrder = (isset($data['resource']) && isset($data['resource']['sortOrder']) ? 
                        $data['resource']['sortOrder'] : ($bottommostPosition+1));
                    $resource->imageId = $data['resource']['imageId'];
                    $resource->title = $data['resource']['title'];
                    $resource->abbreviation = $data['resource']['abbreviation'];
                    $resource->description = $data['resource']['description'];
                    $resource->url = $data['resource']['url'];
                    $resource->save();
                    
                    $this->flash('Resource saved.');
                    break;

                case 'edit':
                    $resource = $this->requireExists($campusResources->get(key($this->getPostCommandData())));
                    $this->template->resource = $resource;
                    break;

                case 'delete':
                    $resource = $this->requireExists($campusResources->get(key($this->getPostCommandData())));
                    $resource->deleted = true;
                    $resource->save();
                    $this->flash('Resource has been flagged as deleted. 
                        <form action="'.$this->baseUrl('/admin/syllabus/resources').'" method="post">
                            <input type="submit" name="command[undelete]['.$resource->id.']" 
                            value="Undo Delete" class="btn btn-warning" />
                            '. $this->template->generateFormPostKey([], null) .'
                        </form>
                        ', 
                        'secondary'
                    );
                    break;

                case 'undelete':
                    $resource = $this->requireExists($campusResources->get(key($this->getPostCommandData())));
                    $resource->deleted = false;
                    $resource->save();
                    $this->flash('Resource has been restored.', 'success');
                    break;

                case 'sort':
                    foreach ($data['sortOrder'] as $id => $sortOrder)
                    {
                        $resource = $this->requireExists($campusResources->get($id));
                        $resource->sortOrder = $sortOrder;
                        $resource->save();
                    }
                    $this->flash('Order of campus resources updated.', 'success');
                    break;
            }
            $this->response->redirect('admin/syllabus/resources');
        }

        $this->template->bottommostPosition = $bottommostPosition;
        $this->template->campusResources = $allResources;
        $this->template->files = $files->getAll();
    }
}