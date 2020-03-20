job('maven-job-dsl') {

	description('Maven job created by DSL')

	logRotator {
		daysToKeep(5)
		numToKeep(5)
	}

	scm {
		git('https://github.com/jenkins-docs/simple-java-maven-app.git','master',{node -> node / 'extensions' << ''})
	}

	steps {
		maven {
			mavenInstallation('jenkins-maven')
			goals('-B -DskipTests clean package')
		}
		maven {
			mavenInstallation('jenkins-maven')
			goals('test')
		}
		shell('''
			echo "******************************* DEPLOYING JAR"
<<<<<<< HEAD
			java -jar /var/jenkins_home/workspace/Maven-job-dsl/target/my-app-1.0-SNAPSHOT.jar
=======
			java -jar /var/jenkins_home/workspace/maven-job-dsl/target/my-app-1.0-SNAPSHOT.jar
>>>>>>> 205d035a5221f1c34ba16fafa9f32b291031f3ab
		      ''')
	}
	publishers {
		archiveArtifacts('target/*.jar')
		archiveJunit('target/surefire-reports/TEST-com.mycompany.app.AppTest.xml')
	}
         
}
