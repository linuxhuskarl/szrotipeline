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
            def container = image.withRun('-t', 'cmake --version') {
                echo 'hmm!'
            }
        }
        stage('Publish') {
            withRegistry('http://172.31.5.2:5000') {
                image.push("0.1.0-b$BUILD_NUMBER")
            }
        }
    }
}
