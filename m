From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [LM_SENSOR-2.8.7] lm_sensors.init and kernel 2.6.5
Message-Id: <20040810204355.098358d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408071426.51805.bepi@adria.it>
In-Reply-To: <200408071426.51805.bepi@adria.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In order to make to work lm_sensors.init on my system with kernel
> 2.6.5 I have executed some modifications (for find they enough to
> search WITHSYS and PSENSORS). 
> I have thought that perhaps they could be to useful and therefore I
> have sent to you.

Yes, this will be useful. We have had several requests about this
already, so I'm glad someone finally proposed a patch to start with.
Thanks!

I've used your work as a base and cleaned the script up a bit. Mostly
cosmetics, but there are also a few improvements. For example, testing
whether /sys exists to detect if we are using sysfs isn't reliable.
Someone using 2.4 and 2.6 kernels on the same system will have /sys but
when running 2.4 it won't be used. So I decided to grep /proc/mounts
instead.

Attached is my proposed script. Could you please test it and tell me if
it works OK for you? I can't test myself, since my distribution is not
compatible with this kind of init script.

Thanks again.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
-------------- next part --------------
#!/bin/sh
#
# chkconfig: 2345 26 74
# description: sensors is used for monitoring motherboard sensor values.
# config: /etc/sysconfig/sensors
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# See also the lm_sensors homepage at:
#     http://www2.lm-sensors.nu/~lm78/index.html

# It uses a config file /etc/sysconfig/sensors that contains the modules to
# be loaded/unloaded. That file is sourced into this one.

# The format of that file a shell script that simply defines the modules 
# in order as normal shell variables with the special names:
#    MODULE_1, MODULE_2, MODULE_3, etc.

if grep -q sysfs /proc/mounts; then
	WITHSYS=1
else
	WITHSYS=0
fi

if [ ! $WITHSYS ]; then
	# If sensors isn't supported by the kernel, try loading the module...
	[ -e /proc/sys/dev/sensors ] || /sbin/modprobe i2c-proc &>/dev/null

	# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
	# support for sensors.
	[ -e /proc/sys/dev/sensors ] || exit 0

	# If sensors was not already running, unload the module...
	[ -e /var/lock/subsys/sensors ] || /sbin/modprobe -r i2c-proc &>/dev/null
fi

CONFIG=/etc/sysconfig/lm_sensors
PSENSORS=/usr/local/bin/sensors

if [ ! -x $PSENSORS ]; then
	PSENSORS=/usr/bin/sensors
fi

# Source function library.
. /etc/init.d/functions

RETVAL=0

start() {
	echo -n $"Starting up sensors: "
	test -r "$CONFIG" && . "$CONFIG"

	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
	i=0
	while [ $i -lt $modules ] ; do
		module=`eval echo '$'MODULE_$i`
		echo starting module __${module}__
		/sbin/modprobe $module &>/dev/null
		i=`expr $i + 1`
	done
	$PSENSORS -s

	RETVAL=$?
	if [ $RETVAL -eq 0 ] && touch /var/lock/subsys/sensors ; then
		echo_success
		echo
	else
		echo_failure
		echo
	fi
}

stop() {
	echo -n $"Shutting down sensors: "
	test -r "$CONFIG" && . "$CONFIG"

	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
	i=`expr $modules`
	while [ $i -ge 0 ] ; do
		module=`eval echo '$'MODULE_$i`
		/sbin/modprobe -r $module &>/dev/null
		i=`expr $i - 1`
	done

	if [ ! $WITHSYS ]; then
		/sbin/modprobe -r i2c-proc &>/dev/null
	fi

	RETVAL=$?
	if [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/sensors ; then
		echo_success
		echo
	else
		echo_failure
		echo
	fi
}

dostatus() {
	$PSENSORS
	RETVAL=$?
}

restart() {
	stop
	start
	RETVAL=$?
}

condrestart() {
	[ -e /var/lock/subsys/sensors ] && restart || :
}

# See how we were called.
case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  status)
	dostatus
	;;
  restart|reload)
	restart
	;;
  condrestart)
	condrestart
	;;
  *)
	echo "Usage: sensors.init {start|stop|status|restart|reload|condrestart}"
	exit 1
esac

exit $RETVAL
