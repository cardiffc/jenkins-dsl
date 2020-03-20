job('maven-job-dsl') {

	description('Maven job.created by DSL')

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
			java -jar /var/jenkins_home/workspace/Maven-job-dsl/target/my-app-1.0-SNAPSHOT.jar
		      ''')
	}
	publishers {
		archiveArtifacts('target/*.jar')
		archiveJunit('target/surefire-reports/TEST-com.mycompany.app.AppTest.xml')
	}
         
}
