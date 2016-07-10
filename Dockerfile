FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install gcc-4.9 g++-4.9 cmake make python git 

RUN mkdir /src
COPY . /src

WORKDIR /build
RUN cmake -DCMAKE_BUILD_TYPE=MinSizeRel /src -DCMAKE_CXX_COMPILER=g++-4.9 -DCMAKE_C_COMPILER=gcc-4.9 -DCMAKE_INSTALL_PREFIX=/usr/local/llvm -DLLVM_INCLUDE_TESTS=OFF -DLLVM_ENABLE_RTTI=ON
RUN make 
RUN make install
RUN rm -rf /src /build 
WORKDIR /

RUN apt-get remove -y gcc-4.9 g++-4.9 python git 
RUN apt autoremove -y 
RUN rm -rf /var/lib/apt/lists/*
RUN echo "export PATH=\$PATH:/usr/local/llvm/bin" >> ~/.bashrc 
