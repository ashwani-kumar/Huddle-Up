package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
class Media {
    @SerialName("id")
    var id: Int? = null

    @SerialName("mediaType")
    var mediaType: String? = null

    @SerialName("url")
    var url: String? = null

    @SerialName("etag")
    var etag: String? = null

}