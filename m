From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 06 Jan 2012 03:33:34 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <20120106033334.GA11821@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Thu, Jan 05, 2012 at 04:23:56PM -0500, Frans Meulenbroeks wrote:
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
>  drivers/hwmon/adm1025.c   |    2 +-
>  drivers/hwmon/ds1621.c    |    6 +++---
>  drivers/hwmon/g760a.c     |    2 +-
>  drivers/hwmon/hwmon-vid.c |    2 +-
>  drivers/hwmon/lm78.c      |   10 +++++-----
>  drivers/hwmon/lm83.c      |    2 +-
>  drivers/hwmon/max1619.c   |    2 +-
>  drivers/hwmon/sis5595.c   |    4 ++--
>  drivers/hwmon/smsc47m1.c  |    2 +-
>  drivers/hwmon/w83627hf.c  |    2 +-
>  drivers/hwmon/w83l785ts.c |    2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)
> 
Your other patches are fine, but this one has checkpatch errors and warnings:

ERROR: code indent should use tabs where possible
#793: FILE: drivers/hwmon/hwmon-vid.c:122:
+^I^I                       1850 - val * 25;$

ERROR: code indent should use tabs where possible
#812: FILE: drivers/hwmon/hwmon-vid.c:137:
+^I^I                     2050 - (val) * 50;$

WARNING: please, no spaces at the start of a line
#1276: FILE: drivers/hwmon/ds1621.c:6:
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with$

WARNING: please, no spaces at the start of a line
#1300: FILE: drivers/hwmon/g760a.c:8:
+      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf$

total: 2 errors, 2 warnings, 607 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

While those were already there in the original files, it doesn't really help much
to only remove the spaces at the end of the line. And newly submitted patches should
not have any checkpatch errors or warnings.

I enqueued the other patches for one of the rc candidates.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
