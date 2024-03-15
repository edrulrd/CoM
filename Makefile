# @(#) $Id: Makefile,v 1.0 2020/12/20 04:59:40 edrulrd_at_hotmail.com
# -------------------------------------------------------------------

.DEFAULT_GOAL := all

# The files we create containing our changes will be stored in the location specified by CoM_Lib.
# The permissions on the folder are set so the files created within it are owned by the user that runs the
# CoM command.  This thus keeps track of who created the initial documentation file.
#
# Since system updates and patches are usually installed as root, the group ownership of our
# files is set by default to "wheel", thus allowing everyone with membership in the "wheel"
# group to subsequently have read/write access to these files without first needing to switch to
# root with sudo.  Note, that users must have membership in the designated group to use CoM.
#
# Note that there is nothing special about the wheel group, other than it typically already exists,
# and typically would be available to users who can sudo.  If there is another group which systems
# administrators are already members of, exclusive of other users, then you may wish to specify that group
# instead of wheel below. As an alternative, you may want to create a "CoM" group, and give access
# to that group to the users you want to be able to record and view recorded changes.
#
# Many of the following settings are overridden when the configure program is run.
CoM_GRP = sudo  # default for debian-based systems
CoM_GRP = wheel # default for RHEL systems
#
product = CoM
CoM_Lib = /var/log/CoM
BINDIR = /usr/sbin
SHRDIR = /usr/share/etc/CoM
ETCDIR = /etc/CoM/etc
MANDIR = /usr/local/man/man8
OWNER = root
PERMSD = u=rwx,g=srwx,o=  # allow members of the group to create files in this directory
PERMSF = u=rw,g=rw,o=
DATESV = `date +%Y%m%d-%H%M`

# Override the above settings with the responses from running the ./configure script
include .configure_answers.sh

.PHONY: all help install Libs CoM Man uninstall archive clean

all: help

help:
	@printf "%b\n" "+------------------------------------------------+"
	@printf "%b\n" "|  Utility program to save System Administration |"
	@printf "%b\n" "|            changes on *nix like systems.       |"
	@printf "%b\n" "|                                                |"
	@printf "%b\n" "|                                                |"
	@printf "%b\n" "|  Generic Makefile for CoM on all Linux systems |"
	@printf "%b\n" "|                                                |"
	@printf "%b\n" "|  help|install|uninstall|archive|clean|target   |"
	@printf "%b\n" "+------------------------------------------------+"


install: Libs CoM Man

