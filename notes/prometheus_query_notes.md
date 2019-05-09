# Prometheus Query Notes & Examples

When running prometheus in a kubernetes cluster to which you have access, you can
access that service using kubectl's ability to form a specific service proxy with the
`kubectl port-forward` command.

For example, when prometheus is installed with Helm, the info template has an example
of how to set this up:

`helm status monitor`:

    export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
    kubectl --namespace monitoring port-forward $POD_NAME 9090

Some example metrics that are interesting to view in the short term:

- `node_memory_MemTotal_bytes`
- `node_memory_MemAvailable_bytes`

## Example queries

get a time-series query for `node_memory_MemAvailable_bytes`


    curl -s http://127.0.0.1:9090/api/v1/query\?query\=node_memory_MemAvailable_bytes | jq

shows the last 10 min of data for node_memory_MemAvailable_bytes aggregated to 1m reads

    curl --data-urlencode "query=node_memory_MemAvailable_bytes[10m:1m]" http://127.0.0.1:9090/api/v1/query | jq

the result type is “Matrix”, rather than a single value (vector - which matches an instant vector). 

There 4 different result types from the Prometheus REST API <https://prometheus.io/docs/prometheus/latest/querying/api/#expression-query-result-formats>:

- matrix (range vector)
- vector (instant vector)
- scalar (scalar instant)
- string

example output:

    {
        "status": "success",
        "data": {
            "resultType": "matrix",
            "result": [
                {
                    "metric": {
                        "__name__": "node_memory_MemAvailable_bytes",
                        "app": "prometheus",
                        "chart": "prometheus-8.10.2",
                        "component": "node-exporter",
                        "heritage": "Tiller",
                        "instance": "192.168.64.38:9100",
                        "job": "kubernetes-service-endpoints",
                        "kubernetes_name": "monitor-prometheus-node-exporter",
                        "kubernetes_namespace": "monitoring",
                        "kubernetes_node": "minikube",
                        "release": "monitor"
                    },
                    "values": [
                        [
                            1556290260,
                            "637726720"
                        ], [
                            1556290320,
                            "646340608"
                        ], [
                            1556290380,
                            "644829184"
                        ], [
                            1556290440,
                            "644800512"
                        ], [
                            1556290500,
                            "645054464"
                        ], [
                            1556290560,
                            "645328896"
                        ], [
                            1556290620,
                            "645283840"
                        ], [
                            1556290680,
                            "644911104"
                        ], [
                            1556290740,
                            "645591040"
                        ], [
                            1556290800,
                            "643661824"
                        ]
                    ]
                }
            ]
        }
    }

A more complex example metric is “container_cpu_usage_seconds_total”

- many pods reporting this data, so there are a lot of  series for this measurement
- you constrain the query using the labels, for example to limit to the namespace “monitoring”:

        container_cpu_usage_seconds_total{namespace="monitoring"}

Then you can look at something like the “rate” of this to see how it’s flowing, since the measurement itself is a counter:

    rate(container_cpu_usage_seconds_total{namespace="monitoring"}[5m])

This can go into a CURL query as:

    curl --data-urlencode 'query=rate(container_cpu_usage_seconds_total{namespace="monitoring"}[5m])' http://127.0.0.1:9090/api/v1/query | jq

