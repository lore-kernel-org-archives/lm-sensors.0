From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Jun 2011 09:33:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM95245 driver
Message-Id: <20110623113316.6ab5a84e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308649953-2774-1-git-send-email-alexander.stein@systec-electronic.com>
	<1308770149.8271.600.camel@groeck-laptop>
	<201106231114.52841.alexander.stein@systec-electronic.com>
In-Reply-To: <201106231114.52841.alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: guenter.roeck@ericsson.com, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 23 Jun 2011 11:14:52 +0200, Alexander Stein wrote:
> Well, I noticed that. But I went the way lm95241 does. I'm also unsure which 
> interval to choose, if user specify a unsupported interval. Choose the next 
> small or the next greater one? Maybe you can give me a hint here.

BTW, is the LM95245 so incompatible that support couldn't be added to
the lm95241 driver? If both devices are compatible to a reasonable
degree, a single driver would be preferred.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
