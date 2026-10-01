-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 01, 2026 at 11:02 PM
-- Server version: 11.8.9-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myrealdesk`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `type` enum('lead_created','lead_updated','stage_changed','note_added','task_created','task_completed','email_sent','sms_sent','call_logged','appointment_set','lead_assigned','website_lead','facebook_lead','google_lead','transaction_created','commission_created') NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(100) DEFAULT 'system'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activities`
--


-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ad_lead_integrations`
--

CREATE TABLE `ad_lead_integrations` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `webhook_key` varchar(120) NOT NULL,
  `access_token` text DEFAULT NULL,
  `page_id` varchar(150) DEFAULT NULL,
  `page_name` varchar(255) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'active',
  `last_lead_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ad_lead_integrations`
--


-- --------------------------------------------------------

--
-- Table structure for table `ad_lead_webhook_logs`
--

CREATE TABLE `ad_lead_webhook_logs` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `source_lead_id` varchar(150) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `payload` longtext DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ad_lead_webhook_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_commission_plans`
--

CREATE TABLE `agent_commission_plans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_name` varchar(100) DEFAULT 'Default Plan',
  `commission_type` enum('split','flat_fee','monthly','cap') DEFAULT 'split',
  `agent_split` decimal(5,2) DEFAULT 80.00,
  `brokerage_split` decimal(5,2) DEFAULT 20.00,
  `flat_fee` decimal(10,2) DEFAULT 0.00,
  `monthly_fee` decimal(10,2) DEFAULT 0.00,
  `transaction_fee` decimal(10,2) DEFAULT 0.00,
  `royalty_fee` decimal(10,2) DEFAULT 0.00,
  `cap_amount` decimal(10,2) DEFAULT 0.00,
  `gst_rate` decimal(5,2) DEFAULT 5.00,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `agent_commission_settings`
--

