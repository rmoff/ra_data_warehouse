WITH mailchimp_campaigns as (

  SELECT * EXCEPT (_sdc_batched_at, max_sdc_batched_at)
  FROM
  (
    SELECT SELECT
      id AS campaign_id,
      content_type AS content_type,
      create_time AS created_at,
      emails_sent AS number_emails_sent,
      long_archive_url AS archive_url,
      recipients.list_id AS list_id,
      recipients.list_is_active AS list_is_active,
      recipients.list_name AS list_name,
      recipients.recipient_count AS recipient_count,
      recipients.segment_opts AS segment_opts,
      recipients.segment_text AS segment_text,
      recipients.segment_opts.conditions AS segment_conditions,
      recipients.segment_opts.match AS segment_match,
      recipients.segment_opts.saved_segment_id AS segment_id,
      report_summary.click_rate AS click_rate,
      report_summary.clicks AS clicks,
      report_summary.open_rate AS open_rate,
      report_summary.opens AS opens,
      report_summary.subscriber_clicks AS subscriber_clicks,
      report_summary.unique_opens AS unique_opens,
      report_summary.ecommerce.total_orders AS ecommerce_total_orders,
      report_summary.ecommerce.total_revenue AS ecommerce_total_revenue,
      report_summary.ecommerce.total_spent AS ecommerce_total_spent,
      resendable AS resendable,
      send_time AS sent_at,
      settings.authenticate AS has_authenticate,
      settings.auto_footer AS has_auto_footer,
      settings.auto_tweet AS has_auto_tweet,
      settings.drag_and_drop AS is_drag_and_drop,
      settings.fb_comments AS has_fb_comments,
      settings.from_name AS from_name,
      settings.preview_text AS preview_text,
      settings.reply_to AS reply_to,
      settings.subject_line AS subject_line,
      settings.template_id AS template_id,
      settings.timewarp AS timewarp,
      settings.title AS title,
      settings.to_name AS to_name,
      status AS status,
      tracking.clicktale AS tracking_clicktale,
      tracking.ecomm360 AS tracking_ecomm360,
      tracking.goal_tracking AS tracking_goal_tracking,
      tracking.google_analytics AS tracking_google_analytics,
      tracking.html_clicks AS tracking_html_clicks,
      tracking.opens AS tracking_opens,
      tracking.text_clicks AS tracking_text_clicks,
      _sdc_batched_at AS _sdc_batched_at,
      MAX(_sdc_batched_at) OVER (PARTITION BY id ORDER BY _sdc_batched_at RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_sdc_batched_at
    FROM {{ source('mailchimp_email', 'campaigns') }}
  )
  WHERE _sdc_batched_at = max_sdc_batched_at
)
,
select * from mailchimp_campaigns
