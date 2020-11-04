package com.huddlup.app.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.huddlup.app.R
import com.huddlup.app.custom.PostView
import com.huddlup.sharedcode.domain.model.Post

class PostItemViewHolder(val inflater: LayoutInflater, val parent: ViewGroup) :
    RecyclerView.ViewHolder(inflater.inflate(R.layout.post_view_layout, parent, false)) {

    private var postItemView: PostView? =null

    init {
        postItemView = itemView.findViewById(R.id.post_view_item)
    }

    fun bind(postdata: Post) {

    }
}