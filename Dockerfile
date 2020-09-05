FROM ubuntu

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv
RUN apt-get install -y git

RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel

RUN mkdir /sc
WORKDIR /sc
COPY requirements.txt /sc/
COPY manage.py /sc/
COPY simpleApp /sc/
RUN pip install -r requirements.txt
RUN python3.6 manage.py makemigrations
RUN python3.6 manage.py migrate
CMD python3.6 manage.py runserver 0.0.0.0:8000
COPY . /sc/
