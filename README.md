# k8sdeploy项目介绍

k8sdeploy项目下有五个子目录：initialize、binary、kubeadm、haproxy和keepalived，顾名思义，每个目录都有特定功能：

* initialize：用来执行Kubernetes集群环境的初始化，包含两个Ansible Playbook文件（installPackages.yaml和initEnv.yaml）和一个config目录。

  * installPackages.yaml：用来安装依赖包，实现了**集群环境初始化**的第2和6步，需要先执行此文件；

  * initEnv.yaml：实现了**集群环境初始化**中的第3、4、5、7步；

  * config：目录里是Ansible Playbook依赖的配置文件，有docker的daemon.json文件和系统参数文件;

  * 使用方法：

    ```bash
    cd k8sdeploy/initialize
    # 安装的依赖包比较多，这个过程会比较慢
    ansible-playbook installPackages.yaml
    ansible-playbook initEnv.yaml
    ```

* binary目录下是二进制包安装Kubernetes集群所需的Ansible Playbook脚本及依赖的文件，其中也包含安装etcd集群；

* kubeadm：Kubeadm工具安装高可用Kubernetes集群所需的文件：

  * installKubeadm.yaml：用来安装kubeadm、kubelet和kubectl

  * config：Kubernetes相关的yum源文件

  * kubernetes：该目录存放了安装Kubernetes集群及组件相关的配置文件

  * 使用方法：

    ```bash
    cd k8sdeploy/kubeadm
    ansible-playbook installKubeadm.yaml
    ```

* haproxy：HaProxy的配置文件，可直接拷贝使用

  * 使用方法：

    ```bash
    cp k8sdeploy/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
    ```

* keepalived：包含两个keepalived配置文件，一主一备需按角色拷贝，还包含一个检测脚本，在HaProxy异常时进行Keepalived的主从切换

  * 使用方法：

    ```bash
    # keepalived master node
    cp k8sdeploy/keepalived/master-keepalived.conf /etc/keepalived/keepalived.conf
    cp k8sdeploy/keepalived/checkHaproxy.sh /etc/keepalived/checkHaproxy.sh
    # keepalived backup node
    cp k8sdeploy/keepalived/backup-keepalived.conf /etc/keepalived/keepalived.conf
    cp k8sdeploy/keepalived/checkHaproxy.sh /etc/keepalived/checkHaproxy.sh
    ```

