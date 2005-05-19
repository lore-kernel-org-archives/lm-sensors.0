From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pc87360 sensor-driver results
Message-Id: <200405071250.i47Coi82027764@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>lm_sensors cvs 05/05/04 @ 6:00 pm
>
>Fan speeds are still problematic. I tried the isasets, but it didn't
>make any apparent difference.

OK... No more ideas at the moment.

>the in8 and in9 dumps are attached

Can't be. Both attached files are for in9.

>;after running
>isaset -f 0xecc0 3
>isaset -f 0xecc2 3
>will I need to set it back to the default setting? How would I do so, or
>will it not make a difference in testing the fans?

You do not need to, it's not a big change. If you want to, however, the
commands would be:

isaset -f 0xecc0 0
isaset -f 0xecc2 0

Thanks.
