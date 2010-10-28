From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 15:10:32 +0000
Subject: Re: [lm-sensors] [patch 30/36 v2] hwmon: (w83795) Make
Message-Id: <20101028151032.GA4311@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 28, 2010 at 10:45:00AM -0400, Jean Delvare wrote:
> Cascaded conditionals are inefficient. Reorder the fields so that
> PWM register addresses can be computed more efficiently.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
