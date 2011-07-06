From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 06 Jul 2011 07:57:30 +0000
Subject: Re: [lm-sensors] [PATCHv3 1/1] Hwmon: Add core_pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E85BB718@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> This needs to be 127000, since val is in mill-degrees C.

Oops..I will fix this disaster :(

> I tested the patch on two systems (Sandy Bridge and Xeon C5528). On both,
> critical
> temperature and max temperatures are the same. tempX_max_hyst is 0 in both
> cases.
> Is this as expected ?

Yes. Initially, TempX_max is TjMax and TempX_max_hyst is 0.
i.e the lowest and highest temperatures. But the these tempX_max and max_hyst
can be programmed to reasonable values.

For example,
I am using an Atom based device.
Initially, max will be 90 and max_hyst will be 0.
Assume, my temp1_input is 65.
Then, I set the max to 70 and max_hyst to 60.
Then the HW will trigger an interrupt when the temperature drops below 60
Or crosses above 70. I forward it to some user space app, which takes some
actions. Thus, the whole idea of max and max_hyst is to 'do something'
so that CPU will not reach TjMax.

> It is possible to set tempX_max_hyst to a value >= tempX_max. Not sure if this
> makes sense.

Yes..The H/W will allow that. Even the manual says we can program like this,
but is not recommended. I can put a small check inside the store methods of
tempX_max and tempX_max_hyst. Is that Ok with you ?

> 
> I can trigger max_alarm by setting the max temperature below the current
> temperature.
> However, I seem to be unable to reset the alarm flag; it looks like once it is
> set,
> it stays set forever. That may be because I am triggering the alarm by reducing

With the current implementation, it will stay set forever.
It's a sticky bit.

> the max limit, but one should assume that the flag is reset once all limits
> are set to values above the current temperature. What is the expected behavior,
> and how can the alarm flag be reset ?

This is how it works:
[Bits 6,7,8,9 in 0x19C THERM_STATUS MSR]
Bits 6 and 8: Threshold 1 and 2 status bits
Bits 7 and 9: Threshold 1 and 2 log bits
Assuming, T1 is lower threshold and T2 is higher threshold
The Hardware generates interrupt on four conditions:
1) temp1_input goes below T1 
2) temp1_input goes above T1
3) temp1_input goes below T2
4) temp1_input goes above T2

When the temp1_input goes above Threshold 1, the corresponding
log bit(7) and the status bit(6) gets set(and an interrupt is generated).
When the temp1_input drops below Threshold 1, the status bit is reset to 0.
But the log bit is not(and an interrupt is generated again). So, We are supposed
to catch this interrupt and in the Interrupt handler 'set the log bit to 0'
manually.

And This Interrupt is forwarded to 'coretemp' from the MCheck Code(therm_throt.c)
We can catch this interrupt inside our code and change the max_alarm.
But, more than that, what do we do with the interrupt ?


Thanks,
Durga


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
