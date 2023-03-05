FROM almalinux
RUN useradd test1
RUN useradd test2
RUN yum update
RUN yum install git -y
RUN git clone github.com/internetProhozhij/sp
CMD bash ./sp/script.sh
