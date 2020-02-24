# k8sdeploy项目介绍

k8sdeploy项目下有七个子目录：addons、app、binary、haproxy、initialize、keepalived、kubeadm，顾名思义，每个目录都有其相关功能：

* addons：Kubernetes集群的相关插件，在集群安装完成后，为了更好的管理集群。

  * calico：网络插件， 集群安装完成后，需要执行此目录中的文件；

* coredns：DNS服务，使用二进制包安装完成集群后，需要执行此目录中的文件；

  * dashboard：集群部署完成后，执行此目录中的文件安装UI控制台；

* ingress-nginx：将集群内的服务发布到集群外。

* app：介绍部署应用程序时，使用到的程序。

* binary：二进制包安装Kubernetes集群所需的Ansible Playbook脚本及依赖的文件，相关目录有：

  * pki：生成证书需要的文件;
  * deployEtcd：安装ETCD集群的脚本及相关文件，二进制环境需要自己部署ETCD；
  * deployApiServer：安装Kube-apiserver组件的脚本及相关文件；
  * deployControllerManager：安装Kube-controller-manager组件的脚本及相关文件；
  * deployScheduler：安装Kube-scheduler组件的脚本及相关文件；
  * deployKubelet：安装Kubelet组件的脚本及相关文件；
  * deployKubeProxy：安装Kubeproxy组件的脚本及相关文件；

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

* kubeadm：Kubeadm工具安装高可用Kubernetes集群所需的文件：

  * installKubeadm.yaml：用来安装kubeadm、kubelet和kubectl

  * config：Kubernetes相关的yum源文件

  * kubernetes：kubeadm安装Kubernetes集群的配置文件

  * 使用方法：

    ```bash
    cd k8sdeploy/kubeadm
    ansible-playbook installKubeadm.yaml
    ```

* haproxy：HaProxy的配置文件，可直接拷贝：

  * 使用方法：

    ```bash
    cp k8sdeploy/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
    ```

* keepalived：包含两个keepalived配置文件，一主一备需按角色拷贝，还包含一个检测脚本，检测到HaProxy异常时实现Keepalived的主从切换

  * 使用方法：

    ```bash
    # keepalived master node
    cp k8sdeploy/keepalived/master-keepalived.conf /etc/keepalived/keepalived.conf
    cp k8sdeploy/keepalived/checkHaproxy.sh /etc/keepalived/checkHaproxy.sh
    # keepalived backup node
    cp k8sdeploy/keepalived/backup-keepalived.conf /etc/keepalived/keepalived.conf
    cp k8sdeploy/keepalived/checkHaproxy.sh /etc/keepalived/checkHaproxy.sh
    ```

### 
