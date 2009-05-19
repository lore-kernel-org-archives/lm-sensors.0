From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 May 2009 21:11:33 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.29.3 1/1] hwmon: added support for the
Message-Id: <20090519231133.21247f05@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 May 2009 22:52:01 +0200, Christian Engelmayer wrote:
> > Extending the supported alarms would be fine, although I would not aggregate
> > them all under one sysfs file, just make a gpio#_alarm sysfs file, and make
> > the presence of this file conditional on the configuration of the gpio pins.
> 
> > Would that work for you ?
> 
> It would.
> 
> I suggested combining the status into a single file because that file name
> is already supported. In case an extension is accptable and for further
> clarification I would suggest the following:
> 
> device alarm         | alarm file
> ---------------------+------------------
> gpio 2 pulled low    | gpio2_alarm
> gpio 1 pulled low    | gpio1_alarm
> Tachometer overflow  | fan1_tach_alarm
> Minimum output level | fan1_min_alarm
> Maximum output level | fan1_max_alarm
> 
> All 5 sources can be enabled independently with POR 'all disabled'.
> The first 2 sources make only sense depending on the gpio definitions,
> while the other 3 would be provided just by the chip itself.

I think tachometer overflow would be better mapped to fan1_fault.

> After the previous discussion I would then leave the setup of the gpios
> and the enabling of appropriate alarm sources completely to the firmware.
> The driver shall discover the alarms enabled by the firmware at startup
> and use that information as a condition for adding the alarm files as shown
> above for enabled alarms.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
