from django.db import models


#criar classe para os artigos

class Artigo(models.Model):
    titulo = models.CharField(max_length=200)
    corpo = models.TextField()
    data_criacao = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.titulo

#criar classe para os comentarios

class Comentario(models.Model):
    artigo = models.ForeignKey(Artigo, on_delete=models.CASCADE, related_name='comentarios')
    texto = models.TextField()
    data_criacao = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comentário em {self.artigo.titulo}"
