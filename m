From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:57:25 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (asb100) Add individual alarm
Message-Id: <20080131135725.GL8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103232424.103f2346@hyperion.delvare>
In-Reply-To: <20080103232424.103f2346@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:24:24 +0100]:
> The new libsensors needs these individual alarm files.
> 
> I did not create alarm files for in5 and in6 as these alarms are documented
> as not working.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
>  drivers/hwmon/asb100.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
