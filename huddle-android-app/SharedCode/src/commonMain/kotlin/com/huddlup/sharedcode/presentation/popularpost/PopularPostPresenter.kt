package com.huddlup.sharedcode.presentation.popularpost

import com.huddlup.sharedcode.domain.defaultDispatcher
import com.huddlup.sharedcode.domain.model.Post
import com.huddlup.sharedcode.domain.usecase.GetPopularMovies
import com.huddlup.sharedcode.domain.usecase.UseCase
import com.huddlup.sharedcode.presentation.BasePresenter
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

class PopularMoviesPresenter(
    private val getPopularMovies: GetPopularMovies,
    coroutineContext: CoroutineContext = defaultDispatcher
) : BasePresenter<PopularMoviesView>(coroutineContext) {

    override fun onViewAttached(view: PopularMoviesView) {
        view.setLoadingVisible(true)
        getPopularMovies()
    }

    private fun getPopularMovies() {
        scope.launch {
            getPopularMovies(
                UseCase.None,
                onSuccess = { view?.setPopularMovies(it.results) },
                onFailure = { view?.showMoviesFailedToLoad() }
            )
            view?.setLoadingVisible(false)
        }
    }
}

interface PopularMoviesView {

    fun setPopularMovies(movies: List<Post>)

    fun showMoviesFailedToLoad()

    fun setLoadingVisible(visible: Boolean)
}