#!jinja|yaml

{% from "dnsmasq/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('dnsmasq:lookup')) %}

dnsmasq:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}
  service:
    - {{ datamap.ensure|default('running') }}
    - name: {{ datamap.service.name|default('dnsmasq') }}
    - enable: {{ datamap.service.enable|default(True) }}
    - watch:
      - file: dnsmasq
  file:
    - managed
    - name: {{ datamap.config.dnsmasq.path|default('/etc/dnsmasq.conf') }}
    - mode: 644
    - user: root
    - group: root
    - contents_pillar: dnsmasq:lookup:config:dnsmasq:content
