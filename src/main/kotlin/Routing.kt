package com.example

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.plugins.contentnegotiation.*

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("Привіт! Мій Android бекенд працює!2221!")
        }
        get("/status") {
            call.respond(mapOf("status" to "OK", "version" to "1.0"))
        }
    }
}
