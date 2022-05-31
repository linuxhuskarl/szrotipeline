node {
    docker.withServer('tcp://127.0.0.1:2375') {
        def image = null
        stage('Build') {
            image = docker.build()
        }
        stage('Test') { 
            image.inside {
                sh 'cmake --version'
            }
        }
        stage('Publish') {
            withRegistry('http://172.31.5.2:5000') {
                image.push("0.1.0-b$BUILD_NUMBER")
            }
        }
    }
}
