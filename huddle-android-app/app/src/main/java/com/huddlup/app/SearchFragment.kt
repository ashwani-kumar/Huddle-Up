package com.huddlup.app

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.view.GravityCompat
import androidx.drawerlayout.widget.DrawerLayout
import androidx.fragment.app.Fragment
import de.hdodenhof.circleimageview.CircleImageView

class SearchFragment: Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_search, container, false)
        val drawer = activity?.findViewById<View>(R.id.drawer_layout) as DrawerLayout
        val profileImageView = view.findViewById<CircleImageView>(R.id.iv_profile)
        profileImageView.setOnClickListener {
            if (drawer.isDrawerOpen(GravityCompat.START)) {
                drawer.closeDrawer(GravityCompat.START, true)
            } else {
                drawer.openDrawer(GravityCompat.START, true)
            }
        }
        return view
    }
}