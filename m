From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Apr 2011 08:02:25 +0000
Subject: Re: [lm-sensors] ITE IT8721F, IT8758E it87 standalone driver report
Message-Id: <20110409100225.3abaf56e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2610648201.20110407001722@mail.ru>
In-Reply-To: <2610648201.20110407001722@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 8 Apr 2011 22:06:48 +0400, Rebel wrote:
> Hello, Jean.
> 
> You wrote:
> 
> >> +5.00V 4.988V
> >> +12.0V 11.816V
> 
> > For these two, we would need more values from the BIOS to conclude, as
> > we have 4 candidates (in0, in1, in2 and in6.)
> 
> More values? But there is no more values in my BIOS.

I mean more samples for a given values. Often monitored values
oscillate between two or three values. On some systems you have to
leave and re-enter the monitoring screen in the BIOS to get new values,
but most of them update the values every second automatically.

> > This is simply not possible. "sensors" reads the configuration files
> > again each time to run it.
> 
> I  don't know how it can be, but before running sensors3 at first time,
> /etc/sensors.d was an empty folder, but now there is it8721.conf wich
> holds data i put into /etc/sensors.conf

Either you live in the 4th dimension, or your distribution has extra
code doing that kind of magic. The code at lm-sensors.org doesn't do
anything like this.

> > Not sure what you did exactly, but /etc/sensors.conf is not used by
> > lm-sensors 3.x if /etc/sensors3.conf is present. /etc/sensors3.conf is
> > always checked first, to make it possible to have both lm-sensors 2 and
> > lm-sensors 3 installed on a given machine (although nobody should be
> > doing this any longer.)
> 
> Here is the log of my actions:
> -   i  have  removed   old   sensors2 (apt-get remove lm-sensors) but may be
> Ubuntu hasn't deleted the old config file.
> -  i  compiled  new sensors from sources and run it without parameters
> (the output was temp1 fan1 and so on)
> - in /etc/sensors.conf i put my chip and some labels
> -  run  newly  built sensors with config /etc/srnsors.conf
> "sensors  -c  /etc/sensors.conf"  and output was with correct labels i
> put in /etc/sensors.conf
> -  i  have  deleted my chip and labesls from /etc/srnsors.conf and run
> sensors again without config, output was correct with my labels
> 
> I  think,  when  i run sensors with edited config /etc/sensors.conf it
> creates file in /etc/sensors.d. Is it right?

Our code doesn't do this, no. Your Linux distribution, maybe, but this
is the first time I hear of this.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
