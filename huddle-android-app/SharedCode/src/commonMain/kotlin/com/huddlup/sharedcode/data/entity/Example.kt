package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
class Example {
    @SerialName("pageId")
    var pageId: String? = null

    @SerialName("activities")
    var activities: List<Activity>? = null

}