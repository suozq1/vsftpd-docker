#docker build -t harbor.hongyunxt.cn/library/vsftp-nginx:1.0 .
FROM nginx:1.25.0
RUN apt update  && apt install vsftpd -y 
ENV FTP_USER=admin FTP_PASS=hongyun@ftp PASV_ADDRESS=127.0.0.1
COPY nginx.conf /etc/nginx/nginx.conf 
COPY vsftpd.conf /etc/vsftpd.conf
RUN useradd ${FTP_USER} && echo "$FTP_USER:$FTP_PASS" | chpasswd && usermod -d /data/ftp ${FTP_USER}
RUN  mkdir -p /data/ftp && chmod 777 /data/ftp
CMD echo "$FTP_USER:$FTP_PASS" | chpasswd; \
    echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd.conf; \
    service vsftpd start;\
    nginx -g 'daemon off;' 