And the result:

    {
        "status": "success",
        "data": {
            "resultType": "vector",
            "result": [
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "POD",
                        "container_name": "POD",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc024899e-65e2-11e9-9137-ce327a1502b5/9341383b974e26912e02a55a91cb07cbb3d1ef1429afec86ab79c2ebb037bcd3",
                        "image": "k8s.gcr.io/pause:3.1",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_POD_monitor-prometheus-node-exporter-7t4mp_monitoring_c024899e-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-node-exporter-7t4mp",
                        "pod_name": "monitor-prometheus-node-exporter-7t4mp"
                    },
                    "value": [
                        1556291228.868,
                        "0"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "POD",
                        "container_name": "POD",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc025f18a-65e2-11e9-9137-ce327a1502b5/75d9b784859a8515de6a7d2069dea50f310fb95deebfd61f774f2065e6f0b61d",
                        "image": "k8s.gcr.io/pause:3.1",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_POD_monitor-prometheus-alertmanager-684b68ddc6-bxgqq_monitoring_c025f18a-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq",
                        "pod_name": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq"
                    },
                    "value": [
                        1556291228.868,
                        "0"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "POD",
                        "container_name": "POD",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc0289e33-65e2-11e9-9137-ce327a1502b5/41db998cd2c64039763c50ff637d0f6010b614f023d77e2a4ac9a3b6352004cb",
                        "image": "k8s.gcr.io/pause:3.1",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_POD_monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c_monitoring_c0289e33-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c",
                        "pod_name": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c"
                    },
                    "value": [
                        1556291228.868,
                        "0"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "POD",
                        "container_name": "POD",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc02e3ad9-65e2-11e9-9137-ce327a1502b5/928b451e1d3644bc3ae6f7976a779e80540e4ebc5c5b9bd4276cf72fbbc83129",
                        "image": "k8s.gcr.io/pause:3.1",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_POD_monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt_monitoring_c02e3ad9-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt",
                        "pod_name": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt"
                    },
                    "value": [
                        1556291228.868,
                        "0"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "POD",
                        "container_name": "POD",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc03faad9-65e2-11e9-9137-ce327a1502b5/b6eed28cd290f7cf3840b71d418c20d83129881814b9ca8b299931cde7cb5245",
                        "image": "k8s.gcr.io/pause:3.1",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_POD_monitor-prometheus-server-5fc4c56c4f-mj67m_monitoring_c03faad9-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-server-5fc4c56c4f-mj67m",
                        "pod_name": "monitor-prometheus-server-5fc4c56c4f-mj67m"
                    },
                    "value": [
                        1556291228.868,
                        "0"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-alertmanager",
                        "container_name": "prometheus-alertmanager",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc025f18a-65e2-11e9-9137-ce327a1502b5/d60bc5db5eca7b5d33dff39270fccf4a3314352b9d4a7cec4914b0aa0a3dc048",
                        "image": "sha256:ed72e25b3d2033bf74f2b110a4ddc283ec3f404e2db611caf0d608ef8c3314f4",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-alertmanager_monitor-prometheus-alertmanager-684b68ddc6-bxgqq_monitoring_c025f18a-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq",
                        "pod_name": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq"
                    },
                    "value": [
                        1556291228.868,
                        "0.0016293745401905252"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-alertmanager-configmap-reload",
                        "container_name": "prometheus-alertmanager-configmap-reload",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc025f18a-65e2-11e9-9137-ce327a1502b5/b591f8148e9cc0c2327d2a4da07f9e51dd9dfdaa0022bc5d7162e4657f811c53",
                        "image": "sha256:7a344aad0fdbe8fd3ebd3ace7268d59946408503db1fe7c171bdb016a51729b7",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-alertmanager-configmap-reload_monitor-prometheus-alertmanager-684b68ddc6-bxgqq_monitoring_c025f18a-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq",
                        "pod_name": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq"
                    },
                    "value": [
                        1556291228.868,
                        "0.0000014143340870359445"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-kube-state-metrics",
                        "container_name": "prometheus-kube-state-metrics",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc0289e33-65e2-11e9-9137-ce327a1502b5/82fc9a91aece4a177f4297a15225a9d81912aa7d5b9ac14cb4afcecf545ef074",
                        "image": "sha256:91599517197a204c99cd2c7e2175c25e18d82f9b53fc9d86f7d9976a3a6c6521",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-kube-state-metrics_monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c_monitoring_c0289e33-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c",
                        "pod_name": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004697109886029308"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-node-exporter",
                        "container_name": "prometheus-node-exporter",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc024899e-65e2-11e9-9137-ce327a1502b5/9d8600b4ef56a1b9c47418e2aae0a3251c39c7c643707d34f6684fa18bf79123",
                        "image": "sha256:b3e7f67a1480979f7c2068c14e4f0d3da6243631b9def8490ed68236a8311f11",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-node-exporter_monitor-prometheus-node-exporter-7t4mp_monitoring_c024899e-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-node-exporter-7t4mp",
                        "pod_name": "monitor-prometheus-node-exporter-7t4mp"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004848702887563311"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-pushgateway",
                        "container_name": "prometheus-pushgateway",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc02e3ad9-65e2-11e9-9137-ce327a1502b5/c17c56fd6fb3bf16e88180d58808e63611e1b379819f9ae39b519627e4872ddf",
                        "image": "sha256:3a612a2371e5259ca5fbff3708ffcc20edfcbcc27f62bba27ad166803f579998",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-pushgateway_monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt_monitoring_c02e3ad9-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt",
                        "pod_name": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004337329261901887"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-server",
                        "container_name": "prometheus-server",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc03faad9-65e2-11e9-9137-ce327a1502b5/af837a5fdc3250bf6b3775420b76a2860e14a8fd242b835935cbf89939917588",
                        "image": "sha256:4737a2d79d1a7da6aad23007a7c09b4f2e6db9bed86e4ec97c5bc40ecbf92272",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-server_monitor-prometheus-server-5fc4c56c4f-mj67m_monitoring_c03faad9-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-server-5fc4c56c4f-mj67m",
                        "pod_name": "monitor-prometheus-server-5fc4c56c4f-mj67m"
                    },
                    "value": [
                        1556291228.868,
                        "0.010887579997749197"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "container": "prometheus-server-configmap-reload",
                        "container_name": "prometheus-server-configmap-reload",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc03faad9-65e2-11e9-9137-ce327a1502b5/bc94ffeee13346e0286566e6c115bfe00bc55a5f185b35bbd220eb37f30bddb5",
                        "image": "sha256:7a344aad0fdbe8fd3ebd3ace7268d59946408503db1fe7c171bdb016a51729b7",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "name": "k8s_prometheus-server-configmap-reload_monitor-prometheus-server-5fc4c56c4f-mj67m_monitoring_c03faad9-65e2-11e9-9137-ce327a1502b5_1",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-server-5fc4c56c4f-mj67m",
                        "pod_name": "monitor-prometheus-server-5fc4c56c4f-mj67m"
                    },
                    "value": [
                        1556291228.868,
                        "0.00000272882217287325"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc024899e-65e2-11e9-9137-ce327a1502b5",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-node-exporter-7t4mp",
                        "pod_name": "monitor-prometheus-node-exporter-7t4mp"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004565042140394769"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc025f18a-65e2-11e9-9137-ce327a1502b5",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq",
                        "pod_name": "monitor-prometheus-alertmanager-684b68ddc6-bxgqq"
                    },
                    "value": [
                        1556291228.868,
                        "0.0016307282664593187"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc0289e33-65e2-11e9-9137-ce327a1502b5",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c",
                        "pod_name": "monitor-prometheus-kube-state-metrics-5d9c7fcd84-jdk5c"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004666214612755529"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc02e3ad9-65e2-11e9-9137-ce327a1502b5",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt",
                        "pod_name": "monitor-prometheus-pushgateway-5f46cbb5cf-bdrdt"
                    },
                    "value": [
                        1556291228.868,
                        "0.0004301016814934629"
                    ]
                },
                {
                    "metric": {
                        "beta_kubernetes_io_arch": "amd64",
                        "beta_kubernetes_io_os": "linux",
                        "cpu": "total",
                        "id": "/kubepods/besteffort/podc03faad9-65e2-11e9-9137-ce327a1502b5",
                        "instance": "minikube",
                        "job": "kubernetes-nodes-cadvisor",
                        "kubernetes_io_arch": "amd64",
                        "kubernetes_io_hostname": "minikube",
                        "kubernetes_io_os": "linux",
                        "namespace": "monitoring",
                        "pod": "monitor-prometheus-server-5fc4c56c4f-mj67m",
                        "pod_name": "monitor-prometheus-server-5fc4c56c4f-mj67m"
                    },
                    "value": [
                        1556291228.868,
                        "0.010906471232592843"
                    ]
                }
            ]
        }
    }


