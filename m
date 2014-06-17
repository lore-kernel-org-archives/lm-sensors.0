From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Jun 2014 10:34:55 +0000
Subject: Re: [lm-sensors] [PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages
Message-Id: <53A019CF.1000401@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E9BC5E534B6C564CA4B01BC388FD1B5A34410C6A@SGSIMBX007.nsn-intra.net>
In-Reply-To: <E9BC5E534B6C564CA4B01BC388FD1B5A34410C6A@SGSIMBX007.nsn-intra.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/17/2014 12:16 AM, Zhu, Richard (NSN - CN/Beijing) wrote:
> Hi All,
>
> When I was trouble shooting the TI power manager chip TPS40422, I found that the kernel pmbus driver (pmbus.c) was not trying to detect the temperature sensors other than page 0 for pmbus devices, so the temp2_input file couldn't be seen in sysfs. So I made a patch file to trying to solve the problem. Please help to review my findings, and to see if the patch can go to the upstream.
>
>
> The following content is the content of the patch file:
> [PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages
>
> For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
> page 1 of the chip, but the original driver only tried to detect this command on
> page 0, this will lead to a result that the temperature sensor in page 1 couldn't
> be detected. This change is finding the temperature sensors on all pages to solve
> the problem.
>
Problem is that many pmbus devices don't implement paged temperature sensors.
While this works for the TPS40422, it would result in duplicate detection for
many other chips with unpaged sensors. Which means we'll need a separate front-end
driver for this chip.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
