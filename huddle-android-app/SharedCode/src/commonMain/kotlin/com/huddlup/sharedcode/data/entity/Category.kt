package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName
@Serializable
class Category {
    @SerialName("id")
    var id: Int? = null

    @SerialName("etag")
    var etag: String? = null

    @SerialName("category")
    var category: String? = null

}