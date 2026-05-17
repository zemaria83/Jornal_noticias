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

#Só é possível conectar à base de dados depois
#do serviço da bd estar inicializado, por isso
#não podemos fazer este comando na fase de construção da imagem. Temos de o executar mais tarde.
# RUN python manage.py migrate

RUN python manage.py collectstatic

#CMD [ "python", "manage.py", "runserver" , "0.0.0.0:8000"  ]
CMD [ "gunicorn" , "--bind" , "0.0.0.0:8000", "mysite.wsgi"  ]

