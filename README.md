# docker-Engine-Swarm-Shell-Script

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
