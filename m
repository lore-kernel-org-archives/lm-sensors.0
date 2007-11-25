From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:02 +0000
Subject: Re: [lm-sensors] hwmon/lm87: Add support for the Analog
Message-Id: <20071125015302.GB13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-09 15:22:22 +0200]:
> It happens that the Analog Devices ADM1024 is fully compatible with
> the National Semiconductor LM87, so support for the former can easily
> be added to the lm87 driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Steven, Murray, can you please test this patch and confirm that it
> works for you? I can also provide a standalone driver if it's easier
> for you to test. Thanks.
> 
>  Documentation/hwmon/lm87 |   11 ++++++++---
>  drivers/hwmon/Kconfig    |    4 ++--
>  drivers/hwmon/lm87.c     |   25 +++++++++++++++++++------
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
