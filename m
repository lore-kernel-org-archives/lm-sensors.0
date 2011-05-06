From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 06 May 2011 13:44:36 +0000
Subject: Re: [lm-sensors] [[PATCH 1/2] hwmon: (max6650) Drop device detection
Message-Id: <20110506134436.GA20118@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110506133338.4df4dc58@endymion.delvare>
In-Reply-To: <20110506133338.4df4dc58@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 06, 2011 at 07:33:38AM -0400, Jean Delvare wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: (max6650) Drop device detection
> 
> MAX6650 device detection is unreliable, we got reports of false
> positives. We now have many ways to let users instantiate the devices
> explicitly, so unreliable detection should be dropped.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: "Hans J. Koch" <hjk@hansjkoch.de>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
