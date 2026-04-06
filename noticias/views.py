from django.shortcuts import render, get_object_or_404, redirect
from .models import Artigo, Comentario


def lista_artigos(request):
    artigos = Artigo.objects.all()
    return render(request, 'noticias/lista_artigos.html', {'artigos': artigos})


def detalhe_artigo(request, artigo_id):
    artigo = get_object_or_404(Artigo, id=artigo_id)
    return render(request, 'noticias/detalhe_artigo.html', {'artigo': artigo})


def comentarios_artigo(request, artigo_id):
    artigo = get_object_or_404(Artigo, id=artigo_id)

    if request.method == 'POST':
        texto = request.POST.get('texto')
        if texto:
            Comentario.objects.create(artigo=artigo, texto=texto)
            return redirect('comentarios_artigo', artigo_id=artigo.id)

    comentarios = artigo.comentarios.all()
    return render(request, 'noticias/comentarios_artigo.html', {
        'artigo': artigo,
        'comentarios': comentarios
    })