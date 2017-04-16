# docker-Engine-Swarm-Shell-Script

## ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) NOTE: Machine must have certificates in /root/certs/

# Docker Engine
```
sh dockerEngine.sh
```

# Docker Swarm
## On Node
```
sh node.sh
```

## On Master
### Swarm Deployment
```
sh master.sh
```

From above you will get a token at last most line like
```
......
.....
.....
Token is [some-token]
````

### Swarm Join
```
sh masterAddNode.sh [node-ip] [some-token]
```



# ALL DONE :)
