FROM apnar/nfs-ganesha

RUN chmod g+rwx /run
RUN sed -i 's/^init_dbus/#init_dbus/g' /start.sh
RUN chmod a+x /start.sh

CMD ["/start.sh"]
