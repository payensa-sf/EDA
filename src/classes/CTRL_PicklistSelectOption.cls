/*
    Copyright (c) 2019, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
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
* @description Controller for LWC drop down
*/
public with sharing class CTRL_PicklistSelectOption {
	/**
    * @description Aura enabled entry point that calls appropriate services to pass view models to LWC component
    */
    @AuraEnabled(cacheable=true)
    public static VMDL_PicklistOptions getFieldSelectOptions(String objectName, String fieldAPIName) {
        return new VMDL_PicklistOptions(SRVC_PicklistSelectOption.getInstance().getPicklistViewModelsFromObjectAndFieldAPI(objectName, fieldAPIName));
    }

    /**
    * @description Top-level view model for field select options
    */
    public with sharing class VMDL_PicklistOptions {
        @AuraEnabled
        public List<SRVC_PicklistSelectOption.VMDL_PicklistSelectOption> fieldSelectOptions {get; private set; }
        
        public VMDL_PicklistOptions(List<SRVC_PicklistSelectOption.VMDL_PicklistSelectOption> fieldSelectOptions){
            this.fieldSelectOptions = fieldSelectOptions;
        }

    }
}