From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Nov 2010 17:32:16 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <20101118173216.GA6694@ericsson.com>
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
I can not comment on ltc4215 behavior, but ltc4261 tends to have alarm bits
set after boot. To display that would simply add noise and not provide any value.
If the ltc4215 does the same, adding the log message would only (and unnecessarily)
cause users to be concerned. This in turn would subject the mailing list, and thus 
the maintainers, to e-mails such as "I get this message during boot, is this
a problem ?".

I don't like the proposed change, unless someone can convince me that it adds value
and not just noise (and maybe volunteers to forever reply to the resulting e-mails).

> Thanks again for your time.
> 
> - Richard
> 
> > FYI, the reason the register is cleared is to avoid displaying power-on
> > faults to the user. Would it be more useful to clear all bits except the
> > EN bit?
> >

So the EN bit changed state, which might just mean that the chip was enabled at some point
in the past. What would be the value of displaying that information ?
If you want to do anything, you might consider displaying the _current_ EN state
if the chip is disabled, or maybe not even instantiate the driver in the first place
if that is the case.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
