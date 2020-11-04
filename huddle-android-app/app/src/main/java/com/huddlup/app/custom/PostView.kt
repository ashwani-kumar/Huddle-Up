package com.huddlup.app.custom

import android.content.Context
import android.graphics.Bitmap
import android.util.AttributeSet
import android.widget.Button
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import com.huddlup.app.R
import de.hdodenhof.circleimageview.CircleImageView

class PostView(context: Context, attrs: AttributeSet): ConstraintLayout(context, attrs) {

    private val POST_TEXT = 0
    private val POST_IMAGE = 1
    private val POST_VIDEO = 2
    private val POST_EXTENDED = 4

    private lateinit var profileImage:CircleImageView
    private lateinit var profileName:TextView
    private lateinit var profileHandle:TextView
    private lateinit var postTime:TextView
    private lateinit var postText:TextView
    private lateinit var commentButton:Button
    private lateinit var repostButton:Button
    private lateinit var likeButton:Button
    private lateinit var shareButton:Button
    private var postType = POST_TEXT
    init {
        inflate(context, R.layout.post_view_layout, this)

        profileImage = findViewById(R.id.profile_image)
        profileName = findViewById(R.id.tv_profile_name)
        profileHandle = findViewById(R.id.tv_profile_handle)
        postTime = findViewById(R.id.tv_post_time)
        postText = findViewById(R.id.tv_post_text)
        commentButton = findViewById(R.id.btn_comment)
        repostButton = findViewById(R.id.btn_repost)
        likeButton = findViewById(R.id.btn_like)
        shareButton = findViewById(R.id.btn_share)
        val attributes = context.obtainStyledAttributes(attrs, R.styleable.PostView)
        profileImage.setImageDrawable(attributes.getDrawable(R.styleable.PostView_userImage))
        profileName.text = attributes.getString(R.styleable.PostView_userName)
        postText.text = attributes.getString(R.styleable.PostView_postText)
        postTime.text = attributes.getString(R.styleable.PostView_userHandle)
        profileName.text = attributes.getString(R.styleable.PostView_postTime)
        postType = attributes.getInt(R.styleable.PostView_postType, POST_TEXT)
        attributes.recycle()
    }

    fun setUserName(userName: String){
        profileName.text = userName
    }

    fun setUserImage(userName: Bitmap){
        profileImage.setImageBitmap(userName)
    }

    fun setUserHandle(userHandle: String){
        profileName.text = userHandle
    }

    fun setPostText(text: String){
        postText.text = text
    }

    fun setPostCommentCount(comment: String){
        commentButton.text = comment
    }

    fun setRepostCount(repost: String){
        repostButton.text = repost
    }

    fun setPostLikeCount(like: String){
        likeButton.text = like
    }

    fun setPostType(type: Int){
        postType = type
        refereshView()
    }

    private fun refereshView() {
        when(postType) {
            0 -> {

            }
            1 -> {

            }
            2 -> {

            }
            3 -> {

            }
            4 -> {

            }
            else -> {

            }
        }
    }
}