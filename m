From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Nov 2012 12:07:29 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (it87) Support PECI for additional chips
Message-Id: <20121103130729.2bbf651d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 30 Oct 2012 13:20:40 -0700, Guenter Roeck wrote:
> Extend support for reporting and selecting PECI temperature sensors
> to IT8718, IT8720, IT8782, and IT8783. For IT8721, report the sensor
> type for temp2 as Intel PECI (6) if the chip is configured to report
> the PCH temperature.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Untested, so this one deserved extra scrutiny if accepted.

I got it tested by one IT8720F user, successfully.

> 
>  drivers/hwmon/it87.c |   48 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> (...)

The code looks good, I can't see any problem with it. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
