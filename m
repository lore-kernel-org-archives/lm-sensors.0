From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 14:44:32 +0000
Subject: Re: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <20140114154432.5942bb59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
In-Reply-To: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 14 Jan 2014 15:09:36 +0100, Andreas Hollmann wrote:
> Thanks for your quick response.
> 
> 
> Here is the requested output and if there is anything missing I willy reply as
> quick as possible.
> 
> [hollmann@inwest ~]$ ls -l /sys/devices/platform/coretemp.0
> total 0
> lrwxrwxrwx 1 root root    0 Jan 14 15:05 driver -> ../../../bus/platform/drivers/coretemp
> drwxr-xr-x 3 root root    0 Jan 10 18:51 hwmon
> -r--r--r-- 1 root root 4096 Jan 14 14:43 modalias
> -r--r--r-- 1 root root 4096 Jan 10 18:51 name
> drwxr-xr-x 2 root root    0 Jan 14 11:54 power
> lrwxrwxrwx 1 root root    0 Jan 10 18:51 subsystem -> ../../../bus/platform
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp10_crit_alar

We have a first bug here, apparently some buffer isn't large enough so
the dynamic attribute name doesn't fit. The (trivial) fix is in the
coretemp kernel driver, I'll send a patch in a minute.

> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_input
> -r--r--r-- 1 root root 4096 Jan 13 15:42 temp10_label
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_max
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp11_crit_alar
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_input
> -r--r--r-- 1 root root 4096 Jan 13 15:42 temp11_label
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_max
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp18_crit_alar
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_input
> -r--r--r-- 1 root root 4096 Jan 13 15:42 temp18_label
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_max
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp19_crit_alar
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_input
> -r--r--r-- 1 root root 4096 Jan 13 15:42 temp19_label
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_max
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp20_crit_alar
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_input
> -r--r--r-- 1 root root 4096 Jan 13 15:42 temp20_label
> -r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_max
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_crit_alar
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_input
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_label
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_max
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_crit
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_crit_alar
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_input
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_label
> -r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_max

Here's the second issue, these indexes are too high for libsensors,
which stops at temp23. We can raise the limit to cover this case (and
I'll probably do that as an immediate fix) but in the long run it would
be great to have it computed dynamically at run-time so that the
problem doesn't ever happen again.

Fixes are coming, stay tuned.

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
