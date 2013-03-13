From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 00:05:09 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130313000509.GA9958@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363084727-2372-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1363084727-2372-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 11:38:45AM +0100, Lars-Peter Clausen wrote:
> Currently each time the temperature register is read the driver also reads the
> threshold and hysteresis registers. This increases the amount of I2C traffic and
> time needed to read the temperature by a factor of ~5. Neither the threshold nor
> the hysteresis change on their own, so once we have read them, we should be able
> to just use the cached value of the registers. This patch modifies the code
> accordingly and only reads the threshold and hysteresis registers once during
> probe.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Changes since v2:
> 	* Fix error the register address in the "Failed to read value" error message
> 	Otherwise I left the patch as it is hoping that the result of our discussion
> 	was that the problem outlined by Hartmut is more of a theoretical nature.

One possibility to at least partially address the concerns would be to load the
value cache from the update function if valid is false, and reset valid if there
was an i2c read error. I'll leave that up to you, though.

The patches took good to me. I'll queue all three for 3.10.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
