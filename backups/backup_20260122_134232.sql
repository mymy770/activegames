--
-- PostgreSQL database dump
--

\restrict Rc8LBBFRV5rs9UGSqLuhizkpQGTUnOT9g0BAh8UMKKvoW38G1asMNoeXmvhtYz6

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP EVENT TRIGGER IF EXISTS pgrst_drop_watch;
DROP EVENT TRIGGER IF EXISTS pgrst_ddl_watch;
DROP EVENT TRIGGER IF EXISTS issue_pg_net_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_graphql_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_cron_access;
DROP EVENT TRIGGER IF EXISTS issue_graphql_placeholder;
DROP PUBLICATION IF EXISTS supabase_realtime_messages_publication;
DROP PUBLICATION IF EXISTS supabase_realtime;
DROP POLICY IF EXISTS roles_select_authenticated ON public.roles;
DROP POLICY IF EXISTS email_templates_update_policy ON public.email_templates;
DROP POLICY IF EXISTS email_templates_select_policy ON public.email_templates;
DROP POLICY IF EXISTS email_templates_insert_policy ON public.email_templates;
DROP POLICY IF EXISTS email_templates_delete_policy ON public.email_templates;
DROP POLICY IF EXISTS email_logs_update_policy ON public.email_logs;
DROP POLICY IF EXISTS email_logs_select_policy ON public.email_logs;
DROP POLICY IF EXISTS email_logs_insert_policy ON public.email_logs;
DROP POLICY IF EXISTS email_logs_delete_policy ON public.email_logs;
DROP POLICY IF EXISTS "Users can view own conversations" ON public.ai_conversations;
DROP POLICY IF EXISTS "Users can view messages of own conversations" ON public.ai_messages;
DROP POLICY IF EXISTS "Users can update own conversations" ON public.ai_conversations;
DROP POLICY IF EXISTS "Users can update orders from their branches" ON public.orders;
DROP POLICY IF EXISTS "Users can insert messages to own conversations" ON public.ai_messages;
DROP POLICY IF EXISTS "Users can delete own conversations" ON public.ai_conversations;
DROP POLICY IF EXISTS "Users can create own conversations" ON public.ai_conversations;
DROP POLICY IF EXISTS "Super admins can read all logs" ON public.activity_logs;
DROP POLICY IF EXISTS "Super admins can modify permissions" ON public.role_permissions;
DROP POLICY IF EXISTS "Super admins can manage payment credentials" ON public.payment_credentials;
DROP POLICY IF EXISTS "Super admins can manage email settings" ON public.email_settings;
DROP POLICY IF EXISTS "Super admins can delete logs" ON public.activity_logs;
DROP POLICY IF EXISTS "Super admin can manage all payments" ON public.payments;
DROP POLICY IF EXISTS "Service role full access to email_templates" ON public.email_templates;
DROP POLICY IF EXISTS "Service role full access to email_logs" ON public.email_logs;
DROP POLICY IF EXISTS "Service role full access messages" ON public.ai_messages;
DROP POLICY IF EXISTS "Service role full access conversations" ON public.ai_conversations;
DROP POLICY IF EXISTS "Public can create orders" ON public.orders;
DROP POLICY IF EXISTS "Branch users can view payments" ON public.payments;
DROP POLICY IF EXISTS "Branch admins can read logs for their branches" ON public.activity_logs;
DROP POLICY IF EXISTS "Branch admin can manage payments" ON public.payments;
DROP POLICY IF EXISTS "Authenticated users can view orders" ON public.orders;
DROP POLICY IF EXISTS "Authenticated users can view email templates" ON public.email_templates;
DROP POLICY IF EXISTS "Authenticated users can view email logs" ON public.email_logs;
DROP POLICY IF EXISTS "Authenticated users can update email logs" ON public.email_logs;
DROP POLICY IF EXISTS "Authenticated users can read permissions" ON public.role_permissions;
DROP POLICY IF EXISTS "Authenticated users can manage email templates" ON public.email_templates;
DROP POLICY IF EXISTS "Authenticated users can insert logs" ON public.activity_logs;
DROP POLICY IF EXISTS "Authenticated users can insert email logs" ON public.email_logs;
DROP POLICY IF EXISTS "Allow service role full access to products" ON public.icount_products;
DROP POLICY IF EXISTS "Allow service role full access rooms" ON public.icount_rooms;
DROP POLICY IF EXISTS "Allow service role full access event formulas" ON public.icount_event_formulas;
DROP POLICY IF EXISTS "Allow authenticated users to view products" ON public.icount_products;
DROP POLICY IF EXISTS "Allow authenticated to view rooms" ON public.icount_rooms;
DROP POLICY IF EXISTS "Allow authenticated to view event formulas" ON public.icount_event_formulas;
DROP POLICY IF EXISTS "Agents can read their own logs" ON public.activity_logs;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_upload_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.prefixes DROP CONSTRAINT IF EXISTS "prefixes_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS "objects_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY public.user_branches DROP CONSTRAINT IF EXISTS user_branches_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_branches DROP CONSTRAINT IF EXISTS user_branches_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_id_fkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_processed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_contact_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_booking_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_credentials DROP CONSTRAINT IF EXISTS payment_credentials_updated_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_credentials DROP CONSTRAINT IF EXISTS payment_credentials_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.payment_credentials DROP CONSTRAINT IF EXISTS payment_credentials_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_processed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_preauth_used_by_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_preauth_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_preauth_cancelled_by_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_contact_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_closed_by_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_booking_id_fkey;
ALTER TABLE IF EXISTS ONLY public.laser_rooms DROP CONSTRAINT IF EXISTS laser_rooms_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.icount_rooms DROP CONSTRAINT IF EXISTS icount_rooms_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.icount_products DROP CONSTRAINT IF EXISTS icount_products_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.icount_event_formulas DROP CONSTRAINT IF EXISTS icount_event_formulas_room_id_fkey;
ALTER TABLE IF EXISTS ONLY public.icount_event_formulas DROP CONSTRAINT IF EXISTS icount_event_formulas_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public.icount_event_formulas DROP CONSTRAINT IF EXISTS icount_event_formulas_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.game_sessions DROP CONSTRAINT IF EXISTS game_sessions_laser_room_id_fkey;
ALTER TABLE IF EXISTS ONLY public.game_sessions DROP CONSTRAINT IF EXISTS game_sessions_booking_id_fkey;
ALTER TABLE IF EXISTS ONLY public.event_rooms DROP CONSTRAINT IF EXISTS event_rooms_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.email_logs DROP CONSTRAINT IF EXISTS email_logs_triggered_by_fkey;
ALTER TABLE IF EXISTS ONLY public.email_logs DROP CONSTRAINT IF EXISTS email_logs_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_updated_by_fkey;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_branch_id_main_fkey;
ALTER TABLE IF EXISTS ONLY public.branch_settings DROP CONSTRAINT IF EXISTS branch_settings_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bookings DROP CONSTRAINT IF EXISTS bookings_primary_contact_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bookings DROP CONSTRAINT IF EXISTS bookings_event_room_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bookings DROP CONSTRAINT IF EXISTS bookings_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.booking_slots DROP CONSTRAINT IF EXISTS booking_slots_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.booking_slots DROP CONSTRAINT IF EXISTS booking_slots_booking_id_fkey;
ALTER TABLE IF EXISTS ONLY public.booking_contacts DROP CONSTRAINT IF EXISTS booking_contacts_contact_id_fkey;
ALTER TABLE IF EXISTS ONLY public.booking_contacts DROP CONSTRAINT IF EXISTS booking_contacts_booking_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ai_messages DROP CONSTRAINT IF EXISTS ai_messages_conversation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.ai_conversations DROP CONSTRAINT IF EXISTS ai_conversations_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_branch_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_oauth_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_flow_state_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_auth_factor_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_user_id_fkey;
DROP TRIGGER IF EXISTS update_objects_updated_at ON storage.objects;
DROP TRIGGER IF EXISTS prefixes_delete_hierarchy ON storage.prefixes;
DROP TRIGGER IF EXISTS prefixes_create_hierarchy ON storage.prefixes;
DROP TRIGGER IF EXISTS objects_update_create_prefix ON storage.objects;
DROP TRIGGER IF EXISTS objects_insert_create_prefix ON storage.objects;
DROP TRIGGER IF EXISTS objects_delete_delete_prefix ON storage.objects;
DROP TRIGGER IF EXISTS enforce_bucket_name_length_trigger ON storage.buckets;
DROP TRIGGER IF EXISTS tr_check_filters ON realtime.subscription;
DROP TRIGGER IF EXISTS update_profiles_updated_at ON public.profiles;
DROP TRIGGER IF EXISTS update_email_templates_updated_at ON public.email_templates;
DROP TRIGGER IF EXISTS update_contacts_updated_at ON public.contacts;
DROP TRIGGER IF EXISTS update_branches_updated_at ON public.branches;
DROP TRIGGER IF EXISTS update_branch_settings_updated_at ON public.branch_settings;
DROP TRIGGER IF EXISTS update_bookings_updated_at ON public.bookings;
DROP TRIGGER IF EXISTS trigger_update_payments_updated_at ON public.payments;
DROP TRIGGER IF EXISTS trigger_update_payment_credentials_updated_at ON public.payment_credentials;
DROP TRIGGER IF EXISTS trigger_update_ai_conversation_timestamp ON public.ai_messages;
DROP TRIGGER IF EXISTS trigger_orders_updated_at ON public.orders;
DROP TRIGGER IF EXISTS trg_seed_icount_products ON public.branches;
DROP TRIGGER IF EXISTS roles_updated_at_trigger ON public.roles;
DROP TRIGGER IF EXISTS email_templates_updated_at ON public.email_templates;
DROP INDEX IF EXISTS storage.vector_indexes_name_bucket_id_idx;
DROP INDEX IF EXISTS storage.objects_bucket_id_level_idx;
DROP INDEX IF EXISTS storage.name_prefix_search;
DROP INDEX IF EXISTS storage.idx_prefixes_lower_name;
DROP INDEX IF EXISTS storage.idx_objects_lower_name;
DROP INDEX IF EXISTS storage.idx_objects_bucket_id_name;
DROP INDEX IF EXISTS storage.idx_name_bucket_level_unique;
DROP INDEX IF EXISTS storage.idx_multipart_uploads_list;
DROP INDEX IF EXISTS storage.buckets_analytics_unique_name_idx;
DROP INDEX IF EXISTS storage.bucketid_objname;
DROP INDEX IF EXISTS storage.bname;
DROP INDEX IF EXISTS realtime.subscription_subscription_id_entity_filters_key;
DROP INDEX IF EXISTS realtime.messages_inserted_at_topic_index;
DROP INDEX IF EXISTS realtime.ix_realtime_subscription_entity;
DROP INDEX IF EXISTS public.idx_user_branches_user;
DROP INDEX IF EXISTS public.idx_user_branches_branch;
DROP INDEX IF EXISTS public.idx_roles_name;
DROP INDEX IF EXISTS public.idx_roles_level;
DROP INDEX IF EXISTS public.idx_role_permissions_role_id;
DROP INDEX IF EXISTS public.idx_profiles_role_id;
DROP INDEX IF EXISTS public.idx_profiles_role;
DROP INDEX IF EXISTS public.idx_profiles_phone;
DROP INDEX IF EXISTS public.idx_profiles_created_by;
DROP INDEX IF EXISTS public.idx_payments_status;
DROP INDEX IF EXISTS public.idx_payments_order_id;
DROP INDEX IF EXISTS public.idx_payments_icount_docnum;
DROP INDEX IF EXISTS public.idx_payments_created_at;
DROP INDEX IF EXISTS public.idx_payments_contact_id;
DROP INDEX IF EXISTS public.idx_payments_branch_id;
DROP INDEX IF EXISTS public.idx_payments_booking_id;
DROP INDEX IF EXISTS public.idx_payment_credentials_provider;
DROP INDEX IF EXISTS public.idx_payment_credentials_branch;
DROP INDEX IF EXISTS public.idx_orders_status;
DROP INDEX IF EXISTS public.idx_orders_requested_date;
DROP INDEX IF EXISTS public.idx_orders_payment_status;
DROP INDEX IF EXISTS public.idx_orders_created_at;
DROP INDEX IF EXISTS public.idx_orders_contact_id;
DROP INDEX IF EXISTS public.idx_orders_closed_at;
DROP INDEX IF EXISTS public.idx_orders_cgv_token;
DROP INDEX IF EXISTS public.idx_orders_cgv_pending;
DROP INDEX IF EXISTS public.idx_orders_branch_status;
DROP INDEX IF EXISTS public.idx_orders_branch_id;
DROP INDEX IF EXISTS public.idx_orders_booking_id;
DROP INDEX IF EXISTS public.idx_laser_rooms_is_active;
DROP INDEX IF EXISTS public.idx_laser_rooms_branch;
DROP INDEX IF EXISTS public.idx_icount_rooms_icount_item_id;
DROP INDEX IF EXISTS public.idx_icount_rooms_branch_id;
DROP INDEX IF EXISTS public.idx_icount_products_icount_item_id;
DROP INDEX IF EXISTS public.idx_icount_products_code;
DROP INDEX IF EXISTS public.idx_icount_products_branch_id;
DROP INDEX IF EXISTS public.idx_icount_event_formulas_game_type;
DROP INDEX IF EXISTS public.idx_icount_event_formulas_branch_id;
DROP INDEX IF EXISTS public.idx_game_sessions_start;
DROP INDEX IF EXISTS public.idx_game_sessions_laser_room;
DROP INDEX IF EXISTS public.idx_game_sessions_game_area;
DROP INDEX IF EXISTS public.idx_game_sessions_booking_id;
DROP INDEX IF EXISTS public.idx_game_sessions_booking;
DROP INDEX IF EXISTS public.idx_event_rooms_is_active;
DROP INDEX IF EXISTS public.idx_event_rooms_branch;
DROP INDEX IF EXISTS public.idx_event_formulas_product_id;
DROP INDEX IF EXISTS public.idx_email_templates_code;
DROP INDEX IF EXISTS public.idx_email_templates_branch;
DROP INDEX IF EXISTS public.idx_email_templates_active;
DROP INDEX IF EXISTS public.idx_email_logs_status;
DROP INDEX IF EXISTS public.idx_email_logs_recipient;
DROP INDEX IF EXISTS public.idx_email_logs_entity;
DROP INDEX IF EXISTS public.idx_email_logs_created_at;
DROP INDEX IF EXISTS public.idx_email_logs_created;
DROP INDEX IF EXISTS public.idx_email_logs_branch_created;
DROP INDEX IF EXISTS public.idx_email_logs_branch;
DROP INDEX IF EXISTS public.idx_contacts_status;
DROP INDEX IF EXISTS public.idx_contacts_phone_clean;
DROP INDEX IF EXISTS public.idx_contacts_phone;
DROP INDEX IF EXISTS public.idx_contacts_name;
DROP INDEX IF EXISTS public.idx_contacts_icount_client_id;
DROP INDEX IF EXISTS public.idx_contacts_email_clean;
DROP INDEX IF EXISTS public.idx_contacts_email;
DROP INDEX IF EXISTS public.idx_contacts_branch_status;
DROP INDEX IF EXISTS public.idx_contacts_branch_phone;
DROP INDEX IF EXISTS public.idx_contacts_branch_main;
DROP INDEX IF EXISTS public.idx_branches_slug;
DROP INDEX IF EXISTS public.idx_branches_is_active;
DROP INDEX IF EXISTS public.idx_branch_settings_branch;
DROP INDEX IF EXISTS public.idx_bookings_status;
DROP INDEX IF EXISTS public.idx_bookings_start_datetime;
DROP INDEX IF EXISTS public.idx_bookings_reference_code;
DROP INDEX IF EXISTS public.idx_bookings_primary_contact;
DROP INDEX IF EXISTS public.idx_bookings_branch_status;
DROP INDEX IF EXISTS public.idx_bookings_branch_date;
DROP INDEX IF EXISTS public.idx_bookings_branch;
DROP INDEX IF EXISTS public.idx_booking_slots_slot_start;
DROP INDEX IF EXISTS public.idx_booking_slots_branch;
DROP INDEX IF EXISTS public.idx_booking_slots_booking_id;
DROP INDEX IF EXISTS public.idx_booking_slots_booking;
DROP INDEX IF EXISTS public.idx_booking_contacts_primary;
DROP INDEX IF EXISTS public.idx_booking_contacts_one_primary;
DROP INDEX IF EXISTS public.idx_booking_contacts_contact_id;
DROP INDEX IF EXISTS public.idx_booking_contacts_contact;
DROP INDEX IF EXISTS public.idx_booking_contacts_booking_id;
DROP INDEX IF EXISTS public.idx_booking_contacts_booking;
DROP INDEX IF EXISTS public.idx_ai_messages_created_at;
DROP INDEX IF EXISTS public.idx_ai_messages_conversation_id;
DROP INDEX IF EXISTS public.idx_ai_conversations_user_id;
DROP INDEX IF EXISTS public.idx_ai_conversations_active;
DROP INDEX IF EXISTS public.idx_activity_logs_user_id;
DROP INDEX IF EXISTS public.idx_activity_logs_target_type;
DROP INDEX IF EXISTS public.idx_activity_logs_created_at;
DROP INDEX IF EXISTS public.idx_activity_logs_branch_id;
DROP INDEX IF EXISTS public.idx_activity_logs_branch_created;
DROP INDEX IF EXISTS public.idx_activity_logs_action_type;
DROP INDEX IF EXISTS auth.users_is_anonymous_idx;
DROP INDEX IF EXISTS auth.users_instance_id_idx;
DROP INDEX IF EXISTS auth.users_instance_id_email_idx;
DROP INDEX IF EXISTS auth.users_email_partial_key;
DROP INDEX IF EXISTS auth.user_id_created_at_idx;
DROP INDEX IF EXISTS auth.unique_phone_factor_per_user;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_pattern_idx;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_domain_idx;
DROP INDEX IF EXISTS auth.sessions_user_id_idx;
DROP INDEX IF EXISTS auth.sessions_oauth_client_id_idx;
DROP INDEX IF EXISTS auth.sessions_not_after_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_for_email_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_created_at_idx;
DROP INDEX IF EXISTS auth.saml_providers_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_updated_at_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_session_id_revoked_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_parent_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_user_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_idx;
DROP INDEX IF EXISTS auth.recovery_token_idx;
DROP INDEX IF EXISTS auth.reauthentication_token_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_user_id_token_type_key;
DROP INDEX IF EXISTS auth.one_time_tokens_token_hash_hash_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_relates_to_hash_idx;
DROP INDEX IF EXISTS auth.oauth_consents_user_order_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_user_client_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_client_idx;
DROP INDEX IF EXISTS auth.oauth_clients_deleted_at_idx;
DROP INDEX IF EXISTS auth.oauth_auth_pending_exp_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_id_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_friendly_name_unique;
DROP INDEX IF EXISTS auth.mfa_challenge_created_at_idx;
DROP INDEX IF EXISTS auth.idx_user_id_auth_method;
DROP INDEX IF EXISTS auth.idx_oauth_client_states_created_at;
DROP INDEX IF EXISTS auth.idx_auth_code;
DROP INDEX IF EXISTS auth.identities_user_id_idx;
DROP INDEX IF EXISTS auth.identities_email_idx;
DROP INDEX IF EXISTS auth.flow_state_created_at_idx;
DROP INDEX IF EXISTS auth.factor_id_created_at_idx;
DROP INDEX IF EXISTS auth.email_change_token_new_idx;
DROP INDEX IF EXISTS auth.email_change_token_current_idx;
DROP INDEX IF EXISTS auth.confirmation_token_idx;
DROP INDEX IF EXISTS auth.audit_logs_instance_id_idx;
ALTER TABLE IF EXISTS ONLY supabase_migrations.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY supabase_migrations.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_idempotency_key_key;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_pkey;
ALTER TABLE IF EXISTS ONLY storage.prefixes DROP CONSTRAINT IF EXISTS prefixes_pkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS objects_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_name_key;
ALTER TABLE IF EXISTS ONLY storage.buckets_vectors DROP CONSTRAINT IF EXISTS buckets_vectors_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets DROP CONSTRAINT IF EXISTS buckets_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets_analytics DROP CONSTRAINT IF EXISTS buckets_analytics_pkey;
ALTER TABLE IF EXISTS ONLY realtime.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY realtime.subscription DROP CONSTRAINT IF EXISTS pk_subscription;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_25 DROP CONSTRAINT IF EXISTS messages_2026_01_25_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_24 DROP CONSTRAINT IF EXISTS messages_2026_01_24_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_23 DROP CONSTRAINT IF EXISTS messages_2026_01_23_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_22 DROP CONSTRAINT IF EXISTS messages_2026_01_22_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_21 DROP CONSTRAINT IF EXISTS messages_2026_01_21_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_20 DROP CONSTRAINT IF EXISTS messages_2026_01_20_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_19 DROP CONSTRAINT IF EXISTS messages_2026_01_19_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages_2026_01_18 DROP CONSTRAINT IF EXISTS messages_2026_01_18_pkey;
ALTER TABLE IF EXISTS ONLY realtime.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.user_branches DROP CONSTRAINT IF EXISTS user_branches_user_id_branch_id_key;
ALTER TABLE IF EXISTS ONLY public.user_branches DROP CONSTRAINT IF EXISTS user_branches_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_name_key;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_role_resource_key;
ALTER TABLE IF EXISTS ONLY public.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_pkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_credentials DROP CONSTRAINT IF EXISTS payment_credentials_pkey;
ALTER TABLE IF EXISTS ONLY public.payment_credentials DROP CONSTRAINT IF EXISTS payment_credentials_branch_id_provider_key;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_request_reference_key;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_cgv_token_key;
ALTER TABLE IF EXISTS ONLY public.laser_rooms DROP CONSTRAINT IF EXISTS laser_rooms_pkey;
ALTER TABLE IF EXISTS ONLY public.laser_rooms DROP CONSTRAINT IF EXISTS laser_rooms_branch_id_slug_key;
ALTER TABLE IF EXISTS ONLY public.icount_rooms DROP CONSTRAINT IF EXISTS icount_rooms_pkey;
ALTER TABLE IF EXISTS ONLY public.icount_rooms DROP CONSTRAINT IF EXISTS icount_rooms_branch_id_code_key;
ALTER TABLE IF EXISTS ONLY public.icount_products DROP CONSTRAINT IF EXISTS icount_products_pkey;
ALTER TABLE IF EXISTS ONLY public.icount_products DROP CONSTRAINT IF EXISTS icount_products_branch_id_code_key;
ALTER TABLE IF EXISTS ONLY public.icount_event_formulas DROP CONSTRAINT IF EXISTS icount_event_formulas_pkey;
ALTER TABLE IF EXISTS ONLY public.game_sessions DROP CONSTRAINT IF EXISTS game_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.event_rooms DROP CONSTRAINT IF EXISTS event_rooms_pkey;
ALTER TABLE IF EXISTS ONLY public.event_rooms DROP CONSTRAINT IF EXISTS event_rooms_branch_id_slug_key;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.email_templates DROP CONSTRAINT IF EXISTS email_templates_code_key;
ALTER TABLE IF EXISTS ONLY public.email_settings DROP CONSTRAINT IF EXISTS email_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.email_logs DROP CONSTRAINT IF EXISTS email_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_slug_key;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_pkey;
ALTER TABLE IF EXISTS ONLY public.branch_settings DROP CONSTRAINT IF EXISTS branch_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.bookings DROP CONSTRAINT IF EXISTS bookings_reference_code_key;
ALTER TABLE IF EXISTS ONLY public.bookings DROP CONSTRAINT IF EXISTS bookings_pkey;
ALTER TABLE IF EXISTS ONLY public.booking_slots DROP CONSTRAINT IF EXISTS booking_slots_pkey;
ALTER TABLE IF EXISTS ONLY public.booking_contacts DROP CONSTRAINT IF EXISTS booking_contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.booking_contacts DROP CONSTRAINT IF EXISTS booking_contacts_booking_id_contact_id_key;
ALTER TABLE IF EXISTS ONLY public.ai_messages DROP CONSTRAINT IF EXISTS ai_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.ai_conversations DROP CONSTRAINT IF EXISTS ai_conversations_pkey;
ALTER TABLE IF EXISTS ONLY public.activity_logs DROP CONSTRAINT IF EXISTS activity_logs_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_phone_key;
ALTER TABLE IF EXISTS ONLY auth.sso_providers DROP CONSTRAINT IF EXISTS sso_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_pkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY auth.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_entity_id_key;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_client_unique;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_clients DROP CONSTRAINT IF EXISTS oauth_clients_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_client_states DROP CONSTRAINT IF EXISTS oauth_client_states_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_id_key;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_code_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_last_challenged_at_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_authentication_method_pkey;
ALTER TABLE IF EXISTS ONLY auth.instances DROP CONSTRAINT IF EXISTS instances_pkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_provider_id_provider_unique;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_pkey;
ALTER TABLE IF EXISTS ONLY auth.flow_state DROP CONSTRAINT IF EXISTS flow_state_pkey;
ALTER TABLE IF EXISTS ONLY auth.audit_log_entries DROP CONSTRAINT IF EXISTS audit_log_entries_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS amr_id_pk;
ALTER TABLE IF EXISTS auth.refresh_tokens ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS supabase_migrations.schema_migrations;
DROP TABLE IF EXISTS storage.vector_indexes;
DROP TABLE IF EXISTS storage.s3_multipart_uploads_parts;
DROP TABLE IF EXISTS storage.s3_multipart_uploads;
DROP TABLE IF EXISTS storage.prefixes;
DROP TABLE IF EXISTS storage.objects;
DROP TABLE IF EXISTS storage.migrations;
DROP TABLE IF EXISTS storage.buckets_vectors;
DROP TABLE IF EXISTS storage.buckets_analytics;
DROP TABLE IF EXISTS storage.buckets;
DROP TABLE IF EXISTS realtime.subscription;
DROP TABLE IF EXISTS realtime.schema_migrations;
DROP TABLE IF EXISTS realtime.messages_2026_01_25;
DROP TABLE IF EXISTS realtime.messages_2026_01_24;
DROP TABLE IF EXISTS realtime.messages_2026_01_23;
DROP TABLE IF EXISTS realtime.messages_2026_01_22;
DROP TABLE IF EXISTS realtime.messages_2026_01_21;
DROP TABLE IF EXISTS realtime.messages_2026_01_20;
DROP TABLE IF EXISTS realtime.messages_2026_01_19;
DROP TABLE IF EXISTS realtime.messages_2026_01_18;
DROP TABLE IF EXISTS realtime.messages;
DROP TABLE IF EXISTS public.user_branches;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.role_permissions;
DROP TABLE IF EXISTS public.profiles;
DROP TABLE IF EXISTS public.payments;
DROP TABLE IF EXISTS public.payment_credentials;
DROP TABLE IF EXISTS public.orders;
DROP TABLE IF EXISTS public.laser_rooms;
DROP TABLE IF EXISTS public.icount_rooms;
DROP TABLE IF EXISTS public.icount_products;
DROP TABLE IF EXISTS public.icount_event_formulas;
DROP TABLE IF EXISTS public.game_sessions;
DROP TABLE IF EXISTS public.event_rooms;
DROP TABLE IF EXISTS public.email_templates;
DROP TABLE IF EXISTS public.email_settings;
DROP TABLE IF EXISTS public.email_logs;
DROP TABLE IF EXISTS public.contacts;
DROP TABLE IF EXISTS public.branches;
DROP TABLE IF EXISTS public.branch_settings;
DROP TABLE IF EXISTS public.bookings;
DROP TABLE IF EXISTS public.booking_slots;
DROP TABLE IF EXISTS public.booking_contacts;
DROP TABLE IF EXISTS public.ai_messages;
DROP TABLE IF EXISTS public.ai_conversations;
DROP TABLE IF EXISTS public.activity_logs;
DROP TABLE IF EXISTS auth.users;
DROP TABLE IF EXISTS auth.sso_providers;
DROP TABLE IF EXISTS auth.sso_domains;
DROP TABLE IF EXISTS auth.sessions;
DROP TABLE IF EXISTS auth.schema_migrations;
DROP TABLE IF EXISTS auth.saml_relay_states;
DROP TABLE IF EXISTS auth.saml_providers;
DROP SEQUENCE IF EXISTS auth.refresh_tokens_id_seq;
DROP TABLE IF EXISTS auth.refresh_tokens;
DROP TABLE IF EXISTS auth.one_time_tokens;
DROP TABLE IF EXISTS auth.oauth_consents;
DROP TABLE IF EXISTS auth.oauth_clients;
DROP TABLE IF EXISTS auth.oauth_client_states;
DROP TABLE IF EXISTS auth.oauth_authorizations;
DROP TABLE IF EXISTS auth.mfa_factors;
DROP TABLE IF EXISTS auth.mfa_challenges;
DROP TABLE IF EXISTS auth.mfa_amr_claims;
DROP TABLE IF EXISTS auth.instances;
DROP TABLE IF EXISTS auth.identities;
DROP TABLE IF EXISTS auth.flow_state;
DROP TABLE IF EXISTS auth.audit_log_entries;
DROP FUNCTION IF EXISTS storage.update_updated_at_column();
DROP FUNCTION IF EXISTS storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text);
DROP FUNCTION IF EXISTS storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.prefixes_insert_trigger();
DROP FUNCTION IF EXISTS storage.prefixes_delete_cleanup();
DROP FUNCTION IF EXISTS storage.operation();
DROP FUNCTION IF EXISTS storage.objects_update_prefix_trigger();
DROP FUNCTION IF EXISTS storage.objects_update_level_trigger();
DROP FUNCTION IF EXISTS storage.objects_update_cleanup();
DROP FUNCTION IF EXISTS storage.objects_insert_prefix_trigger();
DROP FUNCTION IF EXISTS storage.objects_delete_cleanup();
DROP FUNCTION IF EXISTS storage.lock_top_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION IF EXISTS storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text);
DROP FUNCTION IF EXISTS storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
DROP FUNCTION IF EXISTS storage.get_size_by_bucket();
DROP FUNCTION IF EXISTS storage.get_prefixes(name text);
DROP FUNCTION IF EXISTS storage.get_prefix(name text);
DROP FUNCTION IF EXISTS storage.get_level(name text);
DROP FUNCTION IF EXISTS storage.foldername(name text);
DROP FUNCTION IF EXISTS storage.filename(name text);
DROP FUNCTION IF EXISTS storage.extension(name text);
DROP FUNCTION IF EXISTS storage.enforce_bucket_name_length();
DROP FUNCTION IF EXISTS storage.delete_prefix_hierarchy_trigger();
DROP FUNCTION IF EXISTS storage.delete_prefix(_bucket_id text, _name text);
DROP FUNCTION IF EXISTS storage.delete_leaf_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION IF EXISTS storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
DROP FUNCTION IF EXISTS storage.add_prefixes(_bucket_id text, _name text);
DROP FUNCTION IF EXISTS realtime.topic();
DROP FUNCTION IF EXISTS realtime.to_regrole(role_name text);
DROP FUNCTION IF EXISTS realtime.subscription_check_filters();
DROP FUNCTION IF EXISTS realtime.send(payload jsonb, event text, topic text, private boolean);
DROP FUNCTION IF EXISTS realtime.quote_wal2json(entity regclass);
DROP FUNCTION IF EXISTS realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer);
DROP FUNCTION IF EXISTS realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]);
DROP FUNCTION IF EXISTS realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text);
DROP FUNCTION IF EXISTS realtime."cast"(val text, type_ regtype);
DROP FUNCTION IF EXISTS realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]);
DROP FUNCTION IF EXISTS realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text);
DROP FUNCTION IF EXISTS realtime.apply_rls(wal jsonb, max_record_bytes integer);
DROP FUNCTION IF EXISTS public.update_updated_at_column();
DROP FUNCTION IF EXISTS public.update_roles_updated_at();
DROP FUNCTION IF EXISTS public.update_payments_updated_at();
DROP FUNCTION IF EXISTS public.update_payment_credentials_updated_at();
DROP FUNCTION IF EXISTS public.update_orders_updated_at();
DROP FUNCTION IF EXISTS public.update_email_templates_updated_at();
DROP FUNCTION IF EXISTS public.update_ai_conversation_timestamp();
DROP FUNCTION IF EXISTS public.trigger_seed_icount_products();
DROP FUNCTION IF EXISTS public.seed_icount_products_for_branch(p_branch_id uuid);
DROP FUNCTION IF EXISTS public.seed_icount_data_for_branch(p_branch_id uuid);
DROP FUNCTION IF EXISTS public.is_valid_email(email_input text);
DROP FUNCTION IF EXISTS public.get_user_permissions(user_role text);
DROP FUNCTION IF EXISTS public.generate_order_request_reference();
DROP FUNCTION IF EXISTS public.clean_israeli_phone(phone_input text);
DROP FUNCTION IF EXISTS pgbouncer.get_auth(p_usename text);
DROP FUNCTION IF EXISTS extensions.set_graphql_placeholder();
DROP FUNCTION IF EXISTS extensions.pgrst_drop_watch();
DROP FUNCTION IF EXISTS extensions.pgrst_ddl_watch();
DROP FUNCTION IF EXISTS extensions.grant_pg_net_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_graphql_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_cron_access();
DROP FUNCTION IF EXISTS auth.uid();
DROP FUNCTION IF EXISTS auth.role();
DROP FUNCTION IF EXISTS auth.jwt();
DROP FUNCTION IF EXISTS auth.email();
DROP TYPE IF EXISTS storage.buckettype;
DROP TYPE IF EXISTS realtime.wal_rls;
DROP TYPE IF EXISTS realtime.wal_column;
DROP TYPE IF EXISTS realtime.user_defined_filter;
DROP TYPE IF EXISTS realtime.equality_op;
DROP TYPE IF EXISTS realtime.action;
DROP TYPE IF EXISTS public.pending_reason;
DROP TYPE IF EXISTS public.payment_status;
DROP TYPE IF EXISTS public.order_status;
DROP TYPE IF EXISTS auth.one_time_token_type;
DROP TYPE IF EXISTS auth.oauth_response_type;
DROP TYPE IF EXISTS auth.oauth_registration_type;
DROP TYPE IF EXISTS auth.oauth_client_type;
DROP TYPE IF EXISTS auth.oauth_authorization_status;
DROP TYPE IF EXISTS auth.factor_type;
DROP TYPE IF EXISTS auth.factor_status;
DROP TYPE IF EXISTS auth.code_challenge_method;
DROP TYPE IF EXISTS auth.aal_level;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS supabase_vault;
DROP EXTENSION IF EXISTS pgcrypto;
DROP EXTENSION IF EXISTS pg_stat_statements;
DROP EXTENSION IF EXISTS pg_graphql;
DROP SCHEMA IF EXISTS vault;
DROP SCHEMA IF EXISTS supabase_migrations;
DROP SCHEMA IF EXISTS storage;
DROP SCHEMA IF EXISTS realtime;
DROP SCHEMA IF EXISTS pgbouncer;
DROP SCHEMA IF EXISTS graphql_public;
DROP SCHEMA IF EXISTS graphql;
DROP SCHEMA IF EXISTS extensions;
DROP SCHEMA IF EXISTS auth;
--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status AS ENUM (
    'pending',
    'auto_confirmed',
    'manually_confirmed',
    'cancelled',
    'closed'
);


