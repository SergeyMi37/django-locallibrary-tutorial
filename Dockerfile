FROM python:3.9

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .
# install python dependencies
RUN pip install --upgrade pip

RUN apt-get update && apt-get install -y wget && \
 apt-get install -y gettext

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# running migrations
RUN python manage.py migrate
#RUN python manage.py createsuperuser --noinput --username adm --email adm@mswhost.com
#RUN python manage.py loaddata db-init-param.json
# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "locallibrary.wsgi"]
