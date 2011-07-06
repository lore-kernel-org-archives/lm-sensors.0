From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Jul 2011 16:41:12 +0000
Subject: Re: [lm-sensors] [PATCHv3 1/1] Hwmon: Add core_pkg Threshold
Message-Id: <20110706164112.GA6000@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Jul 06, 2011 at 04:30:20AM -0400, Jean Delvare wrote:
> On Wed, 6 Jul 2011 13:23:52 +0530, R, Durgadoss wrote:
> > Hi Guenter,
> > 
> > > This needs to be 127000, since val is in mill-degrees C.
> > 
> > Oops..I will fix this disaster :(
> > 
> > > I tested the patch on two systems (Sandy Bridge and Xeon C5528). On both,
> > > critical
> > > temperature and max temperatures are the same. tempX_max_hyst is 0 in both
> > > cases.
> > > Is this as expected ?
> > 
> > Yes. Initially, TempX_max is TjMax and TempX_max_hyst is 0.
> > i.e the lowest and highest temperatures. But the these tempX_max and max_hyst
> > can be programmed to reasonable values.
> > 
> > For example,
> > I am using an Atom based device.
> > Initially, max will be 90 and max_hyst will be 0.
> > Assume, my temp1_input is 65.
> > Then, I set the max to 70 and max_hyst to 60.
> > Then the HW will trigger an interrupt when the temperature drops below 60
> > Or crosses above 70. I forward it to some user space app, which takes some
> > actions. Thus, the whole idea of max and max_hyst is to 'do something'
> > so that CPU will not reach TjMax.
> > 
> > > It is possible to set tempX_max_hyst to a value >= tempX_max. Not sure if this
> > > makes sense.
> > 
> > Yes..The H/W will allow that. Even the manual says we can program like this,
> > but is not recommended. I can put a small check inside the store methods of
> > tempX_max and tempX_max_hyst. Is that Ok with you ?
> 
> Please don't. Other hwmon drivers don't have such checks, and they
> would prevent users from setting the limits in the order they want,
> depending on the initial values.
> 
On the other side, hysteresis is typically or at least often handled as offset,
meaning it is adjusted automatically if the associated limit changes. So I would
have thought it to be ok to validate that max_hyst < max, as long as max_hyst is 
adjusted automatically if max is changed.

> > > I can trigger max_alarm by setting the max temperature below the current
> > > temperature.
> > > However, I seem to be unable to reset the alarm flag; it looks like once it is
> > > set,
> > > it stays set forever. That may be because I am triggering the alarm by reducing
> > 
> > With the current implementation, it will stay set forever.
> > It's a sticky bit.
> 
> Then the driver has to clear the alarm bit after reporting it to
> user-space. Hopefully it will reassert immediately when cleared if the
> out-of-limit conditions still exist?
> 
> > > the max limit, but one should assume that the flag is reset once all limits
> > > are set to values above the current temperature. What is the expected behavior,
> > > and how can the alarm flag be reset ?
> > 
> > This is how it works:
> > [Bits 6,7,8,9 in 0x19C THERM_STATUS MSR]
> > Bits 6 and 8: Threshold 1 and 2 status bits
> > Bits 7 and 9: Threshold 1 and 2 log bits
> > Assuming, T1 is lower threshold and T2 is higher threshold
> > The Hardware generates interrupt on four conditions:
> > 1) temp1_input goes below T1 
> > 2) temp1_input goes above T1
> > 3) temp1_input goes below T2
> > 4) temp1_input goes above T2
> > 
> > When the temp1_input goes above Threshold 1, the corresponding
> > log bit(7) and the status bit(6) gets set(and an interrupt is generated).
> > When the temp1_input drops below Threshold 1, the status bit is reset to 0.
> > But the log bit is not(and an interrupt is generated again). So, We are supposed
> > to catch this interrupt and in the Interrupt handler 'set the log bit to 0'
> > manually.
> 
> It is OK for the coretemp driver to report once an alarm which happened
> in the past and is no longer relevant. But it is also OK to not do
> that. We have drivers doing both, depending on the underlying hardware
> implementation. But alarms should be cleared when read by the user, in
> both cases. If the hardware does it (most frequent case) then alright.
> If not, the driver should do it.
> 
Definitely. Wonder if it might be better to use bit 6 instead of bit 7.

> > And This Interrupt is forwarded to 'coretemp' from the MCheck Code(therm_throt.c)
> 
> Actually it's not. therm_throt indeed exports a platform_thermal_notify
> function pointer, but the coretemp driver never sets it.
> 
> The whole thing looks pretty clumsy to me anyway. Firtsly, I fail to
> see how this mechanism would be safe on removal of the coretemp driver.
> Secondly I don't see how you'll handle multi-core setups, as
> platform_thermal_notify doesn't pass the CPU as a parameter. And
> lastly, this seems to delegate thermal management to the coretemp
> driver, which is wrong by design, as the coretemp module might as well
> not be loaded.
> 
Yes, I start wondering about this as well. Does this functionality belong into 
coretemp to start with, or should it be implemented in the thermal driver instead ?

> > We can catch this interrupt inside our code and change the max_alarm.
> > But, more than that, what do we do with the interrupt ?
> 
> I don't think we want to deal with this interrupt in coretemp at all.
> This is all therm_throt's job.
> 
Agreed.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
