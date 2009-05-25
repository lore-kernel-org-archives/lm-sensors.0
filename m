From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 May 2009 13:46:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: Updated documentation on alarms
Message-Id: <20090525154624.7b683104@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3103@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3103@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 May 2009 19:30:20 +0200, Hans de Goede wrote:
> 
> 
> On 05/21/2009 11:57 PM, Engelmayer Christian wrote:
> > From: Christian Engelmayer<christian.engelmayer@frequentis.com>
> >
> > Added gpio channel alarm and fan limit alarm 'max_alarm' to the alarm
> > section.
> >
> 
> Not sure if we should mention the gpio alarms in the sysfs docs as they
> are a bit non standard,
> 
> Jean ?

I agree. GPIOs don't have anything to do with hardware monitoring, we
don't want to document that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
