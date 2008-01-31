From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:42:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: VRM is not written to registers
Message-Id: <20080131134235.GH8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-01 11:25:33 +0100]:
> What was true of reading the VRM value is also true of writing it: not
> being a register value, it doesn't need hardware access, so we don't
> need a reference to the i2c client. This allows for a minor code
> cleanup. As gcc appears to be smart enough to simplify the generated
> code by itself, this cleanup only affects the source code, the
> generated binaries are unchanged.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/adm1025.c    |    3 +--
>  drivers/hwmon/asb100.c     |    6 ++----
>  drivers/hwmon/lm85.c       |    8 ++------
>  drivers/hwmon/lm87.c       |    3 +--
>  drivers/hwmon/smsc47m192.c |    3 +--
>  drivers/hwmon/w83791d.c    |    6 ++----
>  drivers/hwmon/w83793.c     |    8 ++------
>  7 files changed, 11 insertions(+), 26 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
