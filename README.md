# k8sdeploy项目介绍
k8sdeploy项目下有五个子目录：initialize、binary、kubeadm、haproxy和keepalived，顾名思义，每个目录都有特定功能：
* initialize：用来执行Kubernetes集群环境的初始化，包含两个Ansible Playbook文件（installPackages.yaml和initEnv.yaml）和一个config目录。
