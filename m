From: Sebastian.Mika@first.fraunhofer.de (Sebastian Mika)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: prog/init/lm_sensors.init
Message-Id: <200208261925.40048.sebastiansseine@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

probably I am not the first to note, but this script contained some bugs in 
the start and stop functions (version lm_sensors-2.6.4)

start: The increment in the loop happend after the loading, i.e. first we try 
to load MODULE_0. But these variables start with MODULE_1

stop: At least on my debian system the line 
"modules=`grep \^MODULE_ $CONFIG | wc -l`"
evaluates to " 4" (a space before 4).

Regards,
Sebastian Mika

start() {
	echo -n $"Starting up sensors: "
	test -r "$CONFIG" && . "$CONFIG"

        modules=`grep \^MODULE_ $CONFIG | wc -l`
        i=0
        while [ $i -lt $modules ] ; do
	    i=`expr $i + 1`
	    module=`eval echo '$'MODULE_$i`
	    /sbin/modprobe $module &>/dev/null
	done

	RETVAL=$?
	[ $RETVAL -eq 0 ] && touch /var/lock/sensors
	echo
}

stop() {
	echo -n $"Shutting down sensors: "
	test -r "$CONFIG" && . "$CONFIG"

        modules=`grep \^MODULE_ $CONFIG | wc -l`
        i=`expr $modules`
        while [ $i -ge 0 ] ; do
                module=`eval echo '$'MODULE_$i`
      		/sbin/modprobe -r $module &>/dev/null
		i=`expr $i - 1`
	done
	/sbin/modprobe -r i2c-proc &>/dev/null

	RETVAL=$?
	[ $RETVAL -eq 0 ] && rm -f /var/lock/sensors
	echo
}

-- 
Sebastian Mika             http://www.first.fraunhofer.de/~mika/
Fraunhofer - First
Kekulestr. 7                                      Tel: +49 (30) 6392 1906
12489 Berlin, Germany                   Fax: +49 (30) 6392 1805
