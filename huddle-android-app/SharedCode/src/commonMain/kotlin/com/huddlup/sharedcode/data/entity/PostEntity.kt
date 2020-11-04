package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class PostEntity(
    //@SerialName("vote_count")
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
)