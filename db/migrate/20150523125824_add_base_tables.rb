class AddBaseTables < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id, index: true
      t.string :name

      t.timestamps null: false
    end

    create_table :questions do |t|
      t.integer :category_id, index: true
      t.integer :difficulty, default: 0
      t.text :content

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.integer :question_id, index: true
      t.text :content
      t.boolean :correct

      t.timestamps null: false
    end

    create_table :responses do |t|
      t.integer :answer_id, index: true
      t.integer :question_id, index: true
      t.integer :user_id, index: true
      t.integer :round_id, index: true

      t.timestamps null: false
    end

    create_table :rounds do |t|
      t.integer :game_id, index: true
      t.integer :p1_score
      t.integer :p2_score

      t.timestamps null: false
    end

    create_table :games do |t|
      t.integer :player_1_id, index: true
      t.integer :payer_2_id, index: true
      t.integer :game_id, index: true
      t.integer :winner_id, index: true

      t.timestamps null: false
    end

    create_table :statistics do |t|
      t.integer :user_id, index: true
      t.integer :type
      t.integer :value

      t.timestamps null: false
    end

    create_table :gems do |t|
      t.integer :category_id, index: true
      t.integer :user_id, index: true
      t.integer :count

      t.timestamps null: false
    end
  end
end
