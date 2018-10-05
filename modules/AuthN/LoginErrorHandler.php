<?php

/**
 * Handles the case when someone attempts to login with a nonexistent account.
 * There are three different cases of interest here:
 * 
 * 1. The user is authenticated by Shibboleth (or another remote identity
 *    provider) and has a Fresca account, but their Fresca account's username
 *    equals their e-mail address rather than the username returned by 
 *    Shibboleth. We fix the acocunt's username and log them in seamlessly.
 * 
 * 2. The user is authenticated but they do not have a Fresca account with a
 *    username that matches either their Shibboleth username or e-mail
 *    address. It's still possible that the person has a Fresca account under a
 *    different e-mail address, but we deal with these mismatches through 
 *    manual intervention. If the user is of the appropriate role, they should
 *    be allowed to create a new account.
 * 
 * 3. The user is unauthenticated and no account could be found. This generally
 *    occurs because the user entered the wrong username (e-mail address) for
 *    the internal password authentication scheme. We treat this the same as
 *    Bss_AuthN_ExLoginRequired.
 * 
 * @author      Daniel A. Koepke (dkoepke@sfsu.edu)
 * @copyright   Copyright &copy; San Francisco State University.
 */
class Syllabus_AuthN_LoginErrorHandler extends Syllabus_Master_ErrorHandler
{
    public static function getErrorClassList () { return array('Bss_AuthN_ExLoginRequired', 'Bss_AuthN_ExAuthenticationFailure'); }
    
    private $pageTitle;
    private $selectedHandler;
    private static $Handlers = array(
        'Bss_AuthN_ExLoginRequired' => array(
            'template' => 'loginRequired.html.tpl',
            'method' => 'handleLoginRequired',
        ),
        'Bss_AuthN_ExAuthenticationFailure' => array(
            'template' => 'failedAuthentication.html.tpl',
            'method' => 'handleFailedAuthentication',
        )
    );
    
    protected function getStatusCode () { return 403; }
    protected function getStatusMessage () { return 'Forbidden'; }
    protected function getTemplateFile () { return $this->selectedHandler['template']; }
    
    protected function handleError ($error)
    {
        $this->selectedHandler = self::$Handlers[get_class($error)];
        
        $moduleManager = $this->getApplication()->moduleManager;
        $this->addTemplateFileLocator(new Bss_Template_ModuleFileLocator($moduleManager->getModule('bss:core:authN')));
        
        $manager = $this->application->identityProviderManager;
        
        $providerList = $manager->getProviders();
        $providerIdList = array_keys($providerList);
        $soleProvider = (count($providerList) == 1 ? $providerIdList[0] : null);
        $providerName = $error->getRequest()->getQueryParameter('idp', $soleProvider);
        
        $this->template->providerList = $providerList;
        $this->template->selectedProvider = $providerName;
        
        call_user_func(array($this, $this->selectedHandler['method']), $error);
        
        parent::handleError($error);
    }
    
    protected function handleLoginRequired ($error)
    {
        
    }
    
    protected function handleFailedAuthentication ($error)
    {
        
    }
}