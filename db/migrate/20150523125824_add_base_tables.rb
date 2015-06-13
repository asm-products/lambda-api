class AddBaseTables < ActiveRecord::Migration
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def change
    create_table :answers do |t|
      t.references :question, index: true, null: false
      t.text :content, null: false
      t.boolean :correct, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :categories do |t|
      t.references :parent, index: true
      t.string :name, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :category_gems do |t|
      t.references :category, index: true, null: false
      t.references :user, index: true, null: false
      t.integer :count, default: 0, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :games do |t|
      t.references :player_1, index: true
      t.references :player_2, index: true
      t.references :winner, index: true
      t.references :category, index: true, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :questions do |t|
      t.references :category, index: true, null: false
      t.integer :difficulty, default: 0, null: false
      t.text :content, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :responses do |t|
      t.references :answer, index: true
      t.references :question, index: true, null: false
      t.references :user, index: true, null: false
      t.references :round, index: true, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :rounds do |t|
      t.references :game, index: true, null: false
      t.integer :p1_score, default: 0, null: false
      t.integer :p2_score, default: 0, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :statistics do |t|
      t.references :user, index: true, null: false
      t.integer :statistic_type, null: false
      t.integer :value, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_foreign_key :answers, :questions
    add_foreign_key :categories, :categories, column: :parent_id
    add_foreign_key :category_gems, :categories
    add_foreign_key :category_gems, :users
    add_foreign_key :games, :users, column: :player_1_id
    add_foreign_key :games, :users, column: :player_2_id
    add_foreign_key :games, :users, column: :winner_id
    add_foreign_key :games, :categories
    add_foreign_key :questions, :categories
    add_foreign_key :responses, :answers
    add_foreign_key :responses, :questions
    add_foreign_key :responses, :users
    add_foreign_key :responses, :rounds
    add_foreign_key :rounds, :games
    add_foreign_key :statistics, :users
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
