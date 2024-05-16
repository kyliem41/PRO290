const Consul = require('consul');
const { v4: uuidv4 } = require('uuid');

const consul = new Consul({
  host: 'consul',
  port: '8500',
});

const serviceName = 'message-service';
const servicePort = process.env.PORT || 6002;
const uuid = uuidv4();

const serviceConfig = {
  name: serviceName + '-' + uuid,
  address: 'messageservice',
  port: servicePort,
  check: {
    http: `http://messageservice:${servicePort}/api/messages/health`,
    interval: '10s',
    timeout: '5s',
  },
  tags: [
    'traefik.enable=true',
    'traefik.http.routers.messageservice.rule=PathPrefix(`/api/messages`)',
    'traefik.http.services.messageservice.loadbalancer.server.port=6002'
  ],
};

consul.agent.service.register(serviceConfig, (err) => {
  if (err) {
    console.error('Failed to register service with Consul:', err);
  } else {
    console.log(`Service registered with Consul: ${serviceName}`);
  }
});

process.on('SIGINT', () => {
  console.log('Deregistering service from Consul...');
  consul.agent.service.deregister(serviceName, (err) => {
    if (err) {
      console.error('Failed to deregister service from Consul:', err);
    } else {
      console.log(`Service deregistered from Consul: ${serviceName}`);
    }
    process.exit();
  });
});