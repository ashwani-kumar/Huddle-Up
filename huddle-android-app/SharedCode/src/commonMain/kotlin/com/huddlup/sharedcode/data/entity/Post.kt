package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
class Post {
    @SerialName("id")
    var id: Int? = null

    @SerialName("user")
    var user: User? = null

    @SerialName("text")
    var text: String? = null

    @SerialName("media")
    var media: Media? = null

    @SerialName("postedAt")
    var postedAt: String? = null

    @SerialName("updatedAt")
    var updatedAt: String? = null

    @SerialName("linkedPost")
    var linkedPost: List<Any>? = null

    @SerialName("childPosts")
    var childPosts: List<Any>? = null

    @SerialName("source")
    var source: String? = null

    @SerialName("type")
    var type: String? = null

    @SerialName("numberOfLikes")
    var numberOfLikes: Int? = null

    @SerialName("numberOfRepoet")
    var numberOfRepoet: Int? = null

    @SerialName("numberOfReplies")
    var numberOfReplies: Int? = null

    @SerialName("category")
    var category: Category? = null

    @SerialName("language")
    var language: String? = null

    @SerialName("etag")
    var etag: String? = null

}