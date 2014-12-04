From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 21:08:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <20141204210823.GA9986@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 04, 2014 at 12:16:29PM -0800, Robert Coulson wrote:
> Hello Guenter,
> 
> does it also make sense to include a check for the conf != 0 here (it
> should be set to 0 for POR from the datasheet)? Other than this
> quesiton/comment, the code looks fine to me.
> 
Hi Rob,

the configuration register could be set to a non-zero value,
for example by the BIOS or rommon. Sure, that is in theory possible
for the hysteresis and limit registers as well, but that would be
both unlikely and unreasonable.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
