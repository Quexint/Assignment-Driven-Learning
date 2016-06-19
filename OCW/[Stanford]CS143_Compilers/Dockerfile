FROM m0elnx/ubuntu-32bit:14.04.20160526

# install the dependency
RUN apt-get upgrade
RUN apt-get update
RUN apt-get update --fix-missing
RUN apt-get install -y g++ csh flex bison openjdk-6-jdk wget
RUN apt-get install -y make git
RUN apt-get install -y vim cscope exuberant-ctags build-essential

# create user compilers
RUN adduser --disabled-password --gecos '' compilers
RUN echo "compilers:cool" | chpasswd
USER compilers
WORKDIR /home/compilers/
ENV PATH /home/compilers/cool/bin:$PATH
WORKDIR /home/compilers

# clone the cool project
RUN mkdir -p /home/compilers/cool
RUN chmod -R 755 /home/compilers
WORKDIR /home/compilers/cool
RUN wget "http://openclassroom.stanford.edu/MainFolder/courses/Compilers/docs/src/pa.linux.i686.tar.gz"
RUN tar xvzf pa.linux.i686.tar.gz
RUN rm pa.linux.i686.tar.gz
WORKDIR /home/compilers/cool/assignments/
RUN wget "http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa1-grading.pl"
RUN wget "http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa2-grading.pl"
RUN wget "http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa3-grading.pl"
RUN wget "http://spark-university.s3.amazonaws.com/stanford-compilers/scripts/pa4-grading.pl"

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