Note: this next query presumes “pod_name” is a label available on the container_cpu_usage_seconds_total time-series. That will depend
entirely on how prometheus is configured and what metrics it's actually scraping.

    sum by(pod_name) (
        rate(container_cpu_usage_seconds_total{namespace=“redash”}[5m])
        )

get the labels for the pods from kube_state_metrics

    kube_pod_labels{label_app=~”redash-.*”}

### API Endpoints for Prometheus

instant queries

    /api/v1/query

range queries (result in range-vector result format)

    /api/v1/query_range

get time series

    /api/v1/series

curl examples

    curl -g 'http://localhost:9090/api/v1/series?' \
        --data-urlencode='match[]=up' \
        --data-urlencode='match[]=process_start_time_seconds{job="prometheus"}'

    curl -s http://127.0.0.1:9090/api/v1/query\?query\=container_cpu_usage_seconds_total | jq



theoretically gets a list of all time series that are available

    curl -g 'http://localhost:9090/api/v1/series?' --data-urlencode='match[]={__name__=~".+"}'

show the labels

    curl -s http://127.0.0.1:9090/api/v1/labels | jq


values for the “pod” label

    curl -s http://127.0.0.1:9090/api/v1/label/pod/values | jq


values for the “node” label

    curl -s http://127.0.0.1:9090/api/v1/label/node/values | jq


