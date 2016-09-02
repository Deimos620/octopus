# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160310160139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "editor_user_id"
    t.integer  "importer_user_id"
    t.integer  "editor_participant_id"
    t.integer  "us_state_id"
    t.integer  "country_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.integer  "kind",                  default: 1
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "venue"
    t.string   "title"
    t.boolean  "primary",               default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "website"
    t.string   "phone"
  end

  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree
  add_index "addresses", ["kind"], name: "index_addresses_on_kind", using: :btree
  add_index "addresses", ["owner_id"], name: "index_addresses_on_owner_id", using: :btree
  add_index "addresses", ["owner_type"], name: "index_addresses_on_owner_type", using: :btree
  add_index "addresses", ["us_state_id"], name: "index_addresses_on_us_state_id", using: :btree

  create_table "attendees", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "event_id"
    t.integer  "status",                 default: 1
    t.integer  "invitor_participant_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree
  add_index "attendees", ["participant_id"], name: "index_attendees_on_participant_id", using: :btree

  create_table "blocked_times", force: :cascade do |t|
    t.integer  "project_date_id"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "editor_participant_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "blocked_times", ["project_date_id"], name: "index_blocked_times_on_project_date_id", using: :btree

  create_table "blog_authors", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "is_default",     default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "twitter"
    t.string   "slug"
    t.text     "bio"
    t.integer  "editor_user_id", default: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "blog_authors", ["slug"], name: "index_blog_authors_on_slug", using: :btree
  add_index "blog_authors", ["user_id"], name: "index_blog_authors_on_user_id", using: :btree

  create_table "blog_categories", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.string   "name"
    t.string   "slug"
    t.string   "hero"
    t.string   "thumbnail"
    t.string   "description"
    t.integer  "rank",           default: 1000
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "blog_categories", ["name"], name: "index_blog_categories_on_name", using: :btree
  add_index "blog_categories", ["slug"], name: "index_blog_categories_on_slug", using: :btree

  create_table "blog_features", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.string   "title"
    t.text     "description"
    t.string   "hero_img"
    t.string   "thumbnail_img"
    t.string   "slug"
    t.boolean  "live",           default: true
    t.string   "hashtag"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "blog_features", ["slug"], name: "index_blog_features_on_slug", using: :btree
  add_index "blog_features", ["title"], name: "index_blog_features_on_title", using: :btree

  create_table "blog_holidays", force: :cascade do |t|
    t.integer  "editor_user_id",             default: 1
    t.string   "name"
    t.text     "about"
    t.string   "url"
    t.string   "month"
    t.string   "date"
    t.string   "category",                   default: "day"
    t.boolean  "by_day_of_week",             default: false
    t.string   "day_of_week"
    t.string   "by_day_of_week_description"
    t.integer  "rank",                       default: 1000
    t.integer  "week_number"
    t.string   "tag"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "blog_images", force: :cascade do |t|
    t.integer  "editor_user_id",  default: 1
    t.string   "type",            default: "PhotoMediaItem"
    t.string   "landscape_image"
    t.string   "portrait_image"
    t.string   "thumbnail_image"
    t.string   "title"
    t.string   "description"
    t.string   "caption"
    t.integer  "status"
    t.integer  "license"
    t.boolean  "octopus_owned",   default: false
    t.string   "owner_name"
    t.string   "owner_link"
    t.string   "owner_site_name"
    t.string   "media_link"
    t.text     "note"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "blog_images", ["status"], name: "index_blog_images_on_status", using: :btree

  create_table "blog_post_categories", force: :cascade do |t|
    t.integer  "blog_category_id"
    t.integer  "blog_post_id"
    t.integer  "rank"
    t.integer  "editor_user_id",   default: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "blog_post_categories", ["blog_category_id"], name: "index_blog_post_categories_on_blog_category_id", using: :btree
  add_index "blog_post_categories", ["blog_post_id"], name: "index_blog_post_categories_on_blog_post_id", using: :btree

  create_table "blog_post_rankings", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.integer  "category",     default: 1
    t.integer  "rank"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "blog_post_rankings", ["blog_post_id"], name: "index_blog_post_rankings_on_blog_post_id", using: :btree

  create_table "blog_post_slides", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.integer  "editor_user_id",      default: 1
    t.integer  "blog_author_id"
    t.integer  "blog_editor_user_id"
    t.integer  "rank",                default: 1000
    t.string   "title"
    t.text     "description"
    t.integer  "blog_image_id"
    t.integer  "orientation",         default: 1
    t.boolean  "active",              default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "blog_post_slides", ["blog_post_id"], name: "index_blog_post_slides_on_blog_post_id", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "editor_user_id",      default: 1
    t.integer  "blog_author_id"
    t.integer  "original_post_id"
    t.integer  "blog_editor_user_id"
    t.string   "type",                default: "",    null: false
    t.integer  "blog_section_id"
    t.integer  "blog_feature_id"
    t.string   "lead"
    t.text     "body"
    t.datetime "published_datetime"
    t.integer  "status",              default: 0
    t.string   "hero_img"
    t.string   "hero_caption"
    t.string   "thumbnail_img"
    t.string   "slug"
    t.boolean  "special",             default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "blog_posts", ["blog_author_id"], name: "index_blog_posts_on_blog_author_id", using: :btree
  add_index "blog_posts", ["blog_feature_id"], name: "index_blog_posts_on_blog_feature_id", using: :btree
  add_index "blog_posts", ["blog_section_id"], name: "index_blog_posts_on_blog_section_id", using: :btree
  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", using: :btree
  add_index "blog_posts", ["status"], name: "index_blog_posts_on_status", using: :btree

  create_table "blog_references", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.integer  "editor_user_id",             default: 1
    t.integer  "author_id"
    t.string   "nickname"
    t.string   "reference_publication"
    t.string   "reference_title"
    t.date     "reference_publication_date"
    t.string   "reference_link"
    t.string   "reference_author"
    t.boolean  "editor_verified",            default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "blog_references", ["blog_post_id"], name: "index_blog_references_on_blog_post_id", using: :btree

  create_table "blog_sections", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.string   "title"
    t.text     "description"
    t.string   "hero_img"
    t.string   "thumbnail_img"
    t.boolean  "live",           default: true
    t.string   "slug"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "blog_sections", ["slug"], name: "index_blog_sections_on_slug", using: :btree

  create_table "blog_selected_images", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.integer  "blog_media_item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "blog_selected_images", ["blog_media_item_id"], name: "index_blog_selected_images_on_blog_media_item_id", using: :btree
  add_index "blog_selected_images", ["blog_post_id"], name: "index_blog_selected_images_on_blog_post_id", using: :btree

  create_table "blog_taggings", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.integer  "blog_post_id"
    t.integer  "blog_tag_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "blog_taggings", ["blog_post_id"], name: "index_blog_taggings_on_blog_post_id", using: :btree
  add_index "blog_taggings", ["blog_tag_id"], name: "index_blog_taggings_on_blog_tag_id", using: :btree

  create_table "blog_tags", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "hero"
    t.integer  "editor_user_id", default: 1
    t.integer  "rank",           default: 1000
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "blog_tags", ["name"], name: "index_blog_tags_on_name", using: :btree
  add_index "blog_tags", ["slug"], name: "index_blog_tags_on_slug", using: :btree

  create_table "contact_households", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "household_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contact_households", ["contact_id"], name: "index_contact_households_on_contact_id", using: :btree
  add_index "contact_households", ["household_id"], name: "index_contact_households_on_household_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "editor_user_id"
    t.integer  "importer_user_id"
    t.integer  "user_id"
    t.string   "prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "nickname"
    t.string   "email"
    t.string   "url"
    t.string   "gender"
    t.string   "birthday"
    t.string   "primary_phone"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.integer  "home_address_id"
    t.integer  "work_address_id"
    t.integer  "uploded_id"
    t.integer  "original_contact_id"
    t.integer  "status"
    t.text     "note"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "contacts", ["importer_user_id"], name: "index_contacts_on_importer_user_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_kinds", force: :cascade do |t|
    t.integer  "email_theme_id"
    t.integer  "editor_user_id", default: 1
    t.string   "type",           default: "",    null: false
    t.string   "project_type"
    t.boolean  "admin",          default: false
    t.string   "role_type"
    t.string   "category"
    t.string   "label"
    t.string   "subject"
    t.integer  "max_sends"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "email_kinds", ["email_theme_id"], name: "index_email_kinds_on_email_theme_id", using: :btree

  create_table "email_lists", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.integer  "email_kind_id"
    t.string   "user_id"
    t.boolean  "subscribed",     default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "email_logs", force: :cascade do |t|
    t.integer  "sender_user_id",          default: 1
    t.integer  "email_kind_id"
    t.integer  "receiver_participant_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "email_logs", ["email_kind_id"], name: "index_email_logs_on_email_kind_id", using: :btree
  add_index "email_logs", ["sender_user_id"], name: "index_email_logs_on_sender_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "participant_id"
    t.integer  "project_date_id"
    t.integer  "editor_participant_id", default: 1
    t.text     "description"
    t.string   "location"
    t.integer  "address_id"
    t.date     "date_start"
    t.date     "date_end"
    t.boolean  "all_day"
    t.string   "repeat"
    t.integer  "status",                default: 1
    t.string   "category"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "attendees_count"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "events", ["participant_id"], name: "index_events_on_participant_id", using: :btree
  add_index "events", ["project_date_id"], name: "index_events_on_project_date_id", using: :btree
  add_index "events", ["project_id"], name: "index_events_on_project_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "editor_user_id",     default: 1
    t.datetime "editor_user_viewed"
    t.boolean  "viewed",             default: false
    t.boolean  "flagged",            default: false
    t.string   "country",            default: "USA"
    t.string   "language",           default: "en-us"
    t.integer  "category",           default: 1
    t.string   "page"
    t.string   "browser"
    t.string   "version"
    t.string   "platform"
    t.string   "os"
    t.text     "feedback"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "feedbacks", ["editor_user_viewed"], name: "index_feedbacks_on_editor_user_viewed", using: :btree
  add_index "feedbacks", ["flagged"], name: "index_feedbacks_on_flagged", using: :btree
  add_index "feedbacks", ["project_id"], name: "index_feedbacks_on_project_id", using: :btree
  add_index "feedbacks", ["viewed"], name: "index_feedbacks_on_viewed", using: :btree

  create_table "flags", force: :cascade do |t|
    t.integer  "editor_contact_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "secondary_owner_type"
    t.integer  "secondary_owner_id"
    t.string   "category"
    t.string   "note"
    t.integer  "status"
    t.boolean  "critical",             default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "guest_households", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guests", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "meal_option_id"
    t.integer  "guest_household_id"
    t.text     "note"
    t.integer  "guest_category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "guests", ["contact_id"], name: "index_guests_on_contact_id", using: :btree
  add_index "guests", ["guest_category_id"], name: "index_guests_on_guest_category_id", using: :btree

  create_table "honored_guests", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "name"
    t.string   "email"
    t.integer  "participant_title_id"
    t.integer  "participant_id"
    t.boolean  "passive",              default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "honored_guests", ["participant_id"], name: "index_honored_guests_on_participant_id", using: :btree
  add_index "honored_guests", ["participant_title_id"], name: "index_honored_guests_on_participant_title_id", using: :btree
  add_index "honored_guests", ["project_id"], name: "index_honored_guests_on_project_id", using: :btree

  create_table "households", force: :cascade do |t|
    t.integer  "editor_user_id"
    t.integer  "importer_user_id"
    t.integer  "status"
    t.string   "name",                 default: "",     null: false
    t.integer  "default_address_id"
    t.string   "default_address_name", default: "Home"
    t.string   "second_address_name",  default: "Home"
    t.integer  "second_address_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "households", ["default_address_id"], name: "index_households_on_default_address_id", using: :btree

  create_table "kinds", force: :cascade do |t|
    t.string   "project_type"
    t.string   "title"
    t.integer  "kind",                  default: 1
    t.integer  "rank",                  default: 99
    t.boolean  "wedding_related",       default: false
    t.boolean  "baby_related",          default: false
    t.string   "short_description"
    t.text     "long_description"
    t.string   "icon"
    t.integer  "status",                default: 1
    t.integer  "editor_participant_id", default: 1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "list_recipients", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "editor_participant_id"
    t.integer  "grantor_participant_id"
    t.integer  "list_id"
    t.integer  "household_id"
    t.string   "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "list_recipients", ["guest_id"], name: "index_list_recipients_on_guest_id", using: :btree
  add_index "list_recipients", ["household_id"], name: "index_list_recipients_on_household_id", using: :btree
  add_index "list_recipients", ["list_id"], name: "index_list_recipients_on_list_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.integer  "editor_participant_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "type"
    t.string   "custom_name"
    t.boolean  "has_limit",             default: false
    t.integer  "limit"
    t.integer  "status"
    t.boolean  "rsvp_needed",           default: true
    t.boolean  "has_meals",             default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "lists", ["project_id"], name: "index_lists_on_project_id", using: :btree
  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "meta_properties", force: :cascade do |t|
    t.integer  "editor_user_id",            default: 1
    t.string   "owner_type"
    t.integer  "owner_id"
    t.integer  "meta_property_category_id"
    t.string   "name"
    t.string   "property"
    t.text     "content"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "meta_properties", ["meta_property_category_id"], name: "index_meta_properties_on_meta_property_category_id", using: :btree
  add_index "meta_properties", ["owner_id"], name: "index_meta_properties_on_owner_id", using: :btree
  add_index "meta_properties", ["owner_type"], name: "index_meta_properties_on_owner_type", using: :btree

  create_table "meta_property_categories", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.integer  "kind"
    t.integer  "label"
    t.string   "name",                       null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "meta_property_categories", ["kind"], name: "index_meta_property_categories_on_kind", using: :btree
  add_index "meta_property_categories", ["label"], name: "index_meta_property_categories_on_label", using: :btree

  create_table "no_access_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "previous_page"
    t.string   "browser"
    t.string   "version"
    t.string   "platform"
    t.string   "os"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "no_access_logs", ["user_id"], name: "index_no_access_logs_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "editor_user_id", default: 1
    t.integer  "section_id"
    t.string   "slug"
    t.string   "title"
    t.string   "lead"
    t.text     "body"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["section_id"], name: "index_pages_on_section_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "participant_roles", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "grantor_participant_id"
    t.integer  "editor_participant_id",  default: 1
    t.string   "type",                   default: "", null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "status",                 default: 1
    t.integer  "project_id"
  end

  add_index "participant_roles", ["grantor_participant_id"], name: "index_participant_roles_on_grantor_participant_id", using: :btree
  add_index "participant_roles", ["participant_id"], name: "index_participant_roles_on_participant_id", using: :btree

  create_table "participant_titles", force: :cascade do |t|
    t.integer  "participant_id"
    t.string   "title"
    t.string   "description"
    t.integer  "editor_participant_id", default: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "participant_titles", ["participant_id"], name: "index_participant_titles_on_participant_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "invitor_participant_id",         default: 1
    t.integer  "editor_participant_id",          default: 1
    t.string   "email"
    t.integer  "status",                         default: 1
    t.text     "message"
    t.string   "title"
    t.string   "conntection_name"
    t.string   "connected_to"
    t.integer  "connected_to_user_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "relationship"
    t.integer  "relationship_to_participant_id"
    t.string   "relationship_to_name"
    t.string   "relationship_to_title"
    t.boolean  "is_star",                        default: false
    t.string   "token"
    t.integer  "times_contacted",                default: 1
  end

  add_index "participants", ["email"], name: "index_participants_on_email", using: :btree
  add_index "participants", ["project_id"], name: "index_participants_on_project_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "profile_socials", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "name"
    t.string   "avatar"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",                                                     null: false
    t.integer  "editor_user_id",        default: 1
    t.date     "birth_date"
    t.string   "vendor_name"
    t.boolean  "is_vendor",             default: false
    t.string   "country",               default: "USA"
    t.string   "language",              default: "en-us"
    t.string   "phone"
    t.string   "website"
    t.string   "referral_code"
    t.string   "created_at_ip"
    t.datetime "originally_created_at"
    t.string   "time_zone",             default: "Centra Time (US & Canada)"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "project_dates", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "editor_participant_id", default: 1
    t.date     "schedule_date",                         null: false
    t.boolean  "available",             default: true
    t.boolean  "custom_time",           default: false
    t.integer  "events_count",          default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "project_dates", ["project_id"], name: "index_project_dates_on_project_id", using: :btree

  create_table "project_restrictions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "restriction_id"
    t.integer  "editor_participant_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "project_restrictions", ["project_id"], name: "index_project_restrictions_on_project_id", using: :btree
  add_index "project_restrictions", ["restriction_id"], name: "index_project_restrictions_on_restriction_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "editor_participant_id",    default: 1
    t.integer  "organizer_participant_id"
    t.integer  "status",                   default: 0
    t.string   "type",                     default: "",    null: false
    t.string   "title"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "img"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "time_start"
    t.time     "time_end"
    t.datetime "prep_start_datetime"
    t.datetime "prep_end_datetime"
    t.integer  "form_progress"
    t.integer  "participants_count"
    t.integer  "guests_count"
    t.integer  "items_count"
    t.integer  "tasks_count"
    t.integer  "milestones_count"
    t.integer  "events_count"
    t.string   "notes"
    t.string   "max_visits"
    t.integer  "approver_user_id"
    t.boolean  "approved",                 default: false
    t.datetime "approved_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "deleted_at"
  end

  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree
  add_index "projects", ["organizer_participant_id"], name: "index_projects_on_organizer_participant_id", using: :btree

  create_table "restrictions", force: :cascade do |t|
    t.integer  "kind",           default: 1
    t.string   "name"
    t.string   "note"
    t.integer  "editor_user_id", default: 1
    t.boolean  "visible",        default: true
    t.integer  "rank",           default: 99
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "restrictions", ["kind"], name: "index_restrictions_on_kind", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "editor_user_id", default: 1
    t.string   "type",           default: "", null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "editor_user_id"
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "sections", ["slug"], name: "index_sections_on_slug", using: :btree

  create_table "social_account_authorizations", force: :cascade do |t|
    t.integer  "editor_user_id",    default: 1
    t.integer  "user_id"
    t.integer  "social_account_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "social_account_authorizations", ["social_account_id"], name: "index_social_account_authorizations_on_social_account_id", using: :btree
  add_index "social_account_authorizations", ["user_id"], name: "index_social_account_authorizations_on_user_id", using: :btree

  create_table "social_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "platform"
    t.string   "name"
    t.string   "url"
    t.integer  "editor_user_id",     default: 1
    t.string   "username"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "login"
    t.string   "encrypted_password", default: "",    null: false
    t.boolean  "internal",           default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "social_accounts", ["username"], name: "index_social_accounts_on_username", using: :btree

  create_table "social_shares", force: :cascade do |t|
    t.integer  "editor_user_id",     default: 1
    t.integer  "blog_post_id"
    t.integer  "social_account_id"
    t.text     "tweet"
    t.text     "copy"
    t.string   "header"
    t.string   "subheader"
    t.string   "default_image"
    t.string   "landscape_image"
    t.string   "square_image"
    t.string   "portrait_image"
    t.string   "scheduled_datetime"
    t.string   "url"
    t.integer  "status",             default: 1
    t.integer  "about_octopus",      default: 1
    t.string   "share_platform_uid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "social_shares", ["blog_post_id"], name: "index_social_shares_on_blog_post_id", using: :btree
  add_index "social_shares", ["social_account_id"], name: "index_social_shares_on_social_account_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "us_states", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                           null: false
    t.string   "encrypted_password",     default: "",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,                            null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.string   "level",                  default: "unknown"
    t.boolean  "accept_terms",           default: false
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "editor_user_id",         default: 1
    t.date     "birth_date"
    t.string   "country",                default: "USA"
    t.string   "language",               default: "en-us"
    t.string   "phone"
    t.string   "website"
    t.string   "referral_code"
    t.string   "created_at_ip"
    t.datetime "originally_created_at"
    t.string   "locale"
    t.string   "location"
    t.string   "time_zone",              default: "Central Time (US & Canada)"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.datetime "deleted_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
