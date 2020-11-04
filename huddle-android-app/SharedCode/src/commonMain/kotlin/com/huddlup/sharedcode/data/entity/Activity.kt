package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
class Activity {
    @SerialName("id")
    var id: Int? = null

    @SerialName("user")
    var user: User? = null

    @SerialName("post")
    var post: Post? = null

    @SerialName("type")
    var type: String? = null

    @SerialName("timestamp")
    var timestamp: String? = null

    @SerialName("etag")
    var etag: String? = null

}