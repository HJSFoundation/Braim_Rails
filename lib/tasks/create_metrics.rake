namespace :create_metrics do
  desc "TODO"
  task mae: :environment do
    values = Mae.calculate
    CSV.open("metrics/mae.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(values)
    end
  end

  desc "TODO"
  task mrse: :environment do
    values = Mrse.calculate
    CSV.open("metrics/mrse.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(values)
    end
  end

  desc "TODO"
  task mae_affective: :environment do
  end

  desc "TODO"
  task mrse_affective: :environment do
  end

  desc "TODO"
  task mae_all: :environment do
    mae = Mae.calculate

    mae_interest_average = MaeAffective.calculate("interest","average")
    mae_interest_sum = MaeAffective.calculate("interest","sum")

    mae_engagement_average = MaeAffective.calculate("engagement","average")
    mae_engagement_sum = MaeAffective.calculate("engagement","sum")

    mae_focus_average = MaeAffective.calculate("focus","average")
    mae_focus_sum = MaeAffective.calculate("focus","sum")

    mae_relaxation_average = MaeAffective.calculate("relaxation","average")
    mae_relaxation_sum = MaeAffective.calculate("relaxation","sum")

    mae_instantaneousExcitement_average = MaeAffective.calculate("instantaneousExcitement","average")
    mae_instantaneousExcitement_sum = MaeAffective.calculate("instantaneousExcitement","sum")

    CSV.open("metrics/mae_all.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(mae)
      csv << ["affective filtering (interest,average)"].concat(mae_interest_average)
      csv << ["affective filtering (interest,sum)"].concat(mae_interest_sum)
      csv << ["affective filtering (engagement,average)"].concat(mae_engagement_average)
      csv << ["affective filtering (engagement,sum)"].concat(mae_engagement_sum)  
      csv << ["affective filtering (focus,average)"].concat(mae_focus_average)
      csv << ["affective filtering (focus,sum)"].concat(mae_focus_sum)      
      csv << ["affective filtering (relaxation,average)"].concat(mae_relaxation_average)
      csv << ["affective filtering (relaxation,sum)"].concat(mae_relaxation_sum)    
      csv << ["affective filtering (instantaneousExcitement,average)"].concat(mae_instantaneousExcitement_average)
      csv << ["affective filtering (instantaneousExcitement,sum)"].concat(mae_instantaneousExcitement_sum)    
    end
  end
end
