<?php

/**
 * Base class for extensions to the Syllabus_Syllabus_Section active record to implement.
 * 
 * @author      Steve Pedersen (pedersen@sfsu.edu)
 * @copyright   Copyright &copy; San Francisco State University.
 */
abstract class Syllabus_Syllabus_SectionExtension extends Bss_Core_NamedExtension implements Bss_ActiveRecord_IExtension
{
    public static function getExtensionPointName () { return 'at:syllabus:syllabus/sectionExtensions'; }
    
    abstract public function getExtensionKey ();
    abstract public function getDisplayName ($plural = false);
    abstract public function getHelpText ();
    abstract public function getRecordClass ();
    abstract public function getSectionTasks ();
    abstract public function getEditFormFragment ();
    abstract public function getViewFragment (); // NOTE: View Fragment is for view mode while in editor
    abstract public function getOutputFragment ();

    // Does it make sense for a syllabus to have multiple instances of this section type?
    public function canHaveMultiple () { return true; }
    public function hasDefaults () { return false; }
    public function getAddonFormFragment () { return false; }
    public function hasImportableContent () { return false; }
    public function getSchema ()
    {
        if ($recordClass = $this->getRecordClass())
        {
            return $this->getApplication()->schemaManager->getSchema($recordClass);
        }
    }
    
    public function getDarkIcon ()
    {
        return 'assets/icons/sections/' . $this->getExtensionName() . '_dark.png';
    }
    public function getLightIcon ()
    {
        return 'assets/icons/sections/' . $this->getExtensionName() . '_light.png';
    }

    public function getImportableSections ()
    {
        $importables = $this->getApplication()->schemaManager->getSchema('Syllabus_Syllabus_ImportableSection');
        return $importables->find(
            $importables->externalKey->equals($this->getExtensionKey())->andIf($importables->importable->isTrue()),
            ['orderBy' => '-createdDate']
        );
    }

    public function initializeRecord (Bss_ActiveRecord_Base $record) {}

}