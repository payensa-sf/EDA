/*
    Copyright (c) 2021, Salesforce.org
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
 * @date 2021
 * @group
 * @group-content ../../ApexDocContent/
 * @description Test class for ProgramPlanSettingsService
 */
@isTest
public with sharing class ProgramPlanSettingsService_TEST {
    /**************************************************************************************************************************
     * @description Test method to verify that the getInstance method returns a new instance of the
     * ProgramPlanSettingsService class when one does not already exist.
     ***************************************************************************************************************************/
    @isTest
    private static void getInstanceNew() {
        Test.startTest();
        ProgramPlanSettingsService programPlanSettingsServiceInstance = ProgramPlanSettingsService.getInstance();
        Test.stopTest();

        System.assertEquals(
            ProgramPlanSettingsService.instance,
            programPlanSettingsServiceInstance,
            'Instance of service class returned should match static instance variable.'
        );
        System.assertEquals(
            true,
            programPlanSettingsServiceInstance != null,
            'Instance of service class should not be null.'
        );
    }

    /**************************************************************************************************************************
     * @description Test method to verify that the getInstance method returns the existing instance of the
     * ProgramPlanSettingsService class when one already exists.
     ***************************************************************************************************************************/
    @isTest
    private static void getInstanceExisting() {
        Test.startTest();
        ProgramPlanSettingsService ppSettingsMapper1 = ProgramPlanSettingsService.getInstance();
        ProgramPlanSettingsService ppSettingsMapper2 = ProgramPlanSettingsService.getInstance();
        Test.stopTest();

        System.assertEquals(
            ProgramPlanSettingsService.instance,
            ppSettingsMapper1,
            'Instance of service class returned should match static instance variable.'
        );
        System.assertEquals(
            ppSettingsMapper1,
            ppSettingsMapper2,
            'Subsequent retrievals of service class instance should return existing instance.'
        );
        System.assertEquals(true, ppSettingsMapper1 != null, 'Instance of service class should not be null.');
    }

    /**************************************************************************************************************************
     * @description Test method to verify that the locateProgramPlanSettingsMapper method returns an instance
     * of the ProgramPlanSettingsMapper class.
     ***************************************************************************************************************************/
    @isTest
    private static void locateProgramPlanSettingsMapperValid() {
        ProgramPlanSettingsService programPlanSettingsServiceInstance = ProgramPlanSettingsService.getInstance();

        Test.startTest();
        ProgramPlanSettingsMapper programPlanSettingsMapperInstance = programPlanSettingsServiceInstance.locateProgramPlanSettingsMapper();
        Test.stopTest();

        System.assertEquals(
            ProgramPlanSettingsMapper.getInstance(),
            programPlanSettingsMapperInstance,
            'Should return instance of ProgramPlanSettingsMapper class.'
        );
    }

    /**************************************************************************************************************************
     * @description Test method to verify that the getProgramPlanSettingsModel method returns a ProgramPlanSettingsModel
     ***************************************************************************************************************************/
    @isTest
    private static void getProgramEnrollmentDeletionSettingsModelValid() {
        ProgramPlanSettingsMapper.instance = new STUB_ProgramPlanSettingsMapper();

        ProgramPlanSettingsService programPlanSettingsServiceInstance = ProgramPlanSettingsService.getInstance();

        Test.startTest();
        ProgramPlanSettingsModel ppSettingsModel = programPlanSettingsServiceInstance.getProgramPlanSettingsModel();
        Test.stopTest();

        System.assertEquals(
            false,
            ppSettingsModel.validateProgramPlanForNestedPR,
            'validateProgramPlanForNestedPR should not be enabled.'
        );
    }

    /***********************************************************************************************************************************
     ****************************************************** STUBS ***********************************************************************
     ***********************************************************************************************************************************/

    /**************************************************************************************************************************************
     * @description Stub class to simulate the response from ProgramPlanSettingsMapper to return
     * a valid ProgramPlanSettingsModel
     **************************************************************************************************************************************/
    private class STUB_ProgramPlanSettingsMapper extends ProgramPlanSettingsMapper {
        public override ProgramPlanSettingsModel getProgramPlanSettingsModel() {
            return new ProgramPlanSettingsModel(false);
        }
    }
}