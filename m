From: Karl Schmidt <karl@xtronics.com>
Date: Fri, 04 Sep 2009 21:40:13 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA1893D.90005@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Karl,
> 
> 
> Alarms are computed by the chips in hardware. "sensors" merely reports
> what the driver tells it to, and the driver in turn merely reports the
> hardware state.

Let me make sure I have this correct - lm-sensor would then have to put a value
into a register in the hardware-sensor-chip and then the chip creates the alarm?

> It is interesting that you have two full-featured hardware monitoring
> chips in your system. I'm rather surprised, I admit.

I'm wondering if it is really just one chip - I tried commenting out one at a time to see if somehow 
appearing twice was the problem. I think it may be a host image due to incomplete hard ware encoding.


This is a Tyan S2865

In case there is something being misidentified I have the spec sheet link here:

ftp://ftp.tyan.com/datasheets/d_s2865_100.pdf


The lm-config from tyan has:

#To your etc/modules.conf file, add the lines:
# 	alias char-major-89 i2c-dev
#
# To your /etc/rc.xxx files, add the lines:
# 	modprobe i2c-nforce2
# 	modprobe lm85 force_emc6d100=0,0x2e
# sensors -s #
# Edited by: Raphael Deng <raphaeld@tyan.com> 03.28.05
#
# As LM-Sensors not support the SMSC DME1737 Chip, I use the SMSC
# EMC6D100 chip to instead of it and the sensor 3.3V StandBy and
# Battery Volt cannot be monitored.

They then use
chip "emc6d100-*"

But this was from 2005.. I don't think it is right for todays version??



--------------------------------------------------------------------------------
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

I can live for two months on a good compliment. -- Mark Twain

--------------------------------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
