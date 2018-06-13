class Fighter < ApplicationRecord
  validates :name, presence: true
  validates :life, :attack, :dodge, :critical, inclusion:
    { in: 0..10, message: "can't have less than 0 or more than 10 skillpoints" }

  validate :cant_have_more_than_15_skillpoints

  def cant_have_more_than_15_skillpoints
    skillpoints = life + attack + dodge + critical
    if skillpoints > 15
      errors.add(:fighter, "can't have more than 15 skillpoints, current: #{skillpoints}")
    end
  end
end
