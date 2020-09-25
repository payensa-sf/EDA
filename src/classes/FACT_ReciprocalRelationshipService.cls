/*
    Copyright (c) 2020, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this List of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this List of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.org
* @date 2020
* @group 
* @group-content ../../ApexDocContent/
* @description Service class for REL_Relationships_Con_TDTM. TODO
*/
public virtual with sharing class FACT_ReciprocalRelationshipService {
    /*********************************************
    * @description Instance for Singleton Pattern.
    **********************************************/
    private static SRVC_ReciprocalRelationship instance;  

    /*********************************************************************
    * @description Empty constructor is not public for Singleton Pattern.
    **********************************************************************/
    protected FACT_ReciprocalRelationshipService() {}

    /*****************************************************************************
    * @description Static method to get the current instance for Singleton pattern.
    * @return The instance of FACT_ReciprocalRelationshipService.
    ******************************************************************************/
    public static SRVC_ReciprocalRelationship getInstance() {
        if (FACT_ReciprocalRelationshipService.instance == null) {
            FACT_ReciprocalRelationshipService.instance = FACT_ReciprocalRelationshipService.locateReciprocalRelationshipService();
        }

        return FACT_ReciprocalRelationshipService.instance;
    }

    /*****************************************************************************
    * @description Get the reciprocal method from custom setting.
    * @return The reciprocal method.
    ******************************************************************************/
    @TestVisible
    private static String getReciprocalMethodFromSettings() {
        return UTIL_CustomSettingsFacade.getSettings().Reciprocal_Method__c;
    }

    /*****************************************************************************
    * @description Retrieves an instance of the Reciprocal Relationship Service class based on the reciprocal method.
    * @return An instance of the ReciprocalRelationshipService class.
    ******************************************************************************/
    @TestVisible
    private static SRVC_ReciprocalRelationship locateReciprocalRelationshipService() {
        String reciprocalMethod = getReciprocalMethodFromSettings();
        if (reciprocalMethod == 'List Setting') {
            //return ReciprocalRelationshipListService
        }

        if (reciprocalMethod == 'Value Inversion') {
            //return ReciprocalRelationshipInversionService
        }
    
        return SRVC_ReciprocalRelationship.getInstance();
    }
}
