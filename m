From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Sep 2010 18:11:28 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: some optimisations
Message-Id: <20100909201128.3840431b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284052336-25864-1-git-send-email-shubhrajyoti@ti.com>
	<20100909175537.GA16681@ericsson.com>
In-Reply-To: <20100909175537.GA16681@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 9 Sep 2010 10:55:37 -0700, Guenter Roeck wrote:
> General comments:
> 
> - Please select a more descriptive headline, such as
> 	hwmon: lm75: Add __devinit and __devexit section initializers
> 
> - It is useful to provide the patch version to reduce confusion and enable
>   version tracking.
>   Example:
> 	[PATCH v3] hwmon: lm75: Add __devinit and __devexit section initializers
> 
> - Please cc linux-kernel@vger.kernel.org and Jean Delvare <khali@linux-fr.org>.

Please do NOT CC linux-kernel@vger.kernel.org. We have a mailing list
dedicated to hardware monitoring, there's no point to add to the 200,000
messages (literally) LKML gets every year. The more messages a list
gets, the fewer readers it has.

As for CC'ing me, it doesn't hurt, but doesn't make a difference either,
as I read the lm-sensors list carefully anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
