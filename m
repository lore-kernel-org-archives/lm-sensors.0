From: "Jeffrey J. Kosowsky" <lm_sensors@kosowsky.org>
Date: Tue, 17 Apr 2007 20:52:27 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <17957.13195.781978.359232@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote at about 21:02:22 +0200 on Tuesday, April 17, 2007:
 > On Tue, 17 Apr 2007 09:34:38 -0400, Jeffrey J. Kosowsky wrote:
 > This patch is better, however I still failed to apply it to our SVN
 > repository (hunk #2 failed). Was it generated cleanly? Does it apply
 > cleanly to 2.10.3 on your side? Better send the patches as attachments
 > if inline isn't reliable.

OK. Well since now almost all lines are rewritten (or at least
re-tabified), I am going to just include the full revised file and
circumvent any diff issues also that way.

 > > Here is the trimmed/streamlined version for 2.6 only:
 > > [Note I also made the sensor an optional input parameter that defaults
 > > to hwmon0 since that seems to be the most likely case for most users]
 > 
 > That's a good idea. That being said, systems with more than one
 > hardware monitoring device are becoming more popular.
....

 > > -if [ $# -ne 2 ]
 > > +if [ $# -lt 1 ]
 > 
 > Maybe test -gt 2 too, for completeness?

I rewrote the whole test thing for neatness and completeness (see below)

 > > +[ $2 ] && HWMON=$2
 > 
 > This usage of "test" isn't documented, so I'd rather avoid using it.
 > What about [ -n "$2" ] or [ $# -ge 2 ] instead?

OK. Changed and combined with first test for simplicity.

 > >  	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
 > 
 > Not related with your patch, but this list should be extended, we have
 > chips with up to temp6 and up to in10. Same for the fan list above, I
 > think we have up to fan7.

OK. But this would also require changing sens_day.cgi, sens_week.cgi,
summ_week.cgi.

Ideally, it would be great if the scripts would look at
/sys/class/hwmon/hwmonN/device/*input to see what the available inputs
are and then use that to determine what to store in and later retrieve
from the round robin database.

 
 > You need to reindent the whole block. I know it will make the patch
 > bigger, but badly indented code is unmaintainable.
Done. I re-tabified and (hopefully) properly indented all the code.
 
 > Patch looks good otherwise. Can you please update it and resubmit?
Here is the whole file:
NOTE: you may also need/want to update the copyright portion but I am
not sure what the right way to do it is...


#	 sens_update_rrd -
#	Update a sensors rrd database.
#	Sample usage:
#		sens_update_rrd /var/lib/database.rrd hwmon0
#	Sample cron entry:
#		*/5 * * * * /usr/local/bin/sens_update_rrd /var/lib/sensors-rrd/sensors.rrd hwmon0
#
#################################################################
#
#	 Copyright 2001,2005 Mark D. Studebaker <mdsxyz123@yahoo.com>
#
#	 This program is free software; you can redistribute it and/or modify
#	 it under the terms of the GNU General Public License as published by
#	 the Free Software Foundation; either version 2 of the License, or
#	 (at your option) any later version.
#
#	 This program is distributed in the hope that it will be useful,
#	 but WITHOUT ANY WARRANTY; without even the implied warranty of
#	 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	 GNU General Public License for more details.
#
#	 You should have received a copy of the GNU General Public License
#	 along with this program; if not, write to the Free Software
#	 Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#################################################################
#
if [ $# -lt 1 -o $# -gt 2 ] ; then
	echo "usage: $0 database.rrd [hwmonN]"
	exit 1
elif [ $# -eq 2 ] ; then
	HWMON=$2
else
	HWMON=hwmon0
fi
#
RRDPATH=/usr/bin
RRDB=$1

SENSDIR=/sys/class/hwmon
SENS=$SENSDIR/$HWMON/device

if [ ! -d $SENS ] ; then
	echo "No sensors found in: $SENS"
	echo "(modprobe sensor modules?)"
	exit 1
fi

STRING=N
#
# Get the value from these sensor files (/sys)
#
SENSORS="fan1 fan2 fan3"
for i in $SENSORS ; do
	V="`cat $SENS/${i}_input 2> /dev/null`"
	if [ $? -ne 0 ] ; then
		STRING="${STRING}:U"
	else
		STRING="${STRING}:${V}"
	fi
done
#
# Get the value from these sensor files (/sys) and divide by 1000
#
SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
for i in $SENSORS ; do
	V="`cat $SENS/${i}_input 2> /dev/null`"
	if [ $? -ne 0 ] ; then
		STRING="${STRING}:U"
	else
		V=`echo "3k0 ${V/-/_} 1000/p"|dc`
		STRING="${STRING}:${V}"
	fi
done

#
# Get the first value from these /proc files
#
SENSORS="loadavg"
for i in $SENSORS ; do
	V="`cat /proc/$i 2> /dev/null`"
	if [ $? -ne 0 ]; then
		STRING="${STRING}:U"
	else
		V="`echo $V | cut -d ' ' -f 1`"
		STRING="${STRING}:${V}"
	fi
done

$RRDPATH/rrdtool update $RRDB $STRING


 > >  > You mentioned that sensors.conf.5 was out-of-date, can you please send
 > >  > a patch for it too?
 > > 
 > > I'm not sure how to fix some of this since I'm not really sure what
 > > the 2.6 equivalent is, but here are the lines that need adjusting:
 > > 
 > > 1.	The  second and third arguments are the description texts. They must
 > > 	be exactly match the texts as they appear  in  /proc/bus/i2c,
 > > 	except for trailing  spaces, which are removed both from the /proc entries
 > > 	and the arguments.
 > > 
 > > 	[I don't know where you find the 'second and third argument'
 > > 	(which are the chip description) in 2.6 kernels]
 > > 
 > 
 > Which version of the man page are you looking at? I updated that
 > section in October 2006.
Hmmm. I am using version 2.10-1 which is an update released in early
January 2007 for Fedora Core 6. But it sounds like the FC6 sources
are lagging


 > > 2.	The  program  prog/config/grab_busses.sh in the source distribution
 > > 	can help you generate these lines.
 > > 
 > > 	[This program needs to be fixed for Kernel 2.6 -- I don't use it
 > > 	so I don't know exactly what it does or how to fix it]
 > 
 > It finds the current I2C buses numbers, and generates bus lines
 > suitable for sensors.conf. The idea is to run this script, copy the
 > output to sensors.conf, and use these bus numbers in the rest of the
 > configuration file. However, this is only needed if you have more than
 > one sensor chip of a given type *and* they need different
 > configurations - otherwise you simply give put the device name without
 > the bus number and address. So I guess that almost nobody needs this
 > script in practice, which explains why nobody ever complained that it
 > was broken for Linux 2.6. In fact the script is untouched since it was
 > created in December 1998!
 > 
 > So we have three options from here:
 > 1* Kill the script and let people who really need bus lines build them
 > by hand. We can point them to i2cdetect, or simply to the output of
 > sensors.
 > 2* Fix the grab_busses.sh script, probably by relying on "i2cdetect -l"
 > instead of /proc/bus/i2c.
 > 3* Move the functionality to libsensors, and add a sensors option.
 > 
 > I wonder what the others think. I don't like option 2 because it adds a
 > dependency from sensors stuff to i2cdetect, while I'd like to get
 > rid of this dependency. (Especially as i2cdetect itself depends on the
 > i2c-dev driver being loaded for 2.6 kernels - another thing we should
 > fix.) So I'd go for option 1 for now, and possibly implement option 3
 > later if users really insist.
 > 
 > > 3.  The chip descriptions are equal to those appearing in
 > >     /proc/sys/dev/sensors, but may contain the * wildcard.
 > > 
 > > 	[Again, I don't know where you find the chip descriptions in 2.6
 > > 	kernels]
 > 
 > The chip descriptions no longer appear anywhere verbatim with 2.6
 > kernels. You have to build them up from the "name" device attribute,
 > the bus type and the device ID. How the chip descriptions are built is
 > already described right after in the manual page, so the best and
 > easiest fix for this one is probably to just drop the outdated
 > reference to /proc/sys/dev/sensors.
 > 
 > > More generally, you may want to have someone who is more familiar with
 > > the 'lm_sensors' project to review the full man page since it seems like
 > > it hasn't been changed since Feb 1999.
 > 
 > Not true. This man page has been updated 7 times since then. But this
 > man page is large an it isn't easy to keep all the sections up-to-date.
 > 
OK. Probably explained by Fedora still being on 2.10.1 so I have an
old manpage. Sorry about any confusion.

 > I've made a complete review of the chip statement section, hopefully
 > it's better now:
 > http://lm-sensors.org/changeset/4370
 > 

One more thing. Perhaps this is covered in your updated manpages, but
in the ones I have, I could not find any reference to
/sys/class/hwmon/. Had I known about this, it probably would have
saved much of this thread since the whole problem I had initially was
due to the non-fixed numbering of the sensors in the
/sys/bus/i2c/devices tree. So, if this is not currently in the
manpages, it may be helpful to add.

Finally, I wonder whether long term, it pays to revisit some of the
programs in the prog branch to see if they are still needed and
relevant. Some seem to be hidden and underutilized jewels while others
may be redundant or even obsolete (like grab_busses.sh). For example,
it seems to me that the sens_update.rrd approach has a lot of overlap
with the rrd functionality embedded in sensord (which can even be used
to generate cgi files). I continue to use the cgi scripts in the rrd
directory since I like them better but it might be a good idea to
think of unifying them in the future. Again, I am just a newbie here
so I may be missing something...

Jeff


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
