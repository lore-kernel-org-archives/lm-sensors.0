From: steffen.grunewald@aei.mpg.de (Steffen Grunewald)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1326
Message-Id: <3F13A65E.1060606@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C658B79.5020609@dipsy.dhs.org>
In-Reply-To: <3C658B79.5020609@dipsy.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

on rounding again...
below /proc/sys/dev/sensors/(chip_id), there are values with two decimal 
positions only, which are already rounded down.
I'm using the w83781d driver here, but I cannot find where those values 
are written (a search for '.2f' didn't yield anything
useful - probably things are done lower-level).
Perhaps the general solution would be to write out full mV values (%.3f) 
so that sensors.c can round them itself.
Do you think that can be done easily?
If I only knew where /proc/sys/dev/sensors/as99127f/in* are written, I'd 
go and try myself without bothering you :-(

Cheers,
 Steffen
