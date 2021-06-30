#!/bin/bash
# 
# Create Jenkins create job
# 
cat <<EOF | java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ -http -auth ddelsizov:secretpassword create-job Docker-Mysql
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github">
      <projectUrl>https://github.com/ddelsizov/two-docker-images.git</projectUrl>
      <displayName>Test2</displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/ddelsizov/two-docker-images.git</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <assignedNode>slavehost1</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H/2 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <customWorkspace>/opt/jenkins/projects/</customWorkspace>
  <builders>
  <hudson.tasks.Shell>
   <command>
#!/bin/bash -l 
/vagrant/cleanup1.sh
   </command>
  </hudson.tasks.Shell>
    <hudson.tasks.Shell>
   <command>
 sudo rm -rf /opt/jenkins/projects/docker
 git clone https://github.com/ddelsizov/two-docker-images.git /opt/jenkins/projects/docker
   </command>
  </hudson.tasks.Shell>
  <hudson.tasks.Shell>
 <command>
docker image build -t mysql-1 /opt/jenkins/projects/docker/mysql
</command>
    </hudson.tasks.Shell>
    <hudson.tasks.Shell>
      <command>docker container run -d --net home-network --name mysql-1 --env="MYSQL_ROOT_PASSWORD=1234567" --publish 192.168.99.102:3306:3306 mysql-1</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF

