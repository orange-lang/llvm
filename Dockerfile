FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install gcc-4.9 g++-4.9 cmake make python git 

RUN mkdir /src
ADD . /src

RUN mkdir /build
WORKDIR /build
RUN cmake -DCMAKE_BUILD_TYPE=MinSizeRel /src -DCMAKE_CXX_COMPILER=g++-4.9 -DCMAKE_C_COMPILER=gcc-4.9
RUN make 
RUN make install
RUN rm -rf /src 
