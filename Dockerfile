FROM apnar/nfs-ganesha

RUN mkdir /var/lib/ganesha
RUN chmod g+rwx /run /var/lib/ganesha /run/dbus
#RUN sed -i 's/^init_dbus/#init_dbus/g' /start.sh
RUN sed -i 's/^init_dbus/echo \'NFS_CORE_PARAM \{ Enable_RQUOTA = false; \}\' >> \/tmp\/ganesha\.log/g' /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
