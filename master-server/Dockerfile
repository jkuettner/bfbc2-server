FROM ubuntu:bionic as makefile

ENV LIB_BOOST_DIR="/usr/include/boost/"
ENV LIB_OPENSSL_DIR="/usr/include/openssl/"
ENV LIB_PATH="/usr/lib"

WORKDIR /bfbc2
RUN apt-get update && apt-get install -y \
        unrar \
        cbp2make \
        wget \
    && apt-get clean \
    && wget -qO /tmp/src_v09.rar "https://iweb.dl.sourceforge.net/project/battlefieldbadcompany2mase/Source%20V0.9/src_v09.rar" \
    && unrar x /tmp/src_v09.rar \
    && cd ./src \
        && sed -i -e 's@$(BOOST_1_54_DIR)@'${LIB_BOOST_DIR}'@g' mase_bc2.vcxproj mase_bc2.cbp \
        && sed -i -e 's@$(OPEN_SSL_DIR)@'${LIB_OPENSSL_DIR}'@g' mase_bc2.vcxproj mase_bc2.cbp \
        && sed -i -e 's@libboost_system.a@'${LIB_PATH}'/libboost_system.a@g' mase_bc2.cbp \
        && sed -i -e 's@libboost_filesystem.a@'${LIB_PATH}'/libboost_filesystem.a@g' mase_bc2.cbp \
        && sed -i -e 's@libboost_random.a@'${LIB_PATH}'/libboost_random.a@g' mase_bc2.cbp \
        && sed -i -e 's@libssl.a@'${LIB_PATH}'/libssl.a@g' mase_bc2.cbp \
        && sed -i -e 's@libcrypto.a@'${LIB_PATH}'/libcrypto.a@g' mase_bc2.cbp \
    && cbp2make -in mase_bc2.cbp -out Makefile \
        && sed -i -e '/^LIB = / s@$@ -lz@' Makefile

######################

FROM alpine:3.6 as build

ENV CXXFLAGS="-std=gnu++11"

RUN apk add --update \
        bash \
        make \
        gcc \
        g++ \
        boost-dev \
        openssl-dev

COPY --from=makefile /bfbc2 /bfbc2

WORKDIR /bfbc2/src

RUN make release

######################

FROM alpine:3.6

COPY --from=build /bfbc2/src/bin/Release/mase_bc2 /home/bfbc2/mase_bc2
ADD ./config.ini /home/bfbc2/.default_config.ini
ADD ./templates /home/bfbc2/templates

RUN adduser -D bfbc2 \
    && ln -s /home/bfbc2/.default_config.ini /home/bfbc2/config.ini \
    && chown bfbc2. -R /home/bfbc2 \
    && apk add --update \
        bash \
        libgcc \
        libstdc++

USER bfbc2

WORKDIR /home/bfbc2

CMD ["/home/bfbc2/mase_bc2"]
