class CreateCertifiedRepositories < ActiveRecord::Migration
  def self.up
    create_table :certified_repositories do |t|
      t.string :certificate_no
      t.string :company_name
      t.string :authority_name
      t.string :authority_signature
      t.string :title
      t.string :phone
      t.string :fax
      t.binary :attachment
      t.string :request_type
      t.datetime :blanket_from_date
      t.datetime :blanket_to_date
      t.string :reference_code
      t.integer :reference_number
      t.timestamps
    end
  end

  def self.down
    drop_table :certified_repositories
  end
end
