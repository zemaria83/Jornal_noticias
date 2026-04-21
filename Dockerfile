# Vai buscar uma imagem de python na versão 3
FROM python:3 as base

# Define onde a pasta vai ser utilizada dentro do Container
WORKDIR /usr/src/app 

# Copia tudo desta pasta para dentro da pasta WORKDIR dentro do Conteiner
COPY . .

# Corre o comando necessário para atualizar o pip
RUN pip install --upgrade pip

# Instala todas as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta 8000 dentro do container para fora
EXPOSE 8000

RUN python manage.py migrate
RUN python manage.py collectstatic

CMD [ "gunicorn" , "--bind" , "myproject.wsgi" , "0.0.0.0:8000" ]

# "python", "manage.py", "runserver"
# "gunicorn" , "myproject.wsgi"