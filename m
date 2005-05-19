From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Setting vrm with 'sensors -s' is broken (w/ Linux 2.6.x)
Message-Id: <20040407035157.GD6289@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi...

The problem is in the last 8 lines of lib/proc.c:

> /* give up, use old name (probably won't work though...) */
> /* known to be the same:
>         "alarms", "beep_enable", "vrm", "fan%d_div"
> */
>         strcpy(sysname, name);
>         *sysmag = (feature->scaling=0?0:3);
>         return 0;
> }

Oops, feature->scaling for VRM is 1!  That explains why 'sensors -s'
tries to write "9000" to vrm instead of "90" under Linux 2.6.x.

Anyone know what that '=0?0:3' qualification is *supposed* to do?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
