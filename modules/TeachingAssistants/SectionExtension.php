<?php

class Syllabus_TeachingAssistants_SectionExtension extends Syllabus_Syllabus_SectionExtension
{
    public static function getExtensionName () { return 'teaching_assistants'; }
    
    public function getExtensionKey () { return 'teaching_assistants_id'; }
    public function getDisplayName ($plural = false) { return 'Teaching Assistants'; }
    public function getHelpText () { return 'Teaching Assistants section type of a syllabus.'; }
    public function getRecordClass () { return 'Syllabus_TeachingAssistants_TeachingAssistants'; }
    public function getSectionTasks () { return []; }
    public function canHaveMultiple () { return false; }
    public function getEditFormFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_teachingAssistants.edit.html.tpl');
    }
    public function getViewFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_teachingAssistants.view.html.tpl');
    }
    public function getOutputFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_teachingAssistants.output.html.tpl');
    }
    public function getExtensionProperties ()
    {
        return [
            'teachingAssistants' => ['1:1', 'to' => 'Syllabus_TeachingAssistants_TeachingAssistants', 'keyMap' => ['teaching_assistants_id' => 'id']],
        ];
    }
    
    public function getExtensionMethods() { return []; }

}