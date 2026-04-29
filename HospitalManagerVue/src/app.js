import { setGlobalDispatcher } from 'undici';
import { Agent } from 'https';

const httpsAgent = new Agent({
  rejectUnauthorized: false,
  keepAlive: true,
  maxSockets: 100,
  maxFreeSockets: 10,
  scheduling: 'lifo'
});

setGlobalDispatcher(new URL('http://localhost:8080'), {
  agent: httpsAgent
});