package com.example

import io.ktor.server.application.*
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import io.ktor.server.response.respond
import io.ktor.server.response.respondText
import io.ktor.server.routing.get
import io.ktor.server.routing.routing
import jdk.internal.vm.ScopedValueContainer.call

fun main(args: Array<String>) {
//    io.ktor.server.netty.EngineMain.main(args)

    embeddedServer(Netty, port = 8080, host = "0.0.0.0") { // 0.0.0.0 важливо для деплою
        routing {
            get("/") {
                call.respondText("Привіт! Мій Android бекенд працює!")
            }
            get("/status") {
                call.respond(mapOf("status" to "OK", "version" to "1.0"))
            }
        }
    }.start(wait = true)
}

fun Application.module() {
    configureRouting()
}
