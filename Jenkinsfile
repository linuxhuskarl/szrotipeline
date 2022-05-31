def DOCKER_HOST = 'tcp://127.0.0.1:2375'
def DOCKER_REGISTRY = 'http://172.31.5.2:5000'

def VERSION_MAJOR = '1'
def VERSION_MINOR = '1'
def VERSION_PATCH = '0'
def VERSION_BUILD = "${BUILD_NUMBER}"

def TAG_MAJOR = "${VERSION_MAJOR}"
def TAG_MINOR = "${TAG_MAJOR}.${VERSION_MINOR}"
def TAG_PATCH = "${TAG_MINOR}.${VERSION_PATCH}"
def TAG_BUILD = "${TAG_PATCH}-b${VERSION_BUILD}"

def IMAGE_NAME = 'alpine-cmake'

node {
    stage('Checkout') {
        checkout scm
    }
    docker.withServer(DOCKER_HOST) {
        def image = null
        stage('Build') {
            image = docker.build(IMAGE_NAME, "--build-arg http_proxy=$HTTP_PROXY --build-arg https_proxy=$HTTPS_PROXY .")
        }
        stage('Publish') {
            docker.withRegistry(DOCKER_REGISTRY) {
                image.push(TAG_BUILD)
                image.push(TAG_PATCH)
                image.push(TAG_MINOR)
                image.push(TAG_MAJOR)
                image.push('latest')
            }
        }
    }
}
