# cimat

Controle Interno de Materiais Bélicos

# Diário

cd /home/catalunha/myapp/cimat && flutter build web && cd back4app/cimat && b4a deploy

ln -s /home/catalunha/myapp/cimat/build/web public


catalunha@pop-os:~/myapp/cimat/back4app$ b4a new

flutter create --project-name=cimat --org to.bope.cimat --platforms android,web ./cimat

# Security
https://www.back4app.com/docs/security/parse-security
https://blog.back4app.com/parse-server-security/
https://www.youtube.com/watch?v=99aaMpJXHyg
https://www.youtube.com/watch?v=TP6zwCE1GCY
https://www.back4app.com/docs/get-started/cloud-functions
# Dockerfile

# BaaS x CaaS
Motivos deste ticket:
1) Caso um de meus projetos de aprendizado cresçam e dependam de recursos mais avançados estive pensando sobre como melhor usar a b4a.
2) E caso algumas das inumeras pessoas com as quais eu satisfatoriamente apresento a b4a me perguntem sobre isto eu gostaria de satr como melhor indicar a b4a.
Então vamos lá.
Comparando (https://www.back4app.com/pricing/backend-as-a-service x https://www.back4app.com/pricing/container-as-a-service) e pensando em um projetos Flutter pra Web e Android.
O BaaS me fornece hoje um Database, CloudCode e WebHosting.
O CaaS me fornece hoje um hosting atraves do container conforme video https://youtu.be/H5_-1BoMrUs?list=PL_lJrbgUtzddPWx-gqxh2H6Bex3NkzGA8. Acho que apenas isto. Senão podem me atualizar.
Então vamos lá.
Seu eu preciso do Database+CloudCode com (-Hosting) pagaria um plano MVP anual da BaaS por US $15
Se for utilizar o plano de Shared-A mensal da CaaS por US$ 5 usaria apenas para hosting. 
Mas ja tenho o hosting na BaaS. Então não compensa.
Agora se eu considerar escalabilidade do container ai é outra questão. 
Então gostaria de entender melhor estas relações entre BaaS e CaaS. 



Funciona conforme video: https://youtu.be/H5_-1BoMrUs?list=PL_lJrbgUtzddPWx-gqxh2H6Bex3NkzGA8




