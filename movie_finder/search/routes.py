from .views import SearchMovieView


def register_routes(app):
    app.router.add_route('POST', '/search/', SearchMovieView)
