FROM apnar/nfs-ganesha

RUN mkdir /run/dbus
RUN chmod g+rwx /run /var/lib/ganesha /run/dbus
RUN sed -i 's/^init_dbus/#init_dbus/g' /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
