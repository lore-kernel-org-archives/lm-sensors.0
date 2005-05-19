From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <4236FAF4.8070302@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Huang0@Winbond.com.tw wrote:
> Hi MDS
> 
> Thank you for your suggestion. The following is my reply.
> 
> 
>>1) alarms
>>    The module does not export an 'alarms' entry in /proc, and to
> 
> generate the
> 
>>ALARM indication in sensors/chips.c
>>    it simply does a comparison to min/max values. This is undesirable
> 
> and not
> 
>>according to our standard.
>>    Reading and exporting the bits in the alarms registers
> 
> (0x41,0x42,0x9b)
> 
>>is much preferred because the chip
>>    latches the alarms between reads. See the other winbond drivers
> 
> and
> 
>>corresponding support in sensors/chips.c for examples.
> 
> 
> Yes, I can catch your meaning :-)
> The method I use is of "software-level", while the other drivers in
> lm_sensors
> use the "hardware-level" method. I finish it with the reference to our
> Windows
> driver, it does NOT use the registers CR[0x41], CR[0x42], CR[0x9b]
> either, and can work well.
> Do you suggest that I change my method into yours? If do, I will modify
> it when
> I'm a little free, because besides porting 792 driver into linux-2.6,
> I'm busy
> attending another job about smart card. And you may also modify it for
> me if
> you have time. :-)
> 
> 

yes, "hardware-level" is much better, for the reasons I mentioned above.
please change it when you have time.

> 
>>2) subclient registration
>>    The module should register the  'subclients' (the two emulated
> 
> lm75 chips)
> 
>>so that other drivers do not claim them.
>>    You can copy this code from w83781d.c
> 
> 
> I noticed the subclient registration when I started to write 792 driver,
> I'm not
> familiar with subclient and sent lm_sensors group a mail for your
> introduction
> about it about several month ago, but do not receive any response.
> Since I'm not familiar with it, I discard it just like the other chip
> drivers:
> lm90.c and lm83.c, finding it can work well.
> 
> 

Since I am familiar  with the subclient registration,
I will make those changes in CVS.

> 
>>3) fan speeds in /proc
>>     Sometimes the fan speeds in /proc are large negative numbers:
>>	w83792d-i2c-1-2d/fan1
>>	187 -556712672
>>	w83792d-i2c-1-2d/fan2
>>	100 0
>>	w83792d-i2c-1-2d/fan3
>>	1695 3835
>>	w83792d-i2c-1-2d/fan4
>>	6000 0
>>	w83792d-i2c-1-2d/fan5
>>	12857 0
>>	w83792d-i2c-1-2d/fan6
>>	6783 0
>>	w83792d-i2c-1-2d/fan7
>>	-1 -556712672
>>      I think it's because you don't always set a value to results[1]
> 
> in
> 
>>w83792d_fan(). There are several
>>       if-then-else cases where no value is set.
> 
> 
> Hm...I think this phenomenon appear when the fan divisor modifying
> itself
> in the "do...while (0)" loop in w83792d_fan(), Once the fan divisor
> reaches
> a reasonable after some time, it will disappear. Maybe there is some bug
> in
> this function, I will debug it in the near future.
> 
> 

the do..while(0) "loop" only "loops" once, of course. Is that what you meant do do?
I don't have a real 792d, I am testing the driver by forcing on a 782d.
But results[1] should always be set.

> 
>>4) a documentation file for doc/chips would be greatly appreciated :)
> 
> 
> Yes, you are right, I will send you the document when I finish it in the
> future.
> 
> 

great.
