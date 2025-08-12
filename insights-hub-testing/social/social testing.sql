with fslm_cte AS(
SELECT 
    assessment_id,
    account_id,
    survey_version,
    (performance ->> 'cl_age_verification')::text AS cl_age_verification,
    (performance ->> 'cl_hazardous_work_legal')::boolean AS cl_hazardous_work_legal,
    (performance ->> 'cl_healthchecks')::text AS cl_healthchecks,
    (performance ->> 'cl_healthchecks_legal')::text AS cl_healthchecks_legal,
    (performance ->> 'cl_healthchecks_prioremployment')::text AS cl_healthchecks_prioremployment,
    (performance ->> 'cl_hs_protective_restrictions')::text AS cl_hs_protective_restrictions,
    (performance ->> 'cl_hs_separate_trainings')::text AS cl_hs_separate_trainings,
    (performance ->> 'cl_hs_specialtrainings')::text AS cl_hs_specialtrainings,
    (performance ->> 'cl_implement_separate_tracking')::text AS cl_implement_separate_tracking,
    (performance ->> 'cl_internship_legal')::text AS cl_internship_legal,
    (performance ->> 'cl_nightwork')::boolean AS cl_nightwork,
    (performance ->> 'cl_parental_permission')::text AS cl_parental_permission,
    (performance ->> 'cl_parental_review')::text AS cl_parental_review,
    (performance ->> 'cl_protectiverestriction_u18')::text AS cl_protectiverestriction_u18,
    (performance ->> 'cl_written_remediation_policy')::text AS cl_written_remediation_policy,
    (performance ->> 'cl_youngest_worker')::text AS cl_youngest_worker,
    (performance ->> 'cl_youngest_worker12_18')::integer AS cl_youngest_worker12_18,
    (performance ->> 'disc_contraception_hiring')::boolean AS disc_contraception_hiring,
    (performance ->> 'disc_contraception_requirement_employment')::boolean AS disc_contraception_requirement_employment,
    (performance ->> 'disc_disability_accommodations')::text AS disc_disability_accommodations,
    (performance ->> 'disc_disabled_hiring_legal')::text AS disc_disabled_hiring_legal,
    (performance ->> 'disc_illness_termination')::text AS disc_illness_termination,
    (performance ->> 'disc_pregnancy_requirements_hiring')::boolean AS disc_pregnancy_requirements_hiring,
    (performance ->> 'disc_promotion_age')::boolean AS disc_promotion_age,
    (performance ->> 'disc_promotion_disability')::boolean AS disc_promotion_disability,
    (performance ->> 'disc_promotion_hiv')::boolean AS disc_promotion_hiv,
    (performance ->> 'disc_promotion_maritalstatus')::boolean AS disc_promotion_maritalstatus,
    (performance ->> 'disc_promotion_maternity')::boolean AS disc_promotion_maternity,
    (performance ->> 'disc_promotion_nationalextraction')::boolean AS disc_promotion_nationalextraction,
    (performance ->> 'disc_promotion_nationality')::boolean AS disc_promotion_nationality,
    (performance ->> 'disc_promotion_other')::boolean AS disc_promotion_other,
    (performance ->> 'disc_promotion_politicalopinion')::boolean AS disc_promotion_politicalopinion,
    (performance ->> 'disc_promotion_race')::boolean AS disc_promotion_race,
    (performance ->> 'disc_promotion_religion')::boolean AS disc_promotion_religion,
    (performance ->> 'disc_promotion_sex')::boolean AS disc_promotion_sex,
    (performance ->> 'disc_promotion_sexualorientation')::boolean AS disc_promotion_sexualorientation,
    (performance ->> 'disc_promotion_socialorigin')::boolean AS disc_promotion_socialorigin,
    (performance ->> 'disc_retaliation_termination')::text AS disc_retaliation_termination,
    (performance ->> 'disc_termination_age')::boolean AS disc_termination_age,
    (performance ->> 'disc_termination_disability')::boolean AS disc_termination_disability,
    (performance ->> 'disc_termination_hiv')::boolean AS disc_termination_hiv,
    (performance ->> 'disc_termination_maritalstatus')::boolean AS disc_termination_maritalstatus,
    (performance ->> 'disc_termination_maternity')::boolean AS disc_termination_maternity,
    (performance ->> 'disc_termination_nationalextraction')::boolean AS disc_termination_nationalextraction,
    (performance ->> 'disc_termination_nationality')::boolean AS disc_termination_nationality,
    (performance ->> 'disc_termination_other')::boolean AS disc_termination_other,
    (performance ->> 'disc_termination_politicalopinion')::boolean AS disc_termination_politicalopinion,
    (performance ->> 'disc_termination_race')::boolean AS disc_termination_race,
    (performance ->> 'disc_termination_religion')::boolean AS disc_termination_religion,
    (performance ->> 'disc_termination_sex')::boolean AS disc_termination_sex,
    (performance ->> 'disc_termination_sexualorientation')::boolean AS disc_termination_sexualorientation,
    (performance ->> 'disc_termination_socialorigin')::boolean AS disc_termination_socialorigin,
    (performance ->> 'disc_virginity_test_hiring')::boolean AS disc_virginity_test_hiring,
    (performance ->> 'disc_workconditions_age')::boolean AS disc_workconditions_age,
    (performance ->> 'disc_workconditions_disability')::boolean AS disc_workconditions_disability,
    (performance ->> 'disc_workconditions_hiv')::boolean AS disc_workconditions_hiv,
    (performance ->> 'disc_workconditions_maritalstatus')::boolean AS disc_workconditions_maritalstatus,
    (performance ->> 'disc_workconditions_maternity')::boolean AS disc_workconditions_maternity,
    (performance ->> 'disc_workconditions_nationalextraction')::boolean AS disc_workconditions_nationalextraction,
    (performance ->> 'disc_workconditions_nationality')::boolean AS disc_workconditions_nationality,
    (performance ->> 'disc_workconditions_other')::boolean AS disc_workconditions_other,
    (performance ->> 'disc_workconditions_politicalopinion')::boolean AS disc_workconditions_politicalopinion,
    (performance ->> 'disc_workconditions_race')::boolean AS disc_workconditions_race,
    (performance ->> 'disc_workconditions_religion')::boolean AS disc_workconditions_religion,
    (performance ->> 'disc_workconditions_sex')::boolean AS disc_workconditions_sex,
    (performance ->> 'disc_workconditions_sexualorientation')::boolean AS disc_workconditions_sexualorientation,
    (performance ->> 'disc_workconditions_socialorigin')::boolean AS disc_workconditions_socialorigin,
    (performance ->> 'discp_legal')::text AS discp_legal,
    (performance ->> 'ep_all_with_contract')::text AS ep_all_with_contract,
    (performance ->> 'ep_defense')::text AS ep_defense,
    (performance ->> 'ep_limits_fixed_contracts')::text AS ep_limits_fixed_contracts,
    (performance ->> 'ep_personnelfiles_legal')::text AS ep_personnelfiles_legal,
    (performance ->> 'ep_probation_legal')::text AS ep_probation_legal,
    (performance ->> 'ep_rif_alternatives')::text AS ep_rif_alternatives,
    (performance ->> 'ep_temp_contracts_avoid_legal')::text AS ep_temp_contracts_avoid_legal,
    (performance ->> 'ep_work_legal')::text AS ep_work_legal,
    (performance ->> 'ep_workers_were_not_given_notice')::text AS ep_workers_were_not_given_notice,
    (performance ->> 'erg_retaliation')::text AS erg_retaliation,
    (performance ->> 'fl_are_any_monetary_deposits')::text AS fl_are_any_monetary_deposits,
    (performance ->> 'fl_forced_overtime')::text AS fl_forced_overtime,
    (performance ->> 'fl_migrant_recruitment_legal')::text AS fl_migrant_recruitment_legal,
    (performance ->> 'fl_passport_access')::text AS fl_passport_access,
    (performance ->> 'fl_prison_labor')::text AS fl_prison_labor,
    (performance ->> 'fl_recruitment_costs_legal')::text AS fl_recruitment_costs_legal,
    (performance ->> 'fl_reimbursement_fees')::text AS fl_reimbursement_fees,
    (performance ->> 'fl_restricted_leaving')::text AS fl_restricted_leaving,
    (performance ->> 'fl_terminate_employment_postnotice')::text AS fl_terminate_employment_postnotice,
    (performance ->> 'fl_witheld_payments')::text AS fl_witheld_payments,
    (performance ->> 'foa_armed_break_strike')::boolean AS foa_armed_break_strike,
    (performance ->> 'foa_cba_favorable_as_law')::text AS foa_cba_favorable_as_law,
    (performance ->> 'foa_consultation_union_legal')::text AS foa_consultation_union_legal,
    (performance ->> 'foa_control_unions')::text AS foa_control_unions,
    (performance ->> 'foa_equal_union_treatment_legal')::text AS foa_equal_union_treatment_legal,
    (performance ->> 'foa_form_join_federations')::text AS foa_form_join_federations,
    (performance ->> 'foa_free_to_meet_wo_mgmt')::text AS foa_free_to_meet_wo_mgmt,
    (performance ->> 'foa_new_workers_replace_strikers')::boolean AS foa_new_workers_replace_strikers,
    (performance ->> 'foa_private_meeting_legal')::text AS foa_private_meeting_legal,
    (performance ->> 'foa_punished_strikes')::boolean AS foa_punished_strikes,
    (performance ->> 'foa_required_union')::text AS foa_required_union,
    (performance ->> 'foa_trade_union_representatives_access')::text AS foa_trade_union_representatives_access,
    (performance ->> 'foa_union_activity_hiring')::text AS foa_union_activity_hiring,
    (performance ->> 'foa_union_intimidation')::boolean AS foa_union_intimidation,
    (performance ->> 'foa_union_punished')::boolean AS foa_union_punished,
    (performance ->> 'foa_union_support_legal')::text AS foa_union_support_legal,
    (performance ->> 'foa_union_terminated')::boolean AS foa_union_terminated,
    (performance ->> 'foa_unions')::text AS foa_unions,
    (performance ->> 'foa_untion_deductions_legal')::text AS foa_untion_deductions_legal,
    (performance ->> 'fp_does_the_facility_maintain')::text AS fp_does_the_facility_maintain,
    (performance ->> 'fp_operating_license_registration')::text AS fp_operating_license_registration,
    (performance ->> 'hb_cases_abuse')::text AS hb_cases_abuse,
    (performance ->> 'hb_cases_characteristics')::text AS hb_cases_characteristics,
    (performance ->> 'hb_effective_remediation')::text AS hb_effective_remediation,
    (performance ->> 'hb_forced_work_strike')::text AS hb_forced_work_strike,
    (performance ->> 'hb_harassment_age')::boolean AS hb_harassment_age,
    (performance ->> 'hb_harassment_disability')::boolean AS hb_harassment_disability,
    (performance ->> 'hb_harassment_hiv')::boolean AS hb_harassment_hiv,
    (performance ->> 'hb_harassment_maternitystatus')::boolean AS hb_harassment_maternitystatus,
    (performance ->> 'hb_harassment_nationality')::boolean AS hb_harassment_nationality,
    (performance ->> 'hb_harassment_other')::boolean AS hb_harassment_other,
    (performance ->> 'hb_harassment_politicalopinion')::boolean AS hb_harassment_politicalopinion,
    (performance ->> 'hb_harassment_race')::boolean AS hb_harassment_race,
    (performance ->> 'hb_harassment_religion')::boolean AS hb_harassment_religion,
    (performance ->> 'hb_harassment_sexualorientation')::boolean AS hb_harassment_sexualorientation,
    (performance ->> 'hb_immigration_threats')::text AS hb_immigration_threats,
    (performance ->> 'hb_sexualharassment_cases')::integer AS hb_sexualharassment_cases,
    (performance ->> 'hb_violence_intimidation')::text AS hb_violence_intimidation,
    (performance ->> 'hb_written_recrods_threats_forcedwork')::text AS hb_written_recrods_threats_forcedwork,
    (performance ->> 'hb_writtenrecords_discp_forcedwork')::text AS hb_writtenrecords_discp_forcedwork,
    (performance ->> 'hb_writtenrecords_harassment_age')::text AS hb_writtenrecords_harassment_age,
    (performance ->> 'hb_writtenrecords_harassment_disability')::text AS hb_writtenrecords_harassment_disability,
    (performance ->> 'hb_writtenrecords_harassment_hiv')::text AS hb_writtenrecords_harassment_hiv,
    (performance ->> 'hb_writtenrecords_harassment_maternity')::text AS hb_writtenrecords_harassment_maternity,
    (performance ->> 'hb_writtenrecords_harassment_nationality')::text AS hb_writtenrecords_harassment_nationality,
    (performance ->> 'hb_writtenrecords_harassment_other')::text AS hb_writtenrecords_harassment_other,
    (performance ->> 'hb_writtenrecords_harassment_politicalopinion')::text AS hb_writtenrecords_harassment_politicalopinion,
    (performance ->> 'hb_writtenrecords_harassment_race')::text AS hb_writtenrecords_harassment_race,
    (performance ->> 'hb_writtenrecords_harassment_religion')::text AS hb_writtenrecords_harassment_religion,
    (performance ->> 'hb_writtenrecords_harassment_sexualharassment')::text AS hb_writtenrecords_harassment_sexualharassment,
    (performance ->> 'hb_writtenrecords_harassment_sexualorientation')::text AS hb_writtenrecords_harassment_sexualorientation,
    (performance ->> 'hs_accessible_emergency_vehicles')::text AS hs_accessible_emergency_vehicles,
    (performance ->> 'hs_airborne_particulates_legal_exposure')::text AS hs_airborne_particulates_legal_exposure,
    (performance ->> 'hs_alarm_system_all_emergencies')::text AS hs_alarm_system_all_emergencies,
    (performance ->> 'hs_alarm_system_no_backup')::boolean AS hs_alarm_system_no_backup,
    (performance ->> 'hs_alarm_system_no_maintenance')::boolean AS hs_alarm_system_no_maintenance,
    (performance ->> 'hs_alarm_system_not_accessible')::boolean AS hs_alarm_system_not_accessible,
    (performance ->> 'hs_alarm_system_not_distinct')::boolean AS hs_alarm_system_not_distinct,
    (performance ->> 'hs_alarm_system_not_heard')::boolean AS hs_alarm_system_not_heard,
    (performance ->> 'hs_alarm_system_notfunctioning')::boolean AS hs_alarm_system_notfunctioning,
    (performance ->> 'hs_are_pregnant_and_nursing')::text AS hs_are_pregnant_and_nursing,
    (performance ->> 'hs_backup_ee_lighting_none_of_the_above')::boolean AS hs_backup_ee_lighting_none_of_the_above,
    (performance ->> 'hs_bangladesh_acid_storage_legal')::text AS hs_bangladesh_acid_storage_legal,
    (performance ->> 'hs_bangladesh_overcrowding_legal_compliance')::text AS hs_bangladesh_overcrowding_legal_compliance,
    (performance ->> 'hs_beds_two_tiers')::boolean AS hs_beds_two_tiers,
    (performance ->> 'hs_building_construction_structural_legal')::text AS hs_building_construction_structural_legal,
    (performance ->> 'hs_cambodia_chemical_mixing')::text AS hs_cambodia_chemical_mixing,
    (performance ->> 'hs_cambodia_spills_legal')::text AS hs_cambodia_spills_legal,
    (performance ->> 'hs_cases_physical_integrity')::text AS hs_cases_physical_integrity,
    (performance ->> 'hs_chemical_harardous_legal')::text AS hs_chemical_harardous_legal,
    (performance ->> 'hs_chemical_practices_legal')::text AS hs_chemical_practices_legal,
    (performance ->> 'hs_chemicals_disposed_in_waste')::boolean AS hs_chemicals_disposed_in_waste,
    (performance ->> 'hs_chemicals_hazardous')::text AS hs_chemicals_hazardous,
    (performance ->> 'hs_chemicals_inappropriate_containers')::boolean AS hs_chemicals_inappropriate_containers,
    (performance ->> 'hs_chemicals_legal')::text AS hs_chemicals_legal,
    (performance ->> 'hs_chemicals_no_spill_kit')::boolean AS hs_chemicals_no_spill_kit,
    (performance ->> 'hs_chemicals_no_written_procedures')::boolean AS hs_chemicals_no_written_procedures,
    (performance ->> 'hs_chemicals_other')::text AS hs_chemicals_other,
    (performance ->> 'hs_children_production_area')::text AS hs_children_production_area,
    (performance ->> 'hs_comply_health_legal_requirements_hiv')::text AS hs_comply_health_legal_requirements_hiv,
    (performance ->> 'hs_confined_authorized_entry_only')::boolean AS hs_confined_authorized_entry_only,
    (performance ->> 'hs_confined_space_accidental_entry')::boolean AS hs_confined_space_accidental_entry,
    (performance ->> 'hs_confined_space_air_safety')::text AS hs_confined_space_air_safety,
    (performance ->> 'hs_confined_space_appropriate_measures')::text AS hs_confined_space_appropriate_measures,
    (performance ->> 'hs_confined_space_no_rescue_equip')::boolean AS hs_confined_space_no_rescue_equip,
    (performance ->> 'hs_confined_space_no_signs')::boolean AS hs_confined_space_no_signs,
    (performance ->> 'hs_confined_space_not_trained')::text AS hs_confined_space_not_trained,
    (performance ->> 'hs_confined_spaces')::text AS hs_confined_spaces,
    (performance ->> 'hs_confined_spaces_legal')::text AS hs_confined_spaces_legal,
    (performance ->> 'hs_construction_permits_dorms')::text AS hs_construction_permits_dorms,
    (performance ->> 'hs_contract_dispose_hazardous_waste')::text AS hs_contract_dispose_hazardous_waste,
    (performance ->> 'hs_cooperation_mechanisms_workers_management')::text AS hs_cooperation_mechanisms_workers_management,
    (performance ->> 'hs_does_the_facility_record')::text AS hs_does_the_facility_record,
    (performance ->> 'hs_dorm_airtight_legal')::text AS hs_dorm_airtight_legal,
    (performance ->> 'hs_dorm_cooking_legal')::text AS hs_dorm_cooking_legal,
    (performance ->> 'hs_dorm_emergencyprep_legal')::text AS hs_dorm_emergencyprep_legal,
    (performance ->> 'hs_dorm_fire_legal')::text AS hs_dorm_fire_legal,
    (performance ->> 'hs_dorm_lighting_legal')::text AS hs_dorm_lighting_legal,
    (performance ->> 'hs_dorm_noise_legal')::text AS hs_dorm_noise_legal,
    (performance ->> 'hs_dorm_not_separate')::boolean AS hs_dorm_not_separate,
    (performance ->> 'hs_dorm_permits_legal')::text AS hs_dorm_permits_legal,
    (performance ->> 'hs_dorm_pests_legal')::text AS hs_dorm_pests_legal,
    (performance ->> 'hs_dorm_privacy_legal')::boolean AS hs_dorm_privacy_legal,
    (performance ->> 'hs_dorm_sufficient_space')::text AS hs_dorm_sufficient_space,
    (performance ->> 'hs_dorm_ventilation_legal')::text AS hs_dorm_ventilation_legal,
    (performance ->> 'hs_dorm_wastewater_legal')::text AS hs_dorm_wastewater_legal,
    (performance ->> 'hs_dorm_water_legal')::text AS hs_dorm_water_legal,
    (performance ->> 'hs_dormitories_not_clean')::boolean AS hs_dormitories_not_clean,
    (performance ->> 'hs_dormitories_space_dimensions_legal')::text AS hs_dormitories_space_dimensions_legal,
    (performance ->> 'hs_dorms_legal')::text AS hs_dorms_legal,
    (performance ->> 'hs_electrical_equipment_inspection_legal')::text AS hs_electrical_equipment_inspection_legal,
    (performance ->> 'hs_electrical_maintenance')::text AS hs_electrical_maintenance,
    (performance ->> 'hs_elevators_elevatordoors_inoperable')::boolean AS hs_elevators_elevatordoors_inoperable,
    (performance ->> 'hs_elevators_inspection')::boolean AS hs_elevators_inspection,
    (performance ->> 'hs_elevators_legal')::text AS hs_elevators_legal,
    (performance ->> 'hs_elevators_loadcapacity')::boolean AS hs_elevators_loadcapacity,
    (performance ->> 'hs_elevators_safety_devices')::boolean AS hs_elevators_safety_devices,
    (performance ->> 'hs_elevators_warning_signs')::boolean AS hs_elevators_warning_signs,
    (performance ->> 'hs_emergency_alarm_legal')::text AS hs_emergency_alarm_legal,
    (performance ->> 'hs_emergency_drills')::text AS hs_emergency_drills,
    (performance ->> 'hs_emergency_exit_doors')::boolean AS hs_emergency_exit_doors,
    (performance ->> 'hs_emergency_exits_marked')::text AS hs_emergency_exits_marked,
    (performance ->> 'hs_emergency_exits_safe')::text AS hs_emergency_exits_safe,
    (performance ->> 'hs_emergency_response_vehicles')::text AS hs_emergency_response_vehicles,
    (performance ->> 'hs_emergencyexits_legal')::text AS hs_emergencyexits_legal,
    (performance ->> 'hs_evacuation_legal')::text AS hs_evacuation_legal,
    (performance ->> 'hs_evacuationplans_legal')::text AS hs_evacuationplans_legal,
    (performance ->> 'hs_facility_provides_drinking_water')::text AS hs_facility_provides_drinking_water,
    (performance ->> 'hs_facilitydoors_legal')::text AS hs_facilitydoors_legal,
    (performance ->> 'hs_fallprotection_designated_location')::boolean AS hs_fallprotection_designated_location,
    (performance ->> 'hs_fallprotection_maintenance_logs')::boolean AS hs_fallprotection_maintenance_logs,
    (performance ->> 'hs_fallprotection_not_trained')::boolean AS hs_fallprotection_not_trained,
    (performance ->> 'hs_fallprotection_not_worn_at_all_times')::boolean AS hs_fallprotection_not_worn_at_all_times,
    (performance ->> 'hs_fallprotection_notgoodcondition')::boolean AS hs_fallprotection_notgoodcondition,
    (performance ->> 'hs_fallprotection_notusing')::boolean AS hs_fallprotection_notusing,
    (performance ->> 'hs_fallprotection_nowalls')::boolean AS hs_fallprotection_nowalls,
    (performance ->> 'hs_fallprotection_training_logs')::boolean AS hs_fallprotection_training_logs,
    (performance ->> 'hs_fire_alarms_legal')::text AS hs_fire_alarms_legal,
    (performance ->> 'hs_fire_detection_legal')::text AS hs_fire_detection_legal,
    (performance ->> 'hs_fire_training')::text AS hs_fire_training,
    (performance ->> 'hs_firefighting_equipment_legal')::text AS hs_firefighting_equipment_legal,
    (performance ->> 'hs_firefighting_equipment_not_accessible')::boolean AS hs_firefighting_equipment_not_accessible,
    (performance ->> 'hs_firefighting_non')::boolean AS hs_firefighting_non,
    (performance ->> 'hs_firefighting_not_marked')::boolean AS hs_firefighting_not_marked,
    (performance ->> 'hs_firefighting_training_legal')::text AS hs_firefighting_training_legal,
    (performance ->> 'hs_first_aid_kits_not_accessible')::text AS hs_first_aid_kits_not_accessible,
    (performance ->> 'hs_first_aid_kits_not_maintained')::text AS hs_first_aid_kits_not_maintained,
    (performance ->> 'hs_first_aid_kits_not_sufficient')::text AS hs_first_aid_kits_not_sufficient,
    (performance ->> 'hs_flammable_materials_not_stored_safely')::text AS hs_flammable_materials_not_stored_safely,
    (performance ->> 'hs_foodservice_permits_legal')::text AS hs_foodservice_permits_legal,
    (performance ->> 'hs_fuel_storage_legal')::text AS hs_fuel_storage_legal,
    (performance ->> 'hs_ghs_available')::text AS hs_ghs_available,
    (performance ->> 'hs_hazardous_substances_exposure')::text AS hs_hazardous_substances_exposure,
    (performance ->> 'hs_hazardous_substances_exposure_label')::text AS hs_hazardous_substances_exposure_label,
    (performance ->> 'hs_hazardous_substances_legal')::text AS hs_hazardous_substances_legal,
    (performance ->> 'hs_hazardous_work_monitoring_legal')::text AS hs_hazardous_work_monitoring_legal,
    (performance ->> 'hs_health_safety_risk_assessment_conducted')::text AS hs_health_safety_risk_assessment_conducted,
    (performance ->> 'hs_hot_work_legal')::text AS hs_hot_work_legal,
    (performance ->> 'hs_hs_assessment')::text AS hs_hs_assessment,
    (performance ->> 'hs_ignition_sources_not_safeguarded')::text AS hs_ignition_sources_not_safeguarded,
    (performance ->> 'hs_initial_and_refresher_trainings_firefighting')::boolean AS hs_initial_and_refresher_trainings_firefighting,
    (performance ->> 'hs_inventory_hazardous_substances')::text AS hs_inventory_hazardous_substances,
    (performance ->> 'hs_laser_radiation_legal')::text AS hs_laser_radiation_legal,
    (performance ->> 'hs_legal_equipment_eyewash')::text AS hs_legal_equipment_eyewash,
    (performance ->> 'hs_legally_required_facilities_provided')::text AS hs_legally_required_facilities_provided,
    (performance ->> 'hs_lighting_legal')::text AS hs_lighting_legal,
    (performance ->> 'hs_lightning_protector_legal')::text AS hs_lightning_protector_legal,
    (performance ->> 'hs_machinery_maintenance_of_worker_machinery')::boolean AS hs_machinery_maintenance_of_worker_machinery,
    (performance ->> 'hs_machinery_no_instructions_language')::boolean AS hs_machinery_no_instructions_language,
    (performance ->> 'hs_measures_none')::boolean AS hs_measures_none,
    (performance ->> 'hs_medical_checks_legal')::text AS hs_medical_checks_legal,
    (performance ->> 'hs_medical_emergency_arrangements')::text AS hs_medical_emergency_arrangements,
    (performance ->> 'hs_negative_consequences_removing_dangerous_situation')::text AS hs_negative_consequences_removing_dangerous_situation,
    (performance ->> 'hs_no_automatic_and_centralized')::boolean AS hs_no_automatic_and_centralized,
    (performance ->> 'hs_no_back_up_battery_ee_lighting')::boolean AS hs_no_back_up_battery_ee_lighting,
    (performance ->> 'hs_no_equipment_firefighting')::boolean AS hs_no_equipment_firefighting,
    (performance ->> 'hs_no_fire_resistant_walls')::boolean AS hs_no_fire_resistant_walls,
    (performance ->> 'hs_no_first_aid_records')::text AS hs_no_first_aid_records,
    (performance ->> 'hs_no_first_aid_training')::text AS hs_no_first_aid_training,
    (performance ->> 'hs_no_functioning_lockout_or_tagout')::text AS hs_no_functioning_lockout_or_tagout,
    (performance ->> 'hs_no_illumination_ee')::boolean AS hs_no_illumination_ee,
    (performance ->> 'hs_no_marking_nor_exit')::boolean AS hs_no_marking_nor_exit,
    (performance ->> 'hs_noise_exposure_legal_compliance')::text AS hs_noise_exposure_legal_compliance,
    (performance ->> 'hs_noise_level_legal')::text AS hs_noise_level_legal,
    (performance ->> 'hs_noise_testing')::text AS hs_noise_testing,
    (performance ->> 'hs_non_prod_hs_noncompliance')::text AS hs_non_prod_hs_noncompliance,
    (performance ->> 'hs_off_site_canteens_legal')::text AS hs_off_site_canteens_legal,
    (performance ->> 'hs_onsite_canteens_legal')::text AS hs_onsite_canteens_legal,
    (performance ->> 'hs_onsite_childcare_legal')::text AS hs_onsite_childcare_legal,
    (performance ->> 'hs_osh_committee_formed_and_functioning')::text AS hs_osh_committee_formed_and_functioning,
    (performance ->> 'hs_osh_cost_to_workers')::text AS hs_osh_cost_to_workers,
    (performance ->> 'hs_other_health_safety_legal_noncompliance')::text AS hs_other_health_safety_legal_noncompliance,
    (performance ->> 'hs_outlets_wet_area')::text AS hs_outlets_wet_area,
    (performance ->> 'hs_permits_special_equipment_legal')::text AS hs_permits_special_equipment_legal,
    (performance ->> 'hs_ppe_for_dmf')::text AS hs_ppe_for_dmf,
    (performance ->> 'hs_ppe_for_dmf_condition')::text AS hs_ppe_for_dmf_condition,
    (performance ->> 'hs_ppe_for_perc')::text AS hs_ppe_for_perc,
    (performance ->> 'hs_ppe_for_perc_condition')::text AS hs_ppe_for_perc_condition,
    (performance ->> 'hs_ppe_for_pp')::text AS hs_ppe_for_pp,
    (performance ->> 'hs_ppe_for_pp_condition')::text AS hs_ppe_for_pp_condition,
    (performance ->> 'hs_ppe_training_legal')::text AS hs_ppe_training_legal,
    (performance ->> 'hs_provided_ppe_legal')::text AS hs_provided_ppe_legal,
    (performance ->> 'hs_qualified_osh_staff_legal_requirement')::text AS hs_qualified_osh_staff_legal_requirement,
    (performance ->> 'hs_required_guards_legal')::text AS hs_required_guards_legal,
    (performance ->> 'hs_required_training_free')::text AS hs_required_training_free,
    (performance ->> 'hs_safety_warnings_legally_posted')::text AS hs_safety_warnings_legally_posted,
    (performance ->> 'hs_sanitation_practices_legal_compliance')::text AS hs_sanitation_practices_legal_compliance,
    (performance ->> 'hs_sufficient_emergency')::text AS hs_sufficient_emergency,
    (performance ->> 'hs_sufficient_toilets_legal')::text AS hs_sufficient_toilets_legal,
    (performance ->> 'hs_sustation_legal')::text AS hs_sustation_legal,
    (performance ->> 'hs_temperature_ventilation_legal_compliance')::text AS hs_temperature_ventilation_legal_compliance,
    (performance ->> 'hs_tempsystems_legal')::text AS hs_tempsystems_legal,
    (performance ->> 'hs_test_fire_alarms')::text AS hs_test_fire_alarms,
    (performance ->> 'hs_toilets_legal_requirements_met')::text AS hs_toilets_legal_requirements_met,
    (performance ->> 'hs_training_records_chemical_12months')::boolean AS hs_training_records_chemical_12months,
    (performance ->> 'hs_vietnam_annual_osh_plan')::text AS hs_vietnam_annual_osh_plan,
    (performance ->> 'hs_vietnam_environmental_conditions_monitoring')::text AS hs_vietnam_environmental_conditions_monitoring,
    (performance ->> 'hs_vietnam_maintenance_machinery_legal')::text AS hs_vietnam_maintenance_machinery_legal,
    (performance ->> 'hs_vietnam_occupational_health_legal')::text AS hs_vietnam_occupational_health_legal,
    (performance ->> 'hs_waste_disposal_legal_compliance')::text AS hs_waste_disposal_legal_compliance,
    (performance ->> 'hs_worker_access_drinking_water_anytime')::text AS hs_worker_access_drinking_water_anytime,
    (performance ->> 'hs_worker_access_toilets_anytime')::text AS hs_worker_access_toilets_anytime,
    (performance ->> 'hs_written_osh_policy_legal_compliance')::text AS hs_written_osh_policy_legal_compliance,
    (performance ->> 'rh_age_jd')::text AS rh_age_jd,
    (performance ->> 'rh_age_referenced')::text AS rh_age_referenced,
    (performance ->> 'rh_bangladesh_do_all_workers')::text AS rh_bangladesh_do_all_workers,
    (performance ->> 'rh_cambodia_entitlements_legal')::text AS rh_cambodia_entitlements_legal,
    (performance ->> 'rh_child_labor_hours_exceeded')::boolean AS rh_child_labor_hours_exceeded,
    (performance ->> 'rh_child_labor_legal_noncompliance')::text AS rh_child_labor_legal_noncompliance,
    (performance ->> 'rh_child_worker_registry')::text AS rh_child_worker_registry,
    (performance ->> 'rh_contract_changes_written_agreement')::text AS rh_contract_changes_written_agreement,
    (performance ->> 'rh_contract_practices_legal')::text AS rh_contract_practices_legal,
    (performance ->> 'rh_contract_practices_nonprod_legal')::text AS rh_contract_practices_nonprod_legal,
    (performance ->> 'rh_contracts_do_not_clearly')::boolean AS rh_contracts_do_not_clearly,
    (performance ->> 'rh_disability_referenced')::text AS rh_disability_referenced,
    (performance ->> 'rh_discrimination_noncompliance')::text AS rh_discrimination_noncompliance,
    (performance ->> 'rh_family_responsibilities')::text AS rh_family_responsibilities,
    (performance ->> 'rh_family_responsibilities_hiring')::text AS rh_family_responsibilities_hiring,
    (performance ->> 'rh_family_responsibilities_jd')::text AS rh_family_responsibilities_jd,
    (performance ->> 'rh_forced_labor_underage')::text AS rh_forced_labor_underage,
    (performance ->> 'rh_hiv_status_hiring')::text AS rh_hiv_status_hiring,
    (performance ->> 'rh_hiv_status_referenced')::text AS rh_hiv_status_referenced,
    (performance ->> 'rh_hiv_testing_jd')::text AS rh_hiv_testing_jd,
    (performance ->> 'rh_homeworkers_legal')::text AS rh_homeworkers_legal,
    (performance ->> 'rh_illness_testing_hiring')::text AS rh_illness_testing_hiring,
    (performance ->> 'rh_illness_testing_hiring_legal')::text AS rh_illness_testing_hiring_legal,
    (performance ->> 'rh_indonesia_outsourced_legal')::text AS rh_indonesia_outsourced_legal,
    (performance ->> 'rh_job_application_discrimination')::text AS rh_job_application_discrimination,
    (performance ->> 'rh_job_description_discrimination')::text AS rh_job_description_discrimination,
    (performance ->> 'rh_marital_status_hiring')::text AS rh_marital_status_hiring,
    (performance ->> 'rh_marital_status_referenced')::text AS rh_marital_status_referenced,
    (performance ->> 'rh_migrant_contracts_legal')::text AS rh_migrant_contracts_legal,
    (performance ->> 'rh_monetary_deposits_legal')::text AS rh_monetary_deposits_legal,
    (performance ->> 'rh_national_extraction_hiring')::boolean AS rh_national_extraction_hiring,
    (performance ->> 'rh_national_extraction_referenced')::boolean AS rh_national_extraction_referenced,
    (performance ->> 'rh_nationality_jd')::text AS rh_nationality_jd,
    (performance ->> 'rh_nationality_referenced')::text AS rh_nationality_referenced,
    (performance ->> 'rh_other_identified_jd')::text AS rh_other_identified_jd,
    (performance ->> 'rh_political_opinion_hiring')::boolean AS rh_political_opinion_hiring,
    (performance ->> 'rh_political_opinion_referenced')::boolean AS rh_political_opinion_referenced,
    (performance ->> 'rh_pregnancy_hiring')::boolean AS rh_pregnancy_hiring,
    (performance ->> 'rh_pregnancy_referenced')::boolean AS rh_pregnancy_referenced,
    (performance ->> 'rh_pregnancy_testing')::boolean AS rh_pregnancy_testing,
    (performance ->> 'rh_prison_laborers_have_not')::boolean AS rh_prison_laborers_have_not,
    (performance ->> 'rh_race_ethnic_group_skin')::boolean AS rh_race_ethnic_group_skin,
    (performance ->> 'rh_race_ethnic_group_skin_jd')::boolean AS rh_race_ethnic_group_skin_jd,
    (performance ->> 'rh_religion_hiring')::boolean AS rh_religion_hiring,
    (performance ->> 'rh_religion_referenced_hiring')::boolean AS rh_religion_referenced_hiring,
    (performance ->> 'rh_sex_gender_hiring')::boolean AS rh_sex_gender_hiring,
    (performance ->> 'rh_sex_gender_jd')::boolean AS rh_sex_gender_jd,
    (performance ->> 'rh_sexual_orientation_hiring')::text AS rh_sexual_orientation_hiring,
    (performance ->> 'rh_sexual_orientation_referenced')::text AS rh_sexual_orientation_referenced,
    (performance ->> 'rh_signed_copies_of_contracts')::boolean AS rh_signed_copies_of_contracts,
    (performance ->> 'rh_social_origin_hiring')::boolean AS rh_social_origin_hiring,
    (performance ->> 'rh_social_origin_referenced')::boolean AS rh_social_origin_referenced,
    (performance ->> 'rh_the_facility_does_not')::boolean AS rh_the_facility_does_not,
    (performance ->> 'rh_there_is_no_supervision')::boolean AS rh_there_is_no_supervision,
    (performance ->> 'rh_vietnam_disability_legal')::text AS rh_vietnam_disability_legal,
    (performance ->> 'rh_worker_privacy')::text AS rh_worker_privacy,
    (performance ->> 'rh_workplace_legal')::text AS rh_workplace_legal,
    (performance ->> 'ter_debt_bondage_risk')::text AS ter_debt_bondage_risk,
    (performance ->> 'ter_family_responsibilities')::boolean AS ter_family_responsibilities,
    (performance ->> 'ter_invalid_termination_reasons')::text AS ter_invalid_termination_reasons,
    (performance ->> 'ter_legal_compliance')::text AS ter_legal_compliance,
    (performance ->> 'ter_other_discrimination')::text AS ter_other_discrimination,
    (performance ->> 'ter_race_ethnic_group')::text AS ter_race_ethnic_group,
    (performance ->> 'ter_reinstatement_orders_not_followed')::boolean AS ter_reinstatement_orders_not_followed,
    (performance ->> 'ter_severance_not_paid')::text AS ter_severance_not_paid,
    (performance ->> 'ter_suspension_legal_compliance')::text AS ter_suspension_legal_compliance,
    (performance ->> 'ter_termination_benefits_not_paid')::text AS ter_termination_benefits_not_paid,
    (performance ->> 'ter_termination_noncompliance_general')::text AS ter_termination_noncompliance_general,
    (performance ->> 'ter_termination_nonprod_noncompliance')::text AS ter_termination_nonprod_noncompliance,
    (performance ->> 'ter_termination_payment_delay')::text AS ter_termination_payment_delay,
    (performance ->> 'ter_unused_leave_not_paid')::text AS ter_unused_leave_not_paid,
    (performance ->> 'wb_accurate_detailed_payslips')::text AS wb_accurate_detailed_payslips,
    (performance ->> 'wb_agencycontract_workers')::text AS wb_agencycontract_workers,
    (performance ->> 'wb_annual_leave_failing_timeoff')::boolean AS wb_annual_leave_failing_timeoff,
    (performance ->> 'wb_annual_leave_failing_to_pay')::boolean AS wb_annual_leave_failing_to_pay,
    (performance ->> 'wb_authorized_3rd_party_agents')::text AS wb_authorized_3rd_party_agents,
    (performance ->> 'wb_bangladesh_has_facility_established')::text AS wb_bangladesh_has_facility_established,
    (performance ->> 'wb_bangladesh_workers_participation_welfare')::text AS wb_bangladesh_workers_participation_welfare,
    (performance ->> 'wb_cambodia_attendance_bonus_casual')::boolean AS wb_cambodia_attendance_bonus_casual,
    (performance ->> 'wb_cambodia_attendance_bonus_during')::boolean AS wb_cambodia_attendance_bonus_during,
    (performance ->> 'wb_cambodia_attendance_bonus_new')::boolean AS wb_cambodia_attendance_bonus_new,
    (performance ->> 'wb_cambodia_piece_rate_set')::text AS wb_cambodia_piece_rate_set,
    (performance ->> 'wb_cambodia_seniority_indemnity_undetermined')::boolean AS wb_cambodia_seniority_indemnity_undetermined,
    (performance ->> 'wb_cambodia_transport_home_place')::boolean AS wb_cambodia_transport_home_place,
    (performance ->> 'wb_cambodia_wage_supplements_including')::boolean AS wb_cambodia_wage_supplements_including,
    (performance ->> 'wb_casual_workers')::text AS wb_casual_workers,
    (performance ->> 'wb_compensation_workers_death')::boolean AS wb_compensation_workers_death,
    (performance ->> 'wb_compensation_workrelated_accidents_diseases')::boolean AS wb_compensation_workrelated_accidents_diseases,
    (performance ->> 'wb_compensatorytimeoff_legal')::text AS wb_compensatorytimeoff_legal,
    (performance ->> 'wb_compulsory_group_insurance_workers')::boolean AS wb_compulsory_group_insurance_workers,
    (performance ->> 'wb_contract_workers_who_part')::text AS wb_contract_workers_who_part,
    (performance ->> 'wb_deductions_injury')::text AS wb_deductions_injury,
    (performance ->> 'wb_deductions_maternity')::text AS wb_deductions_maternity,
    (performance ->> 'wb_deductions_medical')::text AS wb_deductions_medical,
    (performance ->> 'wb_deductions_unemployment')::text AS wb_deductions_unemployment,
    (performance ->> 'wb_deductions_voluntarily_accepted_workers')::boolean AS wb_deductions_voluntarily_accepted_workers,
    (performance ->> 'wb_deductions_wages_explained_workers')::boolean AS wb_deductions_wages_explained_workers,
    (performance ->> 'wb_did_facility_other_wage')::text AS wb_did_facility_other_wage,
    (performance ->> 'wb_ethiopia_provide_legally_required')::text AS wb_ethiopia_provide_legally_required,
    (performance ->> 'wb_ethiopia_provide_time_off')::text AS wb_ethiopia_provide_time_off,
    (performance ->> 'wb_facility_comply_leave_legal')::text AS wb_facility_comply_leave_legal,
    (performance ->> 'wb_facility_conduct_worker_performance')::text AS wb_facility_conduct_worker_performance,
    (performance ->> 'wb_facility_failing_comply_legal')::text AS wb_facility_failing_comply_legal,
    (performance ->> 'wb_facility_failing_correctly_provide')::text AS wb_facility_failing_correctly_provide,
    (performance ->> 'wb_facility_failing_leave_legal_other')::text AS wb_facility_failing_leave_legal_other,
    (performance ->> 'wb_facility_failing_pay_worker_basicwage')::text AS wb_facility_failing_pay_worker_basicwage,
    (performance ->> 'wb_facility_failing_pay_worker_cba')::text AS wb_facility_failing_pay_worker_cba,
    (performance ->> 'wb_facility_failing_pay_worker_legalmin')::text AS wb_facility_failing_pay_worker_legalmin,
    (performance ->> 'wb_facility_failing_pay_workers_experience')::text AS wb_facility_failing_pay_workers_experience,
    (performance ->> 'wb_facility_failing_pay_workers_overtime')::text AS wb_facility_failing_pay_workers_overtime,
    (performance ->> 'wb_facility_failing_pay_workers_overtime_legal')::text AS wb_facility_failing_pay_workers_overtime_legal,
    (performance ->> 'wb_facility_failing_pay_workers_regular')::text AS wb_facility_failing_pay_workers_regular,
    (performance ->> 'wb_facility_has_overdue_social')::text AS wb_facility_has_overdue_social,
    (performance ->> 'wb_facility_paid_annual_bonus')::text AS wb_facility_paid_annual_bonus,
    (performance ->> 'wb_facility_paid_attendance_bonus')::text AS wb_facility_paid_attendance_bonus,
    (performance ->> 'wb_facility_paid_housing_allowance')::text AS wb_facility_paid_housing_allowance,
    (performance ->> 'wb_facility_paid_meal_allowance')::text AS wb_facility_paid_meal_allowance,
    (performance ->> 'wb_facility_paid_productivity_bonus')::text AS wb_facility_paid_productivity_bonus,
    (performance ->> 'wb_facility_paid_seniority_andor')::text AS wb_facility_paid_seniority_andor,
    (performance ->> 'wb_facility_paid_transportation_allowance')::text AS wb_facility_paid_transportation_allowance,
    (performance ->> 'wb_facility_pay_workers_correctly')::text AS wb_facility_pay_workers_correctly,
    (performance ->> 'wb_facility_provide_legally_required')::text AS wb_facility_provide_legally_required,
    (performance ->> 'wb_facility_provide_other_insurance')::text AS wb_facility_provide_other_insurance,
    (performance ->> 'wb_facility_register_workers_social')::text AS wb_facility_register_workers_social,
    (performance ->> 'wb_facility_take_deductions_wages')::text AS wb_facility_take_deductions_wages,
    (performance ->> 'wb_failing_topay_overtime_night')::boolean AS wb_failing_topay_overtime_night,
    (performance ->> 'wb_failing_topay_overtime_ordinary')::boolean AS wb_failing_topay_overtime_ordinary,
    (performance ->> 'wb_failing_topay_overtime_public_holidays')::boolean AS wb_failing_topay_overtime_public_holidays,
    (performance ->> 'wb_failing_topay_overtime_weekly_restdays')::boolean AS wb_failing_topay_overtime_weekly_restdays,
    (performance ->> 'wb_fines_socialsecurity')::text AS wb_fines_socialsecurity,
    (performance ->> 'wb_indonesia_facility_comply_legal')::text AS wb_indonesia_facility_comply_legal,
    (performance ->> 'wb_indonesia_facility_comply_requirements')::text AS wb_indonesia_facility_comply_requirements,
    (performance ->> 'wb_indonesia_facility_establish_wage')::text AS wb_indonesia_facility_establish_wage,
    (performance ->> 'wb_indonesia_nationalhealthcare')::text AS wb_indonesia_nationalhealthcare,
    (performance ->> 'wb_maternity_collected_forwarded')::text AS wb_maternity_collected_forwarded,
    (performance ->> 'wb_maternity_leave_failing_timeoff')::boolean AS wb_maternity_leave_failing_timeoff,
    (performance ->> 'wb_maternity_leave_failing_to_pay')::boolean AS wb_maternity_leave_failing_to_pay,
    (performance ->> 'wb_medical_collected_forwarded')::text AS wb_medical_collected_forwarded,
    (performance ->> 'wb_one_payroll_record')::text AS wb_one_payroll_record,
    (performance ->> 'wb_other')::boolean AS wb_other,
    (performance ->> 'wb_other_collected_forwarded')::text AS wb_other_collected_forwarded,
    (performance ->> 'wb_other_monetary_bonuses_andor')::text AS wb_other_monetary_bonuses_andor,
    (performance ->> 'wb_other_types_required_leave_failing_to_pay')::boolean AS wb_other_types_required_leave_failing_to_pay,
    (performance ->> 'wb_overtime_allowances_providedpaid_line')::text AS wb_overtime_allowances_providedpaid_line,
    (performance ->> 'wb_overtime_premium')::text AS wb_overtime_premium,
    (performance ->> 'wb_pakistan_employer_maintain_fair')::text AS wb_pakistan_employer_maintain_fair,
    (performance ->> 'wb_pakistan_facility_pay_workers')::text AS wb_pakistan_facility_pay_workers,
    (performance ->> 'wb_pakistan_workers_receive_correct')::text AS wb_pakistan_workers_receive_correct,
    (performance ->> 'wb_pakistan_workers_survivors_benefit')::text AS wb_pakistan_workers_survivors_benefit,
    (performance ->> 'wb_pakistan_workers_survivors_injury')::text AS wb_pakistan_workers_survivors_injury,
    (performance ->> 'wb_pakistan_workers_survivors_medical')::text AS wb_pakistan_workers_survivors_medical,
    (performance ->> 'wb_parttime_workers_failing_timeoff')::text AS wb_parttime_workers_failing_timeoff,
    (performance ->> 'wb_paternity_leave_failing_timeoff')::boolean AS wb_paternity_leave_failing_timeoff,
    (performance ->> 'wb_paternity_leave_failing_to_pay')::boolean AS wb_paternity_leave_failing_to_pay,
    (performance ->> 'wb_payroll_records_consistent_attendance')::boolean AS wb_payroll_records_consistent_attendance,
    (performance ->> 'wb_payroll_records_each_worker')::boolean AS wb_payroll_records_each_worker,
    (performance ->> 'wb_payroll_records_show_types')::text AS wb_payroll_records_show_types,
    (performance ->> 'wb_pension_provident_fund_collected')::text AS wb_pension_provident_fund_collected,
    (performance ->> 'wb_pension_provident_fund_collected_legal')::text AS wb_pension_provident_fund_collected_legal,
    (performance ->> 'wb_permanent_workers')::text AS wb_permanent_workers,
    (performance ->> 'wb_personal_leave_failing_timeoff')::boolean AS wb_personal_leave_failing_timeoff,
    (performance ->> 'wb_personal_leave_failing_to_pay')::boolean AS wb_personal_leave_failing_to_pay,
    (performance ->> 'wb_piece_rate_workers_paid')::text AS wb_piece_rate_workers_paid,
    (performance ->> 'wb_premiumpay_night')::text AS wb_premiumpay_night,
    (performance ->> 'wb_premiumpay_public_holidays')::text AS wb_premiumpay_public_holidays,
    (performance ->> 'wb_premiumpay_weeklyrestdays')::text AS wb_premiumpay_weeklyrestdays,
    (performance ->> 'wb_public_holidays_failing_timeoff')::boolean AS wb_public_holidays_failing_timeoff,
    (performance ->> 'wb_public_holidays_failing_to_pay')::boolean AS wb_public_holidays_failing_to_pay,
    (performance ->> 'wb_sick_leave_failing_timeoff')::boolean AS wb_sick_leave_failing_timeoff,
    (performance ->> 'wb_sick_leave_failing_to_pay')::boolean AS wb_sick_leave_failing_to_pay,
    (performance ->> 'wb_temporary_workers')::text AS wb_temporary_workers,
    (performance ->> 'wb_unemployment_collected_forwarded')::text AS wb_unemployment_collected_forwarded,
    (performance ->> 'wb_vietnam_facility_collect_forward')::text AS wb_vietnam_facility_collect_forward,
    (performance ->> 'wb_vietnam_facility_comply_applicable')::text AS wb_vietnam_facility_comply_applicable,
    (performance ->> 'wb_vietnam_facility_contribution_social')::text AS wb_vietnam_facility_contribution_social,
    (performance ->> 'wb_vietnam_facility_incorporate_legally')::text AS wb_vietnam_facility_incorporate_legally,
    (performance ->> 'wb_vietnam_facility_submit_claims')::text AS wb_vietnam_facility_submit_claims,
    (performance ->> 'wb_vietnam_provide_30_minutes')::text AS wb_vietnam_provide_30_minutes,
    (performance ->> 'wb_wage_basis_3rd_party')::text AS wb_wage_basis_3rd_party,
    (performance ->> 'wb_wage_basis_legal_requirements')::boolean AS wb_wage_basis_legal_requirements,
    (performance ->> 'wb_wage_payments_made_regularly')::text AS wb_wage_payments_made_regularly,
    (performance ->> 'wb_were_other_wage_payments')::text AS wb_were_other_wage_payments,
    (performance ->> 'wb_were_withholdings_wages_other')::text AS wb_were_withholdings_wages_other,
    (performance ->> 'wb_workers_access_account_status')::boolean AS wb_workers_access_account_status,
    (performance ->> 'wb_workers_give_written_consent')::boolean AS wb_workers_give_written_consent,
    (performance ->> 'wb_workers_informed_about_individual')::text AS wb_workers_informed_about_individual,
    (performance ->> 'wb_workers_paid_full_wages')::text AS wb_workers_paid_full_wages,
    (performance ->> 'wb_workers_paid_workrelated_activities')::text AS wb_workers_paid_workrelated_activities,
    (performance ->> 'wb_workers_under_probation')::text AS wb_workers_under_probation,
    (performance ->> 'wb_workers_were_paid_correctly')::text AS wb_workers_were_paid_correctly,
    (performance ->> 'wb_workers_who_trainees_apprentices')::text AS wb_workers_who_trainees_apprentices,
    (performance ->> 'wb_workrelated_injury_illness_death')::text AS wb_workrelated_injury_illness_death,
    (performance ->> 'wh_breastfeeding_legal')::text AS wh_breastfeeding_legal,
    (performance ->> 'wh_daily_limits_overtime_hours')::boolean AS wh_daily_limits_overtime_hours,
    (performance ->> 'wh_exceed_legal_requirements')::text AS wh_exceed_legal_requirements,
    (performance ->> 'wh_facility_failing_comply_legal_nonprod')::text AS wh_facility_failing_comply_legal_nonprod,
    (performance ->> 'wh_facility_failing_comply_legal_other')::text AS wh_facility_failing_comply_legal_other,
    (performance ->> 'wh_facility_maintain_only_one')::text AS wh_facility_maintain_only_one,
    (performance ->> 'wh_facility_only_require_workers')::text AS wh_facility_only_require_workers,
    (performance ->> 'wh_facility_provide_breaks_during')::text AS wh_facility_provide_breaks_during,
    (performance ->> 'wh_govt_permission_legal')::text AS wh_govt_permission_legal,
    (performance ->> 'wh_monthly_limits_overtime_hours')::boolean AS wh_monthly_limits_overtime_hours,
    (performance ->> 'wh_other_action_impacting_workers')::boolean AS wh_other_action_impacting_workers,
    (performance ->> 'wh_overtime_voluntary_line_legal')::text AS wh_overtime_voluntary_line_legal,
    (performance ->> 'wh_overtime_working_hours_line')::text AS wh_overtime_working_hours_line,
    (performance ->> 'wh_pakistan_provide_required_time')::text AS wh_pakistan_provide_required_time,
    (performance ->> 'wh_reasons_overtime_line_legal')::text AS wh_reasons_overtime_line_legal,
    (performance ->> 'wh_vietnam_facility_comply_legal')::text AS wh_vietnam_facility_comply_legal,
    (performance ->> 'wh_weekly_limits_overtime_hours')::boolean AS wh_weekly_limits_overtime_hours,
    (performance ->> 'wh_weeklyrestdays_legal')::text AS wh_weeklyrestdays_legal,
    (performance ->> 'wh_work_targets_production_eg')::text AS wh_work_targets_production_eg,
    (performance ->> 'wh_workers_hours_reduced')::boolean AS wh_workers_hours_reduced,
    (performance ->> 'wh_workers_must_stay_home_less_minwage')::boolean AS wh_workers_must_stay_home_less_minwage,
    (performance ->> 'wh_workers_must_stay_home_minwage')::boolean AS wh_workers_must_stay_home_minwage,
    (performance ->> 'wh_workers_must_stay_home_notpaid')::boolean AS wh_workers_must_stay_home_notpaid,
    (performance ->> 'wh_workers_must_stay_home_pto')::boolean AS wh_workers_must_stay_home_pto,
    (performance ->> 'wh_yearly_limits_overtime_hours')::boolean AS wh_yearly_limits_overtime_hours,
    (performance ->> 'wh_yes_regular_hours_exceed')::text AS wh_yes_regular_hours_exceed,
    (performance ->> 'wi_bangladesh_facility_legally_required')::text AS wi_bangladesh_facility_legally_required,
    (performance ->> 'wi_bipartite_committees_established_functioning')::text AS wi_bipartite_committees_established_functioning,
    (performance ->> 'wi_employer_allow_workers_carry')::text AS wi_employer_allow_workers_carry,
    (performance ->> 'wi_facility_failing_comply_legal')::text AS wi_facility_failing_comply_legal,
    (performance ->> 'wi_facility_has_no_trade')::text AS wi_facility_has_no_trade,
    (performance ->> 'wi_facility_inform_workers_about')::text AS wi_facility_inform_workers_about,
    (performance ->> 'wi_facility_refuse_bargain_collectively')::text AS wi_facility_refuse_bargain_collectively,
    (performance ->> 'wi_has_facility_ever_tried')::text AS wi_has_facility_ever_tried,
    (performance ->> 'wi_has_facility_failed_implement')::text AS wi_has_facility_failed_implement,
    (performance ->> 'wi_legally_required_mechanisms_dialogue')::text AS wi_legally_required_mechanisms_dialogue,
    (performance ->> 'wi_legally_required_workers_representatives')::text AS wi_legally_required_workers_representatives,
    (performance ->> 'wi_vietnam_has_collective_agreement')::text AS wi_vietnam_has_collective_agreement,
    (performance ->> 'wi_were_least_twothirds_meetings')::text AS wi_were_least_twothirds_meetings,
    (performance ->> 'wi_were_terminations_trade_union')::text AS wi_were_terminations_trade_union,
    (performance ->> 'wi_workers_free_form_trade')::text AS wi_workers_free_form_trade,
    (performance ->> 'wi_workers_free_join_trade')::text AS wi_workers_free_join_trade,
    (performance ->> 'wt_benefits_maintained')::boolean AS wt_benefits_maintained,
    (performance ->> 'wt_discipline_harassment')::text AS wt_discipline_harassment,
    (performance ->> 'wt_employer_use_other_coercive')::text AS wt_employer_use_other_coercive,
    (performance ->> 'wt_employment_status_maintained')::boolean AS wt_employment_status_maintained,
    (performance ->> 'wt_facility_failing_comply_legal')::text AS wt_facility_failing_comply_legal,
    (performance ->> 'wt_facility_failing_comply_legal_other')::text AS wt_facility_failing_comply_legal_other,
    (performance ->> 'wt_facility_line_legal_requirements')::text AS wt_facility_line_legal_requirements,
    (performance ->> 'wt_facility_require_hivaids_tests')::text AS wt_facility_require_hivaids_tests,
    (performance ->> 'wt_facility_requires_pregnancy_tests')::boolean AS wt_facility_requires_pregnancy_tests,
    (performance ->> 'wt_facility_retain_disabled_ill')::text AS wt_facility_retain_disabled_ill,
    (performance ->> 'wt_facility_retain_ill_legal')::text AS wt_facility_retain_ill_legal,
    (performance ->> 'wt_failure_to_comply_amediated_agreements')::boolean AS wt_failure_to_comply_amediated_agreements,
    (performance ->> 'wt_failure_to_comply_arbitration')::boolean AS wt_failure_to_comply_arbitration,
    (performance ->> 'wt_failure_to_comply_court_order')::boolean AS wt_failure_to_comply_court_order,
    (performance ->> 'wt_failure_to_comply_legal_settlements')::text AS wt_failure_to_comply_legal_settlements,
    (performance ->> 'wt_failure_to_comply_settlements')::boolean AS wt_failure_to_comply_settlements,
    (performance ->> 'wt_family_responsibilities_conditions')::boolean AS wt_family_responsibilities_conditions,
    (performance ->> 'wt_family_responsibilities_harassment')::boolean AS wt_family_responsibilities_harassment,
    (performance ->> 'wt_family_responsibilities_promotion')::boolean AS wt_family_responsibilities_promotion,
    (performance ->> 'wt_female_worker_harassment')::text AS wt_female_worker_harassment,
    (performance ->> 'wt_gender_identity')::boolean AS wt_gender_identity,
    (performance ->> 'wt_illness_tests_legal')::text AS wt_illness_tests_legal,
    (performance ->> 'wt_marital_status')::boolean AS wt_marital_status,
    (performance ->> 'wt_marital_status_written')::text AS wt_marital_status_written,
    (performance ->> 'wt_national_extraction')::boolean AS wt_national_extraction,
    (performance ->> 'wt_pakistan_coc_harassment')::text AS wt_pakistan_coc_harassment,
    (performance ->> 'wt_pakistan_has_employer_set')::text AS wt_pakistan_has_employer_set,
    (performance ->> 'wt_political_opinion_harassment')::text AS wt_political_opinion_harassment,
    (performance ->> 'wt_position_maintained')::boolean AS wt_position_maintained,
    (performance ->> 'wt_religious_harassment')::text AS wt_religious_harassment,
    (performance ->> 'wt_retain_hiv')::text AS wt_retain_hiv,
    (performance ->> 'wt_skin_color_race_harassment')::text AS wt_skin_color_race_harassment,
    (performance ->> 'wt_social_origin_harassment')::boolean AS wt_social_origin_harassment,
    (performance ->> 'wt_there_been_cases_sexual')::text AS wt_there_been_cases_sexual,
    (performance ->> 'wt_vietnam_sa_training')::text AS wt_vietnam_sa_training,
    (performance ->> 'wt_wages_maintained')::boolean AS wt_wages_maintained,
    (performance ->> 'wt_workers_free_come_go')::text AS wt_workers_free_come_go
FROM fslm_simple
)

