class CreateScreenings < ActiveRecord::Migration
  def up
    create_table :screenings do |t|
      t.string :ldb_1k
      t.string :ldb_3k
      t.string :rdb_dot5k
      t.string :rdb_3k
      t.string :ldb_6k
      t.string :rdb_1k
      t.string :audio_comments
      t.string :ldb_dot5k
      t.string :ldb_2k
      t.string :rdb_6k
      t.string :rdb_4k
      t.string :rdb_2k
      t.string :ldb_4k
      t.string :ldb_8k
      t.string :audio_loss_value
      t.string :rdb_8k
      t.string :audiometric_referred
      t.string :audio_periodic_results
      t.string :audio_abnormal_shift
      t.string :audio_abnormal_shift_right
      t.string :audio_recommendation_id
      t.string :audio_test_type
      t.string :audio_abnormal_shift_left
      t.string :audio_baseline_results
      t.string :audio_one_sided
      t.string :audiometric_tested_by_id
      t.string :client_name
      t.string :client_dob
      t.string :trade
      t.string :company
      t.string :collection_site
      t.string :funder
      t.string :location_of_testing
      t.string :mobile_phone
      t.string :wire_api_token
      t.string :affidavit_comments
      t.string :affidavit_status
    end
  end
end
