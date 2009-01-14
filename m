From: Mark Nienberg <gmane@tippingmar.com>
Date: Wed, 14 Jan 2009 17:57:00 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <gkl91d$eiv$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Mark,
> 
> On Tue, 13 Jan 2009 10:26:23 -0800, Mark Nienberg wrote:
>> I have lm_sensors running and "service lm_sensors status" gives
>> correct results.
>>
>> Now if I start sensord with
>>
>> INTERVAL=0
>> LOG_INTERVAL0m
>>
>> then it works just fine and logs to syslog just like I want it to.
>>
>> If I start it with
>>
>> INTERVAL=0
>> LOG_INTERVAL0m
>> RRD_LOGFILE=/var/log/sensors.rrd
>>
>> then i get
>>
>> sensord: creating round robin database
>> sensord: Error creating RRD: /var/log/sensors.rrd: No sensors detected
>>
>> Is there something else I have to do to get the rrd part to work?
> 
> No, it should work. That being said, where do you put these values? We
> do not have such an setup script for sensord. So please tell us:
> * What version of lm-sensors you're using.
> * Which distribution you are using.
> 
> And attach (or point us to) a copy of the initialization script which
> is reading the variables you listed above.

[root@gecko ~]# rpm -q lm_sensors sensord
lm_sensors-2.10.6-55.el5
sensord-2.10.6-55.el5

installed from atrpms on CentOS 5.2 x86_64.

But I should add that the sensord init script in the rpm package seemed wrong to me 
so I replaced it with one I copied from a fedora 7 install.  This one just checks 
that lm_sensors is already running, which should insure that the correct modules are 
loaded. The other one was very old (from redhat 7.2) and actually tried to load 
modules. Here is the one I am using:

#!/bin/sh
#
# sensord:      Hardware sensors monitoring daemon
#
# chkconfig:    - 27 73
# description:  Starts and stops hardware sensors monitoring daemon.
# config:       /etc/sysconfig/sensord
# author:       Filip Kalinski <filon@pld.org.pl>
# adapted for fedora by Hans de Goede <j.w.r.degoede@hhs.nl>

# Source function library.
. /etc/rc.d/init.d/functions

# Get service config
if [ -f /etc/sysconfig/sensord ]; then
         . /etc/sysconfig/sensord
fi

prog="sensord"

start() {
         echo -n $"Starting $prog: "

         if [ ! -f /var/lock/subsys/lm_sensors ]; then
                 echo -n "error lm_sensors service not started"
                 echo_failure
                 echo
                 exit 6
         fi

         daemon sensord \
                 ${INTERVAL:+-i $INTERVAL} \
                 ${LOG_INTERVAL:+-l $LOG_INTERVAL} \
                 ${RRD_LOGFILE:+-r $RRD_LOGFILE} \
                 ${RRD_INTERVAL:+-t $RRD_INTERVAL} \
                 w83792d-* -f daemon

         RETVAL=$?
         echo
         [ $RETVAL -eq 0 ] && touch /var/lock/subsys/sensord
}

RETVAL=0
# See how we were called.
case "$1" in
   start)
         start
         ;;
   stop)
         stop
         ;;
   status)
         status sensord
         RETVAL=$?
         sensors
         ;;
   restart|force-reload)
         stop
         start
         ;;
   *)
         echo $"Usage: $0 {start|stop|restart|force-reload|status}"
         exit 3
esac

exit $RETVAL

stop() {
         echo -n $"Stopping $prog: "

         killproc sensord

         RETVAL=$?
         echo
         [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/sensord
}


And here is the file /etc/sysconfig/sensord, which is included into above:

# configuration for hardware sensors monitoring daemon
# in intervals use suffix "m" for minutes, "s" for seconds, "h" for hours
# 0 means turning facility off

# interval between scanning alarms
INTERVAL=0

# interval between logging to syslog
LOG_INTERVAL0m

# interval between RRD logging
#RRD_INTERVAL0m

# RRD db location
#RRD_LOGFILE=/var/log/sensors.rrd


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
