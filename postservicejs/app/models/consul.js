const Consul = require('consul');
const { v4: uuidv4 } = require('uuid');

const consul = new Consul({
  host: 'consul',
  port: '8500',
});

const serviceName = 'post-service';
const servicePort = process.env.PORT || 8080;
const uuid = uuidv4();

const serviceConfig = {
  name: serviceName + '-' + uuid,
  address: 'postservice',
  port: servicePort,
  check: {
    http: `http://postservice:${servicePort}/api/posts/health`,
    interval: '10s',
    timeout: '5s',
  },
  tags: [
    'traefik.enable=true',
    'traefik.http.routers.postservice.rule=PathPrefix(`/api/posts`)',
    'traefik.http.services.postservice.loadbalancer.server.port=8080'
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