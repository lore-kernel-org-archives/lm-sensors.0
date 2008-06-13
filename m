From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jun 2008 20:59:17 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: (lm90) Enhancements for ADT7461
Message-Id: <20080613225917.3a318145@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213374973-3262-1-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213374973-3262-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Fri, 13 Jun 2008 11:36:11 -0500, Nate Case wrote:
> These changes enable extended mode operation for the ADT7461 which will
> allow temperature readings from -64..191 degC instead of the current
> limited range of 0..127 degC.  I decided to split up the changes so
> that the first patch doesn't affect functionality, but just makes
> preparations needed to make the second patch easier to follow.

Thanks for splitting the changes that way, it will make reviewing them
much easier. I'll do that over the week-end, stay tuned.

Could you possibly provide a dump of an ADT7461 chip in extended mode?
You can obtain it with i2cdump (part of the i2c-tools package). This
will help me test your changes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
