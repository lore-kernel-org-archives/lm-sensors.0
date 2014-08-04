From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Aug 2014 16:17:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sis5595) Prevent overflow problem when writing large limits
Message-Id: <20140804161751.GA12852@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 31, 2014 at 10:27:04PM +0800, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip. Avoid auto-conversion from long to int to fix
> the problem.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
