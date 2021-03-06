<?php

class Syllabus_Syllabus_AdminController extends Syllabus_Master_Controller
{
    public static function getRouteMap ()
    {
        return [
            'admin/templates/university' => ['callback' => 'universityTemplates'],
            'admin/syllabus/resources' => ['callback' => 'campusResources'],
            'admin/syllabus/guidedocs' => ['callback' => 'guideDocs'],
            'admin/syllabus/statistics'=> ['callback' => 'statistics'],
        ];
    }

	public function beforeCallback ($callback)
	{
		parent::beforeCallback($callback);
		$this->requirePermission('admin');
	}

    public function statistics ()
    {
        // $this->template->addBreadcrumb('admin', 'Admin');

        // $_semesters = $this->schema('Syllabus_Admin_Semester');

        // if ($code = $this->request->getQueryParameter('semester'))
        // {
        //     $year = $code[0].'0'.$code[1].$code[2];
        //     $semester = $code[3];
        // }
        // else
        // {
        //     list($year, $semester) = Syllabus_Admin_Semester::guessActiveSemester(false);
        //     $code = $year . $semester;
        //     $year = $year[0].'0'.$year[1].$year[2];
        // }
        // $activeSemester = $_semesters->findOne($_semesters->internal->equals($code));
        // $semesterOnline = 0;
        // $totalOnline = 0;
        // $semesterFiles = 0;
        // $totalFiles = 0;
        // $semesterInstructors = 0;
        // $totalInstructors = 0;

        // // PUBLISHED ONLINE SYLLABI
        // $rs = pg_query("
        //     select count(s.*) from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id) and 
        //         s.file_id is null and
        //         c.semester = '{$semester}' and 
        //         c.year = '{$year}';
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $semesterOnline = $row[0][0];
        // }
        // $rs = pg_query("
        //     select count(s.*) from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id) and 
        //         s.file_id is null;
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $totalOnline = $row[0][0];
        // }       

        // // PUBLISHED FILE SYLLABI
        // $rs = pg_query("
        //     select count(s.*) from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id) and 
        //         s.file_id is null and
        //         c.semester = '{$semester}' and 
        //         c.year = '{$year}';
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $semesterFiles = $row[0][0];
        // }
        // $rs = pg_query("
        //     select count(s.*) from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id) and 
        //         s.file_id is not null;
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $totalFiles = $row[0][0];
        // }    

        // // INSTRUCTORS
        // $rs = pg_query("
        //     select count(distinct(s.created_by_id)) 
        //     from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id) and 
        //         c.semester = '{$semester}' and 
        //         c.year = '{$year}';
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $semesterInstructors = $row[0][0];
        // }
        // $rs = pg_query("
        //     select count(distinct(s.created_by_id)) 
        //     from syllabus_syllabus s, syllabus_published_syllabus p, syllabus_classdata_course_sections c where 
        //         p.share_level = 'all' and 
        //         p.syllabus_id = s.id and 
        //         (s.id = c.syllabus_id or s.course_section_id = c.id);
        // ");
        // while (($row = pg_fetch_row($rs)))
        // {
        //     $totalInstructors = $row[0][0];
        // }    
        
        // $this->template->semesterOnline = $semesterOnline;
        // $this->template->totalOnline = $totalOnline;
        // $this->template->semesterFiles = $semesterFiles;
        // $this->template->totalFiles = $totalFiles;
        // $this->template->semesterInstructors = $semesterInstructors;
        // $this->template->totalInstructors = $totalInstructors;
        // $this->template->semesters = $_semesters->getAll(['orderBy' => '-internal']);
        // $this->template->activeSemester = $activeSemester;
        // $this->template->display = $activeSemester->display;
        // $this->template->internal = $activeSemester->internal;
    }