ALTER TYPE public.order_status OWNER TO postgres;

--
-- Name: payment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status AS ENUM (
    'pending',
    'deposit_paid',
    'fully_paid',
    'card_authorized',
    'refunded',
    'failed'
);


ALTER TYPE public.payment_status OWNER TO postgres;

--
-- Name: pending_reason; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.pending_reason AS ENUM (
    'overbooking',
    'room_unavailable',
    'slot_unavailable',
    'laser_vests_full',
    'other'
);


ALTER TYPE public.pending_reason OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: clean_israeli_phone(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clean_israeli_phone(phone_input text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE
  cleaned TEXT;
BEGIN
  IF phone_input IS NULL OR TRIM(phone_input) = '' THEN
    RETURN NULL;
  END IF;
  
  -- Retirer tous les caractères non numériques
  cleaned := REGEXP_REPLACE(phone_input, '[^0-9]', '', 'g');
  
  -- Vérifier si c'est un numéro israélien valide (05XXXXXXXX)
  IF cleaned ~ '^05[0-9]{8}$' THEN
    RETURN cleaned;
  END IF;
  
  -- Si le format n'est pas valide, retourner tel quel pour inspection manuelle
  RETURN phone_input;
END;
$_$;


ALTER FUNCTION public.clean_israeli_phone(phone_input text) OWNER TO postgres;

--
-- Name: generate_order_request_reference(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_order_request_reference() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  today_str TEXT;
  seq_num INTEGER;
  ref TEXT;
BEGIN
  today_str := to_char(CURRENT_DATE, 'YYYYMMDD');
  
  -- Compter les commandes du jour pour générer un numéro séquentiel
  SELECT COUNT(*) + 1 INTO seq_num
  FROM orders
  WHERE DATE(created_at) = CURRENT_DATE;
  
  ref := 'REQ-' || today_str || '-' || LPAD(seq_num::TEXT, 4, '0');
  
  RETURN ref;
END;
$$;


ALTER FUNCTION public.generate_order_request_reference() OWNER TO postgres;

--
-- Name: get_user_permissions(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user_permissions(user_role text) RETURNS TABLE(resource text, can_view boolean, can_create boolean, can_edit boolean, can_delete boolean)
    LANGUAGE sql STABLE
    AS $$
  SELECT 
    rp.resource,
    rp.can_view,
    rp.can_create,
    rp.can_edit,
    rp.can_delete
  FROM public.role_permissions rp
  WHERE rp.role = user_role;
$$;


ALTER FUNCTION public.get_user_permissions(user_role text) OWNER TO postgres;

--
-- Name: is_valid_email(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_valid_email(email_input text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
  IF email_input IS NULL OR TRIM(email_input) = '' THEN
    RETURN TRUE;  -- NULL/empty est considéré comme valide (optionnel)
  END IF;
  
  -- Regex basique pour email
  RETURN email_input ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
END;
$_$;


ALTER FUNCTION public.is_valid_email(email_input text) OWNER TO postgres;

--
-- Name: seed_icount_data_for_branch(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.seed_icount_data_for_branch(p_branch_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Produits GAME
  IF NOT EXISTS (SELECT 1 FROM icount_products WHERE branch_id = p_branch_id) THEN
    INSERT INTO icount_products (branch_id, code, name, name_he, name_en, unit_price, sort_order) VALUES
      (p_branch_id, 'laser_1', 'Laser 1 partie', 'לייזר משחק 1', 'Laser 1 game', 70.00, 1),
      (p_branch_id, 'laser_2', 'Laser 2 parties', 'לייזר 2 משחקים', 'Laser 2 games', 120.00, 2),
      (p_branch_id, 'laser_3', 'Laser 3 parties', 'לייזר 3 משחקים', 'Laser 3 games', 150.00, 3),
      (p_branch_id, 'laser_4', 'Laser 4 parties', 'לייזר 4 משחקים', 'Laser 4 games', 180.00, 4),
      (p_branch_id, 'active_30', 'Active 30min', 'אקטיב 30 דק', 'Active 30min', 50.00, 10),
      (p_branch_id, 'active_60', 'Active 1h', 'אקטיב שעה', 'Active 1h', 100.00, 11),
      (p_branch_id, 'active_90', 'Active 1h30', 'אקטיב שעה וחצי', 'Active 1h30', 140.00, 12),
      (p_branch_id, 'active_120', 'Active 2h', 'אקטיב שעתיים', 'Active 2h', 180.00, 13);
  END IF;
  
  -- Salles
  IF NOT EXISTS (SELECT 1 FROM icount_rooms WHERE branch_id = p_branch_id) THEN
    INSERT INTO icount_rooms (branch_id, code, name, name_he, name_en, price, sort_order) VALUES
      (p_branch_id, 'room_1', 'Salle 1', 'חדר 1', 'Room 1', 400.00, 1),
      (p_branch_id, 'room_2', 'Salle 2', 'חדר 2', 'Room 2', 500.00, 2);
  END IF;
END;
$$;


ALTER FUNCTION public.seed_icount_data_for_branch(p_branch_id uuid) OWNER TO postgres;

--
-- Name: seed_icount_products_for_branch(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.seed_icount_products_for_branch(p_branch_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Only insert if branch doesn't have products yet
  IF NOT EXISTS (SELECT 1 FROM icount_products WHERE branch_id = p_branch_id) THEN
    INSERT INTO icount_products (branch_id, code, name, name_he, unit_price, is_per_person, sort_order) VALUES
      (p_branch_id, 'laser_1p', '1 Partie Laser', 'משחק לייזר אחד', 70.00, false, 1),
      (p_branch_id, 'laser_2p', '2 Parties Laser', 'שני משחקי לייזר', 120.00, false, 2),
      (p_branch_id, 'laser_3p', '3 Parties Laser', 'שלושה משחקי לייזר', 150.00, false, 3),
      (p_branch_id, 'active_1h', '1h Active Game', 'שעה משחק אקטיבי', 100.00, true, 10),
      (p_branch_id, 'event_15_29', 'Événement (15-29 pers.)', 'אירוע (15-29 משתתפים)', 130.00, true, 20),
      (p_branch_id, 'event_30_plus', 'Événement (30+ pers.)', 'אירוע (30+ משתתפים)', 120.00, true, 21);
  END IF;
END;
$$;


ALTER FUNCTION public.seed_icount_products_for_branch(p_branch_id uuid) OWNER TO postgres;

--
-- Name: trigger_seed_icount_products(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_seed_icount_products() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  PERFORM seed_icount_products_for_branch(NEW.id);
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_seed_icount_products() OWNER TO postgres;

--
-- Name: update_ai_conversation_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_ai_conversation_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE ai_conversations SET updated_at = NOW() WHERE id = NEW.conversation_id;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_ai_conversation_timestamp() OWNER TO postgres;

--
-- Name: update_email_templates_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_email_templates_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_email_templates_updated_at() OWNER TO postgres;

--
-- Name: update_orders_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_orders_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_orders_updated_at() OWNER TO postgres;

--
-- Name: update_payment_credentials_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_payment_credentials_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_payment_credentials_updated_at() OWNER TO postgres;

--
-- Name: update_payments_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_payments_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_payments_updated_at() OWNER TO postgres;

--
-- Name: update_roles_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_roles_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_roles_updated_at() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    user_role text NOT NULL,
    user_name text NOT NULL,
    action_type text NOT NULL,
    target_type text,
    target_id uuid,
    target_name text,
    branch_id uuid,
    details jsonb DEFAULT '{}'::jsonb,
    ip_address text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT activity_logs_action_type_check CHECK ((action_type = ANY (ARRAY['booking_created'::text, 'booking_updated'::text, 'booking_confirmed'::text, 'booking_cancelled'::text, 'booking_deleted'::text, 'order_created'::text, 'order_updated'::text, 'order_confirmed'::text, 'order_cancelled'::text, 'order_deleted'::text, 'contact_created'::text, 'contact_updated'::text, 'contact_archived'::text, 'contact_deleted'::text, 'contact_synced_icount'::text, 'user_created'::text, 'user_updated'::text, 'user_deleted'::text, 'user_login'::text, 'user_logout'::text, 'permission_changed'::text, 'settings_updated'::text, 'log_deleted'::text, 'email_sent'::text, 'email_failed'::text, 'email_resent'::text]))),
    CONSTRAINT activity_logs_target_type_check CHECK ((target_type = ANY (ARRAY['booking'::text, 'order'::text, 'contact'::text, 'user'::text, 'branch'::text, 'settings'::text, 'log'::text, 'email'::text]))),
    CONSTRAINT activity_logs_user_role_check CHECK ((user_role = ANY (ARRAY['super_admin'::text, 'branch_admin'::text, 'agent'::text, 'admin'::text, 'manager'::text, 'employee'::text, 'system'::text, 'website'::text])))
);


ALTER TABLE public.activity_logs OWNER TO postgres;

--
-- Name: TABLE activity_logs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.activity_logs IS 'Activity logs for auditing all user actions. Retention: 1 year.';


--
-- Name: ai_conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_conversations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.ai_conversations OWNER TO postgres;

--
-- Name: ai_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    role text NOT NULL,
    content text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ai_messages_role_check CHECK ((role = ANY (ARRAY['user'::text, 'assistant'::text])))
);


ALTER TABLE public.ai_messages OWNER TO postgres;

--
-- Name: booking_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_contacts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    booking_id uuid NOT NULL,
    contact_id uuid NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    role text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.booking_contacts OWNER TO postgres;

--
-- Name: TABLE booking_contacts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.booking_contacts IS 'Table de liaison many-to-many entre bookings et contacts';


--
-- Name: COLUMN booking_contacts.is_primary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.booking_contacts.is_primary IS 'True pour le contact principal du booking (un seul par booking)';


--
-- Name: COLUMN booking_contacts.role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.booking_contacts.role IS 'Rôle optionnel (payer, parent2, organizer) - utilisé en v1.1';


--
-- Name: booking_slots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_slots (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    booking_id uuid,
    branch_id uuid,
    slot_start timestamp with time zone NOT NULL,
    slot_end timestamp with time zone NOT NULL,
    participants_count integer DEFAULT 1 NOT NULL,
    slot_type text DEFAULT 'game_zone'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.booking_slots OWNER TO postgres;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    type text NOT NULL,
    status text DEFAULT 'CONFIRMED'::text NOT NULL,
    start_datetime timestamp with time zone NOT NULL,
    end_datetime timestamp with time zone NOT NULL,
    game_start_datetime timestamp with time zone,
    game_end_datetime timestamp with time zone,
    participants_count integer DEFAULT 1 NOT NULL,
    event_room_id uuid,
    customer_first_name text NOT NULL,
    customer_last_name text NOT NULL,
    customer_phone text NOT NULL,
    customer_email text,
    customer_notes_at_booking text,
    reference_code text NOT NULL,
    total_price numeric(10,2),
    notes text,
    color text,
    primary_contact_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    cancelled_at timestamp with time zone,
    cancelled_reason text,
    icount_offer_id integer,
    icount_invrec_id integer,
    discount_type character varying(10),
    discount_value numeric(10,2),
    icount_offer_url text,
    CONSTRAINT bookings_status_check CHECK ((status = ANY (ARRAY['DRAFT'::text, 'CONFIRMED'::text, 'CANCELLED'::text]))),
    CONSTRAINT bookings_type_check CHECK ((type = ANY (ARRAY['GAME'::text, 'EVENT'::text])))
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: COLUMN bookings.customer_notes_at_booking; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.customer_notes_at_booking IS 'Snapshot des notes client au moment de la réservation (pour historique)';


--
-- Name: COLUMN bookings.primary_contact_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.primary_contact_id IS 'ID du contact principal (pour backward compatibility, déduit aussi de booking_contacts)';


--
-- Name: COLUMN bookings.icount_offer_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.icount_offer_id IS 'iCount offer (quote) document ID';


--
-- Name: COLUMN bookings.icount_invrec_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.icount_invrec_id IS 'iCount invoice+receipt combined document ID';


--
-- Name: COLUMN bookings.icount_offer_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bookings.icount_offer_url IS 'URL to view the iCount offer document online';


--
-- Name: branch_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    max_concurrent_players integer DEFAULT 84 NOT NULL,
    slot_duration_minutes integer DEFAULT 15 NOT NULL,
    game_duration_minutes integer DEFAULT 60 NOT NULL,
    event_total_duration_minutes integer DEFAULT 120 NOT NULL,
    event_game_duration_minutes integer DEFAULT 60 NOT NULL,
    event_buffer_before_minutes integer DEFAULT 15 NOT NULL,
    event_buffer_after_minutes integer DEFAULT 15 NOT NULL,
    event_min_participants integer DEFAULT 1 NOT NULL,
    game_price_per_person numeric(10,2) DEFAULT 0 NOT NULL,
    bracelet_price numeric(10,2) DEFAULT 0 NOT NULL,
    event_price_15_29 numeric(10,2) DEFAULT 0 NOT NULL,
    event_price_30_plus numeric(10,2) DEFAULT 0 NOT NULL,
    opening_hours jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    total_slots integer DEFAULT 14,
    max_players_per_slot integer DEFAULT 6,
    laser_total_vests integer DEFAULT 0,
    laser_enabled boolean DEFAULT false,
    icount_auto_send_quote boolean DEFAULT true,
    CONSTRAINT check_max_players_per_slot_positive CHECK ((max_players_per_slot > 0)),
    CONSTRAINT check_total_slots_positive CHECK ((total_slots > 0))
);


ALTER TABLE public.branch_settings OWNER TO postgres;

--
-- Name: COLUMN branch_settings.laser_total_vests; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.branch_settings.laser_total_vests IS 'Contrainte HARD : nombre maximum de vestes disponibles (pas d''override possible)';


--
-- Name: COLUMN branch_settings.laser_enabled; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.branch_settings.laser_enabled IS 'Active/désactive le support Laser pour cette branche';


--
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    name_en text,
    address text NOT NULL,
    phone text,
    phone_extension text,
    timezone text DEFAULT 'Europe/Paris'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.branches OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id_main uuid NOT NULL,
    first_name text NOT NULL,
    last_name text,
    phone text NOT NULL,
    email text,
    notes_client text,
    alias text,
    status text DEFAULT 'active'::text NOT NULL,
    source text DEFAULT 'admin_agenda'::text,
    archived_at timestamp with time zone,
    archived_reason text,
    deleted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid,
    client_type character varying(20) DEFAULT 'individual'::character varying,
    company_name character varying(255),
    vat_id character varying(50),
    icount_client_id integer,
    preferred_locale character varying(5) DEFAULT 'he'::character varying NOT NULL,
    icount_cc_token_id integer,
    cc_last4 character varying(4),
    cc_type character varying(50),
    cc_validity character varying(10),
    cc_holder_name character varying(255),
    cc_expiry character varying(10),
    CONSTRAINT contacts_client_type_check CHECK (((client_type)::text = ANY ((ARRAY['individual'::character varying, 'company'::character varying])::text[]))),
    CONSTRAINT contacts_source_check CHECK ((source = ANY (ARRAY['admin_agenda'::text, 'public_booking'::text, 'website'::text]))),
    CONSTRAINT contacts_status_check CHECK ((status = ANY (ARRAY['active'::text, 'archived'::text])))
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: TABLE contacts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contacts IS 'Table des contacts clients (CRM). Un contact appartient à une branche principale.';


--
-- Name: COLUMN contacts.branch_id_main; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.branch_id_main IS 'Branche principale du contact (partage multi-branches hors scope v1)';


--
-- Name: COLUMN contacts.notes_client; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.notes_client IS 'Notes globales du client (allergies, préférences) - différentes des notes booking';


--
-- Name: COLUMN contacts.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.status IS 'Statut: active (visible, modifiable) ou archived (caché par défaut, lecture seule)';


--
-- Name: COLUMN contacts.client_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.client_type IS 'individual or company';


--
-- Name: COLUMN contacts.company_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.company_name IS 'Company name (only for client_type=company)';


--
-- Name: COLUMN contacts.vat_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.vat_id IS 'VAT ID / ח.פ / עוסק מורשה (required for companies)';


--
-- Name: COLUMN contacts.icount_client_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contacts.icount_client_id IS 'iCount client ID for sync';


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipient_email text NOT NULL,
    recipient_name text,
    template_id uuid,
    template_code text,
    subject text NOT NULL,
    body_preview text,
    entity_type text,
    entity_id uuid,
    branch_id uuid,
    attachments jsonb DEFAULT '[]'::jsonb,
    status text DEFAULT 'pending'::text NOT NULL,
    error_message text,
    metadata jsonb DEFAULT '{}'::jsonb,
    sent_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    triggered_by uuid,
    body_html text,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.email_logs OWNER TO postgres;

--
-- Name: email_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    smtp_user text,
    smtp_password text,
    smtp_host text DEFAULT 'smtp.gmail.com'::text,
    smtp_port integer DEFAULT 587,
    from_email text,
    from_name text DEFAULT 'ActiveGames'::text,
    logo_activegames_url text,
    logo_lasercity_url text,
    is_enabled boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.email_settings OWNER TO postgres;

--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    description text,
    subject_template text NOT NULL,
    body_template text NOT NULL,
    is_active boolean DEFAULT true,
    is_system boolean DEFAULT false,
    branch_id uuid,
    available_variables jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    created_by uuid
);


ALTER TABLE public.email_templates OWNER TO postgres;

--
-- Name: event_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    slug text NOT NULL,
    name text NOT NULL,
    name_en text,
    capacity integer NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.event_rooms OWNER TO postgres;

--
-- Name: game_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    booking_id uuid NOT NULL,
    game_area text NOT NULL,
    start_datetime timestamp with time zone NOT NULL,
    end_datetime timestamp with time zone NOT NULL,
    laser_room_id uuid,
    session_order integer DEFAULT 1 NOT NULL,
    pause_before_minutes integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT check_end_after_start CHECK ((end_datetime > start_datetime)),
    CONSTRAINT game_sessions_game_area_check CHECK ((game_area = ANY (ARRAY['ACTIVE'::text, 'LASER'::text])))
);


ALTER TABLE public.game_sessions OWNER TO postgres;

--
-- Name: COLUMN game_sessions.game_area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_sessions.game_area IS 'Zone de jeu : ACTIVE (slots) ou LASER (salles laser)';


--
-- Name: COLUMN game_sessions.laser_room_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_sessions.laser_room_id IS 'Référence à la salle laser si game_area = LASER, NULL sinon';


--
-- Name: COLUMN game_sessions.pause_before_minutes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.game_sessions.pause_before_minutes IS 'Pause avant cette session (pour EVENT avec gap entre sessions)';


--
-- Name: icount_event_formulas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icount_event_formulas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    name character varying(100) NOT NULL,
    game_type character varying(20) NOT NULL,
    min_participants integer NOT NULL,
    max_participants integer DEFAULT 999,
    price_per_person numeric(10,2) NOT NULL,
    room_id uuid,
    is_active boolean DEFAULT true,
    priority integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    product_id uuid
);


ALTER TABLE public.icount_event_formulas OWNER TO postgres;

--
-- Name: icount_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icount_products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    name_he character varying(100),
    description text,
    unit_price numeric(10,2) NOT NULL,
    is_active boolean DEFAULT true,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    name_en character varying(100),
    icount_item_id integer,
    icount_itemcode character varying(50),
    icount_synced_at timestamp with time zone
);


ALTER TABLE public.icount_products OWNER TO postgres;

--
-- Name: TABLE icount_products; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.icount_products IS 'Product/service catalog for iCount document generation. Each branch has its own prices.';


--
-- Name: COLUMN icount_products.code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.icount_products.code IS 'Unique product code per branch: laser_1p, laser_2p, active_1h, event_15_29, etc.';


--
-- Name: icount_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icount_rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    name_he character varying(100),
    name_en character varying(100),
    price numeric(10,2) NOT NULL,
    is_active boolean DEFAULT true,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    icount_item_id integer,
    icount_itemcode character varying(50),
    icount_synced_at timestamp with time zone
);


ALTER TABLE public.icount_rooms OWNER TO postgres;

--
-- Name: laser_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laser_rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    slug text NOT NULL,
    name text NOT NULL,
    name_en text,
    capacity integer NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.laser_rooms OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid,
    order_type character varying(10) NOT NULL,
    status public.order_status DEFAULT 'pending'::public.order_status NOT NULL,
    booking_id uuid,
    contact_id uuid,
    request_reference character varying(20) NOT NULL,
    customer_first_name character varying(100) NOT NULL,
    customer_last_name character varying(100),
    customer_phone character varying(30) NOT NULL,
    customer_email character varying(255),
    customer_notes text,
    requested_date date NOT NULL,
    requested_time time without time zone NOT NULL,
    participants_count integer NOT NULL,
    game_area character varying(10),
    number_of_games integer DEFAULT 1,
    event_type character varying(50),
    event_celebrant_age integer,
    pending_reason public.pending_reason,
    pending_details text,
    terms_accepted boolean DEFAULT false NOT NULL,
    terms_accepted_at timestamp with time zone,
    processed_at timestamp with time zone,
    processed_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    source text DEFAULT 'website'::text,
    cgv_token character varying(64),
    cgv_validated_at timestamp with time zone,
    cgv_reminder_sent_at timestamp with time zone,
    cgv_reminder_count integer DEFAULT 0,
    payment_status public.payment_status DEFAULT 'pending'::public.payment_status,
    total_amount numeric(10,2),
    deposit_amount numeric(10,2),
    paid_amount numeric(10,2) DEFAULT 0,
    currency character varying(3) DEFAULT 'ILS'::character varying,
    icount_transaction_id character varying(100),
    icount_confirmation_code character varying(100),
    preauth_code character varying(100),
    cc_last4 character varying(4),
    cc_type character varying(50),
    payment_method character varying(50),
    payment_notes text,
    paid_at timestamp with time zone,
    payment_deadline timestamp with time zone,
    preauth_amount numeric(10,2),
    preauth_cc_last4 character varying(4),
    preauth_cc_type character varying(50),
    preauth_created_at timestamp with time zone,
    preauth_created_by uuid,
    preauth_cancelled_at timestamp with time zone,
    preauth_cancelled_by uuid,
    preauth_used_at timestamp with time zone,
    preauth_used_by uuid,
    closed_at timestamp with time zone,
    closed_by uuid,
    icount_invrec_id integer,
    icount_invrec_url text,
    CONSTRAINT orders_game_area_check CHECK (((game_area)::text = ANY ((ARRAY['ACTIVE'::character varying, 'LASER'::character varying, NULL::character varying])::text[]))),
    CONSTRAINT orders_order_type_check CHECK (((order_type)::text = ANY ((ARRAY['GAME'::character varying, 'EVENT'::character varying])::text[]))),
    CONSTRAINT orders_participants_count_check CHECK ((participants_count > 0))
);

ALTER TABLE ONLY public.orders REPLICA IDENTITY FULL;


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: COLUMN orders.payment_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.payment_status IS 'Current payment status of the order';


--
-- Name: COLUMN orders.total_amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.total_amount IS 'Total amount to be paid for the order';


--
-- Name: COLUMN orders.deposit_amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.deposit_amount IS 'Required deposit amount';


--
-- Name: COLUMN orders.paid_amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.paid_amount IS 'Amount already paid';


--
-- Name: COLUMN orders.preauth_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_code IS 'J5 preauthorization confirmation code';


--
-- Name: COLUMN orders.payment_deadline; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.payment_deadline IS 'Deadline for payment before auto-cancellation';


--
-- Name: COLUMN orders.preauth_amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_amount IS 'Amount preauthorized on the card';


--
-- Name: COLUMN orders.preauth_cc_last4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_cc_last4 IS 'Last 4 digits of preauthorized card';


--
-- Name: COLUMN orders.preauth_cc_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_cc_type IS 'Type of preauthorized card (Visa, MasterCard, etc)';


--
-- Name: COLUMN orders.preauth_created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_created_at IS 'When the preauthorization was created';


--
-- Name: COLUMN orders.preauth_created_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_created_by IS 'Who created the preauthorization';


--
-- Name: COLUMN orders.preauth_cancelled_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_cancelled_at IS 'When the preauthorization was cancelled';


--
-- Name: COLUMN orders.preauth_used_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.preauth_used_at IS 'When the preauthorization was used for payment';


--
-- Name: COLUMN orders.closed_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.closed_at IS 'Timestamp when order was closed (finalized with invoice)';


--
-- Name: COLUMN orders.closed_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.closed_by IS 'User who closed the order';


--
-- Name: COLUMN orders.icount_invrec_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.icount_invrec_id IS 'iCount invoice+receipt combined document ID (created at close)';


--
-- Name: COLUMN orders.icount_invrec_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.icount_invrec_url IS 'URL to view the iCount invoice+receipt document';


--
-- Name: payment_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    branch_id uuid NOT NULL,
    provider character varying(50) DEFAULT 'icount'::character varying NOT NULL,
    cid character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    is_active boolean DEFAULT true,
    last_connection_test timestamp with time zone,
    last_connection_status boolean,
    last_connection_error text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.payment_credentials OWNER TO postgres;

--
-- Name: TABLE payment_credentials; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.payment_credentials IS 'Stores payment provider API credentials per branch';


--
-- Name: COLUMN payment_credentials.cid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payment_credentials.cid IS 'iCount Company ID';


--
-- Name: COLUMN payment_credentials.username; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payment_credentials.username IS 'iCount API username (email)';


--
-- Name: COLUMN payment_credentials.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payment_credentials.password IS 'iCount API password';


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_id uuid,
    booking_id uuid,
    contact_id uuid,
    branch_id uuid NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency character varying(3) DEFAULT 'ILS'::character varying,
    payment_type character varying(50) NOT NULL,
    payment_method character varying(50) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    icount_transaction_id character varying(100),
    icount_confirmation_code character varying(100),
    icount_document_id character varying(100),
    icount_document_type character varying(50),
    cc_last4 character varying(4),
    cc_type character varying(50),
    check_number character varying(50),
    check_bank character varying(100),
    check_date date,
    transfer_reference character varying(100),
    notes text,
    processed_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    icount_doctype character varying(20),
    icount_docnum integer,
    icount_doc_url text
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: TABLE payments; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.payments IS 'Payment history and transactions for orders';


--
-- Name: COLUMN payments.payment_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payments.payment_type IS 'Type: full, deposit, balance, or refund';


--
-- Name: COLUMN payments.payment_method; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payments.payment_method IS 'Method: card, cash, transfer, or check';


--
-- Name: COLUMN payments.icount_doctype; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payments.icount_doctype IS 'Type de document iCount (invrec, receipt, etc.)';


--
-- Name: COLUMN payments.icount_docnum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payments.icount_docnum IS 'Numéro du document iCount';


--
-- Name: COLUMN payments.icount_doc_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.payments.icount_doc_url IS 'URL du document iCount (PDF)';


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    role text DEFAULT 'agent'::text NOT NULL,
    full_name text,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(20),
    created_by uuid,
    role_id uuid
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: COLUMN profiles.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.first_name IS 'Prénom de l''utilisateur (obligatoire)';


--
-- Name: COLUMN profiles.last_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.last_name IS 'Nom de famille de l''utilisateur (obligatoire)';


--
-- Name: COLUMN profiles.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.phone IS 'Numéro de téléphone israélien format 05XXXXXXXX';


--
-- Name: COLUMN profiles.created_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.created_by IS 'ID de l''utilisateur ayant créé ce compte (NULL pour super_admin initial)';


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    role text NOT NULL,
    resource text NOT NULL,
    can_view boolean DEFAULT false NOT NULL,
    can_create boolean DEFAULT false NOT NULL,
    can_edit boolean DEFAULT false NOT NULL,
    can_delete boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    role_id uuid,
    CONSTRAINT role_permissions_resource_check CHECK ((resource = ANY (ARRAY['agenda'::text, 'orders'::text, 'clients'::text, 'users'::text, 'logs'::text, 'settings'::text, 'permissions'::text])))
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: TABLE role_permissions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.role_permissions IS 'Granular permission settings for each role and resource combination.';


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(50) NOT NULL,
    display_name character varying(100) NOT NULL,
    description text,
    level integer NOT NULL,
    color character varying(7) DEFAULT '#3B82F6'::character varying,
    icon character varying(50) DEFAULT 'User'::character varying,
    is_system boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT roles_level_check CHECK (((level >= 1) AND (level <= 10)))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: user_branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_branches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    branch_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_branches OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_01_18; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_18 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_18 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_19; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_19 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_19 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_20 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_20 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_21 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_21 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_22 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_22 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_23 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_23 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_24 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_24 OWNER TO supabase_admin;

--
-- Name: messages_2026_01_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_01_25 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_01_25 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text,
    rollback text[]
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2026_01_18; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_18 FOR VALUES FROM ('2026-01-18 00:00:00') TO ('2026-01-19 00:00:00');


--
-- Name: messages_2026_01_19; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00') TO ('2026-01-20 00:00:00');


--
-- Name: messages_2026_01_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_20 FOR VALUES FROM ('2026-01-20 00:00:00') TO ('2026-01-21 00:00:00');


--
-- Name: messages_2026_01_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_21 FOR VALUES FROM ('2026-01-21 00:00:00') TO ('2026-01-22 00:00:00');


--
-- Name: messages_2026_01_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_22 FOR VALUES FROM ('2026-01-22 00:00:00') TO ('2026-01-23 00:00:00');


--
-- Name: messages_2026_01_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_23 FOR VALUES FROM ('2026-01-23 00:00:00') TO ('2026-01-24 00:00:00');


--
-- Name: messages_2026_01_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_24 FOR VALUES FROM ('2026-01-24 00:00:00') TO ('2026-01-25 00:00:00');


--
-- Name: messages_2026_01_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_01_25 FOR VALUES FROM ('2026-01-25 00:00:00') TO ('2026-01-26 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
245b421c-3bb5-4ee3-9f6b-10d367e0ce08	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	{"sub": "245b421c-3bb5-4ee3-9f6b-10d367e0ce08", "email": "jeremymalai@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-01-14 22:38:58.281428+00	2026-01-14 22:38:58.282524+00	2026-01-14 22:38:58.282524+00	20494eec-44be-4655-b4ff-0c6a9e636fb0
94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	{"sub": "94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b", "email": "anaelle@al.com", "email_verified": false, "phone_verified": false}	email	2026-01-17 16:06:58.301896+00	2026-01-17 16:06:58.301955+00	2026-01-17 16:06:58.301955+00	383a5cd7-7bc4-42ee-9715-add931e3229a
4d3e330e-07ca-470b-8d47-b9f5a9123d9b	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	{"sub": "4d3e330e-07ca-470b-8d47-b9f5a9123d9b", "email": "shimi@activegames.co.il", "email_verified": false, "phone_verified": false}	email	2026-01-17 14:27:31.522233+00	2026-01-17 14:27:31.522302+00	2026-01-17 14:27:31.522302+00	deada7ba-c8c4-4bb3-a981-20b3885020eb
1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	{"sub": "1b4dccaf-9daa-4ffd-91f0-fe95abe9884d", "email": "viewer@activegames.co.il", "email_verified": false, "phone_verified": false}	email	2026-01-20 17:40:11.616224+00	2026-01-20 17:40:11.616276+00	2026-01-20 17:40:11.616276+00	d446cff2-c8bb-47b2-b73a-67c4609a3902
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
a32bfdad-e7bd-4d30-8044-dfadc6e87446	2026-01-17 16:35:39.193326+00	2026-01-17 16:35:39.193326+00	password	816c1760-c359-40bd-9133-822f88b86ca7
c394da79-6faa-49d0-aa77-99c897596750	2026-01-18 00:18:38.361275+00	2026-01-18 00:18:38.361275+00	password	207806c7-c3be-42f4-a953-a015cdb29828
42b9170f-98a4-4d0a-be1d-66ff39bd0c00	2026-01-18 09:48:16.750011+00	2026-01-18 09:48:16.750011+00	password	ce134f80-92f6-4bdc-970c-ad1d5dc37319
156f484c-9b90-4bfa-9310-3e6b9a4844de	2026-01-22 08:38:09.933314+00	2026-01-22 08:38:09.933314+00	password	37bdf497-7134-44ff-87ea-104e29e0b8f5
9182b0e0-f6c9-49db-85e7-14af7a2286b3	2026-01-18 14:44:46.108464+00	2026-01-18 14:44:46.108464+00	password	ce1caf81-6d93-4af7-ba0f-6575a0ee2733
add98aa0-06bf-465d-adc2-198975afc541	2026-01-21 13:55:09.249804+00	2026-01-21 13:55:09.249804+00	password	7cb1cea4-743e-435b-b6da-f6852f204169
189b69a2-23f1-4510-9d6b-c9903c299fd7	2026-01-20 18:01:12.265573+00	2026-01-20 18:01:12.265573+00	password	e54f49aa-4575-4909-b92b-036ae4461d1c
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	222	ogamejnjabjp	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:35:19.26436+00	2026-01-19 09:40:45.14996+00	mz4qbgl23nsh	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	131	ojiep2gqdxm2	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 09:48:16.747759+00	2026-01-18 09:56:21.645871+00	\N	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	135	d45v4sypw7my	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:16:11.139383+00	2026-01-18 10:21:11.142457+00	irwetkz5y5aw	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	223	6b76iqqcph3k	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:40:45.15125+00	2026-01-19 09:45:44.782183+00	ogamejnjabjp	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	138	tuu3yftwelh3	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:31:11.087302+00	2026-01-18 10:36:57.183086+00	3mn3likdggeb	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	228	p4dgxnrim6bt	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 10:02:40.934637+00	2026-01-19 11:02:32.52422+00	q36hgrsfkfrv	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	794	tudgr3srazzy	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	f	2026-01-21 07:45:31.371398+00	2026-01-21 07:45:31.371398+00	llknsvubvdug	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	142	owfijois5bca	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 11:16:51.340566+00	2026-01-18 12:47:19.058801+00	5z5wam6qkyla	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	231	xi5blfy2n2ur	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 13:07:16.312138+00	2026-01-19 14:14:15.487729+00	4jemumaxbyc7	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	716	6rq7qkyztbsa	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 03:14:24.779443+00	2026-01-21 05:27:15.914281+00	qf5kqqeixwed	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	157	dubcdmbd6z7k	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 16:03:31.596368+00	2026-01-18 17:10:51.621531+00	qzcttmawuzw2	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	830	f2k2sfoto5lu	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:20:05.616998+00	2026-01-21 14:21:11.006344+00	nkdqlysnnrvu	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	163	h45o6qhdsv5j	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 19:42:13.530627+00	2026-01-18 21:24:45.624027+00	wtl3nowqduvx	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	154	da2itxxgmbkk	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 14:44:46.082103+00	2026-01-19 02:48:19.694749+00	\N	9182b0e0-f6c9-49db-85e7-14af7a2286b3
00000000-0000-0000-0000-000000000000	195	hag4lygc66jq	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 03:16:34.790762+00	2026-01-19 05:28:18.857505+00	xtihresigohz	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	199	g5w4erj3zk2i	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 05:28:18.858966+00	2026-01-19 06:33:53.60938+00	hag4lygc66jq	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	209	h6ekhlpuvnvm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:40:19.20547+00	2026-01-19 08:45:19.349755+00	tidl675q2foj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	213	4pco4red4hph	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:00:19.164345+00	2026-01-19 09:05:19.624056+00	qbdvu6mfogrx	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	219	acxqjczqnsnw	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:20:19.039876+00	2026-01-19 09:25:19.216641+00	sqcp42puygfs	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	276	reel4yfvvomi	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 16:47:55.260216+00	2026-01-19 18:22:54.251054+00	wqzrzvzzbljq	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	132	znlgdol3kxja	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 09:56:21.652963+00	2026-01-18 10:01:21.39376+00	ojiep2gqdxm2	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	224	zhypd6wz3xm5	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:45:44.790398+00	2026-01-19 09:51:43.86908+00	6b76iqqcph3k	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	136	q6qq2c4kizcy	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:21:11.144255+00	2026-01-18 10:26:11.313752+00	d45v4sypw7my	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	229	qvpsn5v3o7wn	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 11:02:32.532436+00	2026-01-19 12:01:46.100394+00	p4dgxnrim6bt	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	140	xgbljyzxvtno	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:36:57.184087+00	2026-01-18 10:41:57.48045+00	tuu3yftwelh3	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	831	adwxmmzvmvjw	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:21:11.007151+00	2026-01-21 14:22:05.455295+00	f2k2sfoto5lu	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	152	iwkvywylsaiy	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	f	2026-01-18 14:35:37.659991+00	2026-01-18 14:35:37.659991+00	e5z7susw6zcr	c394da79-6faa-49d0-aa77-99c897596750
00000000-0000-0000-0000-000000000000	832	gfn62b2zggwk	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:22:05.456303+00	2026-01-21 14:27:47.938479+00	adwxmmzvmvjw	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	161	wtl3nowqduvx	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 18:50:48.062858+00	2026-01-18 19:42:13.512508+00	twj3ywtyg4rv	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	203	bq3owtldwy6i	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 07:27:13.836878+00	2026-01-19 08:27:03.811639+00	twigk2yi54do	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	206	tybqjwwzorqp	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:27:03.820976+00	2026-01-19 08:29:03.040855+00	bq3owtldwy6i	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	207	ivjddez4emg5	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:29:03.042542+00	2026-01-19 08:34:03.178318+00	tybqjwwzorqp	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	210	ndz7bqm7mm6f	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:45:19.356034+00	2026-01-19 08:50:19.212948+00	h6ekhlpuvnvm	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	211	kl44hi34pfof	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:50:19.214744+00	2026-01-19 08:55:19.205286+00	ndz7bqm7mm6f	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	214	jwjv322fzmsx	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:05:19.642967+00	2026-01-19 09:10:19.1554+00	4pco4red4hph	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	217	sqcp42puygfs	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:15:19.109235+00	2026-01-19 09:20:19.038768+00	cv2ijk2jvgk6	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	220	rs4ciqi4mlds	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:25:19.225127+00	2026-01-19 09:30:19.210761+00	acxqjczqnsnw	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	236	wqzrzvzzbljq	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 15:29:33.806214+00	2026-01-19 16:47:55.25772+00	kmagiknjkw7g	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	114	lzxyivfthaha	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	f	2026-01-17 16:35:39.184767+00	2026-01-17 16:35:39.184767+00	\N	a32bfdad-e7bd-4d30-8044-dfadc6e87446
00000000-0000-0000-0000-000000000000	225	y3nqxqqetq7b	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:51:43.871803+00	2026-01-19 09:52:40.176137+00	zhypd6wz3xm5	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	134	irwetkz5y5aw	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:01:21.395608+00	2026-01-18 10:16:11.130064+00	znlgdol3kxja	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	137	3mn3likdggeb	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:26:11.324246+00	2026-01-18 10:31:11.085947+00	q6qq2c4kizcy	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	226	tl6c2yj7ewcm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:52:40.177189+00	2026-01-19 09:53:48.973563+00	y3nqxqqetq7b	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	141	5z5wam6qkyla	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 10:41:57.483129+00	2026-01-18 11:16:51.325546+00	xgbljyzxvtno	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	833	ark6mmiaefhw	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:27:47.943644+00	2026-01-21 14:32:05.434207+00	gfn62b2zggwk	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	227	q36hgrsfkfrv	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:53:48.974015+00	2026-01-19 10:02:40.930162+00	tl6c2yj7ewcm	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	147	t5bzjee6sjpj	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 12:47:19.068813+00	2026-01-18 14:08:10.02355+00	owfijois5bca	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	128	e5z7susw6zcr	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 00:18:38.345056+00	2026-01-18 14:35:37.659223+00	\N	c394da79-6faa-49d0-aa77-99c897596750
00000000-0000-0000-0000-000000000000	150	yl6wuja5hj5f	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 14:08:10.040663+00	2026-01-18 14:39:37.657732+00	t5bzjee6sjpj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	230	4jemumaxbyc7	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 12:01:46.126703+00	2026-01-19 13:07:16.297195+00	qvpsn5v3o7wn	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	595	73fxbvr4rjwt	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 20:31:47.052788+00	2026-01-20 22:46:21.014469+00	wkybbtybapp2	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	234	kmagiknjkw7g	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 14:14:15.491481+00	2026-01-19 15:29:33.79146+00	xi5blfy2n2ur	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	153	qzcttmawuzw2	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 14:39:37.659132+00	2026-01-18 16:03:31.589703+00	yl6wuja5hj5f	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	159	twj3ywtyg4rv	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 17:10:51.633989+00	2026-01-18 18:50:48.051323+00	dubcdmbd6z7k	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	171	whrumsgjg6cm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 21:24:45.627318+00	2026-01-18 22:57:11.043562+00	h45o6qhdsv5j	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	181	wz232fkqrtwf	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 01:07:59.647393+00	2026-01-19 01:07:59.893451+00	riyalyywrxfj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	182	wyi2zenrpbek	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	f	2026-01-19 01:07:59.894091+00	2026-01-19 01:07:59.894091+00	wz232fkqrtwf	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	175	riyalyywrxfj	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-18 22:57:11.059123+00	2026-01-19 01:07:59.918483+00	whrumsgjg6cm	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	194	gztbgtqkuj62	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	f	2026-01-19 02:48:19.71709+00	2026-01-19 02:48:19.71709+00	da2itxxgmbkk	9182b0e0-f6c9-49db-85e7-14af7a2286b3
00000000-0000-0000-0000-000000000000	183	xtihresigohz	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 01:07:59.918856+00	2026-01-19 03:16:34.772695+00	riyalyywrxfj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	201	twigk2yi54do	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 06:33:53.611457+00	2026-01-19 07:27:13.803206+00	g5w4erj3zk2i	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	208	tidl675q2foj	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:34:03.204531+00	2026-01-19 08:40:19.202165+00	ivjddez4emg5	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	212	qbdvu6mfogrx	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 08:55:19.212156+00	2026-01-19 09:00:19.161602+00	kl44hi34pfof	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	215	cv2ijk2jvgk6	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:10:19.158248+00	2026-01-19 09:15:19.10826+00	jwjv322fzmsx	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	221	mz4qbgl23nsh	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 09:30:19.213158+00	2026-01-19 09:35:19.248909+00	rs4ciqi4mlds	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	758	prthzbsiiyhk	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 05:27:15.9161+00	2026-01-21 06:46:13.479325+00	6rq7qkyztbsa	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	836	55bnfx7j732t	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:32:05.435882+00	2026-01-21 14:38:29.883843+00	ark6mmiaefhw	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	838	rywlwygabwjw	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:38:29.886394+00	2026-01-21 14:40:10.912733+00	55bnfx7j732t	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	839	bpwy5d7eyutm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:40:10.913133+00	2026-01-21 14:40:35.942883+00	rywlwygabwjw	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	840	z7u3muzsz4dm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:40:35.943283+00	2026-01-21 14:40:41.776279+00	bpwy5d7eyutm	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	841	5ko2stnrpdoc	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:40:41.776662+00	2026-01-21 14:43:04.303852+00	z7u3muzsz4dm	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	843	4u54evr4luck	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:43:04.33887+00	2026-01-21 14:45:43.2511+00	5ko2stnrpdoc	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	314	zimtd5xgxxty	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 18:22:54.254174+00	2026-01-19 20:19:43.669864+00	reel4yfvvomi	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	351	ygajialhgf6p	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 20:19:43.690432+00	2026-01-19 21:56:33.8335+00	zimtd5xgxxty	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	359	prmf2eiaoa2l	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 21:56:33.842926+00	2026-01-19 23:03:55.350351+00	ygajialhgf6p	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	379	67e7obrhnddj	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-19 23:03:55.351192+00	2026-01-20 00:51:58.894845+00	prmf2eiaoa2l	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	948	osyva7tpdug7	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	f	2026-01-22 08:38:09.887812+00	2026-01-22 08:38:09.887812+00	\N	156f484c-9b90-4bfa-9310-3e6b9a4844de
00000000-0000-0000-0000-000000000000	648	3tngkiihvqes	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 22:46:21.022984+00	2026-01-21 01:03:41.141643+00	73fxbvr4rjwt	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	844	xi4qoyxuqruk	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	f	2026-01-21 14:45:43.254403+00	2026-01-21 14:45:43.254403+00	4u54evr4luck	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	398	id3wrj3jnk7c	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 00:51:58.895209+00	2026-01-20 03:02:28.419742+00	67e7obrhnddj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	826	3vzifdrnn3ex	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 13:55:09.20527+00	2026-01-21 14:04:44.500804+00	\N	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	437	frhdul5xkbg6	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 03:02:28.444247+00	2026-01-20 04:48:15.984624+00	id3wrj3jnk7c	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	438	onst2jcv6zcd	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 04:48:16.009673+00	2026-01-20 06:17:26.668061+00	frhdul5xkbg6	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	439	3dvca2slipkn	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 06:17:26.678389+00	2026-01-20 07:41:49.838041+00	onst2jcv6zcd	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	440	eza6ohhnze7e	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 07:41:49.85777+00	2026-01-20 09:16:59.522645+00	3dvca2slipkn	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	443	peu4gip3wyxg	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 09:16:59.548158+00	2026-01-20 10:15:32.682263+00	eza6ohhnze7e	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	444	lhdv4m4odbxz	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 10:15:32.700909+00	2026-01-20 11:14:32.607738+00	peu4gip3wyxg	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	445	orzoqgy35ksj	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 11:14:32.632088+00	2026-01-20 12:15:03.702376+00	lhdv4m4odbxz	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	446	emwekaxws2ju	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 12:15:03.730068+00	2026-01-20 16:20:16.050572+00	orzoqgy35ksj	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	827	veh6bluaf6nm	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:04:44.51696+00	2026-01-21 14:14:44.308709+00	3vzifdrnn3ex	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	496	cfjuj2uu2gvx	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 16:20:16.060224+00	2026-01-20 16:20:16.292411+00	emwekaxws2ju	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	497	jxrtmp4wdxka	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 16:20:16.294059+00	2026-01-20 16:30:16.166695+00	cfjuj2uu2gvx	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	498	gji57yn5hmym	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 16:30:16.177888+00	2026-01-20 16:47:29.844383+00	jxrtmp4wdxka	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	527	vxpg73jtuq4f	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	t	2026-01-20 18:01:12.249921+00	2026-01-20 18:01:20.391294+00	\N	189b69a2-23f1-4510-9d6b-c9903c299fd7
00000000-0000-0000-0000-000000000000	528	3pt3ufra5y3u	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	f	2026-01-20 18:01:20.393139+00	2026-01-20 18:01:20.393139+00	vxpg73jtuq4f	189b69a2-23f1-4510-9d6b-c9903c299fd7
00000000-0000-0000-0000-000000000000	501	miozfwdwy725	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 16:47:29.846104+00	2026-01-20 18:12:35.949882+00	gji57yn5hmym	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	793	llknsvubvdug	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 06:46:13.48243+00	2026-01-21 07:45:31.339737+00	prthzbsiiyhk	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	670	qf5kqqeixwed	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 01:03:41.155606+00	2026-01-21 03:14:24.769751+00	3tngkiihvqes	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	828	nkdqlysnnrvu	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-21 14:14:44.319284+00	2026-01-21 14:20:05.615317+00	veh6bluaf6nm	add98aa0-06bf-465d-adc2-198975afc541
00000000-0000-0000-0000-000000000000	562	wkybbtybapp2	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 19:11:36.066637+00	2026-01-20 20:31:47.050331+00	j6znh6edbcad	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
00000000-0000-0000-0000-000000000000	537	j6znh6edbcad	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	t	2026-01-20 18:12:35.96052+00	2026-01-20 19:11:36.046312+00	miozfwdwy725	42b9170f-98a4-4d0a-be1d-66ff39bd0c00
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
add98aa0-06bf-465d-adc2-198975afc541	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	2026-01-21 13:55:09.165415+00	2026-01-21 14:45:43.27644+00	\N	aal1	\N	2026-01-21 14:45:43.276332	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	84.229.174.168	\N	\N	\N	\N	\N
c394da79-6faa-49d0-aa77-99c897596750	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	2026-01-18 00:18:38.333731+00	2026-01-18 14:35:37.664118+00	\N	aal1	\N	2026-01-18 14:35:37.664016	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	46.121.70.77	\N	\N	\N	\N	\N
42b9170f-98a4-4d0a-be1d-66ff39bd0c00	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	2026-01-18 09:48:16.744718+00	2026-01-21 07:45:31.409911+00	\N	aal1	\N	2026-01-21 07:45:31.409767	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	46.121.242.182	\N	\N	\N	\N	\N
a32bfdad-e7bd-4d30-8044-dfadc6e87446	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	2026-01-17 16:35:39.171483+00	2026-01-17 16:35:39.171483+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	46.121.70.77	\N	\N	\N	\N	\N
9182b0e0-f6c9-49db-85e7-14af7a2286b3	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	2026-01-18 14:44:46.04913+00	2026-01-19 02:48:19.750412+00	\N	aal1	\N	2026-01-19 02:48:19.749085	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	46.121.70.77	\N	\N	\N	\N	\N
189b69a2-23f1-4510-9d6b-c9903c299fd7	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	2026-01-20 18:01:12.229202+00	2026-01-20 18:01:20.396277+00	\N	aal1	\N	2026-01-20 18:01:20.396184	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	46.121.70.77	\N	\N	\N	\N	\N
156f484c-9b90-4bfa-9310-3e6b9a4844de	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	2026-01-22 08:38:09.838746+00	2026-01-22 08:38:09.838746+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	212.106.113.151	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	authenticated	authenticated	viewer@activegames.co.il	$2a$10$a6px5lqCNEncZXzDAPC1kuxgS9gEDNkKTA.2JmxitdjOTqlyUdtV2	2026-01-20 17:40:11.61821+00	\N		\N		\N			\N	2026-01-20 18:01:12.22672+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-01-20 17:40:11.614325+00	2026-01-20 18:01:20.395135+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	authenticated	authenticated	jeremymalai@gmail.com	$2a$10$nPfF0rqwi.s4neZ2XDzlQeC9KHpPSL32vmMSD2HsKPpKnnSbbz0k.	2026-01-14 22:38:58.290165+00	\N		\N		\N			\N	2026-01-22 08:38:09.838066+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-01-14 22:38:58.265811+00	2026-01-22 08:38:09.919544+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	authenticated	authenticated	anaelle@al.com	$2a$10$yN/dZ15CN.xwLwEOx8LEiezU3InswiLLnZsWVs8xjvJzRVVJWoFFC	2026-01-17 16:06:58.305907+00	\N		\N		\N			\N	2026-01-17 16:35:39.170693+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-01-17 16:06:58.289418+00	2026-01-17 16:35:39.192745+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	authenticated	authenticated	shimi@activegames.co.il	$2a$10$l..kznqVD6OQhdjbUbUyVOtNmid0zc8vA793zphgdfmEowc9wYsh6	2026-01-17 14:27:31.530538+00	\N		\N		\N			\N	2026-01-21 13:55:09.165311+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-01-17 14:27:31.514401+00	2026-01-21 14:45:43.269676+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_logs (id, user_id, user_role, user_name, action_type, target_type, target_id, target_name, branch_id, details, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: ai_conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_conversations (id, user_id, title, created_at, updated_at, is_active) FROM stdin;
\.


--
-- Data for Name: ai_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_messages (id, conversation_id, role, content, metadata, created_at) FROM stdin;
\.


--
-- Data for Name: booking_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_contacts (id, booking_id, contact_id, is_primary, role, created_at) FROM stdin;
\.


--
-- Data for Name: booking_slots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_slots (id, booking_id, branch_id, slot_start, slot_end, participants_count, slot_type, created_at) FROM stdin;
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, branch_id, type, status, start_datetime, end_datetime, game_start_datetime, game_end_datetime, participants_count, event_room_id, customer_first_name, customer_last_name, customer_phone, customer_email, customer_notes_at_booking, reference_code, total_price, notes, color, primary_contact_id, created_at, updated_at, cancelled_at, cancelled_reason, icount_offer_id, icount_invrec_id, discount_type, discount_value, icount_offer_url) FROM stdin;
\.


--
-- Data for Name: branch_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch_settings (id, branch_id, max_concurrent_players, slot_duration_minutes, game_duration_minutes, event_total_duration_minutes, event_game_duration_minutes, event_buffer_before_minutes, event_buffer_after_minutes, event_min_participants, game_price_per_person, bracelet_price, event_price_15_29, event_price_30_plus, opening_hours, created_at, updated_at, total_slots, max_players_per_slot, laser_total_vests, laser_enabled, icount_auto_send_quote) FROM stdin;
12975a38-e22c-4961-a2bf-047cab53ddcd	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	60	15	30	120	60	15	15	1	0.00	0.00	0.00	0.00	{"friday": {"open": "10:00", "close": "22:00"}, "monday": {"open": "10:00", "close": "22:00"}, "sunday": {"open": "10:00", "close": "22:00"}, "tuesday": {"open": "10:00", "close": "22:00"}, "saturday": {"open": "10:00", "close": "22:00"}, "thursday": {"open": "10:00", "close": "22:00"}, "wednesday": {"open": "10:00", "close": "22:00"}}	2026-01-14 22:43:34.454188+00	2026-01-16 23:56:15.177979+00	10	6	30	t	t
f82df9b6-629c-4339-9ba1-0ac48a716b54	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	84	15	30	120	60	15	15	1	0.00	0.00	0.00	0.00	{"friday": {"open": "10:00", "close": "22:00"}, "monday": {"open": "10:00", "close": "22:00"}, "sunday": {"open": "10:00", "close": "22:00"}, "tuesday": {"open": "10:00", "close": "22:00"}, "saturday": {"open": "10:00", "close": "22:00"}, "thursday": {"open": "10:00", "close": "22:00"}, "wednesday": {"open": "10:00", "close": "22:00"}}	2026-01-14 22:43:34.454188+00	2026-01-16 23:56:15.177979+00	14	6	35	t	t
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branches (id, slug, name, name_en, address, phone, phone_extension, timezone, is_active, created_at, updated_at) FROM stdin;
5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	rishon-lezion	Rishon LeZion	Rishon LeZion	At Laser City complex, Aliyat HaNoar 1, Bar-On Center – Floor 5	03-5512277	1	Asia/Jerusalem	t	2026-01-14 22:43:34.289472+00	2026-01-18 21:29:05.750452+00
9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	petah-tikva	Petah Tikva	Petah Tikva	At Laser City complex, Amal 37	03-5512277	3	Asia/Jerusalem	t	2026-01-14 22:43:34.289472+00	2026-01-18 21:29:05.891731+00
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, branch_id_main, first_name, last_name, phone, email, notes_client, alias, status, source, archived_at, archived_reason, deleted_at, created_at, updated_at, created_by, updated_by, client_type, company_name, vat_id, icount_client_id, preferred_locale, icount_cc_token_id, cc_last4, cc_type, cc_validity, cc_holder_name, cc_expiry) FROM stdin;
\.


--
-- Data for Name: email_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_logs (id, recipient_email, recipient_name, template_id, template_code, subject, body_preview, entity_type, entity_id, branch_id, attachments, status, error_message, metadata, sent_at, created_at, triggered_by, body_html, updated_at) FROM stdin;
\.


--
-- Data for Name: email_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_settings (id, smtp_user, smtp_password, smtp_host, smtp_port, from_email, from_name, logo_activegames_url, logo_lasercity_url, is_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_templates (id, code, name, description, subject_template, body_template, is_active, is_system, branch_id, available_variables, created_at, updated_at, created_by) FROM stdin;
3cf65a4a-a71d-4c99-a68c-603be94737ac	booking_confirmation_en	Booking Confirmation (EN)	Email sent automatically when a booking is confirmed - English version	Booking Confirmed - Ref. {{booking_reference}}	<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>Booking Confirmation</title>\n</head>\n<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;">\n  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">\n    <tr>\n      <td align="center" style="padding: 40px 20px;">\n        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">\n\n          <!-- Header with logos -->\n          <tr>\n            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                <tr>\n                  <td style="text-align: center;">\n                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />\n                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Main content -->\n          <tr>\n            <td style="padding: 40px 30px;">\n              <!-- Success icon -->\n              <div style="text-align: center; margin-bottom: 25px;">\n                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">\n                  <span style="font-size: 40px; color: #00f0ff;">✓</span>\n                </div>\n              </div>\n\n              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">\n                BOOKING CONFIRMED!\n              </h1>\n\n              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">\n                Thank you for your reservation\n              </p>\n\n              <!-- Reference number -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">\n                <tr>\n                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">\n                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">Booking Number</p>\n                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}{{cgv_section}}</p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Booking details card -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      Summary\n                    </h2>\n\n                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Location</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{branch_name}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Participants</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{participants}} people</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Date</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_date}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0;">Time</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: right;">{{booking_time}}</td>\n                      </tr>\n                    </table>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Client info -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">Reserved for</p>\n                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>\n                  </td>\n                </tr>\n                    {{offer_section}}\n              </table>\n\n              <!-- Branch address -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">\n                      📍 Address\n                    </p>\n                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">\n                      {{branch_address}}\n                    </p>\n                    <p style="color: #00f0ff; margin: 0;">\n                      📞 {{branch_phone}}\n                    </p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Important notes -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ Important Information</p>\n                    <ul style="color: #d4d4d8; margin: 0; padding-left: 20px; font-size: 14px; line-height: 1.8;">\n                      <li>Please arrive 15 minutes before your scheduled time</li>\n                      <li>Wear comfortable clothing</li>\n                      <li>Closed-toe shoes required</li>\n                    </ul>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Terms & Conditions Section -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2);">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      📋 Terms & Conditions\n                    </h2>\n                    <div style="color: #d4d4d8; font-size: 13px; line-height: 1.7;">\n                      {{terms_conditions}}\n                    </div>\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Footer -->\n          <tr>\n            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">\n              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">\n                Thank you for choosing ActiveGames!\n              </p>\n              <p style="color: #606070; margin: 0; font-size: 12px;">\n                © {{current_year}} ActiveGames. All rights reserved.\n              </p>\n            </td>\n          </tr>\n        </table>\n      </td>\n    </tr>\n  </table>\n</body>\n</html>	t	t	\N	["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_first_name", "client_last_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year", "terms_conditions"]	2026-01-18 21:15:46.39837+00	2026-01-20 20:58:36.429052+00	\N
f0f83232-2842-4a8f-a5ef-d30fa78213b1	booking_confirmation_he	אישור הזמנה (HE)	מייל שנשלח אוטומטית כשהזמנה מאושרת - גרסה עברית	ההזמנה אושרה - מס' {{booking_reference}}	<!DOCTYPE html>\n<html lang="he" dir="rtl">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>אישור הזמנה</title>\n</head>\n<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif; direction: rtl;">\n  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">\n    <tr>\n      <td align="center" style="padding: 40px 20px;">\n        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">\n\n          <!-- Header with logos -->\n          <tr>\n            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                <tr>\n                  <td style="text-align: center;">\n                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />\n                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Main content -->\n          <tr>\n            <td style="padding: 40px 30px;">\n              <!-- Success icon -->\n              <div style="text-align: center; margin-bottom: 25px;">\n                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">\n                  <span style="font-size: 40px; color: #00f0ff;">✓</span>\n                </div>\n              </div>\n\n              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">\n                ההזמנה אושרה!\n              </h1>\n\n              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">\n                תודה על ההזמנה שלך\n              </p>\n\n              <!-- Reference number -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">\n                <tr>\n                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">\n                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">מספר הזמנה</p>\n                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}{{cgv_section}}</p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Booking details card -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      פרטי ההזמנה\n                    </h2>\n\n                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">מיקום</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{branch_name}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">סוג</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_type}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">משתתפים</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{participants}} אנשים</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">תאריך</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_date}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0;">שעה</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: left;">{{booking_time}}</td>\n                      </tr>\n                    </table>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Client info -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">הוזמן על שם</p>\n                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>\n                  </td>\n                </tr>\n                    {{offer_section}}\n              </table>\n\n              <!-- Branch address -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">\n                      📍 כתובת\n                    </p>\n                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">\n                      {{branch_address}}\n                    </p>\n                    <p style="color: #00f0ff; margin: 0;">\n                      📞 {{branch_phone}}\n                    </p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Important notes -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ מידע חשוב</p>\n                    <ul style="color: #d4d4d8; margin: 0; padding-right: 20px; font-size: 14px; line-height: 1.8;">\n                      <li>נא להגיע 15 דקות לפני הזמן המתוכנן</li>\n                      <li>לבשו בגדים נוחים</li>\n                      <li>נעליים סגורות חובה</li>\n                    </ul>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Terms & Conditions Section -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2);">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      📋 תנאים והגבלות\n                    </h2>\n                    <div style="color: #d4d4d8; font-size: 13px; line-height: 1.7;">\n                      {{terms_conditions}}\n                    </div>\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Footer -->\n          <tr>\n            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">\n              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">\n                תודה שבחרתם ב-ActiveGames!\n              </p>\n              <p style="color: #606070; margin: 0; font-size: 12px;">\n                © {{current_year}} ActiveGames. כל הזכויות שמורות.\n              </p>\n            </td>\n          </tr>\n        </table>\n      </td>\n    </tr>\n  </table>\n</body>\n</html>	t	t	\N	["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_first_name", "client_last_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year", "terms_conditions"]	2026-01-18 21:15:46.633895+00	2026-01-20 20:58:36.429052+00	\N
3e48cf1d-16dd-4cf0-8c35-06b06fce31ef	booking_confirmation_fr	Confirmation de réservation (FR)	Email envoyé automatiquement lors de la confirmation d'une réservation - Version française	Réservation Confirmée - Réf. {{booking_reference}}	<!DOCTYPE html>\n<html lang="fr">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n  <title>Confirmation de réservation</title>\n</head>\n<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;">\n  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">\n    <tr>\n      <td align="center" style="padding: 40px 20px;">\n        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">\n\n          <!-- Header with logos -->\n          <tr>\n            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                <tr>\n                  <td style="text-align: center;">\n                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />\n                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Main content -->\n          <tr>\n            <td style="padding: 40px 30px;">\n              <!-- Success icon -->\n              <div style="text-align: center; margin-bottom: 25px;">\n                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">\n                  <span style="font-size: 40px; color: #00f0ff;">✓</span>\n                </div>\n              </div>\n\n              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">\n                RÉSERVATION CONFIRMÉE !\n              </h1>\n\n              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">\n                Merci pour votre réservation\n              </p>\n\n              <!-- Reference number -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">\n                <tr>\n                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">\n                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">Numéro de réservation</p>\n                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}{{cgv_section}}</p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Booking details card -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      Récapitulatif\n                    </h2>\n\n                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Lieu</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{branch_name}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Participants</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{participants}} personnes</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Date</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_date}}</td>\n                      </tr>\n                      <tr>\n                        <td style="color: #a0a0b0; padding: 10px 0;">Heure</td>\n                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: right;">{{booking_time}}</td>\n                      </tr>\n                    </table>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Client info -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">Réservé au nom de</p>\n                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>\n                  </td>\n                </tr>\n                    {{offer_section}}\n              </table>\n\n              <!-- Branch address -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">\n                      📍 Adresse\n                    </p>\n                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">\n                      {{branch_address}}\n                    </p>\n                    <p style="color: #00f0ff; margin: 0;">\n                      📞 {{branch_phone}}\n                    </p>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Important notes -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3); margin-bottom: 25px;">\n                <tr>\n                  <td style="padding: 20px;">\n                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ Informations importantes</p>\n                    <ul style="color: #d4d4d8; margin: 0; padding-left: 20px; font-size: 14px; line-height: 1.8;">\n                      <li>Arrivez 15 minutes avant l'heure prévue</li>\n                      <li>Portez des vêtements confortables</li>\n                      <li>Chaussures fermées obligatoires</li>\n                    </ul>\n                  </td>\n                </tr>\n              </table>\n\n              <!-- Terms & Conditions Section -->\n              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2);">\n                <tr>\n                  <td style="padding: 25px;">\n                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">\n                      📋 Conditions Générales\n                    </h2>\n                    <div style="color: #d4d4d8; font-size: 13px; line-height: 1.7;">\n                      {{terms_conditions}}\n                    </div>\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n\n          <!-- Footer -->\n          <tr>\n            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">\n              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">\n                Merci d'avoir choisi ActiveGames !\n              </p>\n              <p style="color: #606070; margin: 0; font-size: 12px;">\n                © {{current_year}} ActiveGames. Tous droits réservés.\n              </p>\n            </td>\n          </tr>\n        </table>\n      </td>\n    </tr>\n  </table>\n</body>\n</html>	t	t	\N	["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_first_name", "client_last_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year", "terms_conditions"]	2026-01-18 21:15:46.154656+00	2026-01-20 20:58:36.429052+00	\N
385cc817-d2c5-46e7-bcee-a450a883a8d1	terms_game_he	תנאים והגבלות - משחקים	תנאים כלליים להזמנות משחקים באתר	תנאים והגבלות	\n<div style="font-family: Arial, sans-serif; direction: rtl; text-align: right; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">תנאים כלליים</h3>\n\n  <p><strong style="color: #00f0ff;">כללי השתתפות (כל הפעילויות):</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>ההשתתפות בנעליים סגורות ושטוחות בלבד</li>\n    <li>אסורה ההשתתפות לנשים בהריון, חולי אפילפסיה ובעלי קוצבי לב</li>\n    <li>החברה שומרת לעצמה את הזכות לבצע משחקים עם פחות משתתפים במקרה של תקלות טכניות</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City - לייזר סיטי</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משך משחק לייזר: 20 דקות נטו + 10-15 דקות של הדרכה והלבשה</li>\n    <li>החברה שומרת לעצמה את הזכות להחליט על כמות המשתתפים שנכנסים בו זמנית למשחק</li>\n    <li>במידה ומספר המשתתפים בקבוצה גדול מכמות האפודים תבוצע חלוקה לסבבים</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games - אקטיב גיימס</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משך פעילות Active Games: 60 דקות של משחק רציף</li>\n    <li>עד 6 שחקנים בו זמנית בכל חדר</li>\n    <li>המתחם כולל 8 חדרים אינטראקטיביים שונים</li>\n    <li>כל משתתף מקבל צמיד חכם לרישום התוצאות</li>\n    <li>ניתן לשחק במצב תחרותי או שיתופי</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 חבילת Mix - לייזר + Active Games</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משחק לייזר אחד (20 דקות) + 30 דקות Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">מידע חשוב:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>החברה אינה עובדת עם שוברים</li>\n    <li>חל איסור להכניס למקום: קומקום חשמלי, מי-חם, מכשירי חשמל, קונפטי, פנייטות, זיקוקים, בועות סבון, סיגריות ואלכוהול</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">תנאי תשלום וביטול:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>ביטולים/דחיה: עד 8 ימים לפני - החזר מלא של המקדמה</li>\n    <li>7-6 ימים לפני - דמי ביטול של 30%</li>\n    <li>5-4 ימים לפני - דמי ביטול של 50%</li>\n    <li>3 ימים לפני ופחות - דמי ביטול של 100%</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">מצב חירום:</strong></p>\n  <p style="color: #e0e0e0;">בעת לחימה - אם האיזור יוגדר כאיזור סיכון ע"י פיקוד העורף, האירוע יידחה ויתואם מחדש.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
b0b5255e-a0eb-4bcb-94c7-fa455a491aa5	terms_event_en	Terms & Conditions - Events	General conditions for online event bookings	Terms & Conditions - Events	\n<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">General Terms & Conditions for Events</h3>\n\n  <p><strong style="color: #00f0ff;">Participation Rules (All Activities):</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Closed and flat shoes are mandatory</li>\n    <li>Participation is prohibited for pregnant women, epilepsy patients, and pacemaker users</li>\n    <li>The company reserves the right to run games with fewer participants in case of technical issues</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Laser game duration: 20 minutes net + 10-15 minutes for briefing and equipment</li>\n    <li>The company reserves the right to decide on the number of participants entering simultaneously</li>\n    <li>If the group size exceeds the number of vests, participants will be divided into rounds</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Active Games session duration: 60 minutes of continuous play</li>\n    <li>Up to 6 players simultaneously in each room</li>\n    <li>The complex includes 8 different interactive rooms</li>\n    <li>Each participant receives a smart wristband for score tracking</li>\n    <li>Play in competitive or cooperative mode</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Mix Package - Laser + Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>One laser game (20 minutes) + 30 minutes of Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">Event Room Conditions:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>You cannot bring outside food if you did not book a room</li>\n    <li>Event rooms: No guarantee of a specific room, the company reserves the right to assign rooms</li>\n    <li>Soft drinks: Soda/juice - 1.5L bottles - flavors based on availability / water from dispenser</li>\n    <li>Snacks: Variety of snacks - flavors based on availability</li>\n    <li>2 pizza slices per participant (additional trays can be ordered)</li>\n    <li>Room decoration - rooms are designed. You can bring additional decorations - no wall adhesives</li>\n    <li>Board games - in case of damage, the organizer bears full responsibility</li>\n  </ul>\n\n  <p><strong style="color: #fbbf24;">⚠️ Allergies:</strong></p>\n  <p style="color: #e0e0e0;">Please note, a child with life-threatening allergies must be accompanied by a dedicated adult. The company cannot take responsibility for allergies. We can provide guidance not to serve certain snacks and allow event organizers to decide which snacks will be served before opening them.</p>\n\n  <p><strong style="color: #00f0ff;">Event Conditions:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Package size can be changed up to 3 days before the event</li>\n    <li>Event start: Customer should arrive 15 minutes before the event, guests should be invited for the scheduled time</li>\n    <li>Activities will start 15 minutes after the scheduled time</li>\n    <li>If the customer refuses to start the activity, the company is not committed to the time and game entry</li>\n    <li>Minimum participants for an event: 15 participants</li>\n    <li>Event duration - 1.5/2 hours - depends on activity type and number of games</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Important Information:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>The company does not accept vouchers</li>\n    <li>Prohibited items: electric kettles, hot water, electrical appliances, confetti, sparklers, fireworks, soap bubbles, cigarettes, and alcohol</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Payment and Cancellation Policy:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Deposit - one third of the event cost, balance to be paid on event day</li>\n    <li>Work order becomes effective only upon full deposit payment</li>\n    <li>Cancellation/postponement: up to 8 days before - full refund of deposit</li>\n    <li>7-6 days before - 30% cancellation fee</li>\n    <li>5-4 days before - 50% cancellation fee</li>\n    <li>3 days or less - 100% cancellation fee</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Emergency Situation:</strong></p>\n  <p style="color: #e0e0e0;">During wartime - if the area is defined as a risk zone by Home Front Command, the event will be postponed and rescheduled within two weeks from when updated guidelines allowing the event are issued.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
8810a7ed-603f-42e5-947a-54879f4f00c4	terms_game_en	Terms & Conditions - Games	General conditions for online game bookings	Terms & Conditions	\n<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">General Terms & Conditions</h3>\n\n  <p><strong style="color: #00f0ff;">Participation Rules (All Activities):</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Closed and flat shoes are mandatory</li>\n    <li>Participation is prohibited for pregnant women, epilepsy patients, and pacemaker users</li>\n    <li>The company reserves the right to run games with fewer participants in case of technical issues</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Laser game duration: 20 minutes net + 10-15 minutes for briefing and equipment</li>\n    <li>The company reserves the right to decide on the number of participants entering simultaneously</li>\n    <li>If the group size exceeds the number of vests, participants will be divided into rounds</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Active Games session duration: 60 minutes of continuous play</li>\n    <li>Up to 6 players simultaneously in each room</li>\n    <li>The complex includes 8 different interactive rooms</li>\n    <li>Each participant receives a smart wristband for score tracking</li>\n    <li>Play in competitive or cooperative mode</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Mix Package - Laser + Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>One laser game (20 minutes) + 30 minutes of Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">Important Information:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>The company does not accept vouchers</li>\n    <li>Prohibited items: electric kettles, hot water, electrical appliances, confetti, sparklers, fireworks, soap bubbles, cigarettes, and alcohol</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Payment and Cancellation Policy:</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Cancellation/postponement: up to 8 days before - full refund of deposit</li>\n    <li>7-6 days before - 30% cancellation fee</li>\n    <li>5-4 days before - 50% cancellation fee</li>\n    <li>3 days or less - 100% cancellation fee</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Emergency Situation:</strong></p>\n  <p style="color: #e0e0e0;">During wartime - if the area is defined as a risk zone by Home Front Command, the event will be postponed and rescheduled.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
5ee19f9c-4a19-4310-b0e7-388bb61cf54b	terms_game_fr	Conditions Générales - Jeux	Conditions générales pour les réservations de jeux en ligne	Conditions Générales	\n<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">Conditions Générales</h3>\n\n  <p><strong style="color: #00f0ff;">Règles de participation (Toutes activités) :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Chaussures fermées et plates obligatoires</li>\n    <li>Participation interdite aux femmes enceintes, épileptiques et porteurs de pacemaker</li>\n    <li>La société se réserve le droit d'organiser des parties avec moins de participants en cas de problèmes techniques</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Durée du jeu laser : 20 minutes nettes + 10-15 minutes de briefing et équipement</li>\n    <li>La société se réserve le droit de décider du nombre de participants entrant simultanément</li>\n    <li>Si le groupe dépasse le nombre de gilets, les participants seront répartis en tours</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Durée de la session Active Games : 60 minutes de jeu continu</li>\n    <li>Jusqu'à 6 joueurs simultanément dans chaque salle</li>\n    <li>Le complexe comprend 8 salles interactives différentes</li>\n    <li>Chaque participant reçoit un bracelet connecté pour le suivi des scores</li>\n    <li>Mode compétitif ou coopératif au choix</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Forfait Mix - Laser + Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Une partie de laser (20 minutes) + 30 minutes d'Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">Informations importantes :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>La société n'accepte pas les bons de réduction</li>\n    <li>Articles interdits : bouilloire électrique, eau chaude, appareils électriques, confettis, cierges magiques, feux d'artifice, bulles de savon, cigarettes et alcool</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Conditions de paiement et d'annulation :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Annulation/report : jusqu'à 8 jours avant - remboursement intégral de l'acompte</li>\n    <li>7-6 jours avant - frais d'annulation de 30%</li>\n    <li>5-4 jours avant - frais d'annulation de 50%</li>\n    <li>3 jours ou moins - frais d'annulation de 100%</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Situation d'urgence :</strong></p>\n  <p style="color: #e0e0e0;">En cas de conflit - si la zone est définie comme zone à risque par les autorités, l'événement sera reporté et reprogrammé.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
cc891386-597b-4f11-b89b-4fbd736dc07c	terms_event_he	תנאים והגבלות - אירועים	תנאים כלליים להזמנות אירועים באתר	תנאים והגבלות - אירועים	\n<div style="font-family: Arial, sans-serif; direction: rtl; text-align: right; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">תנאים כלליים לאירועים</h3>\n\n  <p><strong style="color: #00f0ff;">כללי השתתפות (כל הפעילויות):</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>ההשתתפות בנעליים סגורות ושטוחות בלבד</li>\n    <li>אסורה ההשתתפות לנשים בהריון, חולי אפילפסיה ובעלי קוצבי לב</li>\n    <li>החברה שומרת לעצמה את הזכות לבצע משחקים עם פחות משתתפים במקרה של תקלות טכניות</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City - לייזר סיטי</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משך משחק לייזר: 20 דקות נטו + 10-15 דקות של הדרכה והלבשה</li>\n    <li>החברה שומרת לעצמה את הזכות להחליט על כמות המשתתפים שנכנסים בו זמנית למשחק</li>\n    <li>במידה ומספר המשתתפים בקבוצה גדול מכמות האפודים תבוצע חלוקה לסבבים</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games - אקטיב גיימס</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משך פעילות Active Games: 60 דקות של משחק רציף</li>\n    <li>עד 6 שחקנים בו זמנית בכל חדר</li>\n    <li>המתחם כולל 8 חדרים אינטראקטיביים שונים</li>\n    <li>כל משתתף מקבל צמיד חכם לרישום התוצאות</li>\n    <li>ניתן לשחק במצב תחרותי או שיתופי</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 חבילת Mix - לייזר + Active Games</h4>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>משחק לייזר אחד (20 דקות) + 30 דקות Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">תנאי חדר האירוח:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>אין אפשרות להביא כיבוד אם לא הזמנתם חדר</li>\n    <li>חדרי אירועים: אין התחייבות לחדר אירוע ספציפי, החברה שומרת לעצמה את הזכות לבחור את שיבוץ החדרים</li>\n    <li>שתייה קלה: מוגז/מיץ - בקבוקים 1.5L - טעמים לפי זמינות במלאי / מים בתמי 4</li>\n    <li>כיבוד קל: מגוון חטיפים - הטעמים לפי זמינות במלאי</li>\n    <li>2 משולשי פיצה למשתתף (ניתן להוסיף מגשים נוספים)</li>\n    <li>קישוט החדר - חדרי האירוח מעוצבים. ניתן להביא קישוטים נוספים באופן עצמאי - ללא הדבקה על הקירות</li>\n    <li>משחקי שולחן - במקרה של נזק המזמין יישא באחריות מלאה</li>\n  </ul>\n\n  <p><strong style="color: #fbbf24;">⚠️ אלרגיות:</strong></p>\n  <p style="color: #e0e0e0;">לתשומת ליבכם, ילד בעל אלרגיה מסכנת חיים חייב בליווי מבוגר צמוד אליו. החברה אינה יכולה לקחת אחריות על אלרגיות. אנחנו יכולים לתת הנחייה לא להגיש חטיף כזה או אחר וכמובן לתת לכם בעלי האירוע להחליט אילו חטיפים יוגשו לפני פתיחתם.</p>\n\n  <p><strong style="color: #00f0ff;">תנאי האירוע:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>ניתן לשנות את גודל החבילה עד 3 ימים לפני האירוע</li>\n    <li>תחילת אירועים: הלקוח מתבקש להגיע 15 דקות לפני תחילת האירוע, את האורחים יש להזמין לשעה שנקבעה</li>\n    <li>הפעילות נתחיל 15 דקות לאחר השעה שנקבעה</li>\n    <li>במידה והלקוח יסרב להתחיל את הפעילות, החברה לא מתחייבת לשעה ולכניסה למשחק</li>\n    <li>מספר משתתפים באירוע: מינימום 15 משתתפים</li>\n    <li>משך האירוע - שעה וחצי/שעתיים - תלוי בסוג הפעילות וכמות המשחקים</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">מידע חשוב:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>החברה אינה עובדת עם שוברים</li>\n    <li>חל איסור להכניס למקום: קומקום חשמלי, מי-חם, מכשירי חשמל, קונפטי, פנייטות, זיקוקים, בועות סבון, סיגריות ואלכוהול</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">תנאי תשלום וביטול:</strong></p>\n  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">\n    <li>מקדמה - שליש מעלות האירוע, היתרה תשולם ביום האירוע</li>\n    <li>הזמנת עבודה תכנס לתוקף רק מעת תשלום מלוא המקדמה</li>\n    <li>ביטולים/דחיה: עד 8 ימים לפני - החזר מלא של המקדמה</li>\n    <li>7-6 ימים לפני - דמי ביטול של 30%</li>\n    <li>5-4 ימים לפני - דמי ביטול של 50%</li>\n    <li>3 ימים לפני ופחות - דמי ביטול של 100%</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">מצב חירום:</strong></p>\n  <p style="color: #e0e0e0;">בעת לחימה - אם האיזור יוגדר כאיזור סיכון ע"י פיקוד העורף, האירוע יידחה ויתואם מחדש עד שבועיים מהרגע בו פיקוד העורף הוריד הנחיות מעודכנות המאפשרות לקיים את האירוע.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
7cc2b0f9-af58-43d2-9974-ee79af8db62e	terms_event_fr	Conditions Générales - Événements	Conditions générales pour les réservations d'événements en ligne	Conditions Générales - Événements	\n<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">\n  <h3 style="color: #00f0ff; margin-bottom: 15px;">Conditions Générales pour les Événements</h3>\n\n  <p><strong style="color: #00f0ff;">Règles de participation (Toutes activités) :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Chaussures fermées et plates obligatoires</li>\n    <li>Participation interdite aux femmes enceintes, épileptiques et porteurs de pacemaker</li>\n    <li>La société se réserve le droit d'organiser des parties avec moins de participants en cas de problèmes techniques</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Durée du jeu laser : 20 minutes nettes + 10-15 minutes de briefing et équipement</li>\n    <li>La société se réserve le droit de décider du nombre de participants entrant simultanément</li>\n    <li>Si le groupe dépasse le nombre de gilets, les participants seront répartis en tours</li>\n  </ul>\n\n  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Durée de la session Active Games : 60 minutes de jeu continu</li>\n    <li>Jusqu'à 6 joueurs simultanément dans chaque salle</li>\n    <li>Le complexe comprend 8 salles interactives différentes</li>\n    <li>Chaque participant reçoit un bracelet connecté pour le suivi des scores</li>\n    <li>Mode compétitif ou coopératif au choix</li>\n  </ul>\n\n  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Forfait Mix - Laser + Active Games</h4>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Une partie de laser (20 minutes) + 30 minutes d'Active Games</li>\n  </ul>\n\n  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">\n\n  <p><strong style="color: #00f0ff;">Conditions de la salle d'événement :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Vous ne pouvez pas apporter de nourriture extérieure si vous n'avez pas réservé de salle</li>\n    <li>Salles d'événements : aucune garantie de salle spécifique, la société se réserve le droit d'attribuer les salles</li>\n    <li>Boissons : sodas/jus - bouteilles de 1,5L - parfums selon disponibilité / eau de la fontaine</li>\n    <li>Snacks : variété de snacks - parfums selon disponibilité</li>\n    <li>2 parts de pizza par participant (plateaux supplémentaires disponibles)</li>\n    <li>Décoration - les salles sont décorées. Vous pouvez apporter des décorations supplémentaires - pas de collage sur les murs</li>\n    <li>Jeux de société - en cas de dommage, l'organisateur assume l'entière responsabilité</li>\n  </ul>\n\n  <p><strong style="color: #fbbf24;">⚠️ Allergies :</strong></p>\n  <p style="color: #e0e0e0;">Attention, un enfant souffrant d'allergies potentiellement mortelles doit être accompagné d'un adulte dédié. La société ne peut être tenue responsable des allergies. Nous pouvons vous conseiller de ne pas servir certains snacks et permettre aux organisateurs de décider quels snacks seront servis avant leur ouverture.</p>\n\n  <p><strong style="color: #00f0ff;">Conditions de l'événement :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>La taille du forfait peut être modifiée jusqu'à 3 jours avant l'événement</li>\n    <li>Début de l'événement : le client doit arriver 15 minutes avant, les invités doivent être conviés à l'heure prévue</li>\n    <li>Les activités commenceront 15 minutes après l'heure prévue</li>\n    <li>Si le client refuse de commencer l'activité, la société n'est pas engagée sur l'horaire et l'entrée en jeu</li>\n    <li>Nombre minimum de participants : 15 personnes</li>\n    <li>Durée de l'événement - 1h30/2h - selon le type d'activité et le nombre de parties</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Informations importantes :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>La société n'accepte pas les bons de réduction</li>\n    <li>Articles interdits : bouilloire électrique, eau chaude, appareils électriques, confettis, cierges magiques, feux d'artifice, bulles de savon, cigarettes et alcool</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Conditions de paiement et d'annulation :</strong></p>\n  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">\n    <li>Acompte - un tiers du coût de l'événement, solde à payer le jour de l'événement</li>\n    <li>La commande n'est effective qu'après paiement complet de l'acompte</li>\n    <li>Annulation/report : jusqu'à 8 jours avant - remboursement intégral de l'acompte</li>\n    <li>7-6 jours avant - frais d'annulation de 30%</li>\n    <li>5-4 jours avant - frais d'annulation de 50%</li>\n    <li>3 jours ou moins - frais d'annulation de 100%</li>\n  </ul>\n\n  <p><strong style="color: #00f0ff;">Situation d'urgence :</strong></p>\n  <p style="color: #e0e0e0;">En cas de conflit - si la zone est définie comme zone à risque par les autorités, l'événement sera reporté et reprogrammé dans les deux semaines suivant la levée des restrictions.</p>\n</div>\n	t	t	\N	[]	2026-01-19 02:54:13.41103+00	2026-01-19 03:25:19.609645+00	\N
5f4749d7-2c88-47ed-ba9b-8e1feb955aff	cgv_reminder_fr	Rappel CGV (FR)	Email de rappel pour valider les conditions générales de vente	[Rappel] Validation CGV - Réservation {{booking_reference}}	<!DOCTYPE html>\n<html>\n<head>\n  <meta charset="utf-8">\n</head>\n<body style="font-family: Arial, sans-serif; background-color: #0a0a1a; margin: 0; padding: 20px;">\n  <div style="max-width: 600px; margin: 0 auto; background: linear-gradient(135deg, #1a1a2e 0%, #0f0f23 100%); border-radius: 16px; overflow: hidden; border: 1px solid rgba(0, 240, 255, 0.2);">\n    \n    <!-- Header avec logos -->\n    <div style="padding: 30px; text-align: center; background: linear-gradient(135deg, #00f0ff20 0%, transparent 100%);">\n      <img src="{{logo_activegames_url}}" alt="Active Games" style="height: 50px; width: auto; margin: 0 10px;">\n      <img src="{{logo_lasercity_url}}" alt="Laser City" style="height: 50px; width: auto; margin: 0 10px;">\n    </div>\n\n    <!-- Contenu principal -->\n    <div style="padding: 30px;">\n      <div style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: 12px; padding: 25px; border: 2px solid #f59e0b; margin-bottom: 25px;">\n        <h2 style="color: #92400e; margin: 0 0 15px 0; font-size: 20px;">⚠️ Rappel : Validation CGV en attente</h2>\n        <p style="color: #78350f; margin: 0 0 20px 0; font-size: 15px; line-height: 1.6;">\n          Bonjour {{client_first_name}},<br><br>\n          Nous vous rappelons que votre réservation nécessite la validation de nos conditions générales de vente.\n        </p>\n        <div style="text-align: center;">\n          <a href="{{cgv_url}}" target="_blank" style="display: inline-block; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #ffffff; padding: 14px 35px; border-radius: 8px; text-decoration: none; font-weight: bold; font-size: 16px;">\n            Valider les CGV maintenant\n          </a>\n        </div>\n      </div>\n\n      <!-- Récapitulatif réservation -->\n      <div style="background: rgba(255, 255, 255, 0.05); border-radius: 12px; padding: 20px; border: 1px solid rgba(255, 255, 255, 0.1);">\n        <h3 style="color: #00f0ff; margin: 0 0 15px 0; font-size: 16px;">📋 Votre réservation</h3>\n        <table style="width: 100%; color: #ffffff; font-size: 14px;">\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Référence :</td>\n            <td style="padding: 8px 0; font-weight: bold;">{{booking_reference}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Date :</td>\n            <td style="padding: 8px 0;">{{booking_date}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Heure :</td>\n            <td style="padding: 8px 0;">{{booking_time}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Participants :</td>\n            <td style="padding: 8px 0;">{{participants}} personnes</td>\n          </tr>\n        </table>\n      </div>\n    </div>\n\n    <!-- Footer -->\n    <div style="padding: 20px 30px; background: rgba(0, 0, 0, 0.3); text-align: center;">\n      <p style="color: #666; font-size: 12px; margin: 0;">\n        {{branch_name}} • Active Games World<br>\n        Rappel n°{{reminder_number}}\n      </p>\n    </div>\n  </div>\n</body>\n</html>	t	f	\N	[]	2026-01-20 21:03:33.066057+00	2026-01-20 21:03:48.21236+00	\N
ff30cbdb-3c1f-44c7-8024-ad1d30ecbc92	cgv_reminder_en	CGV Reminder (EN)	Reminder email to validate terms and conditions	[Reminder] T&C Validation - Booking {{booking_reference}}	<!DOCTYPE html>\n<html>\n<head>\n  <meta charset="utf-8">\n</head>\n<body style="font-family: Arial, sans-serif; background-color: #0a0a1a; margin: 0; padding: 20px;">\n  <div style="max-width: 600px; margin: 0 auto; background: linear-gradient(135deg, #1a1a2e 0%, #0f0f23 100%); border-radius: 16px; overflow: hidden; border: 1px solid rgba(0, 240, 255, 0.2);">\n    \n    <div style="padding: 30px; text-align: center; background: linear-gradient(135deg, #00f0ff20 0%, transparent 100%);">\n      <img src="{{logo_activegames_url}}" alt="Active Games" style="height: 50px; width: auto; margin: 0 10px;">\n      <img src="{{logo_lasercity_url}}" alt="Laser City" style="height: 50px; width: auto; margin: 0 10px;">\n    </div>\n\n    <div style="padding: 30px;">\n      <div style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: 12px; padding: 25px; border: 2px solid #f59e0b; margin-bottom: 25px;">\n        <h2 style="color: #92400e; margin: 0 0 15px 0; font-size: 20px;">⚠️ Reminder: T&C Validation Pending</h2>\n        <p style="color: #78350f; margin: 0 0 20px 0; font-size: 15px; line-height: 1.6;">\n          Hello {{client_first_name}},<br><br>\n          This is a reminder that your booking requires validation of our terms and conditions.\n        </p>\n        <div style="text-align: center;">\n          <a href="{{cgv_url}}" target="_blank" style="display: inline-block; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #ffffff; padding: 14px 35px; border-radius: 8px; text-decoration: none; font-weight: bold; font-size: 16px;">\n            Accept Terms Now\n          </a>\n        </div>\n      </div>\n\n      <div style="background: rgba(255, 255, 255, 0.05); border-radius: 12px; padding: 20px; border: 1px solid rgba(255, 255, 255, 0.1);">\n        <h3 style="color: #00f0ff; margin: 0 0 15px 0; font-size: 16px;">📋 Your Booking</h3>\n        <table style="width: 100%; color: #ffffff; font-size: 14px;">\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Reference:</td>\n            <td style="padding: 8px 0; font-weight: bold;">{{booking_reference}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Date:</td>\n            <td style="padding: 8px 0;">{{booking_date}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Time:</td>\n            <td style="padding: 8px 0;">{{booking_time}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">Participants:</td>\n            <td style="padding: 8px 0;">{{participants}} people</td>\n          </tr>\n        </table>\n      </div>\n    </div>\n\n    <div style="padding: 20px 30px; background: rgba(0, 0, 0, 0.3); text-align: center;">\n      <p style="color: #666; font-size: 12px; margin: 0;">\n        {{branch_name}} • Active Games World<br>\n        Reminder #{{reminder_number}}\n      </p>\n    </div>\n  </div>\n</body>\n</html>	t	f	\N	[]	2026-01-20 21:03:33.066057+00	2026-01-20 21:03:48.21236+00	\N
420ad1a9-143d-4476-bd75-525370967392	cgv_reminder_he	תזכורת תנאים (HE)	מייל תזכורת לאישור תנאי שירות	[תזכורת] אישור תנאים - הזמנה {{booking_reference}}	<!DOCTYPE html>\n<html dir="rtl">\n<head>\n  <meta charset="utf-8">\n</head>\n<body style="font-family: Arial, sans-serif; background-color: #0a0a1a; margin: 0; padding: 20px; direction: rtl;">\n  <div style="max-width: 600px; margin: 0 auto; background: linear-gradient(135deg, #1a1a2e 0%, #0f0f23 100%); border-radius: 16px; overflow: hidden; border: 1px solid rgba(0, 240, 255, 0.2);">\n    \n    <div style="padding: 30px; text-align: center; background: linear-gradient(135deg, #00f0ff20 0%, transparent 100%);">\n      <img src="{{logo_activegames_url}}" alt="Active Games" style="height: 50px; width: auto; margin: 0 10px;">\n      <img src="{{logo_lasercity_url}}" alt="Laser City" style="height: 50px; width: auto; margin: 0 10px;">\n    </div>\n\n    <div style="padding: 30px;">\n      <div style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border-radius: 12px; padding: 25px; border: 2px solid #f59e0b; margin-bottom: 25px;">\n        <h2 style="color: #92400e; margin: 0 0 15px 0; font-size: 20px;">⚠️ תזכורת: ממתין לאישור תנאים</h2>\n        <p style="color: #78350f; margin: 0 0 20px 0; font-size: 15px; line-height: 1.6;">\n          שלום {{client_first_name}},<br><br>\n          זוהי תזכורת שההזמנה שלך דורשת אישור של תנאי השירות שלנו.\n        </p>\n        <div style="text-align: center;">\n          <a href="{{cgv_url}}" target="_blank" style="display: inline-block; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #ffffff; padding: 14px 35px; border-radius: 8px; text-decoration: none; font-weight: bold; font-size: 16px;">\n            אשר תנאים עכשיו\n          </a>\n        </div>\n      </div>\n\n      <div style="background: rgba(255, 255, 255, 0.05); border-radius: 12px; padding: 20px; border: 1px solid rgba(255, 255, 255, 0.1);">\n        <h3 style="color: #00f0ff; margin: 0 0 15px 0; font-size: 16px;">📋 ההזמנה שלך</h3>\n        <table style="width: 100%; color: #ffffff; font-size: 14px;">\n          <tr>\n            <td style="padding: 8px 0; color: #888;">מספר הזמנה:</td>\n            <td style="padding: 8px 0; font-weight: bold;">{{booking_reference}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">תאריך:</td>\n            <td style="padding: 8px 0;">{{booking_date}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">שעה:</td>\n            <td style="padding: 8px 0;">{{booking_time}}</td>\n          </tr>\n          <tr>\n            <td style="padding: 8px 0; color: #888;">משתתפים:</td>\n            <td style="padding: 8px 0;">{{participants}} אנשים</td>\n          </tr>\n        </table>\n      </div>\n    </div>\n\n    <div style="padding: 20px 30px; background: rgba(0, 0, 0, 0.3); text-align: center;">\n      <p style="color: #666; font-size: 12px; margin: 0;">\n        {{branch_name}} • Active Games World<br>\n        תזכורת מס׳ {{reminder_number}}\n      </p>\n    </div>\n  </div>\n</body>\n</html>	t	f	\N	[]	2026-01-20 21:03:33.066057+00	2026-01-20 21:03:48.21236+00	\N
73bf98c1-5a6b-4fe1-9b46-484256ed0c0a	cgv_page_game_he	CGV Page - Jeu (Hebrew)	Template de la page de validation CGV pour les jeux en Hébreu		<!-- Template CGV Page Game Hebrew -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:07:55.48958+00	\N
1d201e16-377e-4669-867b-82b57e7e909a	cgv_page_game_en	CGV Page - Game (English)	Template de la page de validation CGV pour les jeux en Anglais		<!-- Template CGV Page Game English -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:07:55.48958+00	\N
3f4db8fa-f56b-4816-951e-84823534ce52	cgv_page_game_fr	CGV Page - Jeu (French)	Template de la page de validation CGV pour les jeux en Français		<!-- Template CGV Page Game French -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:07:55.48958+00	\N
bc78d2d9-6867-412b-93b1-5dfa07157b37	cgv_page_event_he	CGV Page - Événement (Hebrew)	Template de la page de validation CGV pour les événements en Hébreu		<!-- Template CGV Page Event Hebrew -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:07:55.48958+00	\N
bb9832ab-c02c-4fa3-a436-563c75a40afb	cgv_page_event_en	CGV Page - Event (English)	Template de la page de validation CGV pour les événements en Anglais		<!-- Template CGV Page Event English -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:07:55.48958+00	\N
ed712f51-7c05-45e6-a03c-3b8b5e31cbf7	cgv_page_event_fr	CGV Page - Événement (French)	Template de la page de validation CGV pour les événements en Français		<!-- Template CGV Page Event French -->	t	f	\N	[]	2026-01-21 06:07:55.48958+00	2026-01-21 06:09:22.773362+00	\N
\.


--
-- Data for Name: event_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_rooms (id, branch_id, slug, name, name_en, capacity, sort_order, is_active, created_at) FROM stdin;
4892eccf-4671-419c-a6c4-845f7c4b63ef	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	room-1	Salle 1	Room 1	15	0	t	2026-01-15 16:06:39.897347+00
0a8fc849-9b39-45c6-958c-119ae599e954	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	room-2	Salle 2	Room 2	30	1	t	2026-01-15 16:06:39.897347+00
e2220906-f3c8-4441-ba08-0d2a409871e7	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	room-3	Salle 3	Room 3	60	2	t	2026-01-15 16:06:39.897347+00
cd63bb75-400f-4ad9-91cd-de0776fce81b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room-1	Salle 1	Room 1	20	0	t	2026-01-15 16:06:39.897347+00
f4522e3a-a6a5-43f9-bb1e-1207944123bd	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room-2	Salle 2	Room 2	30	1	t	2026-01-15 16:06:39.897347+00
524cbf6e-8653-4202-9b5a-c2e74d771a4b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room-3	Salle 3	Room 3	35	2	t	2026-01-15 16:06:39.897347+00
73fe9022-4028-41cc-90f4-202088adb8fe	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room-4	Salle 4	Room 4	60	3	t	2026-01-15 16:06:39.897347+00
\.


--
-- Data for Name: game_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_sessions (id, booking_id, game_area, start_datetime, end_datetime, laser_room_id, session_order, pause_before_minutes, created_at) FROM stdin;
\.


--
-- Data for Name: icount_event_formulas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icount_event_formulas (id, branch_id, name, game_type, min_participants, max_participants, price_per_person, room_id, is_active, priority, created_at, updated_at, product_id) FROM stdin;
01c847b5-3d73-44a8-84d1-f82c370a5d49	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	LASER EVENT 15+	LASER	15	29	120.00	063544be-4ba6-42cd-aece-00c9174e64a6	t	0	2026-01-20 14:34:00.383208+00	2026-01-20 14:34:00.383208+00	8f590a30-483a-4c90-afe6-015a9214151e
9202c60f-bf3d-4fa7-a3f3-da0158ae0a8b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	LASER EVENT 30+	LASER	30	999	100.00	12d13117-9a39-46d8-b96e-b5b4291d8203	t	0	2026-01-20 14:34:53.419394+00	2026-01-20 14:34:53.419394+00	1b88bc0a-c7c1-45bd-a6d6-0ea4e3ad0115
eb17857e-4c02-4cc8-85d2-b8ac538f7e9f	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	ACTIVE EVENT 15+	ACTIVE	15	29	100.00	063544be-4ba6-42cd-aece-00c9174e64a6	t	0	2026-01-20 14:35:20.649423+00	2026-01-20 14:35:20.649423+00	8de1b01e-b75a-437c-8527-064a36520ed4
dfb0b8cb-0e33-49c4-928d-e02b7cd22288	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	ACTIVE EVENT 30+	ACTIVE	30	999	100.00	12d13117-9a39-46d8-b96e-b5b4291d8203	t	0	2026-01-20 14:37:29.671995+00	2026-01-20 14:37:29.671995+00	266aaaef-c954-4339-8d67-528fb0b37ee2
6a925ee6-fb06-412c-b885-c052bc775178	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	ACTIVE+LASER EVENT 15+	BOTH	15	29	120.00	063544be-4ba6-42cd-aece-00c9174e64a6	t	0	2026-01-20 15:00:00.372128+00	2026-01-20 15:02:35.919+00	0e226179-4129-468f-b0b2-edd758b3b6d4
9b523510-d35a-4279-84d5-35d0765e253e	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	ACTIVE+LASER 30+	BOTH	30	999	110.00	12d13117-9a39-46d8-b96e-b5b4291d8203	t	0	2026-01-20 15:03:09.29736+00	2026-01-20 15:03:09.29736+00	a5c5f3fb-e1de-464b-880f-776433999d71
\.


--
-- Data for Name: icount_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icount_products (id, branch_id, code, name, name_he, description, unit_price, is_active, sort_order, created_at, updated_at, name_en, icount_item_id, icount_itemcode, icount_synced_at) FROM stdin;
5ec76070-1fb5-4e59-ad43-a80388457ef8	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	active_30	Active 30min	אקטיב 30 דק	\N	50.00	t	10	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 30min	22	active_30	2026-01-20 15:08:27.898+00
0b8f930c-a2dc-42cf-8299-027ea0506db4	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	active_90	Active 1h30	אקטיב שעה וחצי	\N	140.00	t	12	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 1h30	32	active_90	2026-01-20 15:08:29.956+00
0e226179-4129-468f-b0b2-edd758b3b6d4	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_both_15_29	ACTIVE+LASER EVENT 15+	ACTIVE+LASER EVENT 15+	\N	120.00	t	100	2026-01-20 15:00:00.695894+00	2026-01-20 15:00:00.695894+00	ACTIVE+LASER EVENT 15+	117	event_both_15_29	2026-01-20 15:08:31.046+00
d9a0835e-c512-4630-8cc3-8e6cabec2362	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	active_60	Active 1h	אקטיב שעה	\N	100.00	t	11	2026-01-19 21:10:40.450723+00	2026-01-21 20:44:17.963+00	Active 1h	21	active_60	2026-01-21 20:44:19.368+00
a5c5f3fb-e1de-464b-880f-776433999d71	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_both_30_999	ACTIVE+LASER 30+	ACTIVE+LASER 30+	\N	110.00	t	100	2026-01-20 15:03:09.837458+00	2026-01-20 15:03:09.837458+00	ACTIVE+LASER 30+	122	event_both_30_999	2026-01-20 15:08:32.183+00
5d579ef2-7e72-48d7-a625-08fbc19f60d6	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	laser_3	Laser 3 parties	לייזר 3 משחקים	\N	150.00	t	3	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 3 games	12	laser_3	2026-01-20 15:08:23.676+00
bd80de28-afb8-48bb-9539-682f6b771709	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room_event_600	Salle Event 600	חדר אירוע 600	\N	600.00	t	100	2026-01-20 00:25:25.207918+00	2026-01-20 00:25:25.207918+00	\N	82	room_event_600	2026-01-20 15:08:24.721+00
a276250f-02b2-4de5-b239-22277d9125d7	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room_event_400	Salle Event 400	חדר אירוע 400	\N	400.00	t	100	2026-01-20 00:25:25.207918+00	2026-01-20 00:25:25.207918+00	\N	72	room_event_400	2026-01-20 15:08:25.743+00
0015fe76-bf79-462a-96a9-4464a0a44da4	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	laser_4	Laser 4 parties	לייזר 4 משחקים	\N	180.00	t	4	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 4 games	17	laser_4	2026-01-20 15:08:26.813+00
1335c90c-abcd-4ca5-9d6b-a20f987050ed	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	laser_1	Laser 1 partie	לייזר משחק 1	\N	70.00	t	1	2026-01-19 21:10:40.450723+00	2026-01-20 00:54:56.557+00	Laser 1 game	42	laser_1	2026-01-20 15:08:33.246+00
76df6783-23a2-44d2-b859-0c43dd5f97cc	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	active_120	Active 2h	אקטיב שעתיים	\N	180.00	t	13	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 2h	37	active_120	2026-01-20 15:08:34.626+00
632ca047-aa09-4df7-8577-e00164317261	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	laser_2	Laser 2 parties	לייזר 2 משחקים	\N	120.00	t	2	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 2 games	7	laser_2	2026-01-20 15:08:35.686+00
8f590a30-483a-4c90-afe6-015a9214151e	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_laser_15_29	LASER EVENT 15+	LASER EVENT 15+	\N	120.00	t	100	2026-01-20 14:34:00.701386+00	2026-01-20 14:34:00.701386+00	LASER EVENT 15+	87	event_laser_15_29	2026-01-20 15:08:36.829+00
1b88bc0a-c7c1-45bd-a6d6-0ea4e3ad0115	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_laser_30_999	LASER EVENT 30+	LASER EVENT 30+	\N	100.00	t	100	2026-01-20 14:34:53.763613+00	2026-01-20 14:34:53.763613+00	LASER EVENT 30+	92	event_laser_30_999	2026-01-20 15:08:37.821+00
8de1b01e-b75a-437c-8527-064a36520ed4	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_active_15_29	ACTIVE EVENT 15+	ACTIVE EVENT 15+	\N	100.00	t	100	2026-01-20 14:35:20.896824+00	2026-01-20 14:35:20.896824+00	ACTIVE EVENT 15+	97	event_active_15_29	2026-01-20 15:08:38.784+00
266aaaef-c954-4339-8d67-528fb0b37ee2	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	event_active_30_999	ACTIVE EVENT 30+	ACTIVE EVENT 30+	\N	100.00	t	100	2026-01-20 14:37:29.960976+00	2026-01-20 14:37:29.960976+00	ACTIVE EVENT 30+	102	event_active_30_999	2026-01-20 15:08:39.825+00
7654a375-5e83-488a-ad72-650ff06a9609	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	laser_1	Laser 1 partie	לייזר משחק 1	\N	70.00	t	1	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 1 game	\N	\N	\N
42b95c04-c3fd-41ce-a94e-17ddb4488a5e	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	laser_2	Laser 2 parties	לייזר 2 משחקים	\N	120.00	t	2	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 2 games	\N	\N	\N
ba0a53c5-2ba7-4edc-8b1d-6d14987ff767	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	laser_3	Laser 3 parties	לייזר 3 משחקים	\N	150.00	t	3	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 3 games	\N	\N	\N
b5dbe34b-859e-41f8-9f40-e45644d54284	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	laser_4	Laser 4 parties	לייזר 4 משחקים	\N	180.00	t	4	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Laser 4 games	\N	\N	\N
6f2ddf4b-ac19-42c0-b636-24f2bc5ca256	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	active_30	Active 30min	אקטיב 30 דק	\N	50.00	t	10	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 30min	\N	\N	\N
7147ea46-45a9-4d24-8732-553313c49585	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	active_60	Active 1h	אקטיב שעה	\N	100.00	t	11	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 1h	\N	\N	\N
ba290f26-2b5e-4338-99cb-887b7d7bd493	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	active_90	Active 1h30	אקטיב שעה וחצי	\N	140.00	t	12	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 1h30	\N	\N	\N
b6042026-c164-400f-84a9-4591c865ec1e	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	active_120	Active 2h	אקטיב שעתיים	\N	180.00	t	13	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	Active 2h	\N	\N	\N
7e604c33-ac5b-47a0-91c4-915d67aabd72	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	ActiveLaser_1	ActiveLaser	אקטיב לייזר	\N	120.00	f	0	2026-01-21 20:43:43.705234+00	2026-01-21 20:45:49.393+00	ActiveLaser	16	ActiveLaser_1	2026-01-21 20:44:27.644+00
\.


--
-- Data for Name: icount_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icount_rooms (id, branch_id, code, name, name_he, name_en, price, is_active, sort_order, created_at, updated_at, icount_item_id, icount_itemcode, icount_synced_at) FROM stdin;
063544be-4ba6-42cd-aece-00c9174e64a6	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room_1	Salle 1	חדר 1	Room 1	400.00	t	1	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	\N	\N	\N
45cf9ab3-ef83-408a-801b-9a13c7f3ff13	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	room_1	Salle 1	חדר 1	Room 1	400.00	t	1	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	\N	\N	\N
baf258b5-76f3-4584-a640-24fed7a47ea7	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	room_2	Salle 2	חדר 2	Room 2	500.00	t	2	2026-01-19 21:10:40.450723+00	2026-01-19 21:10:40.450723+00	\N	\N	\N
12d13117-9a39-46d8-b96e-b5b4291d8203	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	room_2	Salle 2	חדר 2	Room 2	600.00	t	2	2026-01-19 21:10:40.450723+00	2026-01-19 21:43:37.732+00	\N	\N	\N
\.


--
-- Data for Name: laser_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laser_rooms (id, branch_id, slug, name, name_en, capacity, sort_order, is_active, created_at) FROM stdin;
c99d9c09-845a-4049-803d-3b387577573b	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	L1	Laser 1	Laser 1	30	0	t	2026-01-15 19:09:49.576369+00
e84bb6f4-6e01-438c-a77d-ab497736e0af	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	L1	Laser 1	Laser 1	15	0	t	2026-01-15 19:09:49.576369+00
1e136f49-caff-4aad-a829-aadee3976289	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	L2	Laser 2	Laser 2	20	1	t	2026-01-15 19:09:49.576369+00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, branch_id, order_type, status, booking_id, contact_id, request_reference, customer_first_name, customer_last_name, customer_phone, customer_email, customer_notes, requested_date, requested_time, participants_count, game_area, number_of_games, event_type, event_celebrant_age, pending_reason, pending_details, terms_accepted, terms_accepted_at, processed_at, processed_by, created_at, updated_at, source, cgv_token, cgv_validated_at, cgv_reminder_sent_at, cgv_reminder_count, payment_status, total_amount, deposit_amount, paid_amount, currency, icount_transaction_id, icount_confirmation_code, preauth_code, cc_last4, cc_type, payment_method, payment_notes, paid_at, payment_deadline, preauth_amount, preauth_cc_last4, preauth_cc_type, preauth_created_at, preauth_created_by, preauth_cancelled_at, preauth_cancelled_by, preauth_used_at, preauth_used_by, closed_at, closed_by, icount_invrec_id, icount_invrec_url) FROM stdin;
\.


--
-- Data for Name: payment_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_credentials (id, branch_id, provider, cid, username, password, is_active, last_connection_test, last_connection_status, last_connection_error, created_at, updated_at, created_by, updated_by) FROM stdin;
0561a562-4fa1-4bd7-9e0d-aa7eb347b50b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	icount	rishonlaser	rishonlezion	LASER2025.	t	2026-01-21 02:09:32.53+00	t	\N	2026-01-19 18:01:31.236875+00	2026-01-21 02:09:44.152005+00	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	245b421c-3bb5-4ee3-9f6b-10d367e0ce08
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, order_id, booking_id, contact_id, branch_id, amount, currency, payment_type, payment_method, status, icount_transaction_id, icount_confirmation_code, icount_document_id, icount_document_type, cc_last4, cc_type, check_number, check_bank, check_date, transfer_reference, notes, processed_by, created_at, updated_at, icount_doctype, icount_docnum, icount_doc_url) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, role, full_name, avatar_url, created_at, updated_at, first_name, last_name, phone, created_by, role_id) FROM stdin;
245b421c-3bb5-4ee3-9f6b-10d367e0ce08	super_admin	Jeremy	\N	2026-01-14 22:40:11.928509+00	2026-01-18 15:55:51.851043+00	Jeremy	Malai	0586266770	\N	39b483b8-87d6-4714-8c51-a93734cb8412
4d3e330e-07ca-470b-8d47-b9f5a9123d9b	branch_admin	\N	\N	2026-01-17 14:27:31.662784+00	2026-01-18 15:55:51.851043+00	Shimi	Elimeleh	0507247407	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	08841d69-38c6-42a5-8072-eb0b28f36428
94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	agent	\N	\N	2026-01-17 16:06:58.442868+00	2026-01-18 15:55:51.851043+00	Anaelle	Malai	0506326676	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	38ba158a-f95c-483c-bcbe-9f0b2e464d95
1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	viewer	\N	\N	2026-01-20 17:40:11.763872+00	2026-01-20 18:00:56.106918+00	Viewer	Viewer	0500000000	245b421c-3bb5-4ee3-9f6b-10d367e0ce08	18ff9956-f745-4789-9bcd-6e57f37f185b
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, role, resource, can_view, can_create, can_edit, can_delete, created_at, updated_at, role_id) FROM stdin;
25da031f-0a57-499f-bc9a-64d3bdf9b9a9	super_admin	permissions	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
6e708669-f967-411c-984c-4a9e1fb42985	super_admin	settings	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
822fb0f6-9f96-4cf9-8886-7cda31dfc1c1	super_admin	logs	t	f	f	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
27e97db4-6d1c-4095-8444-e8e5d2f280a9	super_admin	users	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
fceb9097-e746-40d7-84d8-8b14120a735b	super_admin	clients	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
0b8bb9ff-6c42-4e9a-8a3e-cfe311579d5f	super_admin	orders	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
9f298dae-ab9b-45a5-9185-f3d529c636fc	super_admin	agenda	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	39b483b8-87d6-4714-8c51-a93734cb8412
6c834377-09a3-4f8a-adfd-ea69ffc055f2	branch_admin	clients	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
449db94c-141e-455e-ae9a-e1a77f906f5b	branch_admin	logs	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
20823eb6-9d64-4518-b718-5743e4106f52	branch_admin	agenda	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
a5de75b2-4eed-4438-a289-da2b750e6cca	branch_admin	permissions	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
f9f6fb71-05c5-4806-a772-192d569498a8	branch_admin	settings	t	f	t	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
f3524009-f077-4814-b70b-05478a6ee05e	branch_admin	users	t	t	t	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
2bd8d4f2-8049-4864-9a4b-0dd7e641e3a6	branch_admin	orders	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	08841d69-38c6-42a5-8072-eb0b28f36428
156f1a9c-0588-4020-8e70-528a3fe28688	agent	clients	t	t	t	t	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
a6187350-8b0e-4e11-819d-840a5f9a8b1f	agent	permissions	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
db512d19-8265-4f06-9a00-9c37a2cbd20b	agent	settings	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
e1fadbe7-d8ae-4636-bf20-ce0f9c59a1da	agent	logs	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
b2b41371-0868-43ab-b897-ff217e123428	agent	users	f	f	f	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
c27dfeca-5544-424c-87b2-4607bc0eeaab	agent	orders	t	t	t	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
041e2d08-662c-49e4-8790-3efc9048cea1	agent	agenda	t	t	t	f	2026-01-18 13:14:45.058541+00	2026-01-18 13:14:45.058541+00	38ba158a-f95c-483c-bcbe-9f0b2e464d95
087458ff-a6d4-45a5-ab0b-ab895b1819f9	viewer	users	f	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
aa97cd37-bed0-4851-88ce-b4ce37fc95b4	viewer	settings	f	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
e842af94-bf5a-452d-80b0-32fa884082db	viewer	permissions	f	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
7e88c790-0827-4916-aac3-37052c1a68e7	viewer	agenda	t	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
7a1a191c-e8c5-4312-931d-b532c0d9d397	viewer	orders	t	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
d648a8dc-42ad-4a27-bb3b-76c2c8219e46	viewer	clients	t	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
258e65c5-67b0-4b70-af7e-e0bc144bf64f	viewer	logs	t	f	f	f	2026-01-20 17:31:57.47464+00	2026-01-20 17:31:57.47464+00	18ff9956-f745-4789-9bcd-6e57f37f185b
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, display_name, description, level, color, icon, is_system, created_at, updated_at) FROM stdin;
39b483b8-87d6-4714-8c51-a93734cb8412	super_admin	Super Admin	Full access to all features. Cannot be modified or deleted.	1	#EF4444	Shield	t	2026-01-18 15:55:21.795252+00	2026-01-18 15:55:21.795252+00
38ba158a-f95c-483c-bcbe-9f0b2e464d95	agent	Agent	Agent with limited access. Permissions can be customized.	7	#3B82F6	Users	f	2026-01-18 15:55:21.795252+00	2026-01-18 16:56:54.263254+00
08841d69-38c6-42a5-8072-eb0b28f36428	branch_admin	Branch Admin	Branch administration. Can manage users within their branches.	4	#8B5CF6	UserCog	f	2026-01-18 15:55:21.795252+00	2026-01-18 16:56:58.905907+00
18ff9956-f745-4789-9bcd-6e57f37f185b	viewer	Viewer	\N	9	#6B7280	User	f	2026-01-20 17:25:19.943597+00	2026-01-20 17:25:19.943597+00
\.


--
-- Data for Name: user_branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_branches (id, user_id, branch_id, created_at) FROM stdin;
4fb14aa7-628b-489e-b87f-8f3d5c6274e1	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	2026-01-18 10:36:21.37556+00
775e9fac-30f2-4310-8077-6e6b7ae70518	4d3e330e-07ca-470b-8d47-b9f5a9123d9b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	2026-01-18 10:36:21.37556+00
bc9e51f4-ca0a-4fea-9322-f6d27d19d3fa	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	2026-01-18 14:39:12.907976+00
b49bfaf8-b192-4d91-a40b-215886577071	94f1b8b3-8147-4ef0-81b0-c2e3c8541f7b	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	2026-01-18 14:39:12.907976+00
c30b33e0-db23-4c0d-8848-89a37e5352bf	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	9fa7c0b6-cf58-4a13-9fd6-db5dd2306362	2026-01-20 18:00:56.435456+00
cc125597-2e84-444f-968e-acaa556c222c	1b4dccaf-9daa-4ffd-91f0-fe95abe9884d	5e3b466e-0327-4ef6-ad5a-02a8ed4b367e	2026-01-20 18:00:56.435456+00
\.


--
-- Data for Name: messages_2026_01_18; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_18 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_19; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_19 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_23; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_23 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_24; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_24 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_01_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_01_25 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-01-14 20:25:14
20211116045059	2026-01-14 20:25:14
20211116050929	2026-01-14 20:25:14
20211116051442	2026-01-14 20:25:14
20211116212300	2026-01-14 20:25:14
20211116213355	2026-01-14 20:25:14
20211116213934	2026-01-14 20:25:14
20211116214523	2026-01-14 20:25:15
20211122062447	2026-01-14 20:25:15
20211124070109	2026-01-14 20:25:15
20211202204204	2026-01-14 20:25:15
20211202204605	2026-01-14 20:25:15
20211210212804	2026-01-14 20:25:15
20211228014915	2026-01-14 20:25:16
20220107221237	2026-01-14 20:25:16
20220228202821	2026-01-14 20:25:16
20220312004840	2026-01-14 20:25:16
20220603231003	2026-01-14 20:25:16
20220603232444	2026-01-14 20:25:16
20220615214548	2026-01-14 20:25:16
20220712093339	2026-01-14 20:25:16
20220908172859	2026-01-14 20:25:17
20220916233421	2026-01-14 20:25:17
20230119133233	2026-01-14 20:25:17
20230128025114	2026-01-14 20:25:17
20230128025212	2026-01-14 20:25:17
20230227211149	2026-01-14 20:25:17
20230228184745	2026-01-14 20:25:17
20230308225145	2026-01-14 20:25:17
20230328144023	2026-01-14 20:25:17
20231018144023	2026-01-14 20:25:18
20231204144023	2026-01-14 20:25:18
20231204144024	2026-01-14 20:25:18
20231204144025	2026-01-14 20:25:18
20240108234812	2026-01-14 20:25:18
20240109165339	2026-01-14 20:25:18
20240227174441	2026-01-14 20:25:18
20240311171622	2026-01-14 20:25:18
20240321100241	2026-01-14 20:25:19
20240401105812	2026-01-14 20:25:19
20240418121054	2026-01-14 20:25:19
20240523004032	2026-01-14 20:25:20
20240618124746	2026-01-14 20:25:20
20240801235015	2026-01-14 20:25:20
20240805133720	2026-01-14 20:25:20
20240827160934	2026-01-14 20:25:20
20240919163303	2026-01-14 20:25:20
20240919163305	2026-01-14 20:25:20
20241019105805	2026-01-14 20:25:20
20241030150047	2026-01-14 20:25:21
20241108114728	2026-01-14 20:25:21
20241121104152	2026-01-14 20:25:21
20241130184212	2026-01-14 20:25:21
20241220035512	2026-01-14 20:25:21
20241220123912	2026-01-14 20:25:21
20241224161212	2026-01-14 20:25:21
20250107150512	2026-01-14 20:25:22
20250110162412	2026-01-14 20:25:22
20250123174212	2026-01-14 20:25:22
20250128220012	2026-01-14 20:25:22
20250506224012	2026-01-14 20:25:22
20250523164012	2026-01-14 20:25:22
20250714121412	2026-01-14 20:25:22
20250905041441	2026-01-14 20:25:22
20251103001201	2026-01-14 20:25:22
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-01-14 20:25:16.322375
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-01-14 20:25:16.330501
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2026-01-14 20:25:16.334797
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-01-14 20:25:16.353392
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-01-14 20:25:16.364708
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-01-14 20:25:16.369916
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2026-01-14 20:25:16.376116
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-01-14 20:25:16.382288
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-01-14 20:25:16.386457
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2026-01-14 20:25:16.391021
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2026-01-14 20:25:16.396136
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-01-14 20:25:16.401229
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-01-14 20:25:16.406703
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-01-14 20:25:16.411601
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-01-14 20:25:16.416388
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-01-14 20:25:16.436964
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-01-14 20:25:16.441889
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-01-14 20:25:16.446294
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-01-14 20:25:16.450423
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-01-14 20:25:16.457804
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-01-14 20:25:16.464803
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-01-14 20:25:16.472337
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-01-14 20:25:16.489962
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-01-14 20:25:16.500065
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-01-14 20:25:16.505332
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-01-14 20:25:16.509644
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2026-01-14 20:25:16.514216
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2026-01-14 20:25:16.527555
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2026-01-14 20:25:16.57892
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2026-01-14 20:25:16.585422
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2026-01-14 20:25:16.590974
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2026-01-14 20:25:16.692513
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2026-01-14 20:25:16.699794
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2026-01-14 20:25:16.706569
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2026-01-14 20:25:16.708445
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2026-01-14 20:25:16.71386
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2026-01-14 20:25:16.718265
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-01-14 20:25:16.727514
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2026-01-14 20:25:16.732377
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2026-01-14 20:25:16.740845
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2026-01-14 20:25:16.746016
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2026-01-14 20:25:16.75402
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2026-01-14 20:25:16.759319
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2026-01-14 20:25:16.767159
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-01-14 20:25:16.778176
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-01-14 20:25:16.782705
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-01-14 20:25:16.798074
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-01-14 20:25:16.803329
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2026-01-14 20:25:16.807629
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-14 20:25:16.823451
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name, created_by, idempotency_key, rollback) FROM stdin;
20260118125349	{"-- Enable Realtime for critical tables\n-- This allows clients to subscribe to INSERT/UPDATE/DELETE events\n\n-- Bookings table - main agenda data\nALTER PUBLICATION supabase_realtime ADD TABLE bookings;\n\n-- Orders table - new orders from website\nALTER PUBLICATION supabase_realtime ADD TABLE orders;\n\n-- Game sessions - linked to bookings, affects agenda display\nALTER PUBLICATION supabase_realtime ADD TABLE game_sessions;\n\n-- Booking slots - linked to bookings\nALTER PUBLICATION supabase_realtime ADD TABLE booking_slots;\n\n-- Contacts - CRM data (optional but useful)\nALTER PUBLICATION supabase_realtime ADD TABLE contacts;\n\n-- Note: This enables broadcast of changes via Supabase Realtime\n-- Clients can subscribe using: supabase.channel('...').on('postgres_changes', ...)"}	enable_realtime_for_tables	jeremymalai@gmail.com	\N	\N
20260118131419	{"-- Activity Logs table for tracking all user actions\n-- Retention: 1 year (handled via scheduled cleanup)\n\nCREATE TABLE public.activity_logs (\n  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Who performed the action\n  user_id uuid REFERENCES auth.users(id) ON DELETE SET NULL,\n  user_role text NOT NULL CHECK (user_role IN ('super_admin', 'branch_admin', 'agent')),\n  user_name text NOT NULL, -- Snapshot of user name at action time\n  \n  -- What action was performed\n  action_type text NOT NULL CHECK (action_type IN (\n    'booking_created',\n    'booking_updated', \n    'booking_cancelled',\n    'booking_deleted',\n    'order_confirmed',\n    'order_cancelled',\n    'order_deleted',\n    'contact_created',\n    'contact_updated',\n    'contact_archived',\n    'contact_deleted',\n    'user_created',\n    'user_updated',\n    'user_deleted',\n    'user_login',\n    'user_logout',\n    'permission_changed',\n    'settings_updated',\n    'log_deleted'\n  )),\n  \n  -- What entity was affected\n  target_type text CHECK (target_type IN ('booking', 'order', 'contact', 'user', 'branch', 'settings', 'log')),\n  target_id uuid, -- ID of the affected entity\n  target_name text, -- Human-readable name/reference of the target\n  \n  -- Context\n  branch_id uuid REFERENCES public.branches(id) ON DELETE SET NULL,\n  \n  -- Additional details (JSON for flexibility)\n  details jsonb DEFAULT '{}',\n  \n  -- IP address for security auditing (optional)\n  ip_address text,\n  \n  -- Timestamps\n  created_at timestamptz NOT NULL DEFAULT now()\n);\n\n-- Indexes for efficient querying\nCREATE INDEX idx_activity_logs_user_id ON public.activity_logs(user_id);\nCREATE INDEX idx_activity_logs_action_type ON public.activity_logs(action_type);\nCREATE INDEX idx_activity_logs_target_type ON public.activity_logs(target_type);\nCREATE INDEX idx_activity_logs_branch_id ON public.activity_logs(branch_id);\nCREATE INDEX idx_activity_logs_created_at ON public.activity_logs(created_at DESC);\n\n-- Enable RLS\nALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;\n\n-- RLS Policies\n-- Super admins can read all logs\nCREATE POLICY \\"Super admins can read all logs\\"\n  ON public.activity_logs\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE profiles.id = auth.uid()\n      AND profiles.role = 'super_admin'\n    )\n  );\n\n-- Branch admins can read logs for their branches\nCREATE POLICY \\"Branch admins can read logs for their branches\\"\n  ON public.activity_logs\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles p\n      JOIN public.user_branches ub ON ub.user_id = p.id\n      WHERE p.id = auth.uid()\n      AND p.role = 'branch_admin'\n      AND ub.branch_id = activity_logs.branch_id\n    )\n  );\n\n-- Agents can read their own logs only\nCREATE POLICY \\"Agents can read their own logs\\"\n  ON public.activity_logs\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE profiles.id = auth.uid()\n      AND profiles.role = 'agent'\n      AND activity_logs.user_id = auth.uid()\n    )\n  );\n\n-- Only super admins can delete logs\nCREATE POLICY \\"Super admins can delete logs\\"\n  ON public.activity_logs\n  FOR DELETE\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE profiles.id = auth.uid()\n      AND profiles.role = 'super_admin'\n    )\n  );\n\n-- Anyone authenticated can insert logs (service will handle this)\nCREATE POLICY \\"Authenticated users can insert logs\\"\n  ON public.activity_logs\n  FOR INSERT\n  TO authenticated\n  WITH CHECK (true);\n\n-- Enable realtime for activity_logs\nALTER PUBLICATION supabase_realtime ADD TABLE public.activity_logs;\n\n-- Comment\nCOMMENT ON TABLE public.activity_logs IS 'Activity logs for auditing all user actions. Retention: 1 year.';"}	create_activity_logs_table	jeremymalai@gmail.com	\N	\N
20260118131445	{"-- Role Permissions table for granular access control\n-- Defines what each role can do on each resource type\n\nCREATE TABLE public.role_permissions (\n  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Role this permission applies to\n  role text NOT NULL CHECK (role IN ('super_admin', 'branch_admin', 'agent')),\n  \n  -- Resource/module this permission controls\n  resource text NOT NULL CHECK (resource IN (\n    'agenda',      -- Agenda/bookings view\n    'orders',      -- Orders management\n    'clients',     -- CRM/contacts\n    'users',       -- User management\n    'logs',        -- Activity logs\n    'settings',    -- Branch settings\n    'permissions'  -- Permission management itself\n  )),\n  \n  -- Actions allowed (granular permissions)\n  can_view boolean NOT NULL DEFAULT false,\n  can_create boolean NOT NULL DEFAULT false,\n  can_edit boolean NOT NULL DEFAULT false,\n  can_delete boolean NOT NULL DEFAULT false,\n  \n  -- Metadata\n  created_at timestamptz NOT NULL DEFAULT now(),\n  updated_at timestamptz NOT NULL DEFAULT now(),\n  \n  -- Unique constraint: one permission entry per role+resource combination\n  UNIQUE(role, resource)\n);\n\n-- Insert default permissions for each role\n\n-- SUPER_ADMIN: Full access to everything\nINSERT INTO public.role_permissions (role, resource, can_view, can_create, can_edit, can_delete) VALUES\n  ('super_admin', 'agenda', true, true, true, true),\n  ('super_admin', 'orders', true, true, true, true),\n  ('super_admin', 'clients', true, true, true, true),\n  ('super_admin', 'users', true, true, true, true),\n  ('super_admin', 'logs', true, false, false, true),  -- Can view and delete logs\n  ('super_admin', 'settings', true, true, true, true),\n  ('super_admin', 'permissions', true, true, true, true);\n\n-- BRANCH_ADMIN: Full access to branch resources, limited admin\nINSERT INTO public.role_permissions (role, resource, can_view, can_create, can_edit, can_delete) VALUES\n  ('branch_admin', 'agenda', true, true, true, true),\n  ('branch_admin', 'orders', true, true, true, true),\n  ('branch_admin', 'clients', true, true, true, true),\n  ('branch_admin', 'users', true, true, true, false),  -- Cannot delete users\n  ('branch_admin', 'logs', true, false, false, false), -- Can only view logs\n  ('branch_admin', 'settings', true, false, true, false), -- Can view and edit settings\n  ('branch_admin', 'permissions', false, false, false, false); -- No access to permissions\n\n-- AGENT: Limited operational access\nINSERT INTO public.role_permissions (role, resource, can_view, can_create, can_edit, can_delete) VALUES\n  ('agent', 'agenda', true, true, true, false),     -- Can manage bookings but not delete\n  ('agent', 'orders', true, true, true, false),     -- Can manage orders but not delete\n  ('agent', 'clients', true, true, true, false),    -- Can manage clients but not delete\n  ('agent', 'users', false, false, false, false),   -- No access to user management\n  ('agent', 'logs', false, false, false, false),    -- No access to logs\n  ('agent', 'settings', false, false, false, false), -- No access to settings\n  ('agent', 'permissions', false, false, false, false); -- No access to permissions\n\n-- Enable RLS\nALTER TABLE public.role_permissions ENABLE ROW LEVEL SECURITY;\n\n-- RLS Policies\n-- Everyone can read permissions (needed to check access)\nCREATE POLICY \\"Authenticated users can read permissions\\"\n  ON public.role_permissions\n  FOR SELECT\n  TO authenticated\n  USING (true);\n\n-- Only super admins can modify permissions\nCREATE POLICY \\"Super admins can modify permissions\\"\n  ON public.role_permissions\n  FOR ALL\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE profiles.id = auth.uid()\n      AND profiles.role = 'super_admin'\n    )\n  )\n  WITH CHECK (\n    EXISTS (\n      SELECT 1 FROM public.profiles\n      WHERE profiles.id = auth.uid()\n      AND profiles.role = 'super_admin'\n    )\n  );\n\n-- Create function to get user permissions\nCREATE OR REPLACE FUNCTION get_user_permissions(user_role text)\nRETURNS TABLE (\n  resource text,\n  can_view boolean,\n  can_create boolean,\n  can_edit boolean,\n  can_delete boolean\n)\nLANGUAGE sql\nSTABLE\nAS $$\n  SELECT \n    rp.resource,\n    rp.can_view,\n    rp.can_create,\n    rp.can_edit,\n    rp.can_delete\n  FROM public.role_permissions rp\n  WHERE rp.role = user_role;\n$$;\n\n-- Comment\nCOMMENT ON TABLE public.role_permissions IS 'Granular permission settings for each role and resource combination.';"}	create_role_permissions_table	jeremymalai@gmail.com	\N	\N
20260118155506	{"-- Create roles table for dynamic role management\nCREATE TABLE roles (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  name VARCHAR(50) UNIQUE NOT NULL,\n  display_name VARCHAR(100) NOT NULL,\n  description TEXT,\n  level INTEGER NOT NULL CHECK (level >= 1 AND level <= 10),\n  color VARCHAR(7) DEFAULT '#3B82F6',\n  icon VARCHAR(50) DEFAULT 'User',\n  is_system BOOLEAN DEFAULT FALSE,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n);\n\n-- Create indexes for faster lookups\nCREATE INDEX idx_roles_name ON roles(name);\nCREATE INDEX idx_roles_level ON roles(level);\n\n-- Enable RLS\nALTER TABLE roles ENABLE ROW LEVEL SECURITY;\n\n-- RLS Policy: All authenticated users can read roles\nCREATE POLICY \\"roles_select_authenticated\\" ON roles\n  FOR SELECT TO authenticated USING (true);\n\n-- Trigger to update updated_at\nCREATE OR REPLACE FUNCTION update_roles_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = NOW();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\nCREATE TRIGGER roles_updated_at_trigger\n  BEFORE UPDATE ON roles\n  FOR EACH ROW\n  EXECUTE FUNCTION update_roles_updated_at();"}	create_roles_table	jeremymalai@gmail.com	\N	\N
20260118155521	{"-- Insert default roles\nINSERT INTO roles (name, display_name, description, level, color, icon, is_system) VALUES\n  ('super_admin', 'Super Admin', 'Full access to all features. Cannot be modified or deleted.', 1, '#EF4444', 'Shield', TRUE),\n  ('branch_admin', 'Branch Admin', 'Branch administration. Can manage users within their branches.', 5, '#8B5CF6', 'UserCog', FALSE),\n  ('agent', 'Agent', 'Agent with limited access. Permissions can be customized.', 8, '#3B82F6', 'Users', FALSE);"}	seed_default_roles	jeremymalai@gmail.com	\N	\N
20260118155537	{"-- Add role_id column to profiles table (nullable for migration)\nALTER TABLE profiles ADD COLUMN role_id UUID REFERENCES roles(id);\n\n-- Add role_id column to role_permissions table (nullable for migration)\nALTER TABLE role_permissions ADD COLUMN role_id UUID REFERENCES roles(id) ON DELETE CASCADE;\n\n-- Create index for faster lookups\nCREATE INDEX idx_profiles_role_id ON profiles(role_id);\nCREATE INDEX idx_role_permissions_role_id ON role_permissions(role_id);"}	add_role_id_columns	jeremymalai@gmail.com	\N	\N
20260118155551	{"-- Migrate existing role data from string to role_id\n\n-- Update profiles.role_id based on existing role string\nUPDATE profiles p\nSET role_id = r.id\nFROM roles r\nWHERE p.role = r.name;\n\n-- Update role_permissions.role_id based on existing role string\nUPDATE role_permissions rp\nSET role_id = r.id\nFROM roles r\nWHERE rp.role = r.name;"}	migrate_role_data	jeremymalai@gmail.com	\N	\N
20260118183320	{"-- Fix Realtime subscription with RLS on orders table\n-- Realtime needs REPLICA IDENTITY FULL to apply RLS policies correctly\nALTER TABLE public.orders REPLICA IDENTITY FULL;"}	fix_orders_realtime_rls	jeremymalai@gmail.com	\N	\N
20260118183731	{"-- Option 1: Désactiver temporairement RLS sur orders pour tester si c'est bien la cause\n-- ALTER TABLE public.orders DISABLE ROW LEVEL SECURITY;\n\n-- Option 2: Ajouter une politique plus permissive pour les utilisateurs authentifiés\n-- D'abord, vérifions si le problème vient de la complexité de la politique\n\n-- Créer une politique simplifiée pour Realtime (SELECT seulement pour authenticated)\n-- Cette politique permet à tout utilisateur authentifié de voir les orders\n-- La restriction par branche sera gérée côté application\n\nDROP POLICY IF EXISTS \\"Users can view orders from their branches\\" ON public.orders;\n\n-- Nouvelle politique simplifiée - permet SELECT pour tous les authenticated\n-- Le filtrage par branche se fait via le filtre Realtime côté client\nCREATE POLICY \\"Authenticated users can view orders\\"\nON public.orders\nFOR SELECT\nTO authenticated\nUSING (true);\n\n-- Garder la politique pour super_admin et branch filtering côté app\n-- Le RLS sert maintenant juste à s'assurer que seuls les users authentifiés peuvent voir"}	fix_orders_realtime_rls_policy	jeremymalai@gmail.com	\N	\N
20260118184300	{"-- Désactiver RLS sur orders pour permettre Realtime de fonctionner\n-- La sécurité sera gérée côté application (API routes) comme pour les autres tables\nALTER TABLE public.orders DISABLE ROW LEVEL SECURITY;\n\n-- Note: Les policies restent en place mais ne sont plus appliquées\n-- On peut les réactiver plus tard si nécessaire"}	disable_orders_rls_for_realtime	jeremymalai@gmail.com	\N	\N
20260118185139	{"-- Réactiver RLS sur orders\nALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;\n\n-- Vérifier les policies existantes et les garder\n-- \\"Authenticated users can view orders\\" - USING (true)\n-- \\"Public can create orders\\" - WITH CHECK (true)\n-- \\"Users can update orders from their branches\\" - avec vérification branch"}	reenable_orders_rls	jeremymalai@gmail.com	\N	\N
20260118190405	{"-- Table pour stocker l'historique des emails envoyés\nCREATE TABLE IF NOT EXISTS email_logs (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Destinataire\n  recipient_email TEXT NOT NULL,\n  recipient_name TEXT,\n  \n  -- Template utilisé\n  template_id UUID,\n  template_code TEXT,\n  \n  -- Contenu\n  subject TEXT NOT NULL,\n  body_preview TEXT,\n  \n  -- Entité liée\n  entity_type TEXT, -- 'booking', 'order', 'contact'\n  entity_id UUID,\n  \n  -- Branche\n  branch_id UUID REFERENCES branches(id),\n  \n  -- Pièces jointes\n  attachments JSONB DEFAULT '[]'::jsonb,\n  \n  -- Statut\n  status TEXT NOT NULL DEFAULT 'pending', -- pending, sent, delivered, failed, bounced\n  error_message TEXT,\n  \n  -- Métadonnées\n  metadata JSONB DEFAULT '{}'::jsonb,\n  \n  -- Timestamps\n  sent_at TIMESTAMPTZ,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  \n  -- Qui a déclenché l'envoi (null = automatique)\n  triggered_by UUID REFERENCES profiles(id)\n);\n\n-- Index pour les recherches fréquentes\nCREATE INDEX idx_email_logs_status ON email_logs(status);\nCREATE INDEX idx_email_logs_entity ON email_logs(entity_type, entity_id);\nCREATE INDEX idx_email_logs_branch ON email_logs(branch_id);\nCREATE INDEX idx_email_logs_created_at ON email_logs(created_at DESC);\nCREATE INDEX idx_email_logs_recipient ON email_logs(recipient_email);\n\n-- RLS Policies\nALTER TABLE email_logs ENABLE ROW LEVEL SECURITY;\n\n-- Policy pour les admins authentifiés\nCREATE POLICY \\"Authenticated users can view email logs\\" ON email_logs\n  FOR SELECT TO authenticated\n  USING (true);\n\nCREATE POLICY \\"Authenticated users can insert email logs\\" ON email_logs\n  FOR INSERT TO authenticated\n  WITH CHECK (true);\n\nCREATE POLICY \\"Authenticated users can update email logs\\" ON email_logs\n  FOR UPDATE TO authenticated\n  USING (true);\n\n-- Service role a accès complet\nCREATE POLICY \\"Service role full access to email_logs\\" ON email_logs\n  FOR ALL TO service_role\n  USING (true)\n  WITH CHECK (true);"}	create_email_logs_table	jeremymalai@gmail.com	\N	\N
20260118190424	{"-- Table pour les templates d'emails\nCREATE TABLE IF NOT EXISTS email_templates (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Identification\n  code TEXT UNIQUE NOT NULL, -- 'booking_confirmation', 'reminder_24h', etc.\n  name TEXT NOT NULL, -- Nom affiché\n  description TEXT,\n  \n  -- Contenu du template\n  subject_template TEXT NOT NULL, -- Sujet avec variables {{client_name}}\n  body_template TEXT NOT NULL, -- HTML avec variables\n  \n  -- Configuration\n  is_active BOOLEAN DEFAULT true,\n  is_system BOOLEAN DEFAULT false, -- Templates système non supprimables\n  \n  -- Branche (NULL = global, tous les branches)\n  branch_id UUID REFERENCES branches(id),\n  \n  -- Variables disponibles pour ce template\n  available_variables JSONB DEFAULT '[]'::jsonb,\n  \n  -- Timestamps\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW(),\n  created_by UUID REFERENCES profiles(id)\n);\n\n-- Index\nCREATE INDEX idx_email_templates_code ON email_templates(code);\nCREATE INDEX idx_email_templates_branch ON email_templates(branch_id);\nCREATE INDEX idx_email_templates_active ON email_templates(is_active);\n\n-- RLS Policies\nALTER TABLE email_templates ENABLE ROW LEVEL SECURITY;\n\nCREATE POLICY \\"Authenticated users can view email templates\\" ON email_templates\n  FOR SELECT TO authenticated\n  USING (true);\n\nCREATE POLICY \\"Authenticated users can manage email templates\\" ON email_templates\n  FOR ALL TO authenticated\n  USING (true)\n  WITH CHECK (true);\n\nCREATE POLICY \\"Service role full access to email_templates\\" ON email_templates\n  FOR ALL TO service_role\n  USING (true)\n  WITH CHECK (true);\n\n-- Trigger pour updated_at\nCREATE OR REPLACE FUNCTION update_email_templates_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = NOW();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\nCREATE TRIGGER email_templates_updated_at\n  BEFORE UPDATE ON email_templates\n  FOR EACH ROW\n  EXECUTE FUNCTION update_email_templates_updated_at();"}	create_email_templates_table	jeremymalai@gmail.com	\N	\N
20260118190457	{"-- Table pour les paramètres email globaux\nCREATE TABLE IF NOT EXISTS email_settings (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Credentials SMTP (Gmail)\n  smtp_user TEXT,\n  smtp_password TEXT, -- App password\n  smtp_host TEXT DEFAULT 'smtp.gmail.com',\n  smtp_port INTEGER DEFAULT 587,\n  \n  -- Expéditeur par défaut\n  from_email TEXT,\n  from_name TEXT DEFAULT 'ActiveGames',\n  \n  -- URLs des logos pour les emails\n  logo_activegames_url TEXT,\n  logo_lasercity_url TEXT,\n  \n  -- Paramètres généraux\n  is_enabled BOOLEAN DEFAULT true,\n  \n  -- Timestamps\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n);\n\n-- RLS\nALTER TABLE email_settings ENABLE ROW LEVEL SECURITY;\n\nCREATE POLICY \\"Super admins can manage email settings\\" ON email_settings\n  FOR ALL TO authenticated\n  USING (true)\n  WITH CHECK (true);\n\n-- Créer le template de confirmation de réservation par défaut\nINSERT INTO email_templates (\n  code,\n  name,\n  description,\n  subject_template,\n  body_template,\n  is_active,\n  is_system,\n  available_variables\n) VALUES (\n  'booking_confirmation',\n  'Confirmation de réservation',\n  'Email envoyé automatiquement lors de la confirmation d''une réservation de jeux',\n  'Votre réservation est confirmée ✓ - Réf. {{booking_reference}}',\n  '<!DOCTYPE html>\n<html>\n<head>\n  <meta charset=\\"utf-8\\">\n  <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\n  <title>Confirmation de réservation</title>\n</head>\n<body style=\\"margin: 0; padding: 0; font-family: Arial, Helvetica, sans-serif; background-color: #f4f4f4;\\">\n  <table role=\\"presentation\\" style=\\"width: 100%; border-collapse: collapse;\\">\n    <tr>\n      <td align=\\"center\\" style=\\"padding: 40px 0;\\">\n        <table role=\\"presentation\\" style=\\"width: 600px; max-width: 100%; border-collapse: collapse; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);\\">\n          \n          <!-- Header avec logos -->\n          <tr>\n            <td style=\\"background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); padding: 30px; text-align: center;\\">\n              <img src=\\"{{logo_activegames_url}}\\" alt=\\"ActiveGames\\" style=\\"height: 50px; margin-right: 20px;\\">\n              <img src=\\"{{logo_lasercity_url}}\\" alt=\\"Laser City\\" style=\\"height: 50px;\\">\n            </td>\n          </tr>\n          \n          <!-- Titre confirmation -->\n          <tr>\n            <td style=\\"padding: 40px 30px 20px; text-align: center;\\">\n              <div style=\\"display: inline-block; background-color: #10b981; color: white; padding: 10px 25px; border-radius: 50px; font-size: 18px; font-weight: bold;\\">\n                ✓ Votre réservation est confirmée\n              </div>\n            </td>\n          </tr>\n          \n          <!-- Numéro de réservation -->\n          <tr>\n            <td style=\\"padding: 0 30px 30px; text-align: center;\\">\n              <p style=\\"color: #666; margin: 0 0 5px;\\">Numéro de réservation</p>\n              <p style=\\"color: #1a1a2e; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 2px;\\">{{booking_reference}}</p>\n            </td>\n          </tr>\n          \n          <!-- Détails de la réservation -->\n          <tr>\n            <td style=\\"padding: 0 30px 30px;\\">\n              <table role=\\"presentation\\" style=\\"width: 100%; border-collapse: collapse; background-color: #f8fafc; border-radius: 8px;\\">\n                <tr>\n                  <td style=\\"padding: 20px;\\">\n                    <table role=\\"presentation\\" style=\\"width: 100%; border-collapse: collapse;\\">\n                      <tr>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0;\\">\n                          <span style=\\"color: #64748b;\\">📅 Date</span>\n                        </td>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0; text-align: right; font-weight: bold; color: #1a1a2e;\\">\n                          {{booking_date}}\n                        </td>\n                      </tr>\n                      <tr>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0;\\">\n                          <span style=\\"color: #64748b;\\">🕐 Heure</span>\n                        </td>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0; text-align: right; font-weight: bold; color: #1a1a2e;\\">\n                          {{booking_time}}\n                        </td>\n                      </tr>\n                      <tr>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0;\\">\n                          <span style=\\"color: #64748b;\\">👥 Participants</span>\n                        </td>\n                        <td style=\\"padding: 10px 0; border-bottom: 1px solid #e2e8f0; text-align: right; font-weight: bold; color: #1a1a2e;\\">\n                          {{participants}} personnes\n                        </td>\n                      </tr>\n                      <tr>\n                        <td style=\\"padding: 10px 0;\\">\n                          <span style=\\"color: #64748b;\\">🎮 Type</span>\n                        </td>\n                        <td style=\\"padding: 10px 0; text-align: right; font-weight: bold; color: #1a1a2e;\\">\n                          {{booking_type}}\n                        </td>\n                      </tr>\n                    </table>\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n          \n          <!-- Adresse de la branche -->\n          <tr>\n            <td style=\\"padding: 0 30px 30px;\\">\n              <table role=\\"presentation\\" style=\\"width: 100%; border-collapse: collapse; background-color: #1a1a2e; border-radius: 8px; color: white;\\">\n                <tr>\n                  <td style=\\"padding: 20px;\\">\n                    <p style=\\"margin: 0 0 10px; font-weight: bold; font-size: 16px;\\">📍 {{branch_name}}</p>\n                    <p style=\\"margin: 0 0 5px; color: #94a3b8;\\">{{branch_address}}</p>\n                    <p style=\\"margin: 0 0 5px; color: #94a3b8;\\">📞 {{branch_phone}}</p>\n                    <p style=\\"margin: 0; color: #94a3b8;\\">✉️ {{branch_email}}</p>\n                  </td>\n                </tr>\n              </table>\n            </td>\n          </tr>\n          \n          <!-- Conditions générales -->\n          <tr>\n            <td style=\\"padding: 0 30px 30px;\\">\n              <div style=\\"background-color: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 0 8px 8px 0;\\">\n                <p style=\\"margin: 0 0 10px; font-weight: bold; color: #92400e;\\">📋 Conditions importantes</p>\n                <ul style=\\"margin: 0; padding-left: 20px; color: #78350f; font-size: 13px;\\">\n                  <li>Merci d''arriver 15 minutes avant l''heure prévue</li>\n                  <li>Portez des vêtements confortables et des chaussures fermées</li>\n                  <li>En cas d''annulation, prévenez-nous au moins 24h à l''avance</li>\n                  <li>Les mineurs doivent être accompagnés d''un adulte</li>\n                </ul>\n              </div>\n            </td>\n          </tr>\n          \n          <!-- Footer -->\n          <tr>\n            <td style=\\"background-color: #f1f5f9; padding: 20px 30px; text-align: center;\\">\n              <p style=\\"margin: 0 0 10px; color: #64748b; font-size: 13px;\\">\n                Des questions ? Répondez directement à cet email ou appelez-nous.\n              </p>\n              <p style=\\"margin: 0; color: #94a3b8; font-size: 12px;\\">\n                © {{current_year}} ActiveGames World. Tous droits réservés.\n              </p>\n            </td>\n          </tr>\n          \n        </table>\n      </td>\n    </tr>\n  </table>\n</body>\n</html>',\n  true,\n  true,\n  '[\\"booking_reference\\", \\"booking_date\\", \\"booking_time\\", \\"participants\\", \\"booking_type\\", \\"branch_name\\", \\"branch_address\\", \\"branch_phone\\", \\"branch_email\\", \\"logo_activegames_url\\", \\"logo_lasercity_url\\", \\"client_name\\", \\"client_email\\", \\"current_year\\"]'::jsonb\n) ON CONFLICT (code) DO NOTHING;"}	create_email_settings_and_default_template	jeremymalai@gmail.com	\N	\N
20260119161628	{"-- Supprimer les tables Phase 4\nDROP TABLE IF EXISTS invoices CASCADE;\nDROP TABLE IF EXISTS payments CASCADE;\nDROP TABLE IF EXISTS card_tokens CASCADE;\nDROP TABLE IF EXISTS products CASCADE;\nDROP TABLE IF EXISTS payment_settings CASCADE;\n\n-- Supprimer les colonnes ajoutées à orders\nALTER TABLE orders DROP COLUMN IF EXISTS payment_status;\nALTER TABLE orders DROP COLUMN IF EXISTS total_amount;\nALTER TABLE orders DROP COLUMN IF EXISTS deposit_amount;\nALTER TABLE orders DROP COLUMN IF EXISTS amount_paid;\nALTER TABLE orders DROP COLUMN IF EXISTS slot_hold_until;\n\n-- Supprimer la colonne ajoutée à contacts\nALTER TABLE contacts DROP COLUMN IF EXISTS provider_client_id;"}	cleanup_phase4_tables	jeremymalai@gmail.com	\N	\N
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 948, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 14477, true);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: ai_conversations ai_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_conversations
    ADD CONSTRAINT ai_conversations_pkey PRIMARY KEY (id);


--
-- Name: ai_messages ai_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_messages
    ADD CONSTRAINT ai_messages_pkey PRIMARY KEY (id);


--
-- Name: booking_contacts booking_contacts_booking_id_contact_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_contacts
    ADD CONSTRAINT booking_contacts_booking_id_contact_id_key UNIQUE (booking_id, contact_id);


--
-- Name: booking_contacts booking_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_contacts
    ADD CONSTRAINT booking_contacts_pkey PRIMARY KEY (id);


--
-- Name: booking_slots booking_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_slots
    ADD CONSTRAINT booking_slots_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_reference_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_reference_code_key UNIQUE (reference_code);


--
-- Name: branch_settings branch_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch_settings
    ADD CONSTRAINT branch_settings_pkey PRIMARY KEY (id);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: branches branches_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_slug_key UNIQUE (slug);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: email_settings email_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_settings
    ADD CONSTRAINT email_settings_pkey PRIMARY KEY (id);


--
-- Name: email_templates email_templates_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_code_key UNIQUE (code);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (id);


--
-- Name: event_rooms event_rooms_branch_id_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_rooms
    ADD CONSTRAINT event_rooms_branch_id_slug_key UNIQUE (branch_id, slug);


--
-- Name: event_rooms event_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_rooms
    ADD CONSTRAINT event_rooms_pkey PRIMARY KEY (id);


--
-- Name: game_sessions game_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_pkey PRIMARY KEY (id);


--
-- Name: icount_event_formulas icount_event_formulas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_event_formulas
    ADD CONSTRAINT icount_event_formulas_pkey PRIMARY KEY (id);


--
-- Name: icount_products icount_products_branch_id_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_products
    ADD CONSTRAINT icount_products_branch_id_code_key UNIQUE (branch_id, code);


--
-- Name: icount_products icount_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_products
    ADD CONSTRAINT icount_products_pkey PRIMARY KEY (id);


--
-- Name: icount_rooms icount_rooms_branch_id_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_rooms
    ADD CONSTRAINT icount_rooms_branch_id_code_key UNIQUE (branch_id, code);


--
-- Name: icount_rooms icount_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_rooms
    ADD CONSTRAINT icount_rooms_pkey PRIMARY KEY (id);


--
-- Name: laser_rooms laser_rooms_branch_id_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laser_rooms
    ADD CONSTRAINT laser_rooms_branch_id_slug_key UNIQUE (branch_id, slug);


--
-- Name: laser_rooms laser_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laser_rooms
    ADD CONSTRAINT laser_rooms_pkey PRIMARY KEY (id);


--
-- Name: orders orders_cgv_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_cgv_token_key UNIQUE (cgv_token);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: orders orders_request_reference_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_request_reference_key UNIQUE (request_reference);


