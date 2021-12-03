// this file has the param overrides for the stage environment
local production = import './staging.libsonnet';

production {
  components +: {
    backend +: {
      replicas: 3,
    },
    frontend +: {
      replicas: 3,
    },
    db +: {
      replicas: 3,
    },
    endpoint: {
      address: "34.125.188.18"
    }
  }
}