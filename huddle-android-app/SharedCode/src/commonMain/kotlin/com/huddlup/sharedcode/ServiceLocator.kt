package com.huddlup.sharedcode

import com.huddlup.sharedcode.data.MoviesApi
import com.huddlup.sharedcode.domain.usecase.GetPopularMovies
import com.huddlup.sharedcode.presentation.popularpost.PopularMoviesPresenter
import io.ktor.client.engine.HttpClientEngine
import kotlin.native.concurrent.ThreadLocal

/**
 * A basic service locator implementation, as any frameworks like `Kodein` don't really work at the moment.
 */
@ThreadLocal
object ServiceLocator {

    val moviesApi by lazy { MoviesApi(PlatformServiceLocator.httpClientEngine) }

    val getPopularMovies: GetPopularMovies
        get() = GetPopularMovies(moviesApi)

    val popularMoviesPresenter: PopularMoviesPresenter
        get() = PopularMoviesPresenter(getPopularMovies)
}

/**
 * Contains some expected dependencies for the [ServiceLocator] that have to be resolved by Android/iOS.
 */
expect object PlatformServiceLocator {

    val httpClientEngine: HttpClientEngine
}