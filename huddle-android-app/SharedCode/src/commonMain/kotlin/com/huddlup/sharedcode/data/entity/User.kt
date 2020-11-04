package com.huddlup.sharedcode.data.entity

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
class User {
    @SerialName("id")
    var id: Int? = null

    @SerialName("username")
    var username: String? = null

    @SerialName("name")
    var name: String? = null

    @SerialName("profilePhoto")
    var profilePhoto: String? = null

    @SerialName("coverPhoto")
    var coverPhoto: String? = null

    @SerialName("bio")
    var bio: String? = null

    @SerialName("location")
    var location: String? = null

    @SerialName("dob")
    var dob: String? = null

    @SerialName("isVerified")
    var isVerified: Boolean? = null

    @SerialName("followersCount")
    var followersCount: Int? = null

    @SerialName("followingsCount")
    var followingsCount: Int? = null

    @SerialName("etag")
    var etag: String? = null

}