from movie_finder.contrib.response import JSONResponse


def index(request):  # pragma: no cover
    return JSONResponse(data={'status': 'OK'})


def register_routes(app):
    app.router.add_route('GET', '/', index)
