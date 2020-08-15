import logging

from aiohttp import web

from movie_finder.contrib.exceptions import BadRequest

logger = logging.getLogger(__name__)


class SearchMovieView(web.View):

    async def post(self):
        try:
            payload = await self.request.json()
        except Exception:
            raise BadRequest(message='Invalid payload')

        payload = {'data': 'OK'}

        return web.json_response(data=payload)
