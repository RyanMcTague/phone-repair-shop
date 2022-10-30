class Phone < ApplicationRecord
  belongs_to :user
  
  validates :name, 
    presence: true,
    uniqueness: { 
      case_sensitive: false,
      scope: :user
    },
    length:{
      minimum: 3,
      maximum: 25
    }
    
  validates :phone_type, 
    presence: true
  
  validates :problem, 
    presence: true

  before_destroy do
    self.errors.add(:base, "cannot delete a phone that is not pending") if self.pending?    
  end

  state_machine :state, initial: :pending do
    state :pending
    state :approved
    state :shipping
    state :arrived
    state :evaluating
    state :analysis_sent
    state :analysis_accepted
    state :fixing
    state :awaiting_shipment

    event :reset do
      transition any - :pending => :pending
    end

    event :approve do
      transition :pending => :approved
    end
    
    event :ship do
      transition :awaiting_shipment => :shipping
    end

    event :arrive do
      transition :shipping => :arrived
    end

    event :evaluate do
      transition :arrived => :evaluating
    end
    
    event :send_analysis do
      transition :evaluating => :analysis_sent
    end

    event :accept_analysis do
      transition :analysis_sent => :analysis_accepted
    end

    event :fix do
      transition :analysis_accepted => :fixing
    end

    event :await_shipment do
      transition [:accepted, :fixing] => :awaiting_shipment
    end
  end
end
