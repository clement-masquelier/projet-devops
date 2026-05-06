<div id="top"></div>
<h1 align="center">TP Final devops</h1>
Ce readme est en 2 parties, la première partie est le readme de l'API initiale, qui a été créée avant le projet devops, et la deuxième partie est le readme du projet devops, qui explique les étapes de configuration de l'infrastructure et de déploiement de l'application.

<a href="#initial-readme">README de l'API initiale</a> | <a href="#devops-readme">README du projet devops</a>

<div id="initial-readme">

<h2 align="center">README de l'API initiale</h2>
<h3 align="center">Node.js Express REST API MySQL JS Example</h3>

<div align="center">
<p align="center">
    This REST API example is a basic backend application to test basic API functions with MySQL database.
</p>
<a href="https://www.postman.com/workspace/node-js-express-mysql-rest-api-example/overview">View Postman Files</a>
</div>

<!-- TABLE OF CONTENTS -->
<details>
<summary>Table of Contents</summary>
<ol>
    <li>
    <a href="#about-the-application">About The Application</a>
    <ul>
        <li><a href="#built-with">Built With</a></li>
    </ul>
    </li>
    <li><a href="#how-to-install">How To Install</a></li>
    <li><a href="#available-scripts">Available Scripts</a></li>
    <li><a href="#postman">Postman</a></li>
</ol>
</details>

<!-- ABOUT THE APPLICATION -->

## About The Application

This REST API example is a basic backend application to test basic API functions with MySQL database.

It is built with Node.js and Express Framework with Javascript. In addition, the applications database is MySQL, with the use of mysql2 library.

In the applicaiton we can manage user data, such as create/edit/delete a user. In addition, we can get all the users in the database.

The point of this backend application is to test CRUD operations with MySQL database.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

- [Node.js](https://nodejs.org/en/)
- [Express](https://expressjs.com/)
- [Cors](https://www.npmjs.com/package/cors)
- [MySQL2](https://www.npmjs.com/package/mysql2)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- INSTALLATION INSTRUCTIONS -->

## How To Install

**Git clone**

```
git clone https://github.com/almoggutin/Node-Express-REST-API-MySQL-JS-Example
```

**Instructions**

- After cloning the the repository run `npm i` in order to install all the dependencies.
- Create an env file in the root of the project named .env and fill in the follwing variables: PORT, DB_HOST, DB_PORT, DB_USERNAME, DB_USERNAME_PASSWORD, DB_NAME.
- In the sql directory, there are sql files that you will need to execute in order to initialize the database.

<p align="right">(<a href="#top">back to top</a>)</p>

<!--  AVAILABLE SCRIPTS -->

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the production mode.\
However, this script is only meant to be run when deploying the application. The application is built, where you need to setup the env variables on the machine that you will be hosting it on or on a web hosting service, unlike in development mode.

### `npm run dev`

Runs the app in the development mode.\
Open localhost on the port you decided on in the env variables to view it in the browser.

The API will reload if you make edits with the use of nodemon.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- POSTMAN -->

## Postman

If you would like to run the files locally on your machine in the postman desktop application, included in the repository, in the `postman` directory all the files so you can import them. In addition you will have to configure env variables in postman so that you will be able to test properly everything.

<div align="center">
<img src="./assets/postman/postman-global-env-variables.png" alt="Postman global env variables."/>
<img src="./assets/postman/postman-jobs-env-variables.png" alt="Postman admin env variables."/>
</div>

<div id="devops-readme">
<h2 align="center">README du projet devops</h2>
Ce projet a été réalisé sur une machine Windows 11, avec VirtualBox, Vagrant et WSL. Dans le cas où vous souhaitez exécuter ce projet sur une machine Linux, veuillez noter que certaines commandes pourront être exécutées directement dans le terminal (là où sur Windows, on bascule entre WSL et le terminal Windows).

Voici les étapes à suivre pour configurer l'infrastructure manuellement, sans utiliser la pipeline CI/CD :

1. **Préparation de l'environnement** :
    - Assurez-vous que VirtualBox, Vagrant et WSL sont installés sur votre machine.
    - Sur WSL, installez Ansible ainsi que les dépendances nécessaires pour exécuter les playbooks Ansible.
    - Toujours sur WSL, installez kubectl pour pouvoir interagir avec le cluster Kubernetes une fois qu'il sera déployé. L'utilisation de K9S est également recommandée pour une gestion plus facile du cluster.

2. **Génération de la clé SSH et du fichier cloud-config.yaml** :
    - Exécutez le script `generate_key_pair.sh` pour générer une paire de clés SSH et créer le fichier `cloud-config.yaml` avec la clé publique injectée.
    - Ce script va créer une clé SSH dans le dossier `.ssh_keys` et générer un fichier `cloud-config.yaml` qui sera utilisé pour configurer les machines virtuelles avec la clé SSH.
3. **Lancement de l'infrastructure avec Vagrant** :
    - Exécutez la commande `vagrant up` pour lancer les machines virtuelles définies dans le Vagrantfile. Vagrant utilisera le fichier `cloud-config.yaml` pour configurer les machines avec la clé SSH.
    - Cette étape va créer les machines virtuelles nécéssaires pour k3s et Grafana/Prometheus, et les configurer pour qu'elles soient accessibles via SSH avec la clé générée.
4. **Configuration de l'inventaire Ansible** :
    - Modifiez le fichier `ansible/inventory.ini` pour vous assurer que les adresses IP, les utilisateurs et les chemins des clés SSH sont corrects pour vos machines virtuelles.
    - Assurez-vous que les machines virtuelles sont accessibles via SSH en utilisant la clé générée.
5. **Déploiement de k3s avec Ansible** :
    - Exécutez le playbook Ansible `deploy_k3s.yaml` pour déployer k3s sur les machines virtuelles. Ce playbook va installer k3s et configurer le cluster Kubernetes.
    - Une fois le playbook exécuté, vous devriez avoir un cluster k3s opérationnel avec les machines virtuelles configurées.
6. **Déploiement de Grafana et Prometheus** :
    - Exécutez le playbook Ansible `deploy_grafana_prometheus.yaml` pour déployer Grafana et Prometheus sur une machine virtuelle dédiée. Ce playbook va installer Grafana et Prometheus, et les configurer pour qu'ils puissent collecter des métriques du cluster k3s.
    - Après l'exécution de ce playbook, vous devriez avoir Grafana et Prometheus opérationnels et configurés pour surveiller votre cluster k3s.

</div>

<p align="right">(<a href="#top">back to top</a>)</p>

</div>
