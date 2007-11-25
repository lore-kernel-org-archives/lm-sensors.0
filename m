From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:54:07 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (gl520sm) Put
Message-Id: <20071125015407.GO13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-04 23:44:52 +0100]:
> This allows for some code refactoring, making the binary slightly
> smaller. This is also required to use dynamic sysfs callbacks for
> voltage and temperature files.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl520sm.c |  104 ++++++++++++++++++-----------------------------
>  1 file changed, 40 insertions(+), 64 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
