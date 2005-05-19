From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Ticket #1376
Message-Id: <20030824102450.2f562ab3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Yes, sensors-detect has suggested it ... here is my /etc/modules
> (after running sensors-detect 2.8.0):
> 
> --- snip ---
> # I2C adapter drivers
> i2c-viapro
> i2c-isa
> 
> # I2C chip drivers
> adm1021
> eeprom
> w83781d
> --- snip ---
> 
> I don't know if viapro is used, but it's in the "i2c-core" list

The i2c-viapro module is used by the eeprom module. This is only useful
to read the SPD EEPROMs found on your memory modules, and I guess you
can live without it, so feel free to remove i2c-viapro and eeprom from
the list for faster operations.

Before you do that, however, I'm interested in the adm1021 problem. You
don't seem to have such a chip on your system, so I wonder why
sensors-detect told you to use it. Could you please provide a full log
of sensors-detect? Please unload all chip drivers (adm1021, eeprom,
w83781d) before running sensors-detect again.

I suspect you have an unsupported chip that has been misdetected as an
adm1021 clone.

> > Could you try writing to the files by yourself? For example, move to
> > /proc/sys/dev/sensors/w83697hf-isa-0290 and do:
> > echo "50 60" > temp1
> > Then read back the values from temp1. Does it work?
> 
> yes, it works!
> 
> # echo "30 40" > temp1
> # cat temp1
> 30.0 40.0 32.0
> # echo "50 60" > temp1
> # cat temp1
> 50.0 60.0 32.0

So the /proc interface isn't at fault here.

The two suspects left are: libsensors, and sensors itself. I'm not fully
qualified to track that kind of bug. I think that Philip Pokorny would
be much more that I am. In a similar case, he suggested to use "strace
-o /tmp/sensors.strace sensors -s". Maybe we can start with that.

Maybe the problem is that sensors drops its root priviledges at some
point. But I don't know why nor how it could do that. All I know is that
only Debian-system-based (or clones) users have reported the problem,
which is probably not a simpe coincidence. What's more, I think I
remember the i2c-isa module was in use each time. That too is probably
not a coincidence. What do Debian systems have particular, and what does
the i2c-isa module do that other bus drivers don't?


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
