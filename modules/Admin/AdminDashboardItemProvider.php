<?php

/**
 */
class Syllabus_Admin_AdminDashboardItemProvider extends At_Admin_DashboardItemProvider
{
    public function getSections (Bss_Master_UserContext $userContext)
    {
        return [
            'Site Settings' => [
                'order' => 2,
            ],
        ];
    }
    
    public function getItems (Bss_Master_UserContext $userContext)
    {
        return [
            'dates-set-semester' => [
                'section' => 'Site Settings',
                'order' => 1,
                'href' => 'admin/classdata/semesters',
                'text' => 'Set active and visible semesters',
            ],
        ];
    }
}
