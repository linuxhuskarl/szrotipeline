def VERSION_MAJOR = '1'
def VERSION_MINOR = '0'
def VERSION_PATCH = '0'
def VERSION_BUILD = "${BUILD_NUMBER}"
def TAG_MAJOR = "${VERSION_MAJOR}"
def TAG_MINOR = "${TAG_MAJOR}.${VERSION_MINOR}"
def TAG_PATCH = "${TAG_MINOR}.${VERSION_PATCH}"
def TAG_BUILD = "${TAG_PATCH}-b${VERSION_BUILD}"

node {
    stage('Checkout') {
        checkout scm
    }
    docker.withServer('tcp://127.0.0.1:2375') {
        def image = null
        stage('Build') {
            image = docker.build('alpine-cmake', "--build-arg http_proxy=$HTTP_PROXY --build-arg https_proxy=$HTTPS_PROXY .")
        }
        stage('Test') { 
            def container = image.run('-t -v $WORKSPACE:/app', 'ls /app')
            sh "docker logs $container.id"
            container.stop()
        }
        stage('Publish') {
            docker.withRegistry('http://172.31.5.2:5000') {
                image.push(TAG_BUILD)
                image.push(TAG_PATCH)
                image.push(TAG_MINOR)
                image.push(TAG_MAJOR)
                image.push('latest')
            }
        }
    }
}
