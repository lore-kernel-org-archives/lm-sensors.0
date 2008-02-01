From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 03:07:27 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm80) De-macro the
Message-Id: <20080201030727.GR8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-05 15:37:05 +0100]:
> Use standard dynamic sysfs callbacks instead of macro-generated
> functions. This makes the code more readable, and the binary smaller
> (by about 34%).
> 
> As a side note, another benefit of this type of cleanup is that they
> shrink the build time. For example, this cleanup saves about 29% of
> the lm80 driver build time.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Tested using i2c-stub.
> 
>  drivers/hwmon/lm80.c |  245 ++++++++++++++++++++++----------------------------
>  1 file changed, 111 insertions(+), 134 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
