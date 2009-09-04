From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Sep 2009 15:17:01 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090904171701.1decd339@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karl,

Please keep the list Cc'd.

On Thu, 03 Sep 2009 23:05:38 -0500, Karl Schmidt wrote:
> Jean Delvare wrote:
> 
> > 
> > This will dump all the device registers. I will then check against the
> > datasheet and see if I spot anything.
> 
> I don't think this is a hardware problem - the readings make sense - where is it that the levels are 
> compared to the set statements? This used to work on this computer until there was an upgrade to -- 
> I think version 3... Unless they are ignoring the set statements - thinking the chip will generate 
> all alarms?

Alarms are computed by the chips in hardware. "sensors" merely reports
what the driver tells it to, and the driver in turn merely reports the
hardware state.

> 
> I have a different machine - different sensors - same version of software and it works.
> 
> I was trying things and listed out the working modules - if that might help:
> 
> lsmod |grep dme
> dme1737                43168  0
> hwmon_vid               7296  2 dme1737,lm85
> i2c_core               27936  4 dme1737,eeprom,lm85,i2c_nforce2
> 
> I tired loading different permutations of the modules - nothing seems to work.
> 
> 
> I tried purging the lm-sensors package and reinstalling... no joy?????

It is interesting that you have two full-featured hardware monitoring
chips in your system. I'm rather surprised, I admit.

I'll look at the dump you sent when I have a moment, but I have a lot
of work these days, so please be patient.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
