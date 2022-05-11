# Bungalow Dev-Ops Hiring

The intention of this repository is to give a baseline to talk about in the interview of a Dev-Ops candidate.

## Getting Started

### Web Application

* Python; tested with Python 3.9, probably works with other versions too
* Django

#### Initial Setup

* Assumes 'nix environment
* The following shell commands will:
  * Create a Python virtual environment and use it
  * Install the requirements
  * Run database migrations
  * Create an admin user
  * Start the server

```bash
cd randomnumber
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```
