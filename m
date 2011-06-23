From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Thu, 23 Jun 2011 10:50:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM95245 driver
Message-Id: <201106231250.38266.alexander.stein@systec-electronic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308649953-2774-1-git-send-email-alexander.stein@systec-electronic.com> <201106231114.52841.alexander.stein@systec-electronic.com> <20110623113316.6ab5a84e@endymion.delvare>
In-Reply-To: <20110623113316.6ab5a84e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: guenter.roeck@ericsson.com, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 23 June 2011 11:33:16 Jean Delvare wrote:
> On Thu, 23 Jun 2011 11:14:52 +0200, Alexander Stein wrote:
> > Well, I noticed that. But I went the way lm95241 does. I'm also unsure
> > which interval to choose, if user specify a unsupported interval. Choose
> > the next small or the next greater one? Maybe you can give me a hint
> > here.
> 
> BTW, is the LM95245 so incompatible that support couldn't be added to
> the lm95241 driver? If both devices are compatible to a reasonable
> degree, a single driver would be preferred.

Well, the register mapping is completly different. Also some configuration 
bits are merged and moved into other registers than in lm95241. I doubt there 
is much more compatibility than i2c transfers and temperature format (despite 
unsigned/unsigned).

Regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
