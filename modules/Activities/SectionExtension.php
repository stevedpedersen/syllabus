<?php

class Syllabus_Activities_SectionExtension extends Syllabus_Syllabus_SectionExtension
{
    public static function getExtensionName () { return 'activities'; }
    
    public function getExtensionKey () { return 'activities_id'; }
    public function getDisplayName ($plural = false) { return 'Activities'; }
    public function getHelpText () { return 'You may change the title of this section from Activities to Homework, Quizzes, Projects, or whatever best describes the activities in this section. It is suggested to add a new Activities section for each new table.'; }
    public function getRecordClass () { return 'Syllabus_Activities_Activities'; }
    public function getSectionTasks () { return []; }
    public function getSectionOrder () { return 6; }
    public function canHaveMultiple () { return true; }
    public function hasImportableContent () { return true; }
    public function getEditFormFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_activities.edit.html.tpl');
    }
    public function getViewFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_activities.view.html.tpl');
    }
    public function getOutputFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_activities.output.html.tpl');
    }
    public function getExportFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_activities.export.html.tpl');
    }
    public function getImportFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_import.html.tpl');
    }
    public function getPreviewFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_preview.html.tpl');
    }
    public function getExtensionProperties ()
    {
        return [
            'activities' => ['1:1', 'to' => 'Syllabus_Activities_Activities', 'keyMap' => ['activities_id' => 'id']],
        ];
    }
    
    public function getExtensionMethods() { return []; }

}