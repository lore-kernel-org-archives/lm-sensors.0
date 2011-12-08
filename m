From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 14:20:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: jz4740: fix signedness bug
Message-Id: <20111208142052.GA8163@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323349452.2823.1.camel@phoenix>
In-Reply-To: <1323349452.2823.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Dec 08, 2011 at 08:04:12AM -0500, Axel Lin wrote:
> wait_for_completion_interruptible_timeout() may return negative value.
> In this case, checking if (t > 0)  will return true if t is unsigned.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
