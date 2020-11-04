package com.huddlup.sharedcode.domain.model

import com.huddlup.sharedcode.data.entity.PostEntity

private const val MOVIE_POSTER_BASE_URL = "https://image.tmdb.org/t/p/original"

data class Post(
    val postedBy: String,
    val id: Int,
    val postedByImage: String,
    val postDate: Long,
    val likeCount: Int,
    val shareCount: Int,
    val postType: Int,
    val postImageUrl: String,
    val postVideoUrl: String,
    val postText: String
) {
}

fun PostEntity.toModel() = Post(
    postedBy = postedBy,
    id = id,
    postedByImage = postedByImage,
    postDate = postDate,
    likeCount = likeCount,
    shareCount = shareCount,
    postType = postType,
    postImageUrl = postImageUrl,
    postVideoUrl = postVideoUrl,
    postText = postText
)