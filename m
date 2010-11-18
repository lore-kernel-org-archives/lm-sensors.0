From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 18 Nov 2010 19:05:07 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <20101118190506.GC11832@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5595B.60300@RuggedCom.com>
In-Reply-To: <4CE5595B.60300@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 18, 2010 at 11:50:35AM -0500, Richard Retanubun wrote:
> On 11/18/10 11:22, Ira W. Snyder wrote:
> > On Thu, Nov 18, 2010 at 10:16:27AM -0500, Richard Retanubun wrote:
> >> Some bits in the fault register can be useful to differentiate
> >> between a planned reset (reboot) or an unplanned reset (pwr-loss).
> >> The EN bit can be used for this detection when a board's planned
> >> reboot action toggles the EN bit and cuts the regulated voltage
> >> (but keeping the hotswap device alive), meanwhile an unplanned
> >> reset (pwr-loss) will not have the EN bit set because even the
> >> hotswap device got powered off.
> >>
> >> So, before clearing the fault register at boot, dump the contents
> >> of the fault register so that other tools can use it as a forensic
> >> marker to differentiate events that preceeds this boot.
> >> ---
> >> Hi Ira and Jean,
> >>
> >> Not sure if there is a mailing list for hwmon, I did not see it,
> >> the MAINTAINERS file did not help, but git history shows that you two
> >> are the people who are working on this driver in the patch.
> >>
> Hi Ira,
> 
> Thanks for the speedy reply.
> 
> >
> > The mailing list you wanted was lm-sensors@lm-sensors.org.
> Thanks, was not sure, cc-ed now.
> >
> > As for the patch, I think it would be more likely to be accepted with a few changes:
> > - only print the register if certain bits are set
> > - don't print the hex value, print something meaningful
> Sure, but which bits? almost all of them means something to someone depending on how the chip is used.
> This is why I opted to a more "interpretation-neutral" hex-value.
> 
> I also chose "FReg" because some tools may catch the word "Fault" and flag this dump as something scary :)
> 
> I can do basic bit to string mapping using the register names,
> something like (GPIO3, GPIO2, FET, EN, PwrBad, OverCurrent, UnderVoltage, OverVoltage)
> in the case where all the bits are set, is this what you have in mind?
> 
> Also, another feedback I got was to not only print this at device_probe, but also
> save the initial value and display it as a device attribute exposed via sysfs,
> do you have any comments on this approach?
> 
> Btw, in your commit, you cleared the bits because of spurious bits being set at boot,
> does this observation pertain only to the [Over|Under][Current|Voltage] bits
> or does other bits also tends to be spurious? just curious.
> 

I just booted a board and checked: I only saw the "Undervoltage fault
occurred" bit set (the register value was 0x02).

The LTC4215_FAULT register isn't used by the Linux driver at all. How
about doing this instead:

Change the ltc4215_probe() routine to do a read-modify-write of the
LTC4215_FAULT register, like this:

s32 val;
val = i2c_smbus_read_byte_data(client, LTC4215_FAULT);
val &= 0xf0; /* clear spurious power-on faults */
i2c_smbus_write_byte_data(client, LTC4215_FAULT, val);

Since the ltc4215 driver doesn't use the LTC4215_FAULT register at all,
you can use userspace to read the value. Like this:
$ i2cget -f -y 0x0 0x44 3 b
0x00

Of course, you can do this with C code rather than using i2cget: look at
the i2cget source for an example. :)

Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
