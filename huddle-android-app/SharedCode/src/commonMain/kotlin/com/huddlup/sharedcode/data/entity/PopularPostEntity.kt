package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RecentPostEntity(
    @SerialName("total_results") val totalResults: Int,
    val results: List<PostEntity>
)