From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 27 Mar 2008 13:44:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Fix I/O resource conflict
Message-Id: <20080327134412.GA767@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080309133428.56de6d25@hyperion.delvare>
In-Reply-To: <20080309133428.56de6d25@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-03-09 13:34:28 +0100]:
> Only request I/O ports 0x295-0x296 instead of the full I/O address
> range. This solves a conflict with PNP resources on a few motherboards.
> 
> Also request the I/O ports in two parts (4 low ports, 4 high ports)
> during device detection, otherwise the PNP resource makes the request
> (and thus the detection) fail.
> 
> This fixes lm-sensors ticket #2306:
> http://www.lm-sensors.org/ticket/2306
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Mark, this fixes a regression so this should go to Linus before 2.6.25
> final. This should also be backported to 2.6.24-stable (I'll take care.)
> 
> Note: I do agree that my fix is not universal and it is possible that
> some boards out there have a different PNP setup not covered by this
> fix. However it's hard to predict what the various BIOS do, and I also
> do not expect that many boards old enough to use a W83781D to declare
> it as a PNP device. So, my current position is to wait for further
> reports before updating the code again if needed.
> 
>  drivers/hwmon/w83781d.c |   21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

There is a special corner of hell reserved for authors of crappy BIOS.

I've applied this to my release tree, and I'll send it to Linus later
today (as a straight patch instead of pull request, if necessary).

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
