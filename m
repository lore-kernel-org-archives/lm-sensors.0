From: sebastiansseine@gmx.net (Sebastian Mika)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: prog/init/lm_sensors.init
Message-Id: <200208271123.26694.Sebastian.Mika@first.fraunhofer.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200208261925.40048.sebastiansseine@gmx.net>
In-Reply-To: <200208261925.40048.sebastiansseine@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

as requested by Albert Cranford, please find attached the outputs of 
lm_sensors.init {start|stop} and also the automagically generated 
/etc/sysconfig/lm_sensors.

The suspicious line is 22 in res_start.out (since the numbering in the 
sysconfig file starts with 1 - see the trivial fix below) and line 19-22 in 
res_stop.out (also a trivial fix below).

Sorry that I forgot to mention that the code pieces appended in my first mail 
were ment to contain a fix for both problems.

Regards,
Sebastian Mika.

On Tuesday 27 August 2002 01:38, you wrote:
> Try putting a set -x right after the #!/bin/sh line then
> send the result output to a file.  Send the file to the list for analysis.
> Ex:
> prog/init/lm_sensors.init 2>&1|tee res.out
>
> Albert
>
> Sebastian Mika wrote:
> > Hi,
> >
> > probably I am not the first to note, but this script contained some bugs
> > in the start and stop functions (version lm_sensors-2.6.4)
> >
> > start: The increment in the loop happend after the loading, i.e. first we
> > try to load MODULE_0. But these variables start with MODULE_1
> >
> > stop: At least on my debian system the line
> > "modules=`grep \^MODULE_ $CONFIG | wc -l`"
> > evaluates to " 4" (a space before 4).
> >
> > Regards,
> > Sebastian Mika
> >
> > start() {
> >         echo -n $"Starting up sensors: "
> >         test -r "$CONFIG" && . "$CONFIG"
> >
> >         modules=`grep \^MODULE_ $CONFIG | wc -l`
> >         i=0
> >         while [ $i -lt $modules ] ; do
> >             i=`expr $i + 1`
> >             module=`eval echo '$'MODULE_$i`
> >             /sbin/modprobe $module &>/dev/null
> >         done
> >
> >         RETVAL=$?
> >         [ $RETVAL -eq 0 ] && touch /var/lock/sensors
> >         echo
> > }
> >
> > stop() {
> >         echo -n $"Shutting down sensors: "
> >         test -r "$CONFIG" && . "$CONFIG"
> >
> >         modules=`grep \^MODULE_ $CONFIG | wc -l`
> >         i=`expr $modules`
> >         while [ $i -ge 0 ] ; do
> >                 module=`eval echo '$'MODULE_$i`
> >                 /sbin/modprobe -r $module &>/dev/null
> >                 i=`expr $i - 1`
> >         done
> >         /sbin/modprobe -r i2c-proc &>/dev/null
> >
> >         RETVAL=$?
> >         [ $RETVAL -eq 0 ] && rm -f /var/lock/sensors
> >         echo
> > }
> >
> > --
> > Sebastian Mika             http://www.first.fraunhofer.de/~mika/
> > Fraunhofer - First
> > Kekulestr. 7                                      Tel: +49 (30) 6392 1906
> > 12489 Berlin, Germany                   Fax: +49 (30) 6392 1805

-- 
Sebastian Mika             http://www.first.fraunhofer.de/~mika/
Fraunhofer - First
Kekulestr. 7                                      Tel: +49 (30) 6392 1906
12489 Berlin, Germany                   Fax: +49 (30) 6392 1805
