# Architecture Ref. Card 03

## Über dieses Projekt

Dieses Projekt ist ein Spring-boot projekt mit einer angehängten MariaDB Datenbank. Im Frontend sieht man Witze, die von der Datenbank abgefragt werden.

## Lokale Inbetriebnahme

Um das Projekt lokal laufen zu lassen, braucht man [Docker](https://www.docker.com/products/docker-desktop/).

1. Projekt clonen
2. `.env.example` kopieren und zu `.env` umbenennen
3. Terminal im Porjektordner öffnen
4. Befehl eingeben: `docker compose -f docker-compose.yml up -d`
5. [http://localhost:8080/](http://localhost:8080/) öffnen

## Inbetriebnahme mit CI/CD Pipeline

Um die Pipeline ausführen zu können, braucht man einen Runner. Wie man einen Runner selbst hosted, findet man [hier](https://docs.gitlab.com/runner/).

### Umgebungsvariablen

Dieses Projekt hat zusätzlich eine Pipeline, welche diverse Umgebungsvariablen benötigt. Diese sind hier aufgelistet.

| Variable                   | Beschreibung                                                                                                                                                                       | Beispiel                                                                                                                                                                                                                                                                                                                                                                                                 |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AWS_ACCESS_KEY_ID          | Access Key Id der AWS Learner Lab Konsole.                                                                                                                                         | ASIAQTI7H2756XUIPE56                                                                                                                                                                                                                                                                                                                                                                                     |
| AWS_DEFAULT_REGION         | Learner Lab Konsole Region.                                                                                                                                                        | us-east-1                                                                                                                                                                                                                                                                                                                                                                                                |
| AWS_SECRET_ACCESS_KEY      | Secret Access Key von der AWS Learner Lab Konsole.                                                                                                                                 | +0RaejpFCuRCeN3Ek8+nx+Ul0rmdwYtdjC/G5yT1                                                                                                                                                                                                                                                                                                                                                                 |
| AWS_SESSION_TOKEN          | Der AWS Session token der Learner Lab Konsole.                                                                                                                                     | FwoGZXIvYXdzEJP//////////wEaDLaLGBNaL/HA/940mSLMAaA+99g7Kb0XBjQ1fPrCgWrMlOwXJMNTz3elOVT4stWuhJBwk/GgUnObNeNiZGDKIxOfRjbm3llupFzhwbTMvuq8Y0L6fntOGCz4IRncntQSWuDmo0tHc4+eKwArb3aG3yGS4uHJD#gs4gysgdfgX9jQB7EXrmXppNMT/sLzXF1JQoz8rQeRHYUOzfxXUQTFDsBWPoEixSdg7Jzk3eRQhv3gABPTCm4+76OZ1mxXXjtAXBuJTLfqVv9A1UsVMLevkr4mtYY9Uyt0dVn/ISiOweGjBjIt3Ei2gNWKuvo6XW2o8M5QNJaWfbo6D8P6Qy2a60sDJQwGvrBOd/vhmKb6H6f9 |
| CI_AWS_ECR_REPOSITORY_NAME | Der Name des Repositories, um das Image korrekt zu bauen. Diese Variabel wird benötigt, das GitLab keine Möglichkeit bereitstellt, dies mit den vorgegebenen Variabeln abzufragen. | refcard_03                                                                                                                                                                                                                                                                                                                                                                                               |
| CI_AWS_ECR_REGISTRY        | Das Registry, um das Image zu pushen.                                                                                                                                              | 111111111111.dkr.ecr.us-east-1.amazonaws.com                                                                                                                                                                                                                                                                                                                                                             |
| CD_AWS_ECS_SERVICE         | Der AWS Service Name, um das Deployment zu automatisieren.                                                                                                                         | refcard03_service                                                                                                                                                                                                                                                                                                                                                                                        |
| CD_AWS_ECS_CLUSTER         | Der AWS Cluster Name um das Deployment zu automatisieren.                                                                                                                          | refcard03_cluster                                                                                                                                                                                                                                                                                                                                                                                        |


### Benötigte AWS Services

Wichtig ist, dass man auf AWS die folgenden Dinge aufgesetzt hat:

- ECR (Registry)
- ECS (Cluster + Service)
- RDS (MariaDB)

### Konfiguraiton AWS

In der Task definition muss man noch die folgenden Environment Variables definieren.

| Variable    | Default (Falls nicht gesetzt)       |
| ----------- | ----------------------------------- |
| DB_URL      | jdbc:mariadb://database:3306/jokedb |
| DB_USERNAME | jokedbuser                          |
| DB_PASSWORD | 123456                              |
