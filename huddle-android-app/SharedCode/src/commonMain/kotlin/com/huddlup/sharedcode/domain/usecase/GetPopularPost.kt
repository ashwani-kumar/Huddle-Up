package com.huddlup.sharedcode.domain.usecase

import com.huddlup.sharedcode.data.MoviesApi
import com.huddlup.sharedcode.domain.model.*

/**
 * A `use case` to get the currently most popular movies.
 */
class GetPopularMovies(private val moviesApi: MoviesApi) : UseCase<PopularMovies, UseCase.None>() {

    override suspend fun run(params: None): Either<Exception, PopularMovies> {
        return try {
            val movies = moviesApi.getPopularMovies().toModel()
            Success(movies)
        } catch (e: Exception) {
            Failure(e)
        }
    }
}