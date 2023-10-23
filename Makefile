# --------------------------------#
# Makefile for the "make" command
# --------------------------------#

# ----- Colors -----
GREEN = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
RED = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"

# ----- Programs -----
COMPOSER         = composer
SYMFONY          = symfony
YARN             = yarn
SYMFONY_CONSOLE  = $(SYMFONY) console

## ----- Project -----
init: ## Initialize the project
	$(MAKE) install
	$(MAKE) db
	@$(call GREEN, "Project initialized!")
	$(MAKE) start

install: ## Install the dependencies and assets
	$(MAKE) c-install
	$(MAKE) y-install

start: ## Start the project
	$(MAKE) serve
	$(MAKE) server

## ----- Composer -----
c-install: ## Install the dependencies
	@$(call GREEN, "Installing dependencies...")
	$(COMPOSER) install

c-update: ## Update the dependencies
	@$(call GREEN, "Updating dependencies...")
	$(COMPOSER) update

## ----- YARN -----
server: ## Start the assets
	@$(call GREEN, "Starting assets...")
	$(YARN) dev-server

y-install: ## Install the assets
	@$(call GREEN, "Installing assets...")
	$(YARN) install

y-update: ## Update the assets
	@$(call GREEN, "Installing assets...")
	$(YARN) install

y-watch: ## Watch the assets
	@$(call GREEN, "Watching assets...")
	$(YARN) yarn watch

y-build: ## Build the assets
	@$(call GREEN, "Building assets...")
	$(YARN) yarn build

## ----- Symfony -----
serve: ## Start the project
	@$(call GREEN, "Starting the project...")
	$(SYMFONY) serve -d
	@$(call GREEN, "Project started! You can now access it at https://127.0.0.1:8000")

stop: ## Stop the project
	@$(call GREEN, "Stopping the project...")
	$(SYMFONY) server:stop
	@$(call GREEN, "Project stopped!")

entity: ## Create the Entity
	@$(call GREEN, "Creating Entity...")
	$(SYMFONY_CONSOLE) make:entity

controller: ## Create the Controller
	@$(call GREEN, "Creating Controller...")
	$(SYMFONY_CONSOLE) make:controller

subscriber: ## Create the Subscriber
	@$(call GREEN, "Creating Subscriber...")
	$(SYMFONY_CONSOLE) make:subscriber

form: ## Create the Form
	@$(call GREEN, "Creating Form...")
	$(SYMFONY_CONSOLE) make:form

user: ## Create the User entity
	@$(call GREEN, "Creating User entity...")
	$(SYMFONY_CONSOLE) make:user

auth: ## Create the Authentication
	@$(call GREEN, "Creating Authenticate...")
	$(SYMFONY_CONSOLE) make:auth

register: ## Create the registration form
	@$(call GREEN, "Creating Registration Form...")
	$(SYMFONY_CONSOLE) make:registration-form

hash: ## Hash a password
	@$(call GREEN, "Hashing Password...")
	$(SYMFONY_CONSOLE) security:hash-password

clear: # Clear the cache
	@$(call GREEN, "Clearing cache...")
	$(SYMFONY_CONSOLE) cache:clear

## ----- Database -----
db: ## Initialize the database
	@$(call GREEN, "Initializing database...")
	$(MAKE) db-create
	$(MAKE) db-update
	$(MAKE) fixtures

db-create: ## Create the database
	@$(call GREEN, "Creating database...")
	$(SYMFONY_CONSOLE) doctrine:database:create

db-update: ## Migrate the database
	@$(call GREEN, "Migrating database...")
	$(SYMFONY_CONSOLE) doctrine:schema:update --force --complete

fixtures: ## Load the fixtures
	@$(call GREEN, "Loading fixtures...")
	$(SYMFONY_CONSOLE) doctrine:fixtures:load --no-interaction

## ----- Help -----
help: ## Display this help
	@$(call GREEN, "Available commands:")
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "3[32m%-30s3[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'