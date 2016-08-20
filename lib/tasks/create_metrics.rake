namespace :create_metrics do
  desc "TODO"
  task mae: :environment do
    values = Mae.calculate
    CSV.open("metrics_prom/mae.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(values)
    end
  end

  desc "TODO"
  task mrse: :environment do
    values = Mrse.calculate
    CSV.open("metrics_prom/mrse.csv", "wb") do |csv|
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
  task mrse_all: :environment do
    mrse = Mrse.calculate

    mrse_interest_average = MrseAffective.calculate("interest","average")
    mrse_interest_sum = MrseAffective.calculate("interest","sum")

    mrse_engagement_average = MrseAffective.calculate("engagement","average")
    mrse_engagement_sum = MrseAffective.calculate("engagement","sum")

    mrse_focus_average = MrseAffective.calculate("focus","average")
    mrse_focus_sum = MrseAffective.calculate("focus","sum")

    mrse_relaxation_average = MrseAffective.calculate("relaxation","average")
    mrse_relaxation_sum = MrseAffective.calculate("relaxation","sum")

    mrse_instantaneousExcitement_average = MrseAffective.calculate("instantaneousExcitement","average")
    mrse_instantaneousExcitement_sum = MrseAffective.calculate("instantaneousExcitement","sum")

    CSV.open("metrics_prom/mrse_all.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(mrse)
      csv << ["affective filtering (interest,average)"].concat(mrse_interest_average)
      csv << ["affective filtering (interest,sum)"].concat(mrse_interest_sum)
      csv << ["affective filtering (engagement,average)"].concat(mrse_engagement_average)
      csv << ["affective filtering (engagement,sum)"].concat(mrse_engagement_sum)  
      csv << ["affective filtering (focus,average)"].concat(mrse_focus_average)
      csv << ["affective filtering (focus,sum)"].concat(mrse_focus_sum)      
      csv << ["affective filtering (relaxation,average)"].concat(mrse_relaxation_average)
      csv << ["affective filtering (relaxation,sum)"].concat(mrse_relaxation_sum)    
      csv << ["affective filtering (instantaneousExcitement,average)"].concat(mrse_instantaneousExcitement_average)
      csv << ["affective filtering (instantaneousExcitement,sum)"].concat(mrse_instantaneousExcitement_sum)    
    end 
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

    CSV.open("metrics_prom/mae_all.csv", "wb") do |csv|
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

  desc "TODO"
  task mrse_increments: :environment do
    mrse = Mrse.calculate

    mrse_interest = MrseIncrements.calculate("interest")
    mrse_engagement = MrseIncrements.calculate("engagement")
    mrse_focus = MrseIncrements.calculate("focus")
    mrse_relaxation = MrseIncrements.calculate("relaxation")
    mrse_instantaneousExcitement = MrseIncrements.calculate("instantaneousExcitement")

    CSV.open("metrics_prom/mrse_increments.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(mrse)
      csv << ["affective filtering (interest)"].concat(mrse_interest)
      csv << ["affective filtering (engagement)"].concat(mrse_engagement)
      csv << ["affective filtering (focus)"].concat(mrse_focus)      
      csv << ["affective filtering (relaxation)"].concat(mrse_relaxation)    
      csv << ["affective filtering (instantaneousExcitement)"].concat(mrse_instantaneousExcitement)    
    end 
  end


  desc "TODO"
  task mae_increments: :environment do
    mae_incremental = Mae.calculate

    mae_incremental_interest = MaeIncrements.calculate("interest")
    mae_incremental_engagement = MaeIncrements.calculate("engagement")
    mae_incremental_focus = MaeIncrements.calculate("focus")
    mae_incremental_relaxation = MaeIncrements.calculate("relaxation")
    mae_incremental_instantaneousExcitement = MaeIncrements.calculate("instantaneousExcitement")

    CSV.open("metrics_prom/mae_increments_all.csv", "wb") do |csv|
      csv << ["name"].concat((1..10).to_a)
      csv << ["Traditional colaborative filtering"].concat(mae_incremental)
      csv << ["affective filtering (interest)"].concat(mae_incremental_interest)
      csv << ["affective filtering (engagement)"].concat(mae_incremental_engagement)  
      csv << ["affective filtering (focus)"].concat(mae_incremental_focus)      
      csv << ["affective filtering (relaxation)"].concat(mae_incremental_relaxation)
      csv << ["affective filtering (instantaneousExcitement)"].concat(mae_incremental_instantaneousExcitement)    
    end
  end
end
