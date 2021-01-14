# Blackbox exporter fork with proxy support

Same as upstream but with support for probing http via proxy (upstream lost this
ability around v0.10 for some unclear reasons). Configure module like this:

``` yaml
modules:
  http_2xx_proxy:
    prober:  http
    timeout: 10s
    http:
      preferred_ip_protocol: "ip4"
      proxy_url: http://proxy.company.com:3128
```

Also DNS resolvability is not reqiured for proxied hosts (proxy does it anyway).