SELECT
    account_id,
    assessment_id,
    survey_version,
    (
    CASE WHEN cl_age_verification = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_hazardous_work_legal = TRUE THEN 1 ELSE 0 END +
    CASE WHEN cl_healthchecks = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_healthchecks_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_healthchecks_prioremployment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_hs_protective_restrictions = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_hs_separate_trainings = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_hs_specialtrainings = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_implement_separate_tracking = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_internship_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_nightwork = TRUE THEN 1 ELSE 0 END +
    CASE WHEN cl_parental_permission = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_parental_review = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_protectiverestriction_u18 = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_written_remediation_policy = 'No' THEN 1 ELSE 0 END +
    CASE WHEN cl_youngest_worker = 'Under 12 OR 13 OR 14' THEN 1 ELSE 0 END +
    CASE WHEN cl_youngest_worker12_18 <=14 THEN 1 ELSE 0 END +
    CASE WHEN disc_contraception_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_contraception_requirement_employment = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_disability_accommodations = 'No' THEN 1 ELSE 0 END +
    CASE WHEN disc_disabled_hiring_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN disc_illness_termination = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN disc_pregnancy_requirements_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_age = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_disability = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_hiv = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_maritalstatus = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_maternity = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_nationalextraction = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_nationality = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_other = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_politicalopinion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_race = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_religion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_sex = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_sexualorientation = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_promotion_socialorigin = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_retaliation_termination = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_age = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_disability = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_hiv = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_maritalstatus = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_maternity = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_nationalextraction = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_nationality = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_other = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_politicalopinion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_race = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_religion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_sex = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_sexualorientation = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_termination_socialorigin = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_virginity_test_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_age = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_disability = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_hiv = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_maritalstatus = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_maternity = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_nationalextraction = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_nationality = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_other = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_politicalopinion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_race = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_religion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_sex = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_sexualorientation = TRUE THEN 1 ELSE 0 END +
    CASE WHEN disc_workconditions_socialorigin = TRUE THEN 1 ELSE 0 END +
    CASE WHEN discp_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_all_with_contract = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_defense = 'X' THEN 1 ELSE 0 END +
    CASE WHEN ep_limits_fixed_contracts = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_personnelfiles_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_probation_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_rif_alternatives = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ep_temp_contracts_avoid_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ep_work_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ep_workers_were_not_given_notice = 'X' THEN 1 ELSE 0 END +
    CASE WHEN erg_retaliation = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_are_any_monetary_deposits = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_forced_overtime = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_migrant_recruitment_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fl_passport_access = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_prison_labor = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_recruitment_costs_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fl_reimbursement_fees = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fl_restricted_leaving = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN fl_terminate_employment_postnotice = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fl_witheld_payments = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN foa_armed_break_strike = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_cba_favorable_as_law = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_consultation_union_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_control_unions = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN foa_equal_union_treatment_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_form_join_federations = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_free_to_meet_wo_mgmt = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_new_workers_replace_strikers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_private_meeting_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_punished_strikes = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_required_union = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_trade_union_representatives_access = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_union_activity_hiring = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN foa_union_intimidation = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_union_punished = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_union_support_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_union_terminated = TRUE THEN 1 ELSE 0 END +
    CASE WHEN foa_unions = 'No' THEN 1 ELSE 0 END +
    CASE WHEN foa_untion_deductions_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fp_does_the_facility_maintain = 'No' THEN 1 ELSE 0 END +
    CASE WHEN fp_operating_license_registration = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_cases_abuse = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hb_cases_characteristics = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hb_effective_remediation = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_forced_work_strike = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_age = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_disability = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_hiv = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_maternitystatus = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_nationality = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_other = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_politicalopinion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_race = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_religion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_harassment_sexualorientation = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hb_immigration_threats = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hb_sexualharassment_cases >0 THEN 1 ELSE 0 END +
    CASE WHEN hb_violence_intimidation = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hb_written_recrods_threats_forcedwork = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_discp_forcedwork = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_age = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_disability = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_hiv = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_maternity = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_nationality = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_other = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_politicalopinion = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_race = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_religion = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_sexualharassment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hb_writtenrecords_harassment_sexualorientation = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_accessible_emergency_vehicles = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_airborne_particulates_legal_exposure = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_all_emergencies = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_no_backup = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_no_maintenance = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_not_accessible = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_not_distinct = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_not_heard = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_alarm_system_notfunctioning = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_are_pregnant_and_nursing = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_backup_ee_lighting_none_of_the_above = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_bangladesh_acid_storage_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_bangladesh_overcrowding_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_beds_two_tiers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_building_construction_structural_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_cambodia_chemical_mixing = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_cambodia_spills_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_cases_physical_integrity = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_chemical_harardous_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_chemical_practices_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_disposed_in_waste = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_hazardous = 'Yes- including hazardous substances' THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_inappropriate_containers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_no_spill_kit = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_no_written_procedures = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_chemicals_other = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_children_production_area = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_comply_health_legal_requirements_hiv = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_authorized_entry_only = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_accidental_entry = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_air_safety = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_appropriate_measures = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_no_rescue_equip = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_no_signs = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_space_not_trained = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_spaces = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_confined_spaces_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_construction_permits_dorms = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_contract_dispose_hazardous_waste = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_cooperation_mechanisms_workers_management = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_does_the_facility_record = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_airtight_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_cooking_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_emergencyprep_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_fire_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_lighting_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_noise_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_not_separate = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_permits_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_pests_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_privacy_legal = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_sufficient_space = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_ventilation_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_wastewater_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorm_water_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dormitories_not_clean = FALSE THEN 1 ELSE 0 END +
    CASE WHEN hs_dormitories_space_dimensions_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_dorms_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_electrical_equipment_inspection_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_electrical_maintenance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_elevatordoors_inoperable = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_inspection = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_loadcapacity = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_safety_devices = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_elevators_warning_signs = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_alarm_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_drills = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_exit_doors = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_exits_marked = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_exits_safe = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_emergency_response_vehicles = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_emergencyexits_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_evacuation_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_evacuationplans_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_facility_provides_drinking_water = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_facilitydoors_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_designated_location = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_maintenance_logs = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_not_trained = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_not_worn_at_all_times = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_notgoodcondition = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_notusing = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_nowalls = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fallprotection_training_logs = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_fire_alarms_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_fire_detection_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_fire_training = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_firefighting_equipment_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_firefighting_equipment_not_accessible = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_firefighting_non = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_firefighting_not_marked = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_firefighting_training_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_first_aid_kits_not_accessible = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_first_aid_kits_not_maintained = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_first_aid_kits_not_sufficient = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_flammable_materials_not_stored_safely = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_foodservice_permits_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_fuel_storage_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ghs_available = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_hazardous_substances_exposure = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_hazardous_substances_exposure_label = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_hazardous_substances_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_hazardous_work_monitoring_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_health_safety_risk_assessment_conducted = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_hot_work_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_hs_assessment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ignition_sources_not_safeguarded = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_initial_and_refresher_trainings_firefighting = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_inventory_hazardous_substances = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_laser_radiation_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_legal_equipment_eyewash = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_legally_required_facilities_provided = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_lighting_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_lightning_protector_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_machinery_maintenance_of_worker_machinery = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_machinery_no_instructions_language = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_measures_none = FALSE THEN 1 ELSE 0 END +
    CASE WHEN hs_medical_checks_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_medical_emergency_arrangements = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_negative_consequences_removing_dangerous_situation = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_no_automatic_and_centralized = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_no_back_up_battery_ee_lighting = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_no_equipment_firefighting = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_no_fire_resistant_walls = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_no_first_aid_records = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_no_first_aid_training = 'X' THEN 1 ELSE 0 END +
    CASE WHEN hs_no_functioning_lockout_or_tagout = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN hs_no_illumination_ee = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_no_marking_nor_exit = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_noise_exposure_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_noise_level_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_noise_testing = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_non_prod_hs_noncompliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_off_site_canteens_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_onsite_canteens_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_onsite_childcare_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_osh_committee_formed_and_functioning = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_osh_cost_to_workers = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_other_health_safety_legal_noncompliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN hs_outlets_wet_area = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_permits_special_equipment_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_dmf = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_dmf_condition = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_perc = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_perc_condition = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_pp = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_for_pp_condition = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_ppe_training_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_provided_ppe_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_qualified_osh_staff_legal_requirement = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_required_guards_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_required_training_free = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_safety_warnings_legally_posted = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_sanitation_practices_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_sufficient_emergency = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_sufficient_toilets_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_sustation_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_temperature_ventilation_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_tempsystems_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_test_fire_alarms = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_toilets_legal_requirements_met = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_training_records_chemical_12months = TRUE THEN 1 ELSE 0 END +
    CASE WHEN hs_vietnam_annual_osh_plan = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_vietnam_environmental_conditions_monitoring = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_vietnam_maintenance_machinery_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_vietnam_occupational_health_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_waste_disposal_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_worker_access_drinking_water_anytime = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_worker_access_toilets_anytime = 'No' THEN 1 ELSE 0 END +
    CASE WHEN hs_written_osh_policy_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_age_jd = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_age_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_bangladesh_do_all_workers = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_cambodia_entitlements_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_child_labor_hours_exceeded = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_child_labor_legal_noncompliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_child_worker_registry = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_contract_changes_written_agreement = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN rh_contract_practices_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_contract_practices_nonprod_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_contracts_do_not_clearly = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_disability_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_discrimination_noncompliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_family_responsibilities = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_family_responsibilities_hiring = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_family_responsibilities_jd = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_forced_labor_underage = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_hiv_status_hiring = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_hiv_status_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_hiv_testing_jd = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_homeworkers_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_illness_testing_hiring = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_illness_testing_hiring_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_indonesia_outsourced_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_job_application_discrimination = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_job_description_discrimination = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_marital_status_hiring = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_marital_status_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_migrant_contracts_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_monetary_deposits_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN rh_national_extraction_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_national_extraction_referenced = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_nationality_jd = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_nationality_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_other_identified_jd = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_political_opinion_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_political_opinion_referenced = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_pregnancy_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_pregnancy_referenced = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_pregnancy_testing = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_prison_laborers_have_not = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_race_ethnic_group_skin = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_race_ethnic_group_skin_jd = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_religion_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_religion_referenced_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_sex_gender_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_sex_gender_jd = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_sexual_orientation_hiring = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_sexual_orientation_referenced = 'X' THEN 1 ELSE 0 END +
    CASE WHEN rh_signed_copies_of_contracts = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_social_origin_hiring = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_social_origin_referenced = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_the_facility_does_not = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_there_is_no_supervision = TRUE THEN 1 ELSE 0 END +
    CASE WHEN rh_vietnam_disability_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_worker_privacy = 'No' THEN 1 ELSE 0 END +
    CASE WHEN rh_workplace_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ter_debt_bondage_risk = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ter_family_responsibilities = TRUE THEN 1 ELSE 0 END +
    CASE WHEN ter_invalid_termination_reasons = 'X' THEN 1 ELSE 0 END +
    CASE WHEN ter_legal_compliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ter_other_discrimination = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ter_race_ethnic_group = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ter_reinstatement_orders_not_followed = TRUE THEN 1 ELSE 0 END +
    CASE WHEN ter_severance_not_paid = 'X' THEN 1 ELSE 0 END +
    CASE WHEN ter_suspension_legal_compliance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN ter_termination_benefits_not_paid = 'X' THEN 1 ELSE 0 END +
    CASE WHEN ter_termination_noncompliance_general = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ter_termination_nonprod_noncompliance = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN ter_termination_payment_delay = 'X' THEN 1 ELSE 0 END +
    CASE WHEN ter_unused_leave_not_paid = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_accurate_detailed_payslips = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_agencycontract_workers = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_annual_leave_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_annual_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_authorized_3rd_party_agents = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_bangladesh_has_facility_established = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_bangladesh_workers_participation_welfare = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_attendance_bonus_casual = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_attendance_bonus_during = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_attendance_bonus_new = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_piece_rate_set = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_seniority_indemnity_undetermined = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_transport_home_place = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_cambodia_wage_supplements_including = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_casual_workers = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_compensation_workers_death = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_compensation_workrelated_accidents_diseases = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_compensatorytimeoff_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_compulsory_group_insurance_workers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_contract_workers_who_part = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_injury = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_maternity = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_medical = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_unemployment = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_voluntarily_accepted_workers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_deductions_wages_explained_workers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_did_facility_other_wage = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_ethiopia_provide_legally_required = 'undefined' THEN 1 ELSE 0 END +
    CASE WHEN wb_ethiopia_provide_time_off = 'undefined' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_comply_leave_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_conduct_worker_performance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_comply_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_correctly_provide = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_leave_legal_other = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_worker_basicwage = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_worker_cba = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_worker_legalmin = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_workers_experience = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_workers_overtime = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_workers_overtime_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_failing_pay_workers_regular = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_has_overdue_social = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_annual_bonus = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_attendance_bonus = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_housing_allowance = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_meal_allowance = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_productivity_bonus = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_seniority_andor = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_paid_transportation_allowance = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_pay_workers_correctly = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_provide_legally_required = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_provide_other_insurance = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_register_workers_social = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_facility_take_deductions_wages = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_failing_topay_overtime_night = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_failing_topay_overtime_ordinary = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_failing_topay_overtime_public_holidays = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_failing_topay_overtime_weekly_restdays = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_fines_socialsecurity = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wb_indonesia_facility_comply_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_indonesia_facility_comply_requirements = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_indonesia_facility_establish_wage = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_indonesia_nationalhealthcare = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_maternity_collected_forwarded = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_maternity_leave_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_maternity_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_medical_collected_forwarded = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_one_payroll_record = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_other = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_other_collected_forwarded = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_other_monetary_bonuses_andor = 'No- out of line with legal requirements' THEN 1 ELSE 0 END +
    CASE WHEN wb_other_types_required_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_overtime_allowances_providedpaid_line = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_overtime_premium = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_employer_maintain_fair = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_facility_pay_workers = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_workers_receive_correct = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_workers_survivors_benefit = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_workers_survivors_injury = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_pakistan_workers_survivors_medical = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_parttime_workers_failing_timeoff = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_paternity_leave_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_paternity_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_payroll_records_consistent_attendance = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_payroll_records_each_worker = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_payroll_records_show_types = 'undefined' THEN 1 ELSE 0 END +
    CASE WHEN wb_pension_provident_fund_collected = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_pension_provident_fund_collected_legal = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_permanent_workers = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_personal_leave_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_personal_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_piece_rate_workers_paid = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_premiumpay_night = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_premiumpay_public_holidays = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_premiumpay_weeklyrestdays = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_public_holidays_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_public_holidays_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_sick_leave_failing_timeoff = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_sick_leave_failing_to_pay = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_temporary_workers = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_unemployment_collected_forwarded = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_facility_collect_forward = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_facility_comply_applicable = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_facility_contribution_social = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_facility_incorporate_legally = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_facility_submit_claims = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_vietnam_provide_30_minutes = 'undefined' THEN 1 ELSE 0 END +
    CASE WHEN wb_wage_basis_3rd_party = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_wage_basis_legal_requirements = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_wage_payments_made_regularly = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_were_other_wage_payments = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_were_withholdings_wages_other = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_access_account_status = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_give_written_consent = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_informed_about_individual = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_paid_full_wages = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_paid_workrelated_activities = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_under_probation = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_were_paid_correctly = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_workers_who_trainees_apprentices = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wb_workrelated_injury_illness_death = 'X' THEN 1 ELSE 0 END +
    CASE WHEN wh_breastfeeding_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_daily_limits_overtime_hours = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_exceed_legal_requirements = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wh_facility_failing_comply_legal_nonprod = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wh_facility_failing_comply_legal_other = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wh_facility_maintain_only_one = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_facility_only_require_workers = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_facility_provide_breaks_during = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_govt_permission_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_monthly_limits_overtime_hours = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_other_action_impacting_workers = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_overtime_voluntary_line_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_overtime_working_hours_line = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_pakistan_provide_required_time = 'undefined' THEN 1 ELSE 0 END +
    CASE WHEN wh_reasons_overtime_line_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_vietnam_facility_comply_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_weekly_limits_overtime_hours = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_weeklyrestdays_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_work_targets_production_eg = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wh_workers_hours_reduced = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_workers_must_stay_home_less_minwage = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_workers_must_stay_home_minwage = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_workers_must_stay_home_notpaid = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_workers_must_stay_home_pto = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_yearly_limits_overtime_hours = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wh_yes_regular_hours_exceed = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wi_bangladesh_facility_legally_required = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_bipartite_committees_established_functioning = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_employer_allow_workers_carry = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_facility_failing_comply_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wi_facility_has_no_trade = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_facility_inform_workers_about = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_facility_refuse_bargain_collectively = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wi_has_facility_ever_tried = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wi_has_facility_failed_implement = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wi_legally_required_mechanisms_dialogue = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_legally_required_workers_representatives = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_vietnam_has_collective_agreement = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_were_least_twothirds_meetings = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_were_terminations_trade_union = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_workers_free_form_trade = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wi_workers_free_join_trade = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_benefits_maintained = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_discipline_harassment = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_employer_use_other_coercive = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_employment_status_maintained = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_failing_comply_legal = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_failing_comply_legal_other = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_line_legal_requirements = 'TRUE' THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_require_hivaids_tests = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_requires_pregnancy_tests = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_retain_disabled_ill = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_facility_retain_ill_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_failure_to_comply_amediated_agreements = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_failure_to_comply_arbitration = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_failure_to_comply_court_order = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_failure_to_comply_legal_settlements = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_failure_to_comply_settlements = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_family_responsibilities_conditions = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_family_responsibilities_harassment = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_family_responsibilities_promotion = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_female_worker_harassment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_gender_identity = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_illness_tests_legal = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_marital_status = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_marital_status_written = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_national_extraction = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_pakistan_coc_harassment = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN wt_pakistan_has_employer_set = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_political_opinion_harassment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_position_maintained = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_religious_harassment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_retain_hiv = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_skin_color_race_harassment = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_social_origin_harassment = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_there_been_cases_sexual = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_vietnam_sa_training = 'No' THEN 1 ELSE 0 END +
    CASE WHEN wt_wages_maintained = TRUE THEN 1 ELSE 0 END +
    CASE WHEN wt_workers_free_come_go = 'No' THEN 1 ELSE 0 END) AS all_flag_count
