From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 19:46:28 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (lm90) Add support for
Message-Id: <1286394388.9690.80.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, 2010-10-06 at 12:07 -0400, Jean Delvare wrote:
> Hi Guenter,
[ ... ]

> Why not just:
> 
> 	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS;
> 	     i < data->max_convrate;
> 	     i++, update_interval >>= 1)
> 		if (interval >= update_interval * 3 / 4)
> 			break;
> 
> The result is the same as far as I can see, and you avoid an arbitrary
> constant.
> 
> Note that your algorithm always rounds interval down, even when the
> closest integer would be up. Proper rounding would need a different
> algorithm to avoid accumulating rounding errors, I think.
> 
> As it stands, requesting a 21 ms update interval will lead to a 31.250
> ms update interval (register value 0x9), reported as 31 ms through
> sysfs, while it should preferably lead to a 15.625 ms update interval
> (register value 0xa), currently reported as 15 ms but ideally reported
> as 16 ms: this is a 7.375 ms error instead of a 8.250 ms error. You may
> decide this is unimportant though, I leave it up to you.
> 
Found a simple solution: Shift interval and update_interval to the left
by three bits. That avoids the rounding error.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