CREATE TABLE `agent_commission_settings` (
  `id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `split_type` enum('percentage','monthly','hybrid') DEFAULT 'percentage',
  `agent_split` decimal(5,2) DEFAULT 80.00,
  `brokerage_split` decimal(5,2) DEFAULT 20.00,
  `monthly_fee` decimal(10,2) DEFAULT 0.00,
  `transaction_fee` decimal(10,2) DEFAULT 0.00,
  `royalty_fee` decimal(10,2) DEFAULT 0.00,
  `franchise_fee` decimal(10,2) DEFAULT 0.00,
  `cap_amount` decimal(10,2) DEFAULT 0.00,
  `cap_reached` tinyint(1) DEFAULT 0,
  `gst_enabled` tinyint(1) DEFAULT 1,
  `gst_percent` decimal(5,2) DEFAULT 5.00,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `yearly_fee` decimal(10,2) DEFAULT 0.00,
  `contract_status` enum('active','inactive') DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `brokerage_id` int(11) DEFAULT 1,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_commission_settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_goals`
--

CREATE TABLE `agent_goals` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `goal_year` int(11) NOT NULL,
  `annual_gci_goal` decimal(12,2) DEFAULT 0.00,
  `annual_closed_deals_goal` int(11) DEFAULT 0,
  `annual_listing_goal` int(11) DEFAULT 0,
  `annual_buyer_sale_goal` int(11) DEFAULT 0,
  `avg_listing_commission` decimal(12,2) DEFAULT 0.00,
  `avg_buyer_commission` decimal(12,2) DEFAULT 0.00,
  `listing_close_rate` decimal(5,2) DEFAULT 70.00,
  `buyer_close_rate` decimal(5,2) DEFAULT 50.00,
  `appointment_to_listing_rate` decimal(5,2) DEFAULT 25.00,
  `appointment_to_buyer_rate` decimal(5,2) DEFAULT 25.00,
  `call_to_appointment_rate` decimal(5,2) DEFAULT 8.00,
  `followup_to_appointment_rate` decimal(5,2) DEFAULT 10.00,
  `tax_percent` decimal(5,2) DEFAULT 30.00,
  `expense_percent` decimal(5,2) DEFAULT 10.00,
  `target_net_income` decimal(12,2) DEFAULT 0.00,
  `monthly_appointment_goal` int(11) DEFAULT 0,
  `weekly_call_goal` int(11) DEFAULT 0,
  `weekly_followup_goal` int(11) DEFAULT 0,
  `status` enum('active','archived') DEFAULT 'active',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_goals`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_invites`
--

CREATE TABLE `agent_invites` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `invited_by` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `role` enum('agent','admin') DEFAULT 'agent',
  `token` varchar(255) NOT NULL,
  `status` enum('pending','accepted','cancelled','expired') DEFAULT 'pending',
  `expires_at` datetime NOT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_invites`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_listings`
--

CREATE TABLE `agent_listings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `price` varchar(100) DEFAULT NULL,
  `listing_type` enum('residential','commercial','rental','land','business') DEFAULT 'residential',
  `status` enum('active','pending','sold','leased') DEFAULT 'active',
  `description` text DEFAULT NULL,
  `main_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1,
  `mls_number` varchar(100) DEFAULT NULL,
  `bedrooms` varchar(50) DEFAULT NULL,
  `bathrooms` varchar(50) DEFAULT NULL,
  `square_feet` varchar(100) DEFAULT NULL,
  `lot_size` varchar(100) DEFAULT NULL,
  `year_built` varchar(50) DEFAULT NULL,
  `property_features` text DEFAULT NULL,
  `public_page_enabled` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_listings`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_listing_images`
--

CREATE TABLE `agent_listing_images` (
  `id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_listing_images`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_profiles`
--

CREATE TABLE `agent_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `signature` text DEFAULT NULL,
  `profile_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bio` text DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `notification_email` tinyint(1) DEFAULT 1,
  `notification_sms` tinyint(1) DEFAULT 0,
  `public_profile` tinyint(1) DEFAULT 1,
  `theme_color` varchar(20) DEFAULT '#0b3b66',
  `accent_color` varchar(20) DEFAULT '#ff8c1a',
  `font_family` varchar(100) DEFAULT 'Segoe UI',
  `email` varchar(255) DEFAULT NULL,
  `brokerage_id` int(11) DEFAULT 1,
  `tax_id` varchar(100) DEFAULT NULL,
  `business_number` varchar(100) DEFAULT NULL,
  `mailing_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_profiles`
--


-- --------------------------------------------------------

--
-- Table structure for table `agent_receivables`
--

CREATE TABLE `agent_receivables` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `agent_id` int(11) NOT NULL,
  `type` enum('brokerage_split','monthly_fee','yearly_fee','transaction_fee','desk_fee','royalty_fee','franchise_fee','other') NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `due_date` date DEFAULT NULL,
  `status` enum('unpaid','paid','waived') DEFAULT 'unpaid',
  `paid_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_receivables`
--


-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `action` varchar(150) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `backup_signature_documents`
--

CREATE TABLE `backup_signature_documents` (
  `id` int(11) NOT NULL DEFAULT 0,
  `brokerage_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `original_file` varchar(255) NOT NULL,
  `signed_file` varchar(255) DEFAULT NULL,
  `status` enum('draft','sent','viewed','completed','cancelled') DEFAULT 'draft',
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `provider` enum('realdesksign','docusign','authentisign','ezsign','nexone','secureshare','synqrafii') DEFAULT 'realdesksign',
  `provider_envelope_id` varchar(255) DEFAULT NULL,
  `provider_status` varchar(100) DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_signature_documents`
--


-- --------------------------------------------------------

--
-- Table structure for table `backup_signature_events`
--

CREATE TABLE `backup_signature_events` (
  `id` int(11) NOT NULL DEFAULT 0,
  `document_id` int(11) NOT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `event_type` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_signature_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `backup_signature_fields`
--

CREATE TABLE `backup_signature_fields` (
  `id` int(11) NOT NULL DEFAULT 0,
  `document_id` int(11) NOT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `page_number` int(11) NOT NULL DEFAULT 1,
  `field_type` enum('signature','initial','date','text','strikeout','checkbox') NOT NULL,
  `x` decimal(10,2) NOT NULL,
  `y` decimal(10,2) NOT NULL,
  `width` decimal(10,2) NOT NULL,
  `height` decimal(10,2) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_signature_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `backup_signature_signers`
--

CREATE TABLE `backup_signature_signers` (
  `id` int(11) NOT NULL DEFAULT 0,
  `document_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `status` enum('pending','viewed','signed') DEFAULT 'pending',
  `viewed_at` datetime DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_signature_signers`
--


-- --------------------------------------------------------

--
-- Table structure for table `banking_transactions`
--

CREATE TABLE `banking_transactions` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `commission_payment_id` int(11) DEFAULT NULL,
  `bank_account_type` varchar(50) DEFAULT 'operating',
  `entry_type` varchar(50) NOT NULL,
  `direction` varchar(20) NOT NULL,
  `amount` decimal(12,2) DEFAULT 0.00,
  `entry_date` date NOT NULL,
  `payee` varchar(255) DEFAULT NULL,
  `reference_no` varchar(150) DEFAULT NULL,
  `source_module` varchar(80) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_reconciled` tinyint(1) DEFAULT 0,
  `reconciled_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `banking_transactions`
--


-- --------------------------------------------------------

--
-- Table structure for table `brokerages`
--

CREATE TABLE `brokerages` (
  `id` int(11) NOT NULL,
  `brokerage_name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `primary_color` varchar(20) DEFAULT '#ff8c1a',
  `website` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `owner_name` varchar(255) DEFAULT NULL,
  `plan` varchar(50) DEFAULT 'starter',
  `subscription_status` varchar(50) DEFAULT 'trial',
  `trial_started_at` datetime DEFAULT NULL,
  `trial_ends_at` datetime DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT 'trial',
  `stripe_customer_id` varchar(255) DEFAULT NULL,
  `stripe_subscription_id` varchar(255) DEFAULT NULL,
  `crm_plan` enum('single_agent','team','brokerage') NOT NULL DEFAULT 'single_agent',
  `default_agent_id` int(11) DEFAULT NULL,
  `lead_distribution_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `distribution_mode` enum('owner','manual','round_robin','source_based') NOT NULL DEFAULT 'owner',
  `secondary_color` varchar(20) DEFAULT '#1f7ed0',
  `accent_color` varchar(20) DEFAULT '#ff8c1a',
  `navbar_color` varchar(20) DEFAULT '#07111f',
  `sidebar_color` varchar(20) DEFAULT '#0b3b66',
  `logo_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brokerages`
--


-- --------------------------------------------------------

--
-- Table structure for table `brokerage_payables`
--

CREATE TABLE `brokerage_payables` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `type` enum('agent_commission','office_expense','lawyer_notary','referral_fee','software','rent','marketing','other') NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `due_date` date DEFAULT NULL,
  `status` enum('unpaid','paid','cancelled') DEFAULT 'unpaid',
  `paid_date` date DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brokerage_payables`
--


-- --------------------------------------------------------

--
-- Table structure for table `brokerage_resources`
--

CREATE TABLE `brokerage_resources` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brokerage_resources`
--


-- --------------------------------------------------------

--
-- Table structure for table `brokerage_settings`
--

CREATE TABLE `brokerage_settings` (
  `id` int(11) NOT NULL,
  `brokerage_name` varchar(255) DEFAULT NULL,
  `brokerage_address` text DEFAULT NULL,
  `brokerage_phone` varchar(100) DEFAULT NULL,
  `brokerage_email` varchar(255) DEFAULT NULL,
  `gst_number` varchar(100) DEFAULT NULL,
  `gst_rate` decimal(5,2) DEFAULT 5.00,
  `default_admin_fee` decimal(12,2) DEFAULT 0.00,
  `logo_path` varchar(255) DEFAULT NULL,
  `paystub_footer` text DEFAULT NULL,
  `commission_note` text DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1,
  `brokerage_website` varchar(255) DEFAULT NULL,
  `license_number` varchar(150) DEFAULT NULL,
  `primary_color` varchar(20) DEFAULT '#0b3b66',
  `accent_color` varchar(20) DEFAULT '#ff8c1a'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brokerage_settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `commission_calculations`
--

CREATE TABLE `commission_calculations` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `gross_commission` decimal(10,2) DEFAULT 0.00,
  `agent_split_percent` decimal(5,2) DEFAULT 0.00,
  `brokerage_split_percent` decimal(5,2) DEFAULT 0.00,
  `agent_gross_amount` decimal(10,2) DEFAULT 0.00,
  `brokerage_amount` decimal(10,2) DEFAULT 0.00,
  `transaction_fee` decimal(10,2) DEFAULT 0.00,
  `royalty_fee` decimal(10,2) DEFAULT 0.00,
  `gst_amount` decimal(10,2) DEFAULT 0.00,
  `agent_net_payout` decimal(10,2) DEFAULT 0.00,
  `status` enum('draft','approved','paid') DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `commission_payments`
--

CREATE TABLE `commission_payments` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `commission_statement_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `agent_id` int(11) NOT NULL,
  `payment_method` varchar(50) DEFAULT 'cheque',
  `payment_status` varchar(50) DEFAULT 'ready',
  `amount` decimal(12,2) DEFAULT 0.00,
  `cheque_number` varchar(100) DEFAULT NULL,
  `bank_reference` varchar(150) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `commission_payments`
--


-- --------------------------------------------------------

--
-- Table structure for table `commission_statements`
--

CREATE TABLE `commission_statements` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `sale_price` decimal(12,2) DEFAULT 0.00,
  `gross_commission` decimal(12,2) DEFAULT 0.00,
  `agent_split_percent` decimal(5,2) DEFAULT 0.00,
  `brokerage_split_percent` decimal(5,2) DEFAULT 0.00,
  `agent_amount` decimal(12,2) DEFAULT 0.00,
  `brokerage_amount` decimal(12,2) DEFAULT 0.00,
  `monthly_fee` decimal(12,2) DEFAULT 0.00,
  `transaction_fee` decimal(12,2) DEFAULT 0.00,
  `royalty_fee` decimal(12,2) DEFAULT 0.00,
  `franchise_fee` decimal(12,2) DEFAULT 0.00,
  `total_deductions` decimal(12,2) DEFAULT 0.00,
  `gst_amount` decimal(12,2) DEFAULT 0.00,
  `final_payout` decimal(12,2) DEFAULT 0.00,
  `brokerage_split` decimal(12,2) DEFAULT 0.00,
  `admin_fee` decimal(12,2) DEFAULT 0.00,
  `deductions` decimal(12,2) DEFAULT 0.00,
  `gst` decimal(12,2) DEFAULT 0.00,
  `net_payable` decimal(12,2) DEFAULT 0.00,
  `status` enum('pending','approved','paid') DEFAULT 'pending',
  `paid_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_date` date DEFAULT NULL,
  `yearly_fee` decimal(12,2) DEFAULT 0.00,
  `brokerage_id` int(11) DEFAULT 1,
  `commission_gst` decimal(12,2) DEFAULT 0.00,
  `total_commission_with_gst` decimal(12,2) DEFAULT 0.00,
  `brokerage_gst` decimal(12,2) DEFAULT 0.00,
  `fee_gst` decimal(12,2) DEFAULT 0.00,
  `gst_payable` decimal(12,2) DEFAULT 0.00,
  `agent_gst` decimal(12,2) DEFAULT 0.00,
  `our_side` varchar(50) DEFAULT 'selling',
  `our_side_commission` decimal(12,2) DEFAULT 0.00,
  `our_side_gst` decimal(12,2) DEFAULT 0.00,
  `our_side_total_with_gst` decimal(12,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_statements`
--


-- --------------------------------------------------------

--
-- Table structure for table `community_comments`
--

CREATE TABLE `community_comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) NOT NULL DEFAULT 1,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `community_likes`
--

CREATE TABLE `community_likes` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_likes`
--


-- --------------------------------------------------------

--
-- Table structure for table `community_posts`
--

CREATE TABLE `community_posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_text` text NOT NULL,
  `post_type` enum('general','announcement','exclusive_listing') DEFAULT 'general',
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `listing_id` int(11) DEFAULT NULL,
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_posts`
--


-- --------------------------------------------------------

--
-- Table structure for table `demo_requests`
--

CREATE TABLE `demo_requests` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `brokerage_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `agent_count` varchar(50) DEFAULT NULL,
  `current_crm` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'new',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `demo_requests`
--


-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `brokerage_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_batches`
--

CREATE TABLE `import_batches` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `import_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `total_rows` int(11) DEFAULT 0,
  `imported_rows` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `duplicate_rows` int(11) DEFAULT 0,
  `skipped_rows` int(11) DEFAULT 0,
  `error_rows` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internal_messages`
--

CREATE TABLE `internal_messages` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL DEFAULT 1,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `internal_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `lawyers`
--

CREATE TABLE `lawyers` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `lawyer_name` varchar(255) NOT NULL,
  `firm_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `email_status` varchar(50) DEFAULT 'unknown',
  `email_last_checked_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lawyers`
--


-- --------------------------------------------------------

--
-- Table structure for table `lawyer_directory`
--

CREATE TABLE `lawyer_directory` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `lawyer_name` varchar(255) NOT NULL,
  `firm_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `min_price` int(11) DEFAULT NULL,
  `max_price` int(11) DEFAULT NULL,
  `beds` int(11) DEFAULT NULL,
  `baths` int(11) DEFAULT NULL,
  `auto_email` tinyint(1) NOT NULL DEFAULT 0,
  `frequency` enum('daily','weekly') DEFAULT 'daily',
  `source` varchar(50) DEFAULT 'manual',
  `status` varchar(50) DEFAULT 'new',
  `email_open_count` int(11) NOT NULL DEFAULT 0,
  `click_count` int(11) NOT NULL DEFAULT 0,
  `last_activity_at` datetime DEFAULT NULL,
  `lead_score` int(11) NOT NULL DEFAULT 0,
  `liked_count` int(11) DEFAULT 0,
  `message_count` int(11) DEFAULT 0,
  `last_viewed` datetime DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `property_type` varchar(50) DEFAULT NULL,
  `filters` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `assigned_to` varchar(100) DEFAULT NULL,
  `unsubscribed` tinyint(1) NOT NULL DEFAULT 0,
  `ai_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `ai_stage` tinyint(1) NOT NULL DEFAULT 0,
  `ai_last_sent` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `lot_min` int(11) DEFAULT NULL,
  `lot_max` int(11) DEFAULT NULL,
  `area_polygon` longtext DEFAULT NULL,
  `rect_north` double DEFAULT NULL,
  `rect_south` double DEFAULT NULL,
  `rect_east` double DEFAULT NULL,
  `rect_west` double DEFAULT NULL,
  `pipeline_type` enum('buyer','seller') DEFAULT 'buyer',
  `stage` varchar(50) DEFAULT 'New Lead',
  `next_followup` date DEFAULT NULL,
  `deal_value` int(11) DEFAULT NULL,
  `followup_notes` text DEFAULT NULL,
  `buyer_stage_flags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`buyer_stage_flags`)),
  `brokerage_id` int(11) DEFAULT 1,
  `source_platform` varchar(50) DEFAULT NULL,
  `source_lead_id` varchar(150) DEFAULT NULL,
  `campaign_name` varchar(255) DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `routing_mode` varchar(50) DEFAULT 'direct',
  `message` text DEFAULT NULL,
  `property_page_id` int(11) DEFAULT NULL,
  `property_address` varchar(255) DEFAULT NULL,
  `open_house_event_id` int(11) DEFAULT NULL,
  `open_house_signin_at` datetime DEFAULT NULL,
  `last_contacted_at` datetime DEFAULT NULL,
  `next_follow_up_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `leads`
--


-- --------------------------------------------------------

--
-- Table structure for table `leads_backup_before_cron_fix`
--

CREATE TABLE `leads_backup_before_cron_fix` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `min_price` int(11) DEFAULT NULL,
  `max_price` int(11) DEFAULT NULL,
  `beds` int(11) DEFAULT NULL,
  `baths` int(11) DEFAULT NULL,
  `auto_email` tinyint(1) NOT NULL DEFAULT 0,
  `frequency` enum('daily','weekly') CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT 'daily',
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT 'manual',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT 'new',
  `liked_count` int(11) DEFAULT 0,
  `message_count` int(11) DEFAULT 0,
  `last_viewed` datetime DEFAULT NULL,
  `tags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `property_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `filters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `assigned_to` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `unsubscribed` tinyint(1) NOT NULL DEFAULT 0,
  `ai_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `ai_stage` tinyint(1) NOT NULL DEFAULT 0,
  `ai_last_sent` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `lot_min` int(11) DEFAULT NULL,
  `lot_max` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leads_backup_before_cron_fix`
--


-- --------------------------------------------------------

--
-- Table structure for table `lead_activities`
--

CREATE TABLE `lead_activities` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL DEFAULT 1,
  `lead_id` int(11) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `activity_type` varchar(50) NOT NULL DEFAULT 'note',
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lead_activities`
--


-- --------------------------------------------------------

--
-- Table structure for table `lead_activity`
--

CREATE TABLE `lead_activity` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lead_activity`
--


-- --------------------------------------------------------

--
-- Table structure for table `lead_distribution_rules`
--

CREATE TABLE `lead_distribution_rules` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `rule_type` enum('default_agent','round_robin','source') NOT NULL DEFAULT 'default_agent',
  `source` varchar(100) DEFAULT NULL,
  `agent_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_assigned_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_followups`
--

CREATE TABLE `lead_followups` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `followup_day` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `scheduled_for` date NOT NULL,
  `status` enum('pending','sent','failed','cancelled') DEFAULT 'pending',
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `error_message` text DEFAULT NULL,
  `send_attempts` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lead_followups`
--


-- --------------------------------------------------------

--
-- Table structure for table `lead_messages`
--

CREATE TABLE `lead_messages` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `channel` enum('sms','whatsapp','email') DEFAULT 'sms',
  `message_text` text DEFAULT NULL,
  `direction` enum('outgoing','incoming') DEFAULT 'outgoing',
  `status` varchar(50) DEFAULT 'sent',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `direction` enum('in','out') DEFAULT 'in',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--


-- --------------------------------------------------------

--
-- Table structure for table `open_house_events`
--

CREATE TABLE `open_house_events` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `property_address` varchar(255) DEFAULT NULL,
  `mls_number` varchar(100) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `pdf_file` varchar(255) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `open_house_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--


-- --------------------------------------------------------

--
-- Table structure for table `password_reset_requests`
--

CREATE TABLE `password_reset_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_requests`
--


-- --------------------------------------------------------

--
-- Table structure for table `payroll_records`
--

CREATE TABLE `payroll_records` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `payee_name` varchar(255) DEFAULT NULL,
  `payee_type` enum('employee','contractor','other') DEFAULT 'employee',
  `pay_period_start` date DEFAULT NULL,
  `pay_period_end` date DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `gross_pay` decimal(12,2) DEFAULT 0.00,
  `deductions` decimal(12,2) DEFAULT 0.00,
  `net_pay` decimal(12,2) DEFAULT 0.00,
  `payment_method` varchar(100) DEFAULT NULL,
  `reference_no` varchar(150) DEFAULT NULL,
  `status` enum('draft','approved','paid','void') DEFAULT 'draft',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_pages`
--

CREATE TABLE `property_pages` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `slug` varchar(160) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'draft',
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `property_address` varchar(255) NOT NULL,
  `city` varchar(150) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `price` decimal(14,2) DEFAULT 0.00,
  `bedrooms` varchar(50) DEFAULT NULL,
  `bathrooms` varchar(50) DEFAULT NULL,
  `interior_sqft` varchar(100) DEFAULT NULL,
  `lot_size` varchar(100) DEFAULT NULL,
  `year_built` varchar(50) DEFAULT NULL,
  `mls_number` varchar(100) DEFAULT NULL,
  `taxes` varchar(100) DEFAULT NULL,
  `parking` varchar(100) DEFAULT NULL,
  `property_type` varchar(150) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `hero_image` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `brochure_path` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `agent_name` varchar(255) DEFAULT NULL,
  `agent_title` varchar(255) DEFAULT NULL,
  `agent_phone` varchar(100) DEFAULT NULL,
  `agent_email` varchar(255) DEFAULT NULL,
  `agent_website` varchar(255) DEFAULT NULL,
  `agent_photo` varchar(255) DEFAULT NULL,
  `brokerage_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `published_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `property_page_media`
--

CREATE TABLE `property_page_media` (
  `id` int(11) NOT NULL,
  `property_page_id` int(11) NOT NULL,
  `media_type` varchar(30) NOT NULL DEFAULT 'image',
  `file_path` varchar(255) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property_page_media`
--


-- --------------------------------------------------------

--
-- Table structure for table `resource_drafts`
--

CREATE TABLE `resource_drafts` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `filled_file` varchar(500) NOT NULL,
  `status` enum('draft','sent_to_sign') NOT NULL DEFAULT 'draft',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_drafts`
--


-- --------------------------------------------------------

--
-- Table structure for table `round_robin_agents`
--

CREATE TABLE `round_robin_agents` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `round_robin_agents`
--


-- --------------------------------------------------------

--
-- Table structure for table `round_robin_settings`
--

CREATE TABLE `round_robin_settings` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `last_assigned_user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `round_robin_settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `saas_admin_logs`
--

CREATE TABLE `saas_admin_logs` (
  `id` int(11) NOT NULL,
  `admin_user_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_emails`
--

CREATE TABLE `scheduled_emails` (
  `id` int(11) NOT NULL,
  `send_at` datetime DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `sent` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sent_log`
--

CREATE TABLE `sent_log` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `listing_key` varchar(255) DEFAULT NULL,
  `sent_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sent_logs`
--

CREATE TABLE `sent_logs` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `listing_key` varchar(255) NOT NULL,
  `sent_at` datetime DEFAULT current_timestamp(),
  `hash` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sent_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(150) DEFAULT NULL,
  `smtp_user` varchar(150) DEFAULT NULL,
  `smtp_pass` varchar(150) DEFAULT NULL,
  `smtp_port` int(11) DEFAULT NULL,
  `from_email` varchar(150) DEFAULT NULL,
  `from_name` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sign_attachments`
--

CREATE TABLE `sign_attachments` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `file_type` enum('original_pdf','signed_pdf','certificate_pdf') NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sign_documents`
--

CREATE TABLE `sign_documents` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_draft_id` int(11) DEFAULT NULL,
  `related_type` varchar(50) DEFAULT 'standalone',
  `related_id` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `original_file` varchar(500) DEFAULT NULL,
  `original_pdf` varchar(500) NOT NULL,
  `signed_pdf` varchar(500) DEFAULT NULL,
  `certificate_pdf` varchar(500) DEFAULT NULL,
  `status` enum('draft','sent','viewed','in_progress','completed','declined','cancelled','expired') NOT NULL DEFAULT 'draft',
  `sender_name` varchar(150) DEFAULT NULL,
  `sender_email` varchar(190) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `signing_mode` enum('parallel','sequential') DEFAULT 'parallel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_documents`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_document_files`
--

CREATE TABLE `sign_document_files` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `signed_file_path` varchar(500) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `page_start` int(11) DEFAULT 1,
  `page_end` int(11) DEFAULT 1,
  `page_count` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_document_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_email_logs`
--

CREATE TABLE `sign_email_logs` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `email_to` varchar(190) NOT NULL,
  `email_subject` varchar(255) NOT NULL,
  `email_type` enum('send_request','reminder','completed','declined','cancelled') NOT NULL,
  `status` enum('sent','failed') NOT NULL DEFAULT 'sent',
  `error_message` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_email_logs`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_events`
--

CREATE TABLE `sign_events` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `event_type` varchar(100) NOT NULL,
  `event_message` text DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_fields`
--

CREATE TABLE `sign_fields` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `document_file_id` int(11) DEFAULT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `page_number` int(11) NOT NULL DEFAULT 1,
  `field_type` enum('signature','initials','date','full_name','text','crossout') NOT NULL,
  `field_label` varchar(255) DEFAULT NULL,
  `field_code` varchar(50) DEFAULT NULL,
  `x_position` decimal(10,2) NOT NULL,
  `y_position` decimal(10,2) NOT NULL,
  `field_width` decimal(10,2) NOT NULL DEFAULT 180.00,
  `field_height` decimal(10,2) NOT NULL DEFAULT 50.00,
  `required` tinyint(1) NOT NULL DEFAULT 1,
  `editable_by` enum('sender','signer','both') NOT NULL DEFAULT 'signer',
  `default_value` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_fields`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_field_values`
--

CREATE TABLE `sign_field_values` (
  `id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `signer_id` int(11) DEFAULT NULL,
  `field_value` longtext DEFAULT NULL,
  `value_type` enum('text','signature_image','initials_image','date','full_name','crossout') NOT NULL DEFAULT 'text',
  `validation_code` varchar(50) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_field_values`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_saved_profiles`
--

CREATE TABLE `sign_saved_profiles` (
  `id` int(11) NOT NULL,
  `signer_email` varchar(190) NOT NULL,
  `signer_name` varchar(190) DEFAULT NULL,
  `signature_data` longtext DEFAULT NULL,
  `initials_data` longtext DEFAULT NULL,
  `signature_type` varchar(30) DEFAULT 'draw',
  `initials_type` varchar(30) DEFAULT 'draw',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_saved_profiles`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_saved_signatures`
--

CREATE TABLE `sign_saved_signatures` (
  `id` int(11) NOT NULL,
  `signer_email` varchar(190) NOT NULL,
  `signer_name` varchar(190) DEFAULT NULL,
  `signature_type` enum('drawn','typed') NOT NULL DEFAULT 'drawn',
  `signature_value` longtext NOT NULL,
  `initials_value` longtext DEFAULT NULL,
  `font_family` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sign_signers`
--

CREATE TABLE `sign_signers` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `signer_name` varchar(150) NOT NULL,
  `signer_email` varchar(190) NOT NULL,
  `signer_color` varchar(20) DEFAULT '#2457ff',
  `signer_role` varchar(100) DEFAULT NULL,
  `signing_order` int(11) NOT NULL DEFAULT 1,
  `secure_token` varchar(128) NOT NULL,
  `status` enum('pending','email_sent','viewed','signed','declined','expired') NOT NULL DEFAULT 'pending',
  `viewed_at` datetime DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_signers`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_templates`
--

CREATE TABLE `sign_templates` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `template_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_templates`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_template_fields`
--

CREATE TABLE `sign_template_fields` (
  `id` int(11) NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `signer_role` varchar(100) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `field_type` varchar(50) DEFAULT NULL,
  `field_label` varchar(255) DEFAULT NULL,
  `x_position` float DEFAULT NULL,
  `y_position` float DEFAULT NULL,
  `field_width` float DEFAULT NULL,
  `field_height` float DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sign_template_files`
--

CREATE TABLE `sign_template_files` (
  `id` int(11) NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `original_pdf` varchar(255) DEFAULT NULL,
  `page_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_template_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `sign_template_roles`
--

CREATE TABLE `sign_template_roles` (
  `id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `signing_order` int(11) NOT NULL DEFAULT 1,
  `role_color` varchar(20) DEFAULT '#3461ff',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sign_template_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `subscription_events`
--

CREATE TABLE `subscription_events` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) DEFAULT NULL,
  `stripe_event_id` varchar(255) DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `raw_payload` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `assigned_to` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `task_type` enum('call','email','sms','followup','meeting','custom') DEFAULT 'followup',
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `status` enum('pending','completed','cancelled') DEFAULT 'pending',
  `due_date` date NOT NULL,
  `due_time` time DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `source` enum('manual','system','automation') DEFAULT 'manual',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `deal_type` enum('residential_listing','residential_sale','commercial_listing','commercial_sale') NOT NULL,
  `property_address` varchar(255) NOT NULL,
  `mls_number` varchar(100) DEFAULT NULL,
  `client_name` varchar(150) DEFAULT NULL,
  `sale_price` varchar(100) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `possession_date` date DEFAULT NULL,
  `gross_commission` varchar(100) DEFAULT NULL,
  `status` enum('draft','active','submitted','under_review','missing_documents','approved','closed','paid') DEFAULT 'draft',
  `admin_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `seller_name` varchar(255) DEFAULT NULL,
  `buyer_name` varchar(255) DEFAULT NULL,
  `subject_removal_date` date DEFAULT NULL,
  `adjustment_date` date DEFAULT NULL,
  `deposit_amount` decimal(12,2) DEFAULT 0.00,
  `deposit_received_by_brokerage` enum('yes','no') DEFAULT 'no',
  `listing_side_commission` decimal(12,2) DEFAULT 0.00,
  `selling_side_commission` decimal(12,2) DEFAULT 0.00,
  `buyer_agent_commission` decimal(12,2) DEFAULT 0.00,
  `seller_lawyer_name` varchar(255) DEFAULT NULL,
  `seller_lawyer_email` varchar(255) DEFAULT NULL,
  `seller_lawyer_phone` varchar(100) DEFAULT NULL,
  `buyer_lawyer_name` varchar(255) DEFAULT NULL,
  `buyer_lawyer_email` varchar(255) DEFAULT NULL,
  `buyer_lawyer_phone` varchar(100) DEFAULT NULL,
  `co_op_brokerage_name` varchar(255) DEFAULT NULL,
  `co_op_agent_name` varchar(255) DEFAULT NULL,
  `co_op_agent_email` varchar(255) DEFAULT NULL,
  `co_op_agent_phone` varchar(100) DEFAULT NULL,
  `commission_gst` decimal(12,2) DEFAULT 0.00,
  `total_commission_with_gst` decimal(12,2) DEFAULT 0.00,
  `deposit_received_date` date DEFAULT NULL,
  `deposit_reference` varchar(100) DEFAULT NULL,
  `deposit_held_by_brokerage` tinyint(1) DEFAULT 1,
  `listing_commission_gst` decimal(12,2) DEFAULT 0.00,
  `listing_commission_total` decimal(12,2) DEFAULT 0.00,
  `selling_commission_gst` decimal(12,2) DEFAULT 0.00,
  `selling_commission_total` decimal(12,2) DEFAULT 0.00,
  `workflow_status` varchar(50) DEFAULT 'draft',
  `compliance_passed` tinyint(1) DEFAULT 0,
  `trust_released` tinyint(1) DEFAULT 0,
  `brokerage_id` int(11) DEFAULT 1,
  `pid_number` varchar(100) DEFAULT NULL,
  `legal_description` text DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `buyer_phone` varchar(100) DEFAULT NULL,
  `buyer_email` varchar(255) DEFAULT NULL,
  `trust_release_due_date` date DEFAULT NULL,
  `completion_confirmed_at` datetime DEFAULT NULL,
  `commission_released_at` datetime DEFAULT NULL,
  `reconciled_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `commission_deposit_received_at` datetime DEFAULT NULL,
  `compliance_status` varchar(50) DEFAULT 'not_reviewed',
  `compliance_score` int(11) DEFAULT 0,
  `compliance_missing_items` text DEFAULT NULL,
  `compliance_reviewed_at` datetime DEFAULT NULL,
  `ai_compliance_summary` text DEFAULT NULL,
  `ai_compliance_risk` varchar(50) DEFAULT NULL,
  `ai_compliance_checked_at` datetime DEFAULT NULL,
  `seller_lawyer_firm` varchar(255) DEFAULT NULL,
  `seller_lawyer_address` text DEFAULT NULL,
  `buyer_lawyer_firm` varchar(255) DEFAULT NULL,
  `buyer_lawyer_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--


-- --------------------------------------------------------

--
-- Table structure for table `transaction_agents`
--

CREATE TABLE `transaction_agents` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `agent_type` enum('internal','external') NOT NULL DEFAULT 'internal',
  `representation_side` enum('listing','selling','both','referral','other') NOT NULL DEFAULT 'listing',
  `role_name` varchar(100) DEFAULT NULL,
  `agent_name` varchar(255) NOT NULL,
  `agent_email` varchar(255) DEFAULT NULL,
  `agent_phone` varchar(100) DEFAULT NULL,
  `licence_number` varchar(100) DEFAULT NULL,
  `commission_percentage` decimal(8,4) DEFAULT NULL,
  `commission_amount` decimal(12,2) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `transaction_agents`
--


-- --------------------------------------------------------

--
-- Table structure for table `transaction_documents`
--

CREATE TABLE `transaction_documents` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `document_type` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_documents`
--


-- --------------------------------------------------------

--
-- Table structure for table `transaction_notes`
--

CREATE TABLE `transaction_notes` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `note_type` enum('general','admin_request','status_update') DEFAULT 'general',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `trust_ledger`
--

CREATE TABLE `trust_ledger` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `type` enum('deposit_received','release_to_lawyer','release_to_seller','refund','adjustment') NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `entry_date` date NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `cleared` tinyint(1) NOT NULL DEFAULT 0,
  `cleared_date` date DEFAULT NULL,
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trust_ledger`
--


-- --------------------------------------------------------

--
-- Table structure for table `trust_reconciliations`
--

CREATE TABLE `trust_reconciliations` (
  `id` int(11) NOT NULL,
  `recon_month` varchar(7) NOT NULL,
  `opening_balance` decimal(12,2) DEFAULT 0.00,
  `bank_ending_balance` decimal(12,2) DEFAULT 0.00,
  `system_balance` decimal(12,2) DEFAULT 0.00,
  `outstanding_deposits` decimal(12,2) DEFAULT 0.00,
  `outstanding_withdrawals` decimal(12,2) DEFAULT 0.00,
  `adjusted_bank_balance` decimal(12,2) DEFAULT 0.00,
  `difference` decimal(12,2) DEFAULT 0.00,
  `status` enum('draft','locked') DEFAULT 'draft',
  `locked_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `brokerage_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','agent') DEFAULT 'agent',
  `created_at` datetime DEFAULT current_timestamp(),
  `email` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `can_view_all_crm` tinyint(1) NOT NULL DEFAULT 0,
  `brokerage_id` int(11) DEFAULT 1,
  `receives_leads` tinyint(1) NOT NULL DEFAULT 1,
  `is_team_lead` tinyint(1) NOT NULL DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `last_ip` varchar(100) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` datetime DEFAULT NULL,
  `verification_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `users`
--


-- --------------------------------------------------------

--
-- Table structure for table `website_form_keys`
--

CREATE TABLE `website_form_keys` (
  `id` int(11) NOT NULL,
  `brokerage_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `form_key` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `website_form_keys`
--


--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `type` (`type`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `ad_lead_integrations`
--
ALTER TABLE `ad_lead_integrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_webhook_key` (`webhook_key`),
  ADD KEY `idx_user_platform` (`brokerage_id`,`user_id`,`platform`);

--
-- Indexes for table `ad_lead_webhook_logs`
--
ALTER TABLE `ad_lead_webhook_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_brokerage_created` (`brokerage_id`,`created_at`),
  ADD KEY `idx_source_lead` (`source_lead_id`);

--
-- Indexes for table `agent_commission_plans`
--
ALTER TABLE `agent_commission_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agent_commission_settings`
--
ALTER TABLE `agent_commission_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_agent` (`agent_id`);

--
-- Indexes for table `agent_goals`
--
ALTER TABLE `agent_goals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_agent_year` (`brokerage_id`,`agent_id`,`goal_year`),
  ADD KEY `idx_brokerage_year` (`brokerage_id`,`goal_year`),
  ADD KEY `idx_agent_year` (`agent_id`,`goal_year`);

--
-- Indexes for table `agent_invites`
--
ALTER TABLE `agent_invites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brokerage_id` (`brokerage_id`),
  ADD KEY `email` (`email`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `agent_listings`
--
ALTER TABLE `agent_listings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agent_listing_images`
--
ALTER TABLE `agent_listing_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agent_profiles`
--
ALTER TABLE `agent_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `agent_receivables`
--
ALTER TABLE `agent_receivables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banking_transactions`
--
ALTER TABLE `banking_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banking_brokerage_date` (`brokerage_id`,`entry_date`),
  ADD KEY `idx_banking_transaction` (`transaction_id`),
  ADD KEY `idx_banking_payment` (`commission_payment_id`);

--
-- Indexes for table `brokerages`
--
ALTER TABLE `brokerages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `brokerage_payables`
--
ALTER TABLE `brokerage_payables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brokerage_resources`
--
ALTER TABLE `brokerage_resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brokerage_settings`
--
ALTER TABLE `brokerage_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commission_calculations`
--
ALTER TABLE `commission_calculations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commission_payments`
--
ALTER TABLE `commission_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_commission_payment` (`brokerage_id`,`commission_statement_id`);

--
-- Indexes for table `commission_statements`
--
ALTER TABLE `commission_statements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_transaction` (`transaction_id`);

--
-- Indexes for table `community_comments`
--
ALTER TABLE `community_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `community_likes`
--
ALTER TABLE `community_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`post_id`,`user_id`);

--
-- Indexes for table `community_posts`
--
ALTER TABLE `community_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `demo_requests`
--
ALTER TABLE `demo_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `import_batches`
--
ALTER TABLE `import_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internal_messages`
--
ALTER TABLE `internal_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lawyers`
--
ALTER TABLE `lawyers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_brokerage_name` (`brokerage_id`,`lawyer_name`),
  ADD KEY `idx_brokerage_email` (`brokerage_id`,`email`);

--
-- Indexes for table `lawyer_directory`
--
ALTER TABLE `lawyer_directory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brokerage_id` (`brokerage_id`),
  ADD KEY `lawyer_name` (`lawyer_name`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lead_activities`
--
ALTER TABLE `lead_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `lead_activity`
--
ALTER TABLE `lead_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `lead_distribution_rules`
--
ALTER TABLE `lead_distribution_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_brokerage_active` (`brokerage_id`,`is_active`),
  ADD KEY `idx_source` (`brokerage_id`,`source`),
  ADD KEY `idx_agent` (`agent_id`);

--
-- Indexes for table `lead_followups`
--
ALTER TABLE `lead_followups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lead_messages`
--
ALTER TABLE `lead_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `open_house_events`
--
ALTER TABLE `open_house_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payroll_records`
--
ALTER TABLE `payroll_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `property_pages`
--
ALTER TABLE `property_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_slug` (`slug`),
  ADD KEY `idx_brokerage_agent` (`brokerage_id`,`agent_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `property_page_media`
--
ALTER TABLE `property_page_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_property_page` (`property_page_id`,`sort_order`);

--
-- Indexes for table `resource_drafts`
--
ALTER TABLE `resource_drafts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_resource_brokerage` (`resource_id`,`brokerage_id`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `round_robin_agents`
--
ALTER TABLE `round_robin_agents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_agent` (`brokerage_id`,`user_id`);

--
-- Indexes for table `round_robin_settings`
--
ALTER TABLE `round_robin_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_brokerage` (`brokerage_id`);

--
-- Indexes for table `saas_admin_logs`
--
ALTER TABLE `saas_admin_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scheduled_emails`
--
ALTER TABLE `scheduled_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_log`
--
ALTER TABLE `sent_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_logs`
--
ALTER TABLE `sent_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sign_attachments`
--
ALTER TABLE `sign_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_document_id` (`document_id`);

--
-- Indexes for table `sign_documents`
--
ALTER TABLE `sign_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_resource_id` (`resource_id`),
  ADD KEY `idx_resource_draft_id` (`resource_draft_id`);

--
-- Indexes for table `sign_document_files`
--
ALTER TABLE `sign_document_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sign_email_logs`
--
ALTER TABLE `sign_email_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_document_id` (`document_id`),
  ADD KEY `idx_signer_id` (`signer_id`);

--
-- Indexes for table `sign_events`
--
ALTER TABLE `sign_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_document_id` (`document_id`),
  ADD KEY `idx_signer_id` (`signer_id`);

--
-- Indexes for table `sign_fields`
--
ALTER TABLE `sign_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_document_id` (`document_id`),
  ADD KEY `idx_signer_id` (`signer_id`),
  ADD KEY `idx_sign_fields_document_file_id` (`document_file_id`);

--
-- Indexes for table `sign_field_values`
--
ALTER TABLE `sign_field_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_signer_id` (`signer_id`);

--
-- Indexes for table `sign_saved_profiles`
--
ALTER TABLE `sign_saved_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_signer_profile` (`signer_email`,`signer_name`);

--
-- Indexes for table `sign_saved_signatures`
--
ALTER TABLE `sign_saved_signatures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_signer_email` (`signer_email`);

--
-- Indexes for table `sign_signers`
--
ALTER TABLE `sign_signers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_secure_token` (`secure_token`),
  ADD KEY `idx_document_id` (`document_id`);

--
-- Indexes for table `sign_templates`
--
ALTER TABLE `sign_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sign_template_fields`
--
ALTER TABLE `sign_template_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_template_role_id` (`role_id`);

--
-- Indexes for table `sign_template_files`
--
ALTER TABLE `sign_template_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sign_template_roles`
--
ALTER TABLE `sign_template_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `subscription_events`
--
ALTER TABLE `subscription_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `due_date` (`due_date`),
  ADD KEY `status` (`status`),
  ADD KEY `priority` (`priority`),
  ADD KEY `idx_due_status` (`status`,`due_date`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transactions_agent` (`agent_id`),
  ADD KEY `idx_transactions_status` (`status`);

--
-- Indexes for table `transaction_agents`
--
ALTER TABLE `transaction_agents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transaction_agents_transaction` (`transaction_id`),
  ADD KEY `idx_transaction_agents_user` (`user_id`),
  ADD KEY `idx_transaction_agents_brokerage` (`brokerage_id`);

--
-- Indexes for table `transaction_documents`
--
ALTER TABLE `transaction_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_documents_transaction` (`transaction_id`);

--
-- Indexes for table `transaction_notes`
--
ALTER TABLE `transaction_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transaction_notes_transaction` (`transaction_id`);

--
-- Indexes for table `trust_ledger`
--
ALTER TABLE `trust_ledger`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trust_reconciliations`
--
ALTER TABLE `trust_reconciliations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_recon_month` (`recon_month`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website_form_keys`
--
ALTER TABLE `website_form_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `form_key` (`form_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ad_lead_integrations`
--
ALTER TABLE `ad_lead_integrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ad_lead_webhook_logs`
--
ALTER TABLE `ad_lead_webhook_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `agent_commission_plans`
--
ALTER TABLE `agent_commission_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agent_commission_settings`
--
ALTER TABLE `agent_commission_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `agent_goals`
--
ALTER TABLE `agent_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `agent_invites`
--
ALTER TABLE `agent_invites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `agent_listings`
--
ALTER TABLE `agent_listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `agent_listing_images`
--
ALTER TABLE `agent_listing_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `agent_profiles`
--
ALTER TABLE `agent_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `agent_receivables`
--
ALTER TABLE `agent_receivables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `banking_transactions`
--
ALTER TABLE `banking_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `brokerages`
--
ALTER TABLE `brokerages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `brokerage_payables`
--
ALTER TABLE `brokerage_payables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `brokerage_resources`
--
ALTER TABLE `brokerage_resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brokerage_settings`
--
ALTER TABLE `brokerage_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `commission_calculations`
--
ALTER TABLE `commission_calculations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commission_payments`
--
ALTER TABLE `commission_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `commission_statements`
--
ALTER TABLE `commission_statements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `community_comments`
--
ALTER TABLE `community_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `community_likes`
--
ALTER TABLE `community_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `community_posts`
--
ALTER TABLE `community_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `demo_requests`
--
ALTER TABLE `demo_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `import_batches`
--
ALTER TABLE `import_batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internal_messages`
--
ALTER TABLE `internal_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `lawyers`
--
ALTER TABLE `lawyers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lawyer_directory`
--
ALTER TABLE `lawyer_directory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `lead_activities`
--
ALTER TABLE `lead_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=344;

--
-- AUTO_INCREMENT for table `lead_activity`
--
ALTER TABLE `lead_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `lead_distribution_rules`
--
ALTER TABLE `lead_distribution_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_followups`
--
ALTER TABLE `lead_followups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=446;

--
-- AUTO_INCREMENT for table `lead_messages`
--
ALTER TABLE `lead_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `open_house_events`
--
ALTER TABLE `open_house_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payroll_records`
--
ALTER TABLE `payroll_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_pages`
--
ALTER TABLE `property_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `property_page_media`
--
ALTER TABLE `property_page_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `resource_drafts`
--
ALTER TABLE `resource_drafts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `round_robin_agents`
--
ALTER TABLE `round_robin_agents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `round_robin_settings`
--
ALTER TABLE `round_robin_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `saas_admin_logs`
--
ALTER TABLE `saas_admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scheduled_emails`
--
ALTER TABLE `scheduled_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sent_log`
--
ALTER TABLE `sent_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sent_logs`
--
ALTER TABLE `sent_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37511;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sign_attachments`
--
ALTER TABLE `sign_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sign_documents`
--
ALTER TABLE `sign_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `sign_document_files`
--
ALTER TABLE `sign_document_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `sign_email_logs`
--
ALTER TABLE `sign_email_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `sign_events`
--
ALTER TABLE `sign_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=542;

--
-- AUTO_INCREMENT for table `sign_fields`
--
ALTER TABLE `sign_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=950;

--
-- AUTO_INCREMENT for table `sign_field_values`
--
ALTER TABLE `sign_field_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `sign_saved_profiles`
--
ALTER TABLE `sign_saved_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `sign_saved_signatures`
--
ALTER TABLE `sign_saved_signatures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sign_signers`
--
ALTER TABLE `sign_signers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `sign_templates`
--
ALTER TABLE `sign_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sign_template_fields`
--
ALTER TABLE `sign_template_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sign_template_files`
--
ALTER TABLE `sign_template_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sign_template_roles`
--
ALTER TABLE `sign_template_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subscription_events`
--
ALTER TABLE `subscription_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=562;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `transaction_agents`
--
ALTER TABLE `transaction_agents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaction_documents`
--
ALTER TABLE `transaction_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `transaction_notes`
--
ALTER TABLE `transaction_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trust_ledger`
--
ALTER TABLE `trust_ledger`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `trust_reconciliations`
--
ALTER TABLE `trust_reconciliations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `website_form_keys`
--
ALTER TABLE `website_form_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lead_messages`
--
ALTER TABLE `lead_messages`
  ADD CONSTRAINT `lead_messages_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sign_attachments`
--
ALTER TABLE `sign_attachments`
  ADD CONSTRAINT `sign_attachments_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `sign_documents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sign_email_logs`
--
ALTER TABLE `sign_email_logs`
  ADD CONSTRAINT `sign_email_logs_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `sign_documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sign_email_logs_ibfk_2` FOREIGN KEY (`signer_id`) REFERENCES `sign_signers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sign_events`
--
ALTER TABLE `sign_events`
  ADD CONSTRAINT `sign_events_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `sign_documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sign_events_ibfk_2` FOREIGN KEY (`signer_id`) REFERENCES `sign_signers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sign_fields`
--
ALTER TABLE `sign_fields`
  ADD CONSTRAINT `sign_fields_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `sign_documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sign_fields_ibfk_2` FOREIGN KEY (`signer_id`) REFERENCES `sign_signers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sign_field_values`
--
ALTER TABLE `sign_field_values`
  ADD CONSTRAINT `sign_field_values_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `sign_fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sign_field_values_ibfk_2` FOREIGN KEY (`signer_id`) REFERENCES `sign_signers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sign_signers`
--
ALTER TABLE `sign_signers`
  ADD CONSTRAINT `sign_signers_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `sign_documents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_agents`
--
ALTER TABLE `transaction_agents`
  ADD CONSTRAINT `fk_transaction_agents_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tx_agents_transaction_0722` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tx_agents_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_txa_transaction_20260722` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_txa_tx_0722` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_agents_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_agents_ibfk_2` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