Libs:
	@printf "%b\n" "\033[1m== Installing CoM support folders ==\033[0;0m"

	@if [ ! -d ${CoM_Lib} ]; \
	then \
		if ! mkdir -vp ${CoM_Lib}; \
		then \
			echo "ERROR: write access privileges insufficient to create ${CoM_Lib}. Exiting"; false; \
		fi; \
	fi
	@chown ${OWNER} ${CoM_Lib};
	@chgrp ${CoM_GRP} ${CoM_Lib};
	@chmod ${PERMSD} ${CoM_Lib};
	@echo CoM change file repository created in ${CoM_Lib};




	@if [ ! -d ${SHRDIR} ]; then \
		if ! mkdir -vp ${SHRDIR}; \
		then \
			echo "ERROR: write access privileges insufficient to create ${SHRDIR}. Exiting"; false; \
		fi; \
	fi
	@chown ${OWNER} ${SHRDIR};
	@chgrp ${CoM_GRP} ${SHRDIR};
	@chmod ${PERMSD} ${SHRDIR};
	@if [ -d ./etc ]; \
	then \
		sed "s:###CoM_Lib###:${CoM_Lib}:" ./etc/default.conf | sed "s:#CoM_Lib:CoM_Lib:"  | \
		sed "s:###MANDIR###:${MANDIR}:"                      | sed "s:#MANDIR:MANDIR:"    | \
		sed "s:###CoM_BIN###:${BINDIR}:"                     | sed "s:#CoM_Bin:CoM_Bin:" > ${SHRDIR}/default.conf; \
		chown ${OWNER} ${SHRDIR}/*; \
		chgrp ${CoM_GRP} ${SHRDIR}/*; \
		chmod ${PERMSF} ${SHRDIR}/*; \
	fi;
	@echo Configuration file created in ${SHRDIR};




	@if [ ! -d ${ETCDIR} ]; \
	then \
		if ! mkdir -vp ${ETCDIR}; \
		then \
			echo "ERROR: write access privileges insufficient to create ${ETCDIR}. Exiting"; false; \
		fi; \
	fi
	@chown ${OWNER} ${ETCDIR};
	@chgrp ${CoM_GRP} ${ETCDIR};
	@chmod ${PERMSD} ${ETCDIR};
	@if [ -d ./etc ]; \
	then \
		sed "s:###CoM_SHR###:${SHRDIR}:" ./etc/local.conf > ${ETCDIR}/local.conf; \
		chown ${OWNER} ${ETCDIR}/*; \
		chgrp ${CoM_GRP} ${ETCDIR}/*; \
		chmod ${PERMSF} ${ETCDIR}/*; \
	fi;
	@echo Configuration file created in ${ETCDIR};


CoM:
	@if [ -f bin/${product} ]; \
	then \
		if [ ! -d ${BINDIR} ]; \
		then \
			if ! mkdir -vp ${BINDIR}; \
			then \
				echo "ERROR: write access privileges insufficient to create ${BINDIR}. Exiting"; false; \
			else \
				chown ${OWNER} ${BINDIR}; \
				chgrp ${CoM_GRP} ${BINDIR}; \
				chmod ${PERMSD} ${BINDIR}; \
			fi; \
		fi; \
		if [ -f ${BINDIR}/${product} ]; \
		then \
			cp -p ${BINDIR}/${product} ${BINDIR}/${product}-${DATESV}; \
		fi; \
		sed "s:###CoM_SHR###:${SHRDIR}:" bin/${product} | sed "s:#SHR_DIR:SHR_DIR:" | \
		sed "s:###CoM_ETC###:${ETCDIR}:"                | sed "s:#ETC_DIR:ETC_DIR:" | \
		sed "s:###CoM_Lib###:${CoM_Lib}:"               | sed "s:#CoM_Lib:CoM_Lib:" > ${BINDIR}/${product}; \
		chown ${OWNER} ${BINDIR}/${product}; \
		chgrp ${CoM_GRP} ${BINDIR}/${product}; \
		chmod u=rwx,g=rx,o-rwx ${BINDIR}/${product}; \
		echo CoM command copied into ${BINDIR}; \
		printf "%b\n" "\033[1m== CoM Installation complete ==\033[0;0m"; \
	fi

Man:
	@if [ -f doc/${product}.8.gz ]; \
	then \
		if [ ! -d ${MANDIR} ]; \
		then \
			if ! mkdir -vp ${MANDIR}; \
			then \
				echo "ERROR: write access privileges insufficient to create ${MANDIR}. Exiting"; false; \
			else \
				chown ${OWNER} ${MANDIR}; \
				chgrp ${CoM_GRP} ${MANDIR}; \
				chmod ${PERMSD} ${MANDIR}; \
			fi; \
		fi; \
		cp -p doc/${product}.8.gz ${MANDIR};\
		chmod ${PERMSF} ${MANDIR}/${product}.8.gz;\
		chown ${OWNER} ${MANDIR}/${product}.8.gz; \
		chgrp ${CoM_GRP} ${MANDIR}/${product}.8.gz; \
		printf "%b\n" "\033[1m== CoM man pages installed ==\033[0;0m"; \
	fi
	

uninstall:
	@if  test "$(shell id -u)" = "0"  ||  test "$(shell id -u)" = "$(shell id -u ${OWNER})"; \
		then : ; \
		else  echo "ERROR: owner or superuser access is needed to remove system libraries."; exit 101;\
	fi
	@printf "%b\n" "\033[1m== Uninstalling CoM ==\033[0;0m"
	@rm -fv ${BINDIR}/${product}
	@rm -fv ${MANDIR}/${product}.8.gz
	@echo Not deleting change records in ${CoM_Lib}
	@echo Not deleting tailored configuration settings in ${ETCDIR}
	@printf "%b\n" "\033[1m== CoM Uninstallation complete ==\033[0;0m"

archive:
	@echo "Copying installed configuration settings and Change Repository to /tmp/CoM_backup-${DATESV}.tar.gz"
	@if [ -f /tmp/CoM_backup-${DATESV}.tar.gz ]; then rm -f /tmp/CoM_backup-${DATESV}.tar.gz; fi
	tar czf /tmp/CoM_backup-${DATESV}.tar.gz .configure_answers.sh  ${BINDIR}/${product} ${SHRDIR}/default.conf ${ETCDIR}/local.conf ${MANDIR}/${product}.8.gz ${CoM_Lib};
	@echo "gzip'ed tar archive (/tmp/CoM_backup-${DATESV}.tar.gz) created"

src_archive:
	@echo "Copying our configuration settings to /tmp/CoM.tar.gz"
	@if [ -f /tmp/CoM.tar.gz ]; then rm -f /tmp/CoM.tar.gz; fi
	tar czf /tmp/CoM.tar.gz configure Makefile bin/CoM doc/CoM.8.gz etc/default.conf etc/local.conf ChangeLog.txt LICENSE README.md
	@echo "gzip'ed tar archive (/tmp/CoM.tar.gz) created"

clean:
	@echo make clean is currently a No-Op

target:
	@echo "Installed, or configured locations for ${product}'s files:"

	@if [ -f ${BINDIR}/${product} ]; \
	then \
		ls -l ${BINDIR}/${product}; \
	else \
		echo Binary:"			"${BINDIR}/${product}; \
	fi

	@if [ -d ${CoM_Lib} ]; \
	then \
		ls -ld ${CoM_Lib}; \
	else \
		echo Change Library:"		"${CoM_Lib}; \
	fi

	@if [ -f ${SHRDIR}/default.conf ]; \
	then \
		ls -l ${SHRDIR}/*; \
	else \
		echo System Config File:"	"${SHRDIR}/default.conf; \
	fi

	@if [ -f ${ETCDIR}/local.conf ]; \
	then \
		ls -l ${ETCDIR}/*; \
	else \
		echo Local Config File:"	"${ETCDIR}/local.conf; \
	fi

	@if [ -f ${MANDIR}/${product}.8.gz ]; \
	then \
		ls -l ${MANDIR}/${product}.8.gz; \
	else \
		echo Man page:"		"${MANDIR}/${product}.8.gz; \
	fi
