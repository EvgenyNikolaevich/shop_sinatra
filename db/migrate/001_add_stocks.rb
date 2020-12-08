Sequel.migration do
  change do
    create_table :stocks do |_t|
      primary_key :id

      String  :name, null: false
      Integer :bearer_id, null: false

      DateTime :created_at,   null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at,   null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :deleted_at
    end
  end
end
