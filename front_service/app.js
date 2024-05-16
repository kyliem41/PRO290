const express = require('express')
const path = require('path')
const cookieParser = require('cookie-parser')
const logger = require('morgan')
const Consul = require('consul')
const app = express()

const PORT = 8002
const HOST = process.env.HOST || '127.0.0.1'

app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

const page_controller = require('./routes/index.js')
app.use('/', page_controller)

const consul = new Consul({
    host: 'consul',
    port: 8500,
    })

    const registerService = () => {
    // const serviceId = Utils.generate_guid();
    // const serviceName = 'frontservice-' + serviceId;
    const serviceId = '1'
    const serviceName = 'frontservice-1'

    const serviceDefinition = {
        id: serviceId,
        name: serviceName,
        address: 'frontservice',
        port: PORT,
        check: {
        http: `http://frontservice:${PORT}/health`,
        interval: '10s',
        },
        tags: [
            'traefik.enable=true',
            `traefik.http.services.frontservice.loadbalancer.server.port=${PORT}`,
            'traefik.http.routers.frontservice.rule=PathPrefix(`/`)'  
        ],
    };

    consul.agent.service.register(serviceDefinition, (err) => {
        if (err) {
        console.error('Failed to register service with Consul:', err)
        } 
        else {
            console.log(`Service registered with Consul`)
        }
    })
}

app.listen(PORT, HOST, () => {
    console.log(`Server listening on ${HOST} ${PORT}`)
    registerService()
});

module.exports = app