package com.huddlup.app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import androidx.drawerlayout.widget.DrawerLayout
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.navigation.NavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.NavigationUI
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.android.material.navigation.NavigationView

class MainActivity : AppCompatActivity(), NavigationView.OnNavigationItemSelectedListener {
    private lateinit var currentNavController: LiveData<NavController>
    private lateinit var drawer: DrawerLayout
    private lateinit var navigationView: NavigationView
    private lateinit var appBarConfiguration: AppBarConfiguration
    private lateinit var bottomNavigationView: BottomNavigationView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        drawer = findViewById(R.id.drawer_layout)
        navigationView = findViewById(R.id.drawer_nav_view)
        bottomNavigationView = findViewById(R.id.bottom_nav_view)
        val navGraphIds = listOf(R.navigation.timeline_navigation,
            R.navigation.search_navigation,
            R.navigation.notification_navigation,
            R.navigation.message_navigation)

        val controller = bottomNavigationView.setupWithNavController(
            navGraphIds = navGraphIds,
            fragmentManager = supportFragmentManager,
            containerId = R.id.nav_host_container,
            intent = intent
        )

        controller.observe(this, Observer { navController ->
            NavigationUI.setupWithNavController(navigationView, navController)
        })
        currentNavController = controller
        appBarConfiguration = AppBarConfiguration(setOf(
            R.navigation.timeline_navigation,
            R.navigation.search_navigation,
            R.navigation.notification_navigation,
            R.navigation.message_navigation
        ),drawer)

//        supportActionBar?.setHomeButtonEnabled(false)
//        supportActionBar?.setDisplayHomeAsUpEnabled(false)
        navigationView.setNavigationItemSelectedListener(this)
        //findViewById<TextView>(R.id.main_text).text = createApplicationScreenMessage()
//        val recyclerPosts = findViewById<RecyclerView>(R.id.rv_posts)
//        recyclerPosts?.layoutManager =
//            LinearLayoutManager(this@MainActivity, LinearLayoutManager.HORIZONTAL, false)
//        val adapter = PostsAdapter(emptyList())
//        recyclerPosts?.adapter = adapter
    }

    override fun onNavigationItemSelected(item: MenuItem): Boolean {
        val id: Int = item.itemId
        return true
    }
}