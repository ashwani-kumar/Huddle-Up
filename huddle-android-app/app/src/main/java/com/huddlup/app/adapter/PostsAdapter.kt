package com.huddlup.app.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.huddlup.sharedcode.domain.model.Post


class PostsAdapter(private var list: List<Post>)
    : RecyclerView.Adapter<PostItemViewHolder>() {

    private var itemSelectionListener: RowItemClickListener? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PostItemViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        return PostItemViewHolder(inflater, parent)
    }

    fun setRowItemClickListener(listener: RowItemClickListener){
        this.itemSelectionListener = listener
    }

    override fun onBindViewHolder(holderPost: PostItemViewHolder, position: Int) {
        val favItem = list[position]
        holderPost.bind(favItem)

        holderPost.itemView.setOnClickListener {
            itemSelectionListener?.onItemSelected(favItem)
        }
    }

    override fun getItemCount(): Int = list.size

    fun setList(arrayList: List<Post>) {
        list = arrayList
        notifyDataSetChanged()
    }

}

interface RowItemClickListener {
    fun onItemSelected(rowItem: Post)
}