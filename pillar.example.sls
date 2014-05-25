dnsmasq:
  lookup:
    config:
      dnsmasq:
        content: |
          no-poll
          server=8.8.8.8
          interface=lo
          except-interface=eth0
          listen-address=127.0.0.1
          bind-interfaces
