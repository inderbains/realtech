export const resources = {
  "crm": {
    "table": "leads",
    "cols": [
      "id",
      "email",
      "phone",
      "source",
      "stage",
      "assigned_to",
      "created_at"
    ]
  },
  "pipeline": {
    "table": "leads",
    "cols": [
      "id",
      "stage",
      "source",
      "assigned_to"
    ]
  },
  "tasks": {
    "table": "tasks",
    "cols": [
      "id",
      "title",
      "lead_id",
      "assigned_to",
      "due_date",
      "priority",
      "status",
      "created_at"
    ]
  },
  "messages": {
    "table": "messages",
    "cols": [
      "id",
      "created_at"
    ]
  },
  "community": {
    "table": "community_posts",
    "cols": [
      "id",
      "user_id",
      "created_at"
    ]
  },
  "transactions": {
    "table": "transactions",
    "cols": [
      "id",
      "property_address",
      "status",
      "workflow_status",
      "agent_id",
      "completion_date",
      "created_at"
    ]
  },
  "listings": {
    "table": "agent_listings",
    "cols": [
      "id",
      "title",
      "address",
      "price",
      "listing_type",
      "status",
      "mls_number",
      "created_at"
    ]
  },
  "open-houses": {
    "table": "open_house_events",
    "cols": [
      "id",
      "event_date",
      "start_time",
      "end_time"
    ]
  },
  "property-pages": {
    "table": "property_pages",
    "cols": [
      "id",
      "title",
      "status",
      "slug",
      "created_at"
    ]
  },
  "goals": {
    "table": "agent_goals",
    "cols": [
      "id",
      "agent_id",
      "goal_year",
      "annual_gci_goal",
      "annual_closed_deals_goal",
      "status"
    ]
  },
  "resources": {
    "table": "brokerage_resources",
    "cols": [
      "id",
      "title",
      "category",
      "created_at"
    ]
  },
  "commissions": {
    "table": "commission_statements",
    "cols": [
      "id",
      "transaction_id",
      "agent_id",
      "gross_commission",
      "status",
      "created_at"
    ]
  },
  "accounting": {
    "table": "banking_transactions",
    "cols": [
      "id",
      "transaction_id",
      "direction",
      "amount",
      "entry_date",
      "reference_no"
    ]
  },
  "banking": {
    "table": "banking_transactions",
    "cols": [
      "id",
      "direction",
      "amount",
      "entry_date",
      "payee",
      "reference_no"
    ]
  },
  "trust": {
    "table": "trust_ledger",
    "cols": [
      "id",
      "transaction_id",
      "type",
      "amount",
      "entry_date",
      "reference_no",
      "cleared",
      "cleared_date"
    ]
  },
  "reconciliation": {
    "table": "trust_reconciliations",
    "cols": [
      "id",
      "recon_month",
      "opening_balance",
      "bank_ending_balance",
      "system_balance",
      "difference",
      "status",
      "locked_at"
    ]
  },
  "compliance": {
    "table": "transactions",
    "cols": [
      "id",
      "property_address",
      "status",
      "workflow_status",
      "completion_date",
      "updated_at"
    ]
  },
  "reports": {
    "table": "audit_logs",
    "cols": [
      "id",
      "user_id",
      "transaction_id",
      "action",
      "created_at"
    ]
  },
  "t4a": {
    "table": "payroll_records",
    "cols": [
      "id",
      "status"
    ]
  },
  "agents": {
    "table": "users",
    "cols": [
      "id",
      "username",
      "email",
      "role",
      "status",
      "can_view_all_crm",
      "receives_leads",
      "is_team_lead",
      "last_login"
    ]
  },
  "lead-distribution": {
    "table": "lead_distribution_rules",
    "cols": [
      "id",
      "source",
      "agent_id",
      "is_active",
      "created_at"
    ]
  },
  "integrations": {
    "table": "ad_lead_integrations",
    "cols": [
      "id",
      "platform",
      "page_name",
      "status",
      "last_lead_at",
      "created_at"
    ]
  },
  "import": {
    "table": "import_batches",
    "cols": [
      "id",
      "user_id",
      "file_name",
      "total_rows",
      "imported_rows",
      "created_at"
    ]
  },
  "email-templates": {
    "table": "email_templates",
    "cols": [
      "id",
      "subject",
      "created_at"
    ]
  },
  "settings": {
    "table": "brokerages",
    "cols": [
      "id",
      "brokerage_name",
      "slug",
      "email",
      "phone",
      "plan",
      "subscription_status",
      "crm_plan",
      "distribution_mode",
      "status"
    ]
  },
  "sign-documents": {
    "table": "sign_documents",
    "cols": [
      "id",
      "status",
      "created_by",
      "completed_at",
      "created_at"
    ]
  },
  "sign-templates": {
    "table": "sign_templates",
    "cols": [
      "id",
      "created_by",
      "created_at"
    ]
  },
  "sign-signers": {
    "table": "sign_signers",
    "cols": [
      "id",
      "document_id",
      "signing_order",
      "status",
      "viewed_at",
      "signed_at"
    ]
  },
  "sign-reports": {
    "table": "sign_events",
    "cols": [
      "id",
      "document_id",
      "signer_id",
      "event_type",
      "ip_address",
      "created_at"
    ]
  }
} as const;
