# IRC Redirect via SSH

### Configure your machine to redirect your IRC connection

##### Setup SSH Tunnel
You can configure a redirect via a local port.

```
ssh -L localhost:6667:<irc-host>:6667 <user>@<ssh-host> -N -v
```

So for example, you could connect thru you preferred shell server to Freenode.

```
ssh -L localhost:6667:irc.freenode.net:6667 badgumby@myserver.net -N -v
```

##### Setup IRC Client

Now in your IRC client, configure a new network server:

```
Server: localhost
Port: 6667
```
