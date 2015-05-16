# docker-jenkins



    
	docker run -p 8080:8080 -privileged monsendag/jenkins

A docker image containing Jenkins, and dependencies needed for building docker images in Jenkins.

* git
* docker
* qemu (for building images for ARM, including Raspberry Pi))


Uses Docker in Docker: https://github.com/jpetazzo/dind


I will try to keep this image up to date. Create an issue on Github if anything is outdated, and I will push a new version.
  