--
-- Name: payment_credentials payment_credentials_branch_id_provider_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_credentials
    ADD CONSTRAINT payment_credentials_branch_id_provider_key UNIQUE (branch_id, provider);


--
-- Name: payment_credentials payment_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_credentials
    ADD CONSTRAINT payment_credentials_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_role_resource_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_resource_key UNIQUE (role, resource);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: user_branches user_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_branches
    ADD CONSTRAINT user_branches_pkey PRIMARY KEY (id);


--
-- Name: user_branches user_branches_user_id_branch_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_branches
    ADD CONSTRAINT user_branches_user_id_branch_id_key UNIQUE (user_id, branch_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_18 messages_2026_01_18_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_18
    ADD CONSTRAINT messages_2026_01_18_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_19 messages_2026_01_19_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_19
    ADD CONSTRAINT messages_2026_01_19_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_20 messages_2026_01_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_20
    ADD CONSTRAINT messages_2026_01_20_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_21 messages_2026_01_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_21
    ADD CONSTRAINT messages_2026_01_21_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_22 messages_2026_01_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_22
    ADD CONSTRAINT messages_2026_01_22_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_23 messages_2026_01_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_23
    ADD CONSTRAINT messages_2026_01_23_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_24 messages_2026_01_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_24
    ADD CONSTRAINT messages_2026_01_24_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_01_25 messages_2026_01_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_01_25
    ADD CONSTRAINT messages_2026_01_25_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_activity_logs_action_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_action_type ON public.activity_logs USING btree (action_type);


--
-- Name: idx_activity_logs_branch_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_branch_created ON public.activity_logs USING btree (branch_id, created_at DESC);


--
-- Name: idx_activity_logs_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_branch_id ON public.activity_logs USING btree (branch_id);


--
-- Name: idx_activity_logs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_created_at ON public.activity_logs USING btree (created_at DESC);


--
-- Name: idx_activity_logs_target_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_target_type ON public.activity_logs USING btree (target_type);


--
-- Name: idx_activity_logs_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_logs_user_id ON public.activity_logs USING btree (user_id);


--
-- Name: idx_ai_conversations_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_conversations_active ON public.ai_conversations USING btree (user_id, is_active) WHERE (is_active = true);


--
-- Name: idx_ai_conversations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_conversations_user_id ON public.ai_conversations USING btree (user_id);


--
-- Name: idx_ai_messages_conversation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_messages_conversation_id ON public.ai_messages USING btree (conversation_id);


--
-- Name: idx_ai_messages_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_messages_created_at ON public.ai_messages USING btree (conversation_id, created_at);


--
-- Name: idx_booking_contacts_booking; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_contacts_booking ON public.booking_contacts USING btree (booking_id);


--
-- Name: idx_booking_contacts_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_contacts_booking_id ON public.booking_contacts USING btree (booking_id);


--
-- Name: idx_booking_contacts_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_contacts_contact ON public.booking_contacts USING btree (contact_id);


--
-- Name: idx_booking_contacts_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_contacts_contact_id ON public.booking_contacts USING btree (contact_id);


--
-- Name: idx_booking_contacts_one_primary; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_booking_contacts_one_primary ON public.booking_contacts USING btree (booking_id) WHERE (is_primary = true);


--
-- Name: idx_booking_contacts_primary; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_contacts_primary ON public.booking_contacts USING btree (booking_id, is_primary) WHERE (is_primary = true);


--
-- Name: idx_booking_slots_booking; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_slots_booking ON public.booking_slots USING btree (booking_id);


--
-- Name: idx_booking_slots_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_slots_booking_id ON public.booking_slots USING btree (booking_id);


--
-- Name: idx_booking_slots_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_slots_branch ON public.booking_slots USING btree (branch_id);


--
-- Name: idx_booking_slots_slot_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_slots_slot_start ON public.booking_slots USING btree (slot_start);


--
-- Name: idx_bookings_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_branch ON public.bookings USING btree (branch_id);


--
-- Name: idx_bookings_branch_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_branch_date ON public.bookings USING btree (branch_id, start_datetime);


--
-- Name: idx_bookings_branch_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_branch_status ON public.bookings USING btree (branch_id, status);


--
-- Name: idx_bookings_primary_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_primary_contact ON public.bookings USING btree (primary_contact_id);


--
-- Name: idx_bookings_reference_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_reference_code ON public.bookings USING btree (reference_code);


--
-- Name: idx_bookings_start_datetime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_start_datetime ON public.bookings USING btree (start_datetime);


--
-- Name: idx_bookings_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_status ON public.bookings USING btree (status);


--
-- Name: idx_branch_settings_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_branch_settings_branch ON public.branch_settings USING btree (branch_id);


--
-- Name: idx_branches_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_branches_is_active ON public.branches USING btree (is_active);


--
-- Name: idx_branches_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_branches_slug ON public.branches USING btree (slug);


--
-- Name: idx_contacts_branch_main; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_branch_main ON public.contacts USING btree (branch_id_main);


--
-- Name: idx_contacts_branch_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_branch_phone ON public.contacts USING btree (branch_id_main, phone);


--
-- Name: idx_contacts_branch_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_branch_status ON public.contacts USING btree (branch_id_main, status);


--
-- Name: idx_contacts_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_email ON public.contacts USING btree (email) WHERE (email IS NOT NULL);


--
-- Name: idx_contacts_email_clean; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_email_clean ON public.contacts USING btree (email) WHERE (email IS NOT NULL);


--
-- Name: idx_contacts_icount_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_icount_client_id ON public.contacts USING btree (icount_client_id) WHERE (icount_client_id IS NOT NULL);


--
-- Name: idx_contacts_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_name ON public.contacts USING btree (last_name, first_name);


--
-- Name: idx_contacts_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_phone ON public.contacts USING btree (phone);


--
-- Name: idx_contacts_phone_clean; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_phone_clean ON public.contacts USING btree (phone) WHERE (phone ~ '^05[0-9]{8}$'::text);


--
-- Name: idx_contacts_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_status ON public.contacts USING btree (status) WHERE (status = 'active'::text);


--
-- Name: idx_email_logs_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_branch ON public.email_logs USING btree (branch_id);


--
-- Name: idx_email_logs_branch_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_branch_created ON public.email_logs USING btree (branch_id, created_at DESC);


--
-- Name: idx_email_logs_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_created ON public.email_logs USING btree (created_at DESC);


--
-- Name: idx_email_logs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_created_at ON public.email_logs USING btree (created_at DESC);


--
-- Name: idx_email_logs_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_entity ON public.email_logs USING btree (entity_type, entity_id);


--
-- Name: idx_email_logs_recipient; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_recipient ON public.email_logs USING btree (recipient_email);


--
-- Name: idx_email_logs_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_logs_status ON public.email_logs USING btree (status);


--
-- Name: idx_email_templates_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_templates_active ON public.email_templates USING btree (is_active);


--
-- Name: idx_email_templates_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_templates_branch ON public.email_templates USING btree (branch_id);


--
-- Name: idx_email_templates_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_email_templates_code ON public.email_templates USING btree (code);


--
-- Name: idx_event_formulas_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_formulas_product_id ON public.icount_event_formulas USING btree (product_id);


--
-- Name: idx_event_rooms_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_rooms_branch ON public.event_rooms USING btree (branch_id);


--
-- Name: idx_event_rooms_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_rooms_is_active ON public.event_rooms USING btree (is_active);


--
-- Name: idx_game_sessions_booking; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_sessions_booking ON public.game_sessions USING btree (booking_id);


--
-- Name: idx_game_sessions_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_sessions_booking_id ON public.game_sessions USING btree (booking_id);


--
-- Name: idx_game_sessions_game_area; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_sessions_game_area ON public.game_sessions USING btree (game_area);


--
-- Name: idx_game_sessions_laser_room; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_sessions_laser_room ON public.game_sessions USING btree (laser_room_id);


--
-- Name: idx_game_sessions_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_sessions_start ON public.game_sessions USING btree (start_datetime);


--
-- Name: idx_icount_event_formulas_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_event_formulas_branch_id ON public.icount_event_formulas USING btree (branch_id);


--
-- Name: idx_icount_event_formulas_game_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_event_formulas_game_type ON public.icount_event_formulas USING btree (game_type);


--
-- Name: idx_icount_products_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_products_branch_id ON public.icount_products USING btree (branch_id);


--
-- Name: idx_icount_products_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_products_code ON public.icount_products USING btree (code);


--
-- Name: idx_icount_products_icount_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_products_icount_item_id ON public.icount_products USING btree (icount_item_id) WHERE (icount_item_id IS NOT NULL);


--
-- Name: idx_icount_rooms_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_rooms_branch_id ON public.icount_rooms USING btree (branch_id);


--
-- Name: idx_icount_rooms_icount_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_icount_rooms_icount_item_id ON public.icount_rooms USING btree (icount_item_id) WHERE (icount_item_id IS NOT NULL);


--
-- Name: idx_laser_rooms_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_laser_rooms_branch ON public.laser_rooms USING btree (branch_id);


--
-- Name: idx_laser_rooms_is_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_laser_rooms_is_active ON public.laser_rooms USING btree (is_active);


--
-- Name: idx_orders_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_booking_id ON public.orders USING btree (booking_id);


--
-- Name: idx_orders_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_branch_id ON public.orders USING btree (branch_id);


--
-- Name: idx_orders_branch_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_branch_status ON public.orders USING btree (branch_id, status);


--
-- Name: idx_orders_cgv_pending; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_cgv_pending ON public.orders USING btree (source, cgv_token, cgv_validated_at) WHERE ((source = 'admin_agenda'::text) AND (cgv_token IS NOT NULL) AND (cgv_validated_at IS NULL));


--
-- Name: idx_orders_cgv_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_cgv_token ON public.orders USING btree (cgv_token) WHERE (cgv_token IS NOT NULL);


--
-- Name: idx_orders_closed_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_closed_at ON public.orders USING btree (closed_at) WHERE (closed_at IS NOT NULL);


--
-- Name: idx_orders_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_contact_id ON public.orders USING btree (contact_id);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at DESC);


--
-- Name: idx_orders_payment_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_payment_status ON public.orders USING btree (payment_status);


--
-- Name: idx_orders_requested_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_requested_date ON public.orders USING btree (requested_date);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- Name: idx_payment_credentials_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_credentials_branch ON public.payment_credentials USING btree (branch_id);


--
-- Name: idx_payment_credentials_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_credentials_provider ON public.payment_credentials USING btree (provider);


--
-- Name: idx_payments_booking_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_booking_id ON public.payments USING btree (booking_id);


--
-- Name: idx_payments_branch_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_branch_id ON public.payments USING btree (branch_id);


--
-- Name: idx_payments_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_contact_id ON public.payments USING btree (contact_id);


--
-- Name: idx_payments_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_created_at ON public.payments USING btree (created_at);


--
-- Name: idx_payments_icount_docnum; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_icount_docnum ON public.payments USING btree (icount_doctype, icount_docnum) WHERE (icount_docnum IS NOT NULL);


--
-- Name: idx_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_order_id ON public.payments USING btree (order_id);


--
-- Name: idx_payments_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_status ON public.payments USING btree (status);


--
-- Name: idx_profiles_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_created_by ON public.profiles USING btree (created_by);


--
-- Name: idx_profiles_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_phone ON public.profiles USING btree (phone);


