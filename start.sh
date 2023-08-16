#!/bin/bash
set -e

: ${GANESHA_CONFIGFILE:="/tmp/ganesha.conf"}
: ${GANESHA_LOGFILE:="/tmp/ganesha.log"}

function bootstrap_config {
        echo "Bootstrapping Ganesha NFS config"
  cat <<END >${GANESHA_CONFIGFILE}
NFS_CORE_PARAM
{
                Bind_addr = 0.0.0.0;
                Protocols = 4;
                Enable_RQUOTA = false;
                Clustered = false;
}

EXPORT_DEFAULTS
{
                Access_Type = RW;
}

EXPORT
{
                # Export Id (mandatory, each EXPORT must have a unique Export_Id)
                Export_Id = 2023;

                # Exported path (mandatory)
                Path = /export;

                # Pseudo Path (for NFS v4)
                Pseudo = /;

                # Access control options
                Squash = none;

                # NFS protocol options
                Transports = TCP;

                SecType = sys;
                Disable_ACL = true;

                # Exporting FSAL
                FSAL
                {
                        Name = VFS;
                        #Name = MEM;
                }
}

LOG {
                Default_Log_Level = INFO;

                Components {
                        FH = INFO;
                }

                Facility {
                        name = FILE;
                        destination = ${GANESHA_LOGFILE};
                        enable = active;
                }
}

#VFS
#{
#                link_support = false;
#                symlink_support = false;
#                umask = 0777;
#                only_one_user = true;
#}

END
}

bootstrap_config

echo "Starting Ganesha NFS"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
exec /usr/bin/ganesha.nfsd -F -L ${GANESHA_LOGFILE} -f ${GANESHA_CONFIGFILE}
