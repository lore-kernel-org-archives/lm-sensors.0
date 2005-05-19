From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <423601CD.8080702@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

no, I'm just slow.
Here are some suggestions. Some of them you may already know about.
Of course you may have gotten different advice from Jean, (not that unusual), let us know if so and
we'll talk about it :)
None of these are critical and of course these are things we can work on ourselves too if you don't have time.

1) alarms
    The module does not export an 'alarms' entry in /proc, and to generate the ALARM indication in sensors/chips.c
    it simply does a comparison to min/max values. This is undesirable and not according to our standard.
    Reading and exporting the bits in the alarms registers (0x41,0x42,0x9b) is much preferred because the chip
    latches the alarms between reads. See the other winbond drivers and corresponding support in sensors/chips.c for examples.

2) subclient registration
    The module should register the  'subclients' (the two emulated lm75 chips) so that other drivers do not claim them.
    You can copy this code from w83781d.c

3) fan speeds in /proc
     Sometimes the fan speeds in /proc are large negative numbers:
	w83792d-i2c-1-2d/fan1
	187 -556712672
	w83792d-i2c-1-2d/fan2
	100 0
	w83792d-i2c-1-2d/fan3
	1695 3835
	w83792d-i2c-1-2d/fan4
	6000 0
	w83792d-i2c-1-2d/fan5
	12857 0
	w83792d-i2c-1-2d/fan6
	6783 0
	w83792d-i2c-1-2d/fan7
	-1 -556712672
      I think it's because you don't always set a value to results[1] in w83792d_fan(). There are several
       if-then-else cases where no value is set.

4) a documentation file for doc/chips would be greatly appreciated :)



Huang0@Winbond.com.tw wrote:
> Dear MDS
> 
> 
>>Reviewed, briefly tested (forcing driver on a w83782d chip) and
> 
> checked in to
> 
>>CVS.
>>I'll have some comments and test results in a follow-up email.
> 
> 
> I have NOT received your test results, Did you send it? I'm afraid of it
> getting
> lost.
> 
> Thanks
> Best Regards
> Chunhao
