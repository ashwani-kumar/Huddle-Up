package com.huddlup.sharedcode.domain.model

import com.huddlup.sharedcode.data.entity.RecentPostEntity

data class PopularMovies(
    val totalResults: Int,
    val results: List<Post>
)

fun RecentPostEntity.toModel() = PopularMovies(
    totalResults = totalResults,
    results = results.map { it.toModel() }
)