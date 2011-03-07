From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Mar 2011 18:19:37 +0000
Subject: Re: [lm-sensors] tempX_source sysfs attribute needed ?
Message-Id: <20110307191937.5c62b2d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208171026.GE13717@ericsson.com>
In-Reply-To: <20110208171026.GE13717@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Mar 2011 09:58:51 -0800, Guenter Roeck wrote:
> Speaking about NCT6775F/NCT6776F - did you follow the fan debounce discussion ?

No, I did not.

> I advocated using a module parameter there, but your response above seems 
> to suggest that this may not be the way to go (I still prefer it, though).
> Other options would be a non-standard sysfs attribute or to always enable it.
> It would help to get your input on this.

This isn't an I2C device/driver, and you can assume a single instance
on a given system, so module parameters are just fine if they solve
your problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