    public function universityTemplates ()
    {
        $this->template->addBreadcrumb('admin', 'Admin');
        $this->template->addBreadcrumb('admin/templates/university', 'University Templates');
        $viewer = $this->requireLogin();
        if (!$this->hasPermission('admin'))
        {
            $this->sendError(403, 'Forbidden', 'Non-Admin', 'You must be a site Administrator to manage university templates.');
        }
        $syllabi = $this->schema('Syllabus_Syllabus_Syllabus');
        $siteSettings = $this->getApplication()->siteSettings;
        
        $userId = $siteSettings->getProperty('university-template-user-id');
        $templateId = $siteSettings->getProperty('university-template-id');

        if ($newUserId = $this->request->getQueryParameter('userId'))
        {
            $siteSettings->setProperty('university-template-user-id', $newUserId);
            $userId = $newUserId;
        }

        if ($userId)
        {
            $universityTemplates = $syllabi->find(
                $syllabi->createdById->equals($userId),
                ['orderBy' => ['-modifiedDate', '-createdDate']]
            );
            // foreach ($universityTemplates as $template)
            // {
            //     $sid = $template->id;
            //     $results = $this->getScreenshotUrl($sid);
            //     $template->imageUrl = $results->imageUrls->$sid;
            // }
            $this->template->universityTemplates = $universityTemplates;
        }

        if ($this->request->wasPostedByUser())
        {
            switch ($this->getPostCommand())
            {
                case 'select':
                    $templateId = $this->request->getPostParameter('template');
                    if ($template = $syllabi->get($templateId))
                    {
                        $template->templateAuthorizationId = 'university/' . $templateId;
                        $template->save();
                        $siteSettings->setProperty('university-template-id', $templateId);
                        $this->flash('The University Template has been set.');
                    }
                    break;
                case 'unset':
                    $siteSettings->setProperty('university-template-id', null);
                    $this->flash('Template has been unset');
            }
            $this->response->redirect('admin/templates/university');
        }

        $this->template->templateId = $templateId;
        $this->template->userId = $userId;
    }

    public function guideDocs ()
    {
        $this->template->addBreadcrumb('admin/syllabus/guidedocs', 'Guidelines & Documents');
        $files = $this->schema('Syllabus_Files_File');
        $guideDocs = $this->schema('Syllabus_Syllabus_SharedResource');
        $allGuideDocs = $guideDocs->getAll(['orderBy' => ['sortOrder', 'title']]);
        $bottommostPosition = -1;
        if ($allGuideDocs)
        {
            $bottommostPosition = array_values(array_slice($allGuideDocs, -1))[0]->sortOrder;    
        }
        
        if ($this->request->wasPostedByUser())
        {
            $data = $this->request->getPostParameters();
            switch ($this->getPostCommand())
            {
                case 'upload':
                    $file = $files->createInstance();
                    $file->createFromRequest($this->request, 'file', false);
                    
                    if ($file->isValid())
                    {
                        $file->uploadedBy = $this->getAccount();
                        $file->moveToPermanentStorage();
                        $file->save();
                    }
                    
                    $this->template->errors = $file->getValidationMessages();
                    break;
                
                case 'save': 
                    $resource = (isset($data['resourceId'])&&$data['resourceId']!=='') ? 
                        $guideDocs->get($data['resourceId']) : $guideDocs->createInstance();
                    $resource->sortOrder = (isset($data['resource']) && isset($data['resource']['sortOrder']) ? 
                        $data['resource']['sortOrder'] : ($bottommostPosition+1));
                    $resource->fileId = isset($data['resource']['fileId']) ? (int)$data['resource']['fileId'] : null;
                    $resource->title = $data['resource']['title'];
                    $resource->iconClass = $data['resource']['iconClass'];
                    $resource->description = $data['resource']['description'];
                    $resource->url = isset($data['resource']['url']) ? $data['resource']['url'] : null;
                    $resource->createdDate = new DateTime;
                    $resource->active = isset($data['resource']['active']);
                    $resource->save();
                    
                    $this->flash('Resource saved.');
                    break;

                case 'delete':
                    $resource = $this->requireExists($guideDocs->get(key($this->getPostCommandData())));

                    $resource->delete();
                    $this->flash('Resource has been flagged as deleted.', 'secondary');
                    break;

                case 'sort':
                    foreach ($data['sortOrder'] as $id => $sortOrder)
                    {
                        $resource = $this->requireExists($guideDocs->get($id));
                        $resource->sortOrder = $sortOrder;
                        $resource->save();
                    }
                    $this->flash('Order of campus resources updated.', 'success');
                    break;

            }
            $this->response->redirect('admin/syllabus/guidedocs');
        }

        if (!$this->request->wasPostedByUser() && ($resourceId = $this->request->getQueryParameter('edit')))
        {
            $this->template->resource = $guideDocs->get($resourceId);
        }

        $this->template->bottommostPosition = $bottommostPosition;
        $this->template->guideDocs = $allGuideDocs;
        $this->template->files = $files->getAll();
    }

    public function campusResources ()
    {
        $this->template->addBreadcrumb('admin/syllabus/resources', 'Campus Resources');
        $files = $this->schema('Syllabus_Files_File');
        $campusResources = $this->schema('Syllabus_Syllabus_CampusResource');
        $tags = $this->schema('Syllabus_Resources_Tag');

        $allResources = $campusResources->find(
            $campusResources->deleted->isFalse()->orIf($campusResources->deleted->isNull()),
            ['orderBy' => ['title']]
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
                    $file->createFromRequest($this->request, 'file', false);
                    
                    if ($file->isValid())
                    {
                        $file->uploadedBy = $this->getAccount();
                        $file->moveToPermanentStorage();
                        $file->save();
                    }
                    
                    $this->template->errors = $file->getValidationMessages();
                    break;
                
                case 'save': 

                    // echo "<pre>"; var_dump($data); die;
                    
                    $resource = (isset($data['resourceId'])&&$data['resourceId']!=='') ? 
                        $campusResources->get($data['resourceId']) : $campusResources->createInstance();
                    $resource->sortOrder = (isset($data['resource']) && isset($data['resource']['sortOrder']) ? 
                        $data['resource']['sortOrder'] : ($bottommostPosition+1));
                    $resource->imageId = $data['resource']['imageId'];
                    $resource->title = $data['resource']['title'];
                    $resource->abbreviation = $data['resource']['abbreviation'];
                    $resource->description = $data['resource']['description'];
                    $resource->url = $data['resource']['url'];
                    $resource->createdDate = $resource->createdDate ?? new DateTime;
                    $resource->modifiedDate = new DateTime;
                    $resource->save();
                    
                    foreach ($resource->tags as $tag)
                    {
                        if (!isset($data['tags'][$tag->id]))
                        {
                            $resource->tags->remove($tag);
                            $resource->tags->save();
                        }
                    }
                    foreach ($data['tags'] as $id)
                    {
                        if ($id !== 'new')
                        {
                            $tag = $tags->get((int)$id);
                            if ($tag && !$resource->tags->has($tag))
                            {
                                $resource->tags->add($tag);
                                $resource->tags->save();
                                $resource->save();
                            }
                        }
                    }

                    if ($data['tags']['new'])
                    {
                        if (!($tag = $tags->findOne($tags->name->equals($data['tags']['new']))))
                        {
                            $tag = $tags->createInstance();
                            $tag->name = $data['tags']['new'];
                            $tag->save();
                        }
                        $resource->tags->add($tag);
                        $resource->tags->save();
                        $resource->save();
                    }

                    $this->flash('Resource saved.');
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

                case 'deletetag':
                    $tag = $this->requireExists($tags->get($this->getPostCommandData()));
                    foreach ($tag->resources as $resource)
                    {
                        $tag->resources->remove($resource);
                    }
                    $tag->delete();
                    $this->flash('Tag removed');
                    
                    break;
            }
            $this->response->redirect('admin/syllabus/resources');
        }

        if (!$this->request->wasPostedByUser() && ($resourceId = $this->request->getQueryParameter('edit')))
        {
            $this->template->resource = $campusResources->get($resourceId);
        }

        $this->template->bottommostPosition = $bottommostPosition;
        $this->template->campusResources = $allResources;
        $this->template->tags = $tags->getAll(['orderBy' => 'name']);
        $this->template->files = $files->getAll(['orderBy' => ['-uploadedDate', 'remoteName']]);
    }
}















