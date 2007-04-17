From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Apr 2007 19:02:22 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070417210222.0e8d2894@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Tue, 17 Apr 2007 09:34:38 -0400, Jeffrey J. Kosowsky wrote:
> Actually, I think the problem was due to the fact that I posted via
> gmane and somehow my cut-paste from a putty xterm on my Linux machine
> to a Firefox html text box on my Windoze machine messed up the
> tabs. So, I am mailing this directly from my Linux machine.

This patch is better, however I still failed to apply it to our SVN
repository (hunk #2 failed). Was it generated cleanly? Does it apply
cleanly to 2.10.3 on your side? Better send the patches as attachments
if inline isn't reliable.

> Here is the trimmed/streamlined version for 2.6 only:
> [Note I also made the sensor an optional input parameter that defaults
> to hwmon0 since that seems to be the most likely case for most users]

That's a good idea. That being said, systems with more than one
hardware monitoring device are becoming more popular.

> --- sens_update_rrd	2007-04-17 09:03:08.000000000 -0400
> +++ sens_update_rrd.new	2007-04-17 09:16:26.000000000 -0400
> @@ -2,9 +2,9 @@
>  #    sens_update_rrd -
>  #	Update a sensors rrd database.
>  #	Sample usage:
> -#		sens_update_rrd /var/lib/database.rrd w83781d-isa-0290
> +#		sens_update_rrd /var/lib/database.rrd hwmon0
>  #	Sample cron entry:
> -#		*/5 * * * * /usr/local/bin/sens_update_rrd /var/lib/sensors-rrd/sensors.rrd w83781d-isa-0290
> +#		*/5 * * * * /usr/local/bin/sens_update_rrd /var/lib/sensors-rrd/sensors.rrd hwmon0
>  #
>  #################################################################
>  #
> @@ -26,48 +26,35 @@
>  #
>  #################################################################
>  #
> -if [ $# -ne 2 ]
> +if [ $# -lt 1 ]

Maybe test -gt 2 too, for completeness?

>  then
> -	echo "usage: $0 database.rrd sensor"
> -	echo "       sensor example: w83781d-isa-0290 (2.4) or 0-0290 (2.6)"
> +	echo "usage: $0 database.rrd [hwmonN]"
>  	exit 1
>  fi
>  #
>  RRDPATH=/usr/bin
>  RRDB=$1
>  
> -SENSDIR=/proc/sys/dev/sensors
> -SDIR=/sys/bus/i2c/devices
> -if [ ! -d $SENSDIR ]
> -then
> -	if [ ! -d $SDIR ]
> -	then
> -		echo $0: 'No sensors found! (modprobe sensor modules?)'
> -		exit 1
> -	else
> -		SYSFS=1
> -		SENSDIR=$SDIR
> -	fi	
> -fi
> +SENSDIR=/sys/class/hwmon
> +HWMON=hwmon0
> +[ $2 ] && HWMON=$2

This usage of "test" isn't documented, so I'd rather avoid using it.
What about [ -n "$2" ] or [ $# -ge 2 ] instead?

> +SENS=$SENSDIR/$HWMON/device
>  
> -SENSDEV=$2
> -SENS=$SENSDIR/$SENSDEV
> -if [ ! -r $SENS ]
> +if [ ! -d $SENS ]
>  then
> -	echo $0: 'No sensors found! (modprobe sensor modules?)'
> +	echo "No sensors found in: $SENS"
> +	echo "(modprobe sensor modules?)"
>  	exit 1
>  fi
>  
>  STRING=N
> -if [ "$SYSFS" = "1" ]
> -then
>  	#
>  	# Get the value from these sensor files (/sys)
>  	#
>  	SENSORS="fan1 fan2 fan3"
>  	for i in $SENSORS
>  	do
> -		V="`cat $SENSDIR/$SENSDEV/${i}_input 2> /dev/null`"
> +	V="`cat $SENS/${i}_input 2> /dev/null`"
>  		if [ $? -ne 0 ]
>  		then
>  			STRING="${STRING}:U"
> @@ -81,7 +68,7 @@
>  	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"

Not related with your patch, but this list should be extended, we have
chips with up to temp6 and up to in10. Same for the fan list above, I
think we have up to fan7.

>  	for i in $SENSORS
>  	do
> -		V="`cat $SENSDIR/$SENSDEV/${i}_input 2> /dev/null`"
> +	V="`cat $SENS/${i}_input 2> /dev/null`"
>  		if [ $? -ne 0 ]
>  		then
>  			STRING="${STRING}:U"
> @@ -90,38 +77,6 @@
>  			STRING="${STRING}:${V}"
>  		fi
>  	done

You need to reindent the whole block. I know it will make the patch
bigger, but badly indented code is unmaintainable.

> -else
> -	#
> -	# Get the second value from these sensor files (/proc)
> -	#
> -	SENSORS="fan1 fan2 fan3"
> -	for i in $SENSORS
> -	do
> -		V="`cat $SENSDIR/$SENSDEV/$i 2> /dev/null`"
> -		if [ $? -ne 0 ]
> -		then
> -			STRING="${STRING}:U"
> -		else
> -			V="`echo $V | cut -d ' ' -f 2`"
> -			STRING="${STRING}:${V}"
> -		fi
> -	done
> -	#
> -	# Get the third value from these sensor files (/proc)
> -	#
> -	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
> -	for i in $SENSORS
> -	do
> -		V="`cat $SENSDIR/$SENSDEV/$i 2> /dev/null`"
> -		if [ $? -ne 0 ]
> -		then
> -			STRING="${STRING}:U"
> -		else
> -			V="`echo $V | cut -d ' ' -f 3`"
> -			STRING="${STRING}:${V}"
> -		fi
> -	done
> -fi
>  
>  #
>  # Get the first value from these /proc files

Patch looks good otherwise. Can you please update it and resubmit?

>  > You mentioned that sensors.conf.5 was out-of-date, can you please send
>  > a patch for it too?
> 
> I'm not sure how to fix some of this since I'm not really sure what
> the 2.6 equivalent is, but here are the lines that need adjusting:
> 
> 1.	The  second and third arguments are the description texts. They must
> 	be exactly match the texts as they appear  in  /proc/bus/i2c,
> 	except for trailing  spaces, which are removed both from the /proc entries
> 	and the arguments.
> 
> 	[I don't know where you find the 'second and third argument'
> 	(which are the chip description) in 2.6 kernels]
> 

Which version of the man page are you looking at? I updated that
section in October 2006.

> 2.	The  program  prog/config/grab_busses.sh in the source distribution
> 	can help you generate these lines.
> 
> 	[This program needs to be fixed for Kernel 2.6 -- I don't use it
> 	so I don't know exactly what it does or how to fix it]

It finds the current I2C buses numbers, and generates bus lines
suitable for sensors.conf. The idea is to run this script, copy the
output to sensors.conf, and use these bus numbers in the rest of the
configuration file. However, this is only needed if you have more than
one sensor chip of a given type *and* they need different
configurations - otherwise you simply give put the device name without
the bus number and address. So I guess that almost nobody needs this
script in practice, which explains why nobody ever complained that it
was broken for Linux 2.6. In fact the script is untouched since it was
created in December 1998!

So we have three options from here:
1* Kill the script and let people who really need bus lines build them
by hand. We can point them to i2cdetect, or simply to the output of
sensors.
2* Fix the grab_busses.sh script, probably by relying on "i2cdetect -l"
instead of /proc/bus/i2c.
3* Move the functionality to libsensors, and add a sensors option.

I wonder what the others think. I don't like option 2 because it adds a
dependency from sensors stuff to i2cdetect, while I'd like to get
rid of this dependency. (Especially as i2cdetect itself depends on the
i2c-dev driver being loaded for 2.6 kernels - another thing we should
fix.) So I'd go for option 1 for now, and possibly implement option 3
later if users really insist.

> 3.  The chip descriptions are equal to those appearing in
>     /proc/sys/dev/sensors, but may contain the * wildcard.
> 
> 	[Again, I don't know where you find the chip descriptions in 2.6
> 	kernels]

The chip descriptions no longer appear anywhere verbatim with 2.6
kernels. You have to build them up from the "name" device attribute,
the bus type and the device ID. How the chip descriptions are built is
already described right after in the manual page, so the best and
easiest fix for this one is probably to just drop the outdated
reference to /proc/sys/dev/sensors.

> More generally, you may want to have someone who is more familiar with
> the 'lm_sensors' project to review the full man page since it seems like
> it hasn't been changed since Feb 1999.

Not true. This man page has been updated 7 times since then. But this
man page is large an it isn't easy to keep all the sections up-to-date.

I've made a complete review of the chip statement section, hopefully
it's better now:
http://lm-sensors.org/changeset/4370

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
