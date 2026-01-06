package com.example

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("Привіт! Мій Android бекенд працює!1!!!")
        }
        get("/status") {
            call.respond(mapOf("status" to "OK", "version" to "1.0"))
        }
    }
}
