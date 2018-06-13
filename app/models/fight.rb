class Fight < ApplicationRecord
  has_one :fighter_one, class_name: 'Fighter', foreign_key: 'fighter_one_id'
  has_one :fighter_two, class_name: 'Fighter', foreign_key: 'fighter_two_id'

  validate :not_the_same_fighter

  def not_the_same_fighter
      errors.add(:fight, "can't have a fighter fiightting against himself") if fighter_one_id == fighter_two_id
  end

  private
  
  def self.fight_between(f_one, f_two)
    ### Fighter One ###
    f1 = Fighter.find(f_one[:fighter_id])
    # w1 = Figher.find(f_one[:fighter_id])
    # s1 = Figher.find(f_one[:fighter_id])

    stats_one = {
      life: f1.life, # + s1.type == 'life' ? s1.stat : 0,
      attack: f1.attack, # + w1.type == 'attack' ? w1.stat,
      dodge: f1.dodge, # + s1.type == 'dodge' ? s1.stat : 0,
      critical: f1.critical # +w1.type == 'critical' ? w1.stat : 0
    }

    ### Fighter Two ###
    f2 = Fighter.find(f_two[:fighter_id])
    # w2 = Figher.find(f_one[:fighter_id])
    # s2 = Figher.find(f_one[:fighter_id])

    stats_two = {
      life: f2.life, # + s2.type == 'life' ? s2.stat : 0,
      attack: f2.attack, # + w2.type == 'attack' ? w2.stat,
      dodge: f2.dodge, # + s2.type == 'dodge' ? s2.stat : 0,
      critical: f2.critical # +w2.type == 'critical' ? w2.stat : 0
    }

    ### Create Fight Result and History
    r = Random.new
    history = "Fight Between #{f1.name} and #{f2.name}"
    while (stats_one[:life] > 0 && stats_two[:life] > 0)
      ## Fighter One Turn
      ad = stats_one[:attack]
      history += "|#{f1.name} is attacking for #{ad} damage!"

      if (r.rand(0..100) <= stats_one[:critical])
        ad *= 2
        history += "|It's a critical hit ! It'll deal double damage (#{ad})"
      end

      if (r.rand(0..100) <= stats_two[:dodge])
        history += "|#{f2.name} dodges the attack with a magnificent sidestep !"
      else
        stats_two[:life] -= ad
        history += "|#{f2.name} suffers the loss of #{ad} life points !"
      end

      break if stats_two[:life] <= 0

      ## Fighter One Turn
      ad = stats_two[:attack]
      history += "|#{f2.name} is attacking for #{ad} damage!"

      if (r.rand(0..100) <= stats_two[:critical])
        ad *= 2
        history += "|It's a critical hit ! It'll deal double damage (#{ad})"
      end

      if (r.rand(0..100) <= stats_two[:dodge])
        history += "|#{f1.name} dodges the attack with a magnificent sidestep !"
      else
        stats_one[:life] -= ad
        history += "|#{f1.name} suffers the loss of #{ad} life points !"
      end
    end

    history += "|The fight is over ! Congratulation to our two fighters : #{f1.name} and #{f2.name}"

    if stats_one[:life] <= 0
      winner = f2
      looser = f1
    else
      winner = f1
      looser = f2
    end

    history += "|And the winner is... #{winner.name} !!"

    return {
      winner_id: winner.id,
      looser_id: looser.id,
      history: history,
      fighter_one_id: f1.id,
      fighter_two_id: f2.id
    }
  end
end
