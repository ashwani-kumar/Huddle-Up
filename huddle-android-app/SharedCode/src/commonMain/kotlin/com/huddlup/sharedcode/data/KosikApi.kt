package com.huddlup.sharedcode.data

import com.huddlup.sharedcode.data.entity.RecentPostEntity
import io.ktor.client.HttpClient
import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.get
import io.ktor.client.request.header
import io.ktor.client.request.parameter
import io.ktor.client.statement.HttpStatement
import io.ktor.client.response.readText
import io.ktor.client.statement.HttpResponse
import io.ktor.client.statement.readText
import io.ktor.http.URLProtocol
import kotlinx.serialization.json.Json

private const val BASE_URL = "api.themoviedb.org/4"
private const val HEADER_AUTHORIZATION = "Authorization"

@Suppress("EXPERIMENTAL_API_USAGE")
class MoviesApi(clientEngine: HttpClientEngine) {

    private val client = HttpClient(clientEngine) {
        install(JsonFeature) {
            serializer = KotlinxSerializer()
        }
    }

    suspend fun getPopularMovies(): RecentPostEntity {
        // Actually we're able to just return the get()-call and Ktor's JsonFeature will automatically do the
        // JSON parsing for us. However, this currently doesn't work with Kotlin/Native as it doesn't support reflection
        // and we have to manually use PopularMoviesEntity.serializer()
        val response = client.get<HttpStatement> {
            url {
                protocol = URLProtocol.HTTPS
                host = BASE_URL
                encodedPath = "/discover/movie"
                parameter("sort_by", "popularity.desc")
                header(HEADER_AUTHORIZATION, "")//API_KEY.asBearerToken())
            }
        }
        val httpResponse:HttpResponse = response.execute()
        httpResponse.readText()
        val jsonBody = httpResponse.readText()
        return RecentPostEntity(5, emptyList())
    }
}

private fun String.asBearerToken() = "Bearer $this"