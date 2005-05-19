From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: LM_Sensors with 2.5.75+ kernels
Message-Id: <20030920220246.GB17127@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Ben Rockwood <benr@cuddletech.com> [2003-09-16 17:43:36 -0700]:
> 
> Hello.
> 
>  I'm currently using LM_Sensors with Kernel 2.5.75 (I can upgrade to
>  2.6.0pre's if needbe) but am confused by the temp readings.Here's what I see:
> 
> [benr@nexus6 0-002d]$ grep "" temp_input*
> temp_input1:6900
> temp_input2:6650
> temp_input3:6800
> [benr@nexus6 0-002d]$ pwd
> /sys/bus/i2c/devices/0-002d
> [benr@nexus6 0-002d]$ cat name
> W83782D chip
> 
> In the kernel documentation almost every file except temp_input was
> described as being divisable by 1000, so I guess this means my tempsare 6.9deg for the board, and 6.6deg for CPU0 and 6.8 for CPU1.
> This obviously isn't right.

FYI there is a patch that fixes some voltage conversion troubles here;
it hasn't made it to Linus yet though:

http://marc.theaimsgroup.com/?l=linux-kernel&m6262291731729&w=3

Nothing else that I can see since 2.5.75.

> How do I read these values?  And are they in F or C?  I know the temps
> can't be 69C, etc, my system isn't running that hot.  I'm using a Tyan
> Thunder K7 with dual 1.2G AMD AthlonMPs.

The temp_input? files are milli-degrees C.  This is a "raw" driver value
which may need further adjustment in userspace.  If you've ever used sensors
with kernel 2.4 in the past, check /etc/sensors.conf to see what that
conversion might be.  The userspace library is not ready for 2.6, sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