show the targets

    curl -s http://127.0.0.1:9090/api/v1/targets | jq

Some other default prometheus instance (with Helm) metrics:

- `admission_quota_controller_*`
- `apiserver_admission_controller_*`
- `node_memory_MemAvailable_bytes`

### Alerts

Show Overall CPU usage for a server

    record: instance:node_cpu_utilization_percent:rate5m
    expr: 100 * (1 - avg by(instance)(irate(node_cpu{mode='idle'}[5m])))


Track http error rates as a proportion of total traffic

    record: job_instance_method_path:demo_api_request_errors_50x_requests:rate5m
    expr: >
    rate(demo_api_request_duration_seconds_count{status="500",job="demo"}[5m]) * 50
    > on(job, instance, method, path)
    rate(demo_api_request_duration_seconds_count{status="200",job="demo"}[5m])


90th Percentile latency

    record: instance:demo_api_90th_over_50ms_and_requests_over_1:rate5m
    expr: >
    histogram_quantile(0.9, rate(demo_api_request_duration_seconds_bucket{job="demo"}[5m])) > 0.05
    and
    rate(demo_api_request_duration_seconds_count{job="demo"}[5m]) > 1


HTTP request rate, per second.. an hour ago

    record: instance:api_http_requests_total:offset_1h_rate5m
    expr: rate(api_http_requests_total{status=500}[5m] offset 1h)


Kubernetes Container Memory Usage

    record: kubernetes_pod_name:container_memory_usage_bytes:sum
    expr: sum by(kubernetes_pod_name) (container_memory_usage_bytes{kubernetes_namespace="kube-system"})

predictive disk fill

    alert: PreditciveHostDiskSpace
    expr: predict_linear(node_filesystem_free{mountpoint="/"}[4h], 4 * 3600) < 0
    for: 30m
    labels:
    severity: warning
    annotations:
    description: 'Based on recent sampling, the disk is likely to will fill on volume
    {{ $labels.mountpoint }} within the next 4 hours for instace: {{ $labels.instance_id
    }} tagged as: {{ $labels.instance_name_tag }}'
    summary: Predictive Disk Space Utilisation Alert

alert on high memory load

    expr: (sum(node_memory_MemTotal) - sum(node_memory_MemFree + node_memory_Buffers + node_memory_Cached) ) / sum(node_memory_MemTotal) * 100 > 85

alert on high CPU utilization

    alert: HostCPUUtilisation
    expr: 100 - (avg by(instance) (irate(node_cpu{mode="idle"}[5m])) * 100) > 70
    for: 20m
    labels:
    severity: warning
    annotations:
    description: 'High CPU utilisation detected for instance {{ $labels.instance_id
    }} tagged as: {{ $labels.instance_name_tag }}, the utilisation is currently:
    {{ $value }}%'
    summary: CPU Utilisation Alert


## various blog posts and urls with more details on making prometheus queries

- https://medium.com/@amimahloof/kubernetes-promql-prometheus-cpu-aggregation-walkthrough-2c6fd2f941eb
- https://github.com/infinityworks/prometheus-example-queries/blob/master/README.md
- https://www.digitalocean.com/community/tutorials/how-to-query-prometheus-on-ubuntu-14-04-part-2
- https://www.digitalocean.com/community/tutorials/how-to-query-prometheus-on-ubuntu-14-04-part-1
- https://timber.io/blog/promql-for-humans/
- http://keleir.me/2018/01/27/prometheus-in-practice/
- https://www.section.io/blog/prometheus-querying/

### Prometheus Docs

  - https://prometheus.io/docs/prometheus/latest/querying/basics/
  - https://prometheus.io/docs/prometheus/latest/querying/examples/
  - https://prometheus.io/docs/prometheus/latest/querying/functions/
  - https://prometheus.io/docs/prometheus/latest/querying/operators/
