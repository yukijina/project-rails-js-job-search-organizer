# Job Search Organizer

## User  
has_many :companies
has_many :positions, through: :companies
has_many :checklists

- username
- email
- password_digest

## Company
has_many :users
has_many :positions

- name
- city
- contact_person
- email
- phone_number

## Position
belongs_to :company
has_many :users
has_many :checklists

- title
- description
- salary
- full_time (boolean, default: false, null: false)
- company_id

## Checklist
belongs_to :user
belongs_to :position

- user_id
- position_id
- resume (boolean)
- interview (boolean)
- completed (boolean)
- note
- created_at (datetime, null: false) - auto
- updated_at (datetime, null: false) - auto  


Routes:
home  
login
logout

### user
signup - new, create - check box if you are company
show - user profile  

### company
show - company profile

### position (nested under company)
show
can edit/update only company

### checklist (nested under user)
index  - table for user, company, resume, interview, created, updated - only user can see
new, create
edit, update
destroy



- user/new   #signup
- user/:id   #show   -> add company

- company/new  #or choose existing company
- company/:id  -> add positions
- company
- company/positions
- company/positions/new
- company/positions/:id


- user/:id/checklist
- user/:id/checklist/new
- user/:id/checklist/:id
- user/:id/checklist/:id/edit
- user/:id/checklist/:id/destroy


Routes:
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  root 'sessions#home'

  resources users, only: [:show] do
    resources checklists
  end

  resources companies do
    resources positions, only: [:index, :show, :new, :create]
  end

  resources :users, only: [:new, :create, :show]
  resources :companies