--
-- Name: idx_profiles_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_role ON public.profiles USING btree (role);


--
-- Name: idx_profiles_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_role_id ON public.profiles USING btree (role_id);


--
-- Name: idx_role_permissions_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_permissions_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: idx_roles_level; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_roles_level ON public.roles USING btree (level);


--
-- Name: idx_roles_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_roles_name ON public.roles USING btree (name);


--
-- Name: idx_user_branches_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_branches_branch ON public.user_branches USING btree (branch_id);


--
-- Name: idx_user_branches_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_branches_user ON public.user_branches USING btree (user_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_18_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_18_inserted_at_topic_idx ON realtime.messages_2026_01_18 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_19_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_19_inserted_at_topic_idx ON realtime.messages_2026_01_19 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_20_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_20_inserted_at_topic_idx ON realtime.messages_2026_01_20 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_21_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_21_inserted_at_topic_idx ON realtime.messages_2026_01_21 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_22_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_22_inserted_at_topic_idx ON realtime.messages_2026_01_22 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_23_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_23_inserted_at_topic_idx ON realtime.messages_2026_01_23 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_24_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_24_inserted_at_topic_idx ON realtime.messages_2026_01_24 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_01_25_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_01_25_inserted_at_topic_idx ON realtime.messages_2026_01_25 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: messages_2026_01_18_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_18_inserted_at_topic_idx;


--
-- Name: messages_2026_01_18_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_18_pkey;


--
-- Name: messages_2026_01_19_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_19_inserted_at_topic_idx;


--
-- Name: messages_2026_01_19_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_19_pkey;


--
-- Name: messages_2026_01_20_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_20_inserted_at_topic_idx;


--
-- Name: messages_2026_01_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_20_pkey;


--
-- Name: messages_2026_01_21_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_21_inserted_at_topic_idx;


--
-- Name: messages_2026_01_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_21_pkey;


--
-- Name: messages_2026_01_22_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_22_inserted_at_topic_idx;


--
-- Name: messages_2026_01_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_22_pkey;


--
-- Name: messages_2026_01_23_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_23_inserted_at_topic_idx;


--
-- Name: messages_2026_01_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_23_pkey;


--
-- Name: messages_2026_01_24_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_24_inserted_at_topic_idx;


--
-- Name: messages_2026_01_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_24_pkey;


--
-- Name: messages_2026_01_25_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_01_25_inserted_at_topic_idx;


--
-- Name: messages_2026_01_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_01_25_pkey;


--
-- Name: email_templates email_templates_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER email_templates_updated_at BEFORE UPDATE ON public.email_templates FOR EACH ROW EXECUTE FUNCTION public.update_email_templates_updated_at();


--
-- Name: roles roles_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER roles_updated_at_trigger BEFORE UPDATE ON public.roles FOR EACH ROW EXECUTE FUNCTION public.update_roles_updated_at();


--
-- Name: branches trg_seed_icount_products; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_seed_icount_products AFTER INSERT ON public.branches FOR EACH ROW EXECUTE FUNCTION public.trigger_seed_icount_products();


--
-- Name: orders trigger_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.update_orders_updated_at();


--
-- Name: ai_messages trigger_update_ai_conversation_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_ai_conversation_timestamp AFTER INSERT ON public.ai_messages FOR EACH ROW EXECUTE FUNCTION public.update_ai_conversation_timestamp();


--
-- Name: payment_credentials trigger_update_payment_credentials_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_payment_credentials_updated_at BEFORE UPDATE ON public.payment_credentials FOR EACH ROW EXECUTE FUNCTION public.update_payment_credentials_updated_at();


--
-- Name: payments trigger_update_payments_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.update_payments_updated_at();


--
-- Name: bookings update_bookings_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: branch_settings update_branch_settings_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_branch_settings_updated_at BEFORE UPDATE ON public.branch_settings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: branches update_branches_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_branches_updated_at BEFORE UPDATE ON public.branches FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contacts update_contacts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_contacts_updated_at BEFORE UPDATE ON public.contacts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: email_templates update_email_templates_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_email_templates_updated_at BEFORE UPDATE ON public.email_templates FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: profiles update_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: activity_logs activity_logs_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE SET NULL;


--
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: ai_conversations ai_conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_conversations
    ADD CONSTRAINT ai_conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: ai_messages ai_messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_messages
    ADD CONSTRAINT ai_messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.ai_conversations(id) ON DELETE CASCADE;


--
-- Name: booking_contacts booking_contacts_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_contacts
    ADD CONSTRAINT booking_contacts_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_contacts booking_contacts_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_contacts
    ADD CONSTRAINT booking_contacts_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(id) ON DELETE CASCADE;


--
-- Name: booking_slots booking_slots_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_slots
    ADD CONSTRAINT booking_slots_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_slots booking_slots_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_slots
    ADD CONSTRAINT booking_slots_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_event_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_event_room_id_fkey FOREIGN KEY (event_room_id) REFERENCES public.event_rooms(id) ON DELETE SET NULL;


--
-- Name: bookings bookings_primary_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_primary_contact_id_fkey FOREIGN KEY (primary_contact_id) REFERENCES public.contacts(id) ON DELETE SET NULL;


--
-- Name: branch_settings branch_settings_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch_settings
    ADD CONSTRAINT branch_settings_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: contacts contacts_branch_id_main_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_branch_id_main_fkey FOREIGN KEY (branch_id_main) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: contacts contacts_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- Name: contacts contacts_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id);


--
-- Name: email_logs email_logs_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: email_logs email_logs_triggered_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_triggered_by_fkey FOREIGN KEY (triggered_by) REFERENCES public.profiles(id);


--
-- Name: email_templates email_templates_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: email_templates email_templates_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: event_rooms event_rooms_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_rooms
    ADD CONSTRAINT event_rooms_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: game_sessions game_sessions_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: game_sessions game_sessions_laser_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_laser_room_id_fkey FOREIGN KEY (laser_room_id) REFERENCES public.laser_rooms(id) ON DELETE SET NULL;


--
-- Name: icount_event_formulas icount_event_formulas_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_event_formulas
    ADD CONSTRAINT icount_event_formulas_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: icount_event_formulas icount_event_formulas_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_event_formulas
    ADD CONSTRAINT icount_event_formulas_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.icount_products(id) ON DELETE SET NULL;


--
-- Name: icount_event_formulas icount_event_formulas_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_event_formulas
    ADD CONSTRAINT icount_event_formulas_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.icount_rooms(id);


--
-- Name: icount_products icount_products_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_products
    ADD CONSTRAINT icount_products_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: icount_rooms icount_rooms_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icount_rooms
    ADD CONSTRAINT icount_rooms_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: laser_rooms laser_rooms_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laser_rooms
    ADD CONSTRAINT laser_rooms_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: orders orders_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE SET NULL;


--
-- Name: orders orders_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE SET NULL;


--
-- Name: orders orders_closed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_closed_by_fkey FOREIGN KEY (closed_by) REFERENCES auth.users(id);


--
-- Name: orders orders_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(id) ON DELETE SET NULL;


--
-- Name: orders orders_preauth_cancelled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_preauth_cancelled_by_fkey FOREIGN KEY (preauth_cancelled_by) REFERENCES auth.users(id);


--
-- Name: orders orders_preauth_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_preauth_created_by_fkey FOREIGN KEY (preauth_created_by) REFERENCES auth.users(id);


--
-- Name: orders orders_preauth_used_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_preauth_used_by_fkey FOREIGN KEY (preauth_used_by) REFERENCES auth.users(id);


--
-- Name: orders orders_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: payment_credentials payment_credentials_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_credentials
    ADD CONSTRAINT payment_credentials_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: payment_credentials payment_credentials_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_credentials
    ADD CONSTRAINT payment_credentials_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: payment_credentials payment_credentials_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_credentials
    ADD CONSTRAINT payment_credentials_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: payments payments_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE SET NULL;


--
-- Name: payments payments_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: payments payments_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(id) ON DELETE SET NULL;


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: payments payments_processed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_processed_by_fkey FOREIGN KEY (processed_by) REFERENCES auth.users(id);


--
-- Name: profiles profiles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_branches user_branches_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_branches
    ADD CONSTRAINT user_branches_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: user_branches user_branches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_branches
    ADD CONSTRAINT user_branches_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: activity_logs Agents can read their own logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Agents can read their own logs" ON public.activity_logs FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'agent'::text) AND (activity_logs.user_id = auth.uid())))));


--
-- Name: icount_event_formulas Allow authenticated to view event formulas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated to view event formulas" ON public.icount_event_formulas FOR SELECT TO authenticated USING (true);


--
-- Name: icount_rooms Allow authenticated to view rooms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated to view rooms" ON public.icount_rooms FOR SELECT TO authenticated USING (true);


--
-- Name: icount_products Allow authenticated users to view products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated users to view products" ON public.icount_products FOR SELECT TO authenticated USING (true);


--
-- Name: icount_event_formulas Allow service role full access event formulas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow service role full access event formulas" ON public.icount_event_formulas TO service_role USING (true) WITH CHECK (true);


--
-- Name: icount_rooms Allow service role full access rooms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow service role full access rooms" ON public.icount_rooms TO service_role USING (true) WITH CHECK (true);


--
-- Name: icount_products Allow service role full access to products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow service role full access to products" ON public.icount_products TO service_role USING (true) WITH CHECK (true);


--
-- Name: email_logs Authenticated users can insert email logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can insert email logs" ON public.email_logs FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: activity_logs Authenticated users can insert logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can insert logs" ON public.activity_logs FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: email_templates Authenticated users can manage email templates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can manage email templates" ON public.email_templates TO authenticated USING (true) WITH CHECK (true);


--
-- Name: role_permissions Authenticated users can read permissions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can read permissions" ON public.role_permissions FOR SELECT TO authenticated USING (true);


--
-- Name: email_logs Authenticated users can update email logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can update email logs" ON public.email_logs FOR UPDATE TO authenticated USING (true);


--
-- Name: email_logs Authenticated users can view email logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view email logs" ON public.email_logs FOR SELECT TO authenticated USING (true);


--
-- Name: email_templates Authenticated users can view email templates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view email templates" ON public.email_templates FOR SELECT TO authenticated USING (true);


--
-- Name: orders Authenticated users can view orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view orders" ON public.orders FOR SELECT TO authenticated USING (true);


--
-- Name: payments Branch admin can manage payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Branch admin can manage payments" ON public.payments TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.profiles p
     JOIN public.user_branches ub ON ((ub.user_id = p.id)))
  WHERE ((p.id = auth.uid()) AND (p.role = ANY (ARRAY['super_admin'::text, 'branch_admin'::text])) AND (ub.branch_id = payments.branch_id)))));


--
-- Name: activity_logs Branch admins can read logs for their branches; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Branch admins can read logs for their branches" ON public.activity_logs FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.profiles p
     JOIN public.user_branches ub ON ((ub.user_id = p.id)))
  WHERE ((p.id = auth.uid()) AND (p.role = 'branch_admin'::text) AND (ub.branch_id = activity_logs.branch_id)))));


--
-- Name: payments Branch users can view payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Branch users can view payments" ON public.payments FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.user_branches
  WHERE ((user_branches.user_id = auth.uid()) AND (user_branches.branch_id = payments.branch_id)))));


--
-- Name: orders Public can create orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can create orders" ON public.orders FOR INSERT WITH CHECK (true);


--
-- Name: ai_conversations Service role full access conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role full access conversations" ON public.ai_conversations USING (((auth.jwt() ->> 'role'::text) = 'service_role'::text));


--
-- Name: ai_messages Service role full access messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role full access messages" ON public.ai_messages USING (((auth.jwt() ->> 'role'::text) = 'service_role'::text));


--
-- Name: email_logs Service role full access to email_logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role full access to email_logs" ON public.email_logs TO service_role USING (true) WITH CHECK (true);


--
-- Name: email_templates Service role full access to email_templates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role full access to email_templates" ON public.email_templates TO service_role USING (true) WITH CHECK (true);


--
-- Name: payments Super admin can manage all payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admin can manage all payments" ON public.payments TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text)))));


--
-- Name: activity_logs Super admins can delete logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admins can delete logs" ON public.activity_logs FOR DELETE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text)))));


--
-- Name: email_settings Super admins can manage email settings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admins can manage email settings" ON public.email_settings TO authenticated USING (true) WITH CHECK (true);


--
-- Name: payment_credentials Super admins can manage payment credentials; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admins can manage payment credentials" ON public.payment_credentials TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text)))));


--
-- Name: role_permissions Super admins can modify permissions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admins can modify permissions" ON public.role_permissions TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text)))));


--
-- Name: activity_logs Super admins can read all logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Super admins can read all logs" ON public.activity_logs FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text)))));


--
-- Name: ai_conversations Users can create own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own conversations" ON public.ai_conversations FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: ai_conversations Users can delete own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own conversations" ON public.ai_conversations FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: ai_messages Users can insert messages to own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert messages to own conversations" ON public.ai_messages FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.ai_conversations
  WHERE ((ai_conversations.id = ai_messages.conversation_id) AND (ai_conversations.user_id = auth.uid())))));


--
-- Name: orders Users can update orders from their branches; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update orders from their branches" ON public.orders FOR UPDATE USING (((branch_id IN ( SELECT user_branches.branch_id
   FROM public.user_branches
  WHERE (user_branches.user_id = auth.uid()))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::text))))));


--
-- Name: ai_conversations Users can update own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own conversations" ON public.ai_conversations FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: ai_messages Users can view messages of own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view messages of own conversations" ON public.ai_messages FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.ai_conversations
  WHERE ((ai_conversations.id = ai_messages.conversation_id) AND (ai_conversations.user_id = auth.uid())))));


--
-- Name: ai_conversations Users can view own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own conversations" ON public.ai_conversations FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: activity_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_conversations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_conversations ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: email_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.email_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: email_logs email_logs_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_logs_delete_policy ON public.email_logs FOR DELETE USING (true);


--
-- Name: email_logs email_logs_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_logs_insert_policy ON public.email_logs FOR INSERT WITH CHECK (true);


--
-- Name: email_logs email_logs_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_logs_select_policy ON public.email_logs FOR SELECT USING (true);


--
-- Name: email_logs email_logs_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_logs_update_policy ON public.email_logs FOR UPDATE USING (true);


--
-- Name: email_settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.email_settings ENABLE ROW LEVEL SECURITY;

--
-- Name: email_templates; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.email_templates ENABLE ROW LEVEL SECURITY;

--
-- Name: email_templates email_templates_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_templates_delete_policy ON public.email_templates FOR DELETE USING ((is_system = false));


--
-- Name: email_templates email_templates_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_templates_insert_policy ON public.email_templates FOR INSERT WITH CHECK (true);


--
-- Name: email_templates email_templates_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_templates_select_policy ON public.email_templates FOR SELECT USING (true);


--
-- Name: email_templates email_templates_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY email_templates_update_policy ON public.email_templates FOR UPDATE USING (true);


--
-- Name: icount_event_formulas; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.icount_event_formulas ENABLE ROW LEVEL SECURITY;

--
-- Name: icount_products; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.icount_products ENABLE ROW LEVEL SECURITY;

--
-- Name: icount_rooms; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.icount_rooms ENABLE ROW LEVEL SECURITY;

--
-- Name: orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

--
-- Name: payment_credentials; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.payment_credentials ENABLE ROW LEVEL SECURITY;

--
-- Name: payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

--
-- Name: role_permissions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.role_permissions ENABLE ROW LEVEL SECURITY;

--
-- Name: roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;

--
-- Name: roles roles_select_authenticated; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY roles_select_authenticated ON public.roles FOR SELECT TO authenticated USING (true);


--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime activity_logs; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.activity_logs;


--
-- Name: supabase_realtime booking_slots; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.booking_slots;


--
-- Name: supabase_realtime bookings; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.bookings;


--
-- Name: supabase_realtime contacts; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.contacts;


--
-- Name: supabase_realtime game_sessions; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.game_sessions;


--
-- Name: supabase_realtime orders; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.orders;


--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION clean_israeli_phone(phone_input text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.clean_israeli_phone(phone_input text) TO anon;
GRANT ALL ON FUNCTION public.clean_israeli_phone(phone_input text) TO authenticated;
GRANT ALL ON FUNCTION public.clean_israeli_phone(phone_input text) TO service_role;


--
-- Name: FUNCTION generate_order_request_reference(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_order_request_reference() TO anon;
GRANT ALL ON FUNCTION public.generate_order_request_reference() TO authenticated;
GRANT ALL ON FUNCTION public.generate_order_request_reference() TO service_role;


--
-- Name: FUNCTION get_user_permissions(user_role text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_user_permissions(user_role text) TO anon;
GRANT ALL ON FUNCTION public.get_user_permissions(user_role text) TO authenticated;
GRANT ALL ON FUNCTION public.get_user_permissions(user_role text) TO service_role;


--
-- Name: FUNCTION is_valid_email(email_input text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_valid_email(email_input text) TO anon;
GRANT ALL ON FUNCTION public.is_valid_email(email_input text) TO authenticated;
GRANT ALL ON FUNCTION public.is_valid_email(email_input text) TO service_role;


--
-- Name: FUNCTION seed_icount_data_for_branch(p_branch_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.seed_icount_data_for_branch(p_branch_id uuid) TO anon;
GRANT ALL ON FUNCTION public.seed_icount_data_for_branch(p_branch_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.seed_icount_data_for_branch(p_branch_id uuid) TO service_role;


--
-- Name: FUNCTION seed_icount_products_for_branch(p_branch_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.seed_icount_products_for_branch(p_branch_id uuid) TO anon;
GRANT ALL ON FUNCTION public.seed_icount_products_for_branch(p_branch_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.seed_icount_products_for_branch(p_branch_id uuid) TO service_role;


--
-- Name: FUNCTION trigger_seed_icount_products(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trigger_seed_icount_products() TO anon;
GRANT ALL ON FUNCTION public.trigger_seed_icount_products() TO authenticated;
GRANT ALL ON FUNCTION public.trigger_seed_icount_products() TO service_role;


--
-- Name: FUNCTION update_ai_conversation_timestamp(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_ai_conversation_timestamp() TO anon;
GRANT ALL ON FUNCTION public.update_ai_conversation_timestamp() TO authenticated;
GRANT ALL ON FUNCTION public.update_ai_conversation_timestamp() TO service_role;


--
-- Name: FUNCTION update_email_templates_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_email_templates_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_email_templates_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_email_templates_updated_at() TO service_role;


--
-- Name: FUNCTION update_orders_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_orders_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_orders_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_orders_updated_at() TO service_role;


--
-- Name: FUNCTION update_payment_credentials_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_payment_credentials_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_payment_credentials_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_payment_credentials_updated_at() TO service_role;


--
-- Name: FUNCTION update_payments_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_payments_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_payments_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_payments_updated_at() TO service_role;


--
-- Name: FUNCTION update_roles_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_roles_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_roles_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_roles_updated_at() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE activity_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.activity_logs TO anon;
GRANT ALL ON TABLE public.activity_logs TO authenticated;
GRANT ALL ON TABLE public.activity_logs TO service_role;


--
-- Name: TABLE ai_conversations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ai_conversations TO anon;
GRANT ALL ON TABLE public.ai_conversations TO authenticated;
GRANT ALL ON TABLE public.ai_conversations TO service_role;


--
-- Name: TABLE ai_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ai_messages TO anon;
GRANT ALL ON TABLE public.ai_messages TO authenticated;
GRANT ALL ON TABLE public.ai_messages TO service_role;


--
-- Name: TABLE booking_contacts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.booking_contacts TO anon;
GRANT ALL ON TABLE public.booking_contacts TO authenticated;
GRANT ALL ON TABLE public.booking_contacts TO service_role;


--
-- Name: TABLE booking_slots; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.booking_slots TO anon;
GRANT ALL ON TABLE public.booking_slots TO authenticated;
GRANT ALL ON TABLE public.booking_slots TO service_role;


--
-- Name: TABLE bookings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bookings TO anon;
GRANT ALL ON TABLE public.bookings TO authenticated;
GRANT ALL ON TABLE public.bookings TO service_role;


--
-- Name: TABLE branch_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.branch_settings TO anon;
GRANT ALL ON TABLE public.branch_settings TO authenticated;
GRANT ALL ON TABLE public.branch_settings TO service_role;


--
-- Name: TABLE branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.branches TO anon;
GRANT ALL ON TABLE public.branches TO authenticated;
GRANT ALL ON TABLE public.branches TO service_role;


--
-- Name: TABLE contacts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.contacts TO anon;
GRANT ALL ON TABLE public.contacts TO authenticated;
GRANT ALL ON TABLE public.contacts TO service_role;


--
-- Name: TABLE email_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.email_logs TO anon;
GRANT ALL ON TABLE public.email_logs TO authenticated;
GRANT ALL ON TABLE public.email_logs TO service_role;


--
-- Name: TABLE email_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.email_settings TO anon;
GRANT ALL ON TABLE public.email_settings TO authenticated;
GRANT ALL ON TABLE public.email_settings TO service_role;


--
-- Name: TABLE email_templates; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.email_templates TO anon;
GRANT ALL ON TABLE public.email_templates TO authenticated;
GRANT ALL ON TABLE public.email_templates TO service_role;


--
-- Name: TABLE event_rooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.event_rooms TO anon;
GRANT ALL ON TABLE public.event_rooms TO authenticated;
GRANT ALL ON TABLE public.event_rooms TO service_role;


--
-- Name: TABLE game_sessions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.game_sessions TO anon;
GRANT ALL ON TABLE public.game_sessions TO authenticated;
GRANT ALL ON TABLE public.game_sessions TO service_role;


--
-- Name: TABLE icount_event_formulas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.icount_event_formulas TO anon;
GRANT ALL ON TABLE public.icount_event_formulas TO authenticated;
GRANT ALL ON TABLE public.icount_event_formulas TO service_role;


--
-- Name: TABLE icount_products; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.icount_products TO anon;
GRANT ALL ON TABLE public.icount_products TO authenticated;
GRANT ALL ON TABLE public.icount_products TO service_role;


--
-- Name: TABLE icount_rooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.icount_rooms TO anon;
GRANT ALL ON TABLE public.icount_rooms TO authenticated;
GRANT ALL ON TABLE public.icount_rooms TO service_role;


--
-- Name: TABLE laser_rooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.laser_rooms TO anon;
GRANT ALL ON TABLE public.laser_rooms TO authenticated;
GRANT ALL ON TABLE public.laser_rooms TO service_role;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.orders TO anon;
GRANT ALL ON TABLE public.orders TO authenticated;
GRANT ALL ON TABLE public.orders TO service_role;


--
-- Name: TABLE payment_credentials; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payment_credentials TO anon;
GRANT ALL ON TABLE public.payment_credentials TO authenticated;
GRANT ALL ON TABLE public.payment_credentials TO service_role;


--
-- Name: TABLE payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payments TO anon;
GRANT ALL ON TABLE public.payments TO authenticated;
GRANT ALL ON TABLE public.payments TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE role_permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.role_permissions TO anon;
GRANT ALL ON TABLE public.role_permissions TO authenticated;
GRANT ALL ON TABLE public.role_permissions TO service_role;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.roles TO anon;
GRANT ALL ON TABLE public.roles TO authenticated;
GRANT ALL ON TABLE public.roles TO service_role;


--
-- Name: TABLE user_branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_branches TO anon;
GRANT ALL ON TABLE public.user_branches TO authenticated;
GRANT ALL ON TABLE public.user_branches TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_01_18; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_18 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_18 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_19; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_19 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_19 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_20; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_20 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_20 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_21; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_21 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_21 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_22; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_22 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_22 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_23; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_23 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_23 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_24; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_24 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_24 TO dashboard_user;


--
-- Name: TABLE messages_2026_01_25; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_01_25 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_01_25 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict Rc8LBBFRV5rs9UGSqLuhizkpQGTUnOT9g0BAh8UMKKvoW38G1asMNoeXmvhtYz6

