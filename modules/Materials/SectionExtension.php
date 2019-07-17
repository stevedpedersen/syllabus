<?php

class Syllabus_Materials_SectionExtension extends Syllabus_Syllabus_SectionExtension
{
    public static function getExtensionName () { return 'materials'; }
    
    public function getExtensionKey () { return 'materials_id'; }
    public function getDisplayName ($plural = false) { return 'Materials'; }
    public function getHelpText () { return 'Add multiple materials at a time in this Materials section type.'; }
    public function getRecordClass () { return 'Syllabus_Materials_Materials'; }
    public function getSectionTasks () { return []; }
    public function getEditFormFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_materials.edit.html.tpl');
    }
    public function getViewFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_materials.view.html.tpl');
    }
    public function getOutputFragment ()
    {
        return Bss_Core_PathUtils::path(dirname(__FILE__), 'resources', '_materials.output.html.tpl');
    }
    public function getExtensionProperties ()
    {
        return [
            'materials' => ['1:1', 'to' => 'Syllabus_Materials_Materials', 'keyMap' => ['materials_id' => 'id']],
        ];
    }
    
    public function getExtensionMethods() { return []; }

}