FROM fslm_cte
GROUP BY 1,2,3,
    cl_age_verification,
    cl_hazardous_work_legal,
    cl_healthchecks,
    cl_healthchecks_legal,
    cl_healthchecks_prioremployment,
    cl_hs_protective_restrictions,
    cl_hs_separate_trainings,
    cl_hs_specialtrainings,
    cl_implement_separate_tracking,
    cl_internship_legal,
    cl_nightwork,
    cl_parental_permission,
    cl_parental_review,
    cl_protectiverestriction_u18,
    cl_written_remediation_policy,
    cl_youngest_worker,
    cl_youngest_worker12_18,
    disc_contraception_hiring,
    disc_contraception_requirement_employment,
    disc_disability_accommodations,
    disc_disabled_hiring_legal,
    disc_illness_termination,
    disc_pregnancy_requirements_hiring,
    disc_promotion_age,
    disc_promotion_disability,
    disc_promotion_hiv,
    disc_promotion_maritalstatus,
    disc_promotion_maternity,
    disc_promotion_nationalextraction,
    disc_promotion_nationality,
    disc_promotion_other,
    disc_promotion_politicalopinion,
    disc_promotion_race,
    disc_promotion_religion,
    disc_promotion_sex,
    disc_promotion_sexualorientation,
    disc_promotion_socialorigin,
    disc_retaliation_termination,
    disc_termination_age,
    disc_termination_disability,
    disc_termination_hiv,
    disc_termination_maritalstatus,
    disc_termination_maternity,
    disc_termination_nationalextraction,
    disc_termination_nationality,
    disc_termination_other,
    disc_termination_politicalopinion,
    disc_termination_race,
    disc_termination_religion,
    disc_termination_sex,
    disc_termination_sexualorientation,
    disc_termination_socialorigin,
    disc_virginity_test_hiring,
    disc_workconditions_age,
    disc_workconditions_disability,
    disc_workconditions_hiv,
    disc_workconditions_maritalstatus,
    disc_workconditions_maternity,
    disc_workconditions_nationalextraction,
    disc_workconditions_nationality,
    disc_workconditions_other,
    disc_workconditions_politicalopinion,
    disc_workconditions_race,
    disc_workconditions_religion,
    disc_workconditions_sex,
    disc_workconditions_sexualorientation,
    disc_workconditions_socialorigin,
    discp_legal,
    ep_all_with_contract,
    ep_defense,
    ep_limits_fixed_contracts,
    ep_personnelfiles_legal,
    ep_probation_legal,
    ep_rif_alternatives,
    ep_temp_contracts_avoid_legal,
    ep_work_legal,
    ep_workers_were_not_given_notice,
    erg_retaliation,
    fl_are_any_monetary_deposits,
    fl_forced_overtime,
    fl_migrant_recruitment_legal,
    fl_passport_access,
    fl_prison_labor,
    fl_recruitment_costs_legal,
    fl_reimbursement_fees,
    fl_restricted_leaving,
    fl_terminate_employment_postnotice,
    fl_witheld_payments,
    foa_armed_break_strike,
    foa_cba_favorable_as_law,
    foa_consultation_union_legal,
    foa_control_unions,
    foa_equal_union_treatment_legal,
    foa_form_join_federations,
    foa_free_to_meet_wo_mgmt,
    foa_new_workers_replace_strikers,
    foa_private_meeting_legal,
    foa_punished_strikes,
    foa_required_union,
    foa_trade_union_representatives_access,
    foa_union_activity_hiring,
    foa_union_intimidation,
    foa_union_punished,
    foa_union_support_legal,
    foa_union_terminated,
    foa_unions,
    foa_untion_deductions_legal,
    fp_does_the_facility_maintain,
    fp_operating_license_registration,
    hb_cases_abuse,
    hb_cases_characteristics,
    hb_effective_remediation,
    hb_forced_work_strike,
    hb_harassment_age,
    hb_harassment_disability,
    hb_harassment_hiv,
    hb_harassment_maternitystatus,
    hb_harassment_nationality,
    hb_harassment_other,
    hb_harassment_politicalopinion,
    hb_harassment_race,
    hb_harassment_religion,
    hb_harassment_sexualorientation,
    hb_immigration_threats,
    hb_sexualharassment_cases,
    hb_violence_intimidation,
    hb_written_recrods_threats_forcedwork,
    hb_writtenrecords_discp_forcedwork,
    hb_writtenrecords_harassment_age,
    hb_writtenrecords_harassment_disability,
    hb_writtenrecords_harassment_hiv,
    hb_writtenrecords_harassment_maternity,
    hb_writtenrecords_harassment_nationality,
    hb_writtenrecords_harassment_other,
    hb_writtenrecords_harassment_politicalopinion,
    hb_writtenrecords_harassment_race,
    hb_writtenrecords_harassment_religion,
    hb_writtenrecords_harassment_sexualharassment,
    hb_writtenrecords_harassment_sexualorientation,
    hs_accessible_emergency_vehicles,
    hs_airborne_particulates_legal_exposure,
    hs_alarm_system_all_emergencies,
    hs_alarm_system_no_backup,
    hs_alarm_system_no_maintenance,
    hs_alarm_system_not_accessible,
    hs_alarm_system_not_distinct,
    hs_alarm_system_not_heard,
    hs_alarm_system_notfunctioning,
    hs_are_pregnant_and_nursing,
    hs_backup_ee_lighting_none_of_the_above,
    hs_bangladesh_acid_storage_legal,
    hs_bangladesh_overcrowding_legal_compliance,
    hs_beds_two_tiers,
    hs_building_construction_structural_legal,
    hs_cambodia_chemical_mixing,
    hs_cambodia_spills_legal,
    hs_cases_physical_integrity,
    hs_chemical_harardous_legal,
    hs_chemical_practices_legal,
    hs_chemicals_disposed_in_waste,
    hs_chemicals_hazardous,
    hs_chemicals_inappropriate_containers,
    hs_chemicals_legal,
    hs_chemicals_no_spill_kit,
    hs_chemicals_no_written_procedures,
    hs_chemicals_other,
    hs_children_production_area,
    hs_comply_health_legal_requirements_hiv,
    hs_confined_authorized_entry_only,
    hs_confined_space_accidental_entry,
    hs_confined_space_air_safety,
    hs_confined_space_appropriate_measures,
    hs_confined_space_no_rescue_equip,
    hs_confined_space_no_signs,
    hs_confined_space_not_trained,
    hs_confined_spaces,
    hs_confined_spaces_legal,
    hs_construction_permits_dorms,
    hs_contract_dispose_hazardous_waste,
    hs_cooperation_mechanisms_workers_management,
    hs_does_the_facility_record,
    hs_dorm_airtight_legal,
    hs_dorm_cooking_legal,
    hs_dorm_emergencyprep_legal,
    hs_dorm_fire_legal,
    hs_dorm_lighting_legal,
    hs_dorm_noise_legal,
    hs_dorm_not_separate,
    hs_dorm_permits_legal,
    hs_dorm_pests_legal,
    hs_dorm_privacy_legal,
    hs_dorm_sufficient_space,
    hs_dorm_ventilation_legal,
    hs_dorm_wastewater_legal,
    hs_dorm_water_legal,
    hs_dormitories_not_clean,
    hs_dormitories_space_dimensions_legal,
    hs_dorms_legal,
    hs_electrical_equipment_inspection_legal,
    hs_electrical_maintenance,
    hs_elevators_elevatordoors_inoperable,
    hs_elevators_inspection,
    hs_elevators_legal,
    hs_elevators_loadcapacity,
    hs_elevators_safety_devices,
    hs_elevators_warning_signs,
    hs_emergency_alarm_legal,
    hs_emergency_drills,
    hs_emergency_exit_doors,
    hs_emergency_exits_marked,
    hs_emergency_exits_safe,
    hs_emergency_response_vehicles,
    hs_emergencyexits_legal,
    hs_evacuation_legal,
    hs_evacuationplans_legal,
    hs_facility_provides_drinking_water,
    hs_facilitydoors_legal,
    hs_fallprotection_designated_location,
    hs_fallprotection_maintenance_logs,
    hs_fallprotection_not_trained,
    hs_fallprotection_not_worn_at_all_times,
    hs_fallprotection_notgoodcondition,
    hs_fallprotection_notusing,
    hs_fallprotection_nowalls,
    hs_fallprotection_training_logs,
    hs_fire_alarms_legal,
    hs_fire_detection_legal,
    hs_fire_training,
    hs_firefighting_equipment_legal,
    hs_firefighting_equipment_not_accessible,
    hs_firefighting_non,
    hs_firefighting_not_marked,
    hs_firefighting_training_legal,
    hs_first_aid_kits_not_accessible,
    hs_first_aid_kits_not_maintained,
    hs_first_aid_kits_not_sufficient,
    hs_flammable_materials_not_stored_safely,
    hs_foodservice_permits_legal,
    hs_fuel_storage_legal,
    hs_ghs_available,
    hs_hazardous_substances_exposure,
    hs_hazardous_substances_exposure_label,
    hs_hazardous_substances_legal,
    hs_hazardous_work_monitoring_legal,
    hs_health_safety_risk_assessment_conducted,
    hs_hot_work_legal,
    hs_hs_assessment,
    hs_ignition_sources_not_safeguarded,
    hs_initial_and_refresher_trainings_firefighting,
    hs_inventory_hazardous_substances,
    hs_laser_radiation_legal,
    hs_legal_equipment_eyewash,
    hs_legally_required_facilities_provided,
    hs_lighting_legal,
    hs_lightning_protector_legal,
    hs_machinery_maintenance_of_worker_machinery,
    hs_machinery_no_instructions_language,
    hs_measures_none,
    hs_medical_checks_legal,
    hs_medical_emergency_arrangements,
    hs_negative_consequences_removing_dangerous_situation,
    hs_no_automatic_and_centralized,
    hs_no_back_up_battery_ee_lighting,
    hs_no_equipment_firefighting,
    hs_no_fire_resistant_walls,
    hs_no_first_aid_records,
    hs_no_first_aid_training,
    hs_no_functioning_lockout_or_tagout,
    hs_no_illumination_ee,
    hs_no_marking_nor_exit,
    hs_noise_exposure_legal_compliance,
    hs_noise_level_legal,
    hs_noise_testing,
    hs_non_prod_hs_noncompliance,
    hs_off_site_canteens_legal,
    hs_onsite_canteens_legal,
    hs_onsite_childcare_legal,
    hs_osh_committee_formed_and_functioning,
    hs_osh_cost_to_workers,
    hs_other_health_safety_legal_noncompliance,
    hs_outlets_wet_area,
    hs_permits_special_equipment_legal,
    hs_ppe_for_dmf,
    hs_ppe_for_dmf_condition,
    hs_ppe_for_perc,
    hs_ppe_for_perc_condition,
    hs_ppe_for_pp,
    hs_ppe_for_pp_condition,
    hs_ppe_training_legal,
    hs_provided_ppe_legal,
    hs_qualified_osh_staff_legal_requirement,
    hs_required_guards_legal,
    hs_required_training_free,
    hs_safety_warnings_legally_posted,
    hs_sanitation_practices_legal_compliance,
    hs_sufficient_emergency,
    hs_sufficient_toilets_legal,
    hs_sustation_legal,
    hs_temperature_ventilation_legal_compliance,
    hs_tempsystems_legal,
    hs_test_fire_alarms,
    hs_toilets_legal_requirements_met,
    hs_training_records_chemical_12months,
    hs_vietnam_annual_osh_plan,
    hs_vietnam_environmental_conditions_monitoring,
    hs_vietnam_maintenance_machinery_legal,
    hs_vietnam_occupational_health_legal,
    hs_waste_disposal_legal_compliance,
    hs_worker_access_drinking_water_anytime,
    hs_worker_access_toilets_anytime,
    hs_written_osh_policy_legal_compliance,
    rh_age_jd,
    rh_age_referenced,
    rh_bangladesh_do_all_workers,
    rh_cambodia_entitlements_legal,
    rh_child_labor_hours_exceeded,
    rh_child_labor_legal_noncompliance,
    rh_child_worker_registry,
    rh_contract_changes_written_agreement,
    rh_contract_practices_legal,
    rh_contract_practices_nonprod_legal,
    rh_contracts_do_not_clearly,
    rh_disability_referenced,
    rh_discrimination_noncompliance,
    rh_family_responsibilities,
    rh_family_responsibilities_hiring,
    rh_family_responsibilities_jd,
    rh_forced_labor_underage,
    rh_hiv_status_hiring,
    rh_hiv_status_referenced,
    rh_hiv_testing_jd,
    rh_homeworkers_legal,
    rh_illness_testing_hiring,
    rh_illness_testing_hiring_legal,
    rh_indonesia_outsourced_legal,
    rh_job_application_discrimination,
    rh_job_description_discrimination,
    rh_marital_status_hiring,
    rh_marital_status_referenced,
    rh_migrant_contracts_legal,
    rh_monetary_deposits_legal,
    rh_national_extraction_hiring,
    rh_national_extraction_referenced,
    rh_nationality_jd,
    rh_nationality_referenced,
    rh_other_identified_jd,
    rh_political_opinion_hiring,
    rh_political_opinion_referenced,
    rh_pregnancy_hiring,
    rh_pregnancy_referenced,
    rh_pregnancy_testing,
    rh_prison_laborers_have_not,
    rh_race_ethnic_group_skin,
    rh_race_ethnic_group_skin_jd,
    rh_religion_hiring,
    rh_religion_referenced_hiring,
    rh_sex_gender_hiring,
    rh_sex_gender_jd,
    rh_sexual_orientation_hiring,
    rh_sexual_orientation_referenced,
    rh_signed_copies_of_contracts,
    rh_social_origin_hiring,
    rh_social_origin_referenced,
    rh_the_facility_does_not,
    rh_there_is_no_supervision,
    rh_vietnam_disability_legal,
    rh_worker_privacy,
    rh_workplace_legal,
    ter_debt_bondage_risk,
    ter_family_responsibilities,
    ter_invalid_termination_reasons,
    ter_legal_compliance,
    ter_other_discrimination,
    ter_race_ethnic_group,
    ter_reinstatement_orders_not_followed,
    ter_severance_not_paid,
    ter_suspension_legal_compliance,
    ter_termination_benefits_not_paid,
    ter_termination_noncompliance_general,
    ter_termination_nonprod_noncompliance,
    ter_termination_payment_delay,
    ter_unused_leave_not_paid,
    wb_accurate_detailed_payslips,
    wb_agencycontract_workers,
    wb_annual_leave_failing_timeoff,
    wb_annual_leave_failing_to_pay,
    wb_authorized_3rd_party_agents,
    wb_bangladesh_has_facility_established,
    wb_bangladesh_workers_participation_welfare,
    wb_cambodia_attendance_bonus_casual,
    wb_cambodia_attendance_bonus_during,
    wb_cambodia_attendance_bonus_new,
    wb_cambodia_piece_rate_set,
    wb_cambodia_seniority_indemnity_undetermined,
    wb_cambodia_transport_home_place,
    wb_cambodia_wage_supplements_including,
    wb_casual_workers,
    wb_compensation_workers_death,
    wb_compensation_workrelated_accidents_diseases,
    wb_compensatorytimeoff_legal,
    wb_compulsory_group_insurance_workers,
    wb_contract_workers_who_part,
    wb_deductions_injury,
    wb_deductions_maternity,
    wb_deductions_medical,
    wb_deductions_unemployment,
    wb_deductions_voluntarily_accepted_workers,
    wb_deductions_wages_explained_workers,
    wb_did_facility_other_wage,
    wb_ethiopia_provide_legally_required,
    wb_ethiopia_provide_time_off,
    wb_facility_comply_leave_legal,
    wb_facility_conduct_worker_performance,
    wb_facility_failing_comply_legal,
    wb_facility_failing_correctly_provide,
    wb_facility_failing_leave_legal_other,
    wb_facility_failing_pay_worker_basicwage,
    wb_facility_failing_pay_worker_cba,
    wb_facility_failing_pay_worker_legalmin,
    wb_facility_failing_pay_workers_experience,
    wb_facility_failing_pay_workers_overtime,
    wb_facility_failing_pay_workers_overtime_legal,
    wb_facility_failing_pay_workers_regular,
    wb_facility_has_overdue_social,
    wb_facility_paid_annual_bonus,
    wb_facility_paid_attendance_bonus,
    wb_facility_paid_housing_allowance,
    wb_facility_paid_meal_allowance,
    wb_facility_paid_productivity_bonus,
    wb_facility_paid_seniority_andor,
    wb_facility_paid_transportation_allowance,
    wb_facility_pay_workers_correctly,
    wb_facility_provide_legally_required,
    wb_facility_provide_other_insurance,
    wb_facility_register_workers_social,
    wb_facility_take_deductions_wages,
    wb_failing_topay_overtime_night,
    wb_failing_topay_overtime_ordinary,
    wb_failing_topay_overtime_public_holidays,
    wb_failing_topay_overtime_weekly_restdays,
    wb_fines_socialsecurity,
    wb_indonesia_facility_comply_legal,
    wb_indonesia_facility_comply_requirements,
    wb_indonesia_facility_establish_wage,
    wb_indonesia_nationalhealthcare,
    wb_maternity_collected_forwarded,
    wb_maternity_leave_failing_timeoff,
    wb_maternity_leave_failing_to_pay,
    wb_medical_collected_forwarded,
    wb_one_payroll_record,
    wb_other,
    wb_other_collected_forwarded,
    wb_other_monetary_bonuses_andor,
    wb_other_types_required_leave_failing_to_pay,
    wb_overtime_allowances_providedpaid_line,
    wb_overtime_premium,
    wb_pakistan_employer_maintain_fair,
    wb_pakistan_facility_pay_workers,
    wb_pakistan_workers_receive_correct,
    wb_pakistan_workers_survivors_benefit,
    wb_pakistan_workers_survivors_injury,
    wb_pakistan_workers_survivors_medical,
    wb_parttime_workers_failing_timeoff,
    wb_paternity_leave_failing_timeoff,
    wb_paternity_leave_failing_to_pay,
    wb_payroll_records_consistent_attendance,
    wb_payroll_records_each_worker,
    wb_payroll_records_show_types,
    wb_pension_provident_fund_collected,
    wb_pension_provident_fund_collected_legal,
    wb_permanent_workers,
    wb_personal_leave_failing_timeoff,
    wb_personal_leave_failing_to_pay,
    wb_piece_rate_workers_paid,
    wb_premiumpay_night,
    wb_premiumpay_public_holidays,
    wb_premiumpay_weeklyrestdays,
    wb_public_holidays_failing_timeoff,
    wb_public_holidays_failing_to_pay,
    wb_sick_leave_failing_timeoff,
    wb_sick_leave_failing_to_pay,
    wb_temporary_workers,
    wb_unemployment_collected_forwarded,
    wb_vietnam_facility_collect_forward,
    wb_vietnam_facility_comply_applicable,
    wb_vietnam_facility_contribution_social,
    wb_vietnam_facility_incorporate_legally,
    wb_vietnam_facility_submit_claims,
    wb_vietnam_provide_30_minutes,
    wb_wage_basis_3rd_party,
    wb_wage_basis_legal_requirements,
    wb_wage_payments_made_regularly,
    wb_were_other_wage_payments,
    wb_were_withholdings_wages_other,
    wb_workers_access_account_status,
    wb_workers_give_written_consent,
    wb_workers_informed_about_individual,
    wb_workers_paid_full_wages,
    wb_workers_paid_workrelated_activities,
    wb_workers_under_probation,
    wb_workers_were_paid_correctly,
    wb_workers_who_trainees_apprentices,
    wb_workrelated_injury_illness_death,
    wh_breastfeeding_legal,
    wh_daily_limits_overtime_hours,
    wh_exceed_legal_requirements,
    wh_facility_failing_comply_legal_nonprod,
    wh_facility_failing_comply_legal_other,
    wh_facility_maintain_only_one,
    wh_facility_only_require_workers,
    wh_facility_provide_breaks_during,
    wh_govt_permission_legal,
    wh_monthly_limits_overtime_hours,
    wh_other_action_impacting_workers,
    wh_overtime_voluntary_line_legal,
    wh_overtime_working_hours_line,
    wh_pakistan_provide_required_time,
    wh_reasons_overtime_line_legal,
    wh_vietnam_facility_comply_legal,
    wh_weekly_limits_overtime_hours,
    wh_weeklyrestdays_legal,
    wh_work_targets_production_eg,
    wh_workers_hours_reduced,
    wh_workers_must_stay_home_less_minwage,
    wh_workers_must_stay_home_minwage,
    wh_workers_must_stay_home_notpaid,
    wh_workers_must_stay_home_pto,
    wh_yearly_limits_overtime_hours,
    wh_yes_regular_hours_exceed,
    wi_bangladesh_facility_legally_required,
    wi_bipartite_committees_established_functioning,
    wi_employer_allow_workers_carry,
    wi_facility_failing_comply_legal,
    wi_facility_has_no_trade,
    wi_facility_inform_workers_about,
    wi_facility_refuse_bargain_collectively,
    wi_has_facility_ever_tried,
    wi_has_facility_failed_implement,
    wi_legally_required_mechanisms_dialogue,
    wi_legally_required_workers_representatives,
    wi_vietnam_has_collective_agreement,
    wi_were_least_twothirds_meetings,
    wi_were_terminations_trade_union,
    wi_workers_free_form_trade,
    wi_workers_free_join_trade,
    wt_benefits_maintained,
    wt_discipline_harassment,
    wt_employer_use_other_coercive,
    wt_employment_status_maintained,
    wt_facility_failing_comply_legal,
    wt_facility_failing_comply_legal_other,
    wt_facility_line_legal_requirements,
    wt_facility_require_hivaids_tests,
    wt_facility_requires_pregnancy_tests,
    wt_facility_retain_disabled_ill,
    wt_facility_retain_ill_legal,
    wt_failure_to_comply_amediated_agreements,
    wt_failure_to_comply_arbitration,
    wt_failure_to_comply_court_order,
    wt_failure_to_comply_legal_settlements,
    wt_failure_to_comply_settlements,
    wt_family_responsibilities_conditions,
    wt_family_responsibilities_harassment,
    wt_family_responsibilities_promotion,
    wt_female_worker_harassment,
    wt_gender_identity,
    wt_illness_tests_legal,
    wt_marital_status,
    wt_marital_status_written,
    wt_national_extraction,
    wt_pakistan_coc_harassment,
    wt_pakistan_has_employer_set,
    wt_political_opinion_harassment,
    wt_position_maintained,
    wt_religious_harassment,
    wt_retain_hiv,
    wt_skin_color_race_harassment,
    wt_social_origin_harassment,
    wt_there_been_cases_sexual,
    wt_vietnam_sa_training,
    wt_wages_maintained,
    wt_workers_free_come_go