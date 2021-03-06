<?php

/**
 * Activities section type active record.
 * 
 * @author      Steve Pedersen (pedersen@sfsu.edu)
 * @copyright   Copyright &copy; San Francisco State University.
 */
class Syllabus_Activities_Activities extends Bss_ActiveRecord_Base
{
    use IsNotWhiteSpaceOnly;

    public static function SchemaInfo ()
    {
        return [
            '__type' => 'syllabus_activities',
            '__pk' => ['id'],
            
            'id' => 'int',

            'activities' => ['1:N', 'to' => 'Syllabus_Activities_Activity', 'reverseOf' => 'activitiesSection', 'orderBy' => ['+sortOrder']],
        ];
    }

    public function getActivities ()
    {
        $activities = [];
        foreach ($this->_fetch('activities') as $obj)
        {
            $activities[] = $obj;
        }    
        return !empty($activities) ? $activities : null;
    }

    public function processEdit ($request, $data=null) 
    {
        $data = $request->getPostParameters();
        $errorMsg = '';
        if (isset($data['section']) && isset($data['section']['real']))
        {
            $this->save();
            $schema = $this->getSchema('Syllabus_Activities_Activity');
            $htmlSanitizer = new Bss_RichText_HtmlSanitizer();
            foreach ($data['section']['real'] as $id => $activity)
            {
                if ($this->isNotWhiteSpaceOnly($activity, 'name'))
                {
                    $save = true;
                    $obj = $schema->createInstance();
                    if ($save)
                    {
                        $obj->absorbData($activity);
                        $obj->name = strip_tags(trim($activity['name']));
                        $obj->value = strip_tags(trim($activity['value']));
                        $obj->description = $htmlSanitizer->sanitize(trim($activity['description']));
                        $obj->activities_id = $this->id;
                        $obj->save();
                    }   
                }
                else
                {
                    $errorMsg = 'Any Activities with empty descriptions were not saved.';
                }
            }
        }

        return $errorMsg;
    }

    public function copyImportables ($resolvedImportable)
    {
        $ignoredProperties = ['sortOrder', 'id', 'activities'];
        $sortOrder = count($this->activities);
        $imported = [];

        if (!isset($this->id)) $this->save();

        foreach ($resolvedImportable->activities as $activity)
        {
            $deriv = $this->getSchema('Syllabus_Activities_Activity')->createInstance();
            foreach ($activity->getData() as $key => $val)
            {
                // echo "<pre>"; var_dump($activity->getData()); die;
                if (!in_array($key, $ignoredProperties))
                {
                    $deriv->$key = $val;
                }
                $deriv->sortOrder = $sortOrder;
                $sortOrder++;
            }
            $deriv->activities_id = $this->id;
            $deriv->save();
            $imported[] = $deriv;
        }

        return $imported;
    }
}
