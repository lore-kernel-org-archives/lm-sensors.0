From: Harald Judt <h.judt@gmx.at>
Date: Tue, 23 Oct 2012 12:08:10 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <508688AA.2090607@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 23.10.2012 13:45, schrieb Jean Delvare:
> On Tue, 23 Oct 2012 11:57:41 +0200, Harald Judt wrote:
>> Am 23.10.2012 09:14, schrieb Jean Delvare:
>>> Reloading the module shouldn't help for limits, they are set by
>>> user-space. Reloading the lm_sensors service instead should help.
>>
>> Actually that's what I did. Why the need to reload the service after
>> suspend? Restarting the service causes some user applications to crash
>> (yes maybe they should be fixed so that doesn't happen).
>
> The key issue with service reloading is that it will reload (some of)
> the hwmon drivers, which it turn causes hwmon devices to disappear and
> reappear in sysfs. libsensors doesn't notice so it can't tell the
> applications. If we want to be able to handle that kind of cases
> properly we need to let libsensors monitor this and notify the
> applications.
>
> The fact that this isn't supported at the moment certainly speaks in
> favor of adding proper suspend/resume to the affected drivers rather
> than blindly reloading the lm_sensors service after resume.

I agree. Suspend/resume support is always a good idea.

>>> Vbat is indeed enabled by the driver at device bind time, as well as a
>>> few other things. In your case you report battery monitoring missing,
>>> but other settings may be broken, for example temperature monitoring
>>> could be stuck or overall monitoring could be disabled. Do all values
>>> (other than Vbat) change as before? The exact effects really depend on
>>> what the BIOS is doing to the chip at boot time and resume time.
>>
>> All values except the ones mentioned are being reported correctly after
>> resuming.
>
> OK. This might depend on the board though. But we can start with your
> particular case, and improve on top of that.
>
>>> I've been pondering this for a long time. Adding support for limit
>>> saving and restoring to all hwmon drivers would be a significant amount
>>> of code. An easier workaround would be to run "sensors -s" after
>>> resume. This is what I had suggested here:
>>>     https://bugzilla.novell.com/show_bug.cgi?idX0988#c3
>>
>> I will try this and see if it helps. However, the min/max values or
>> alarms are not something I use on my desktop, so I don't care very much
>> if they don't work. In other environments, they will be much more
>> important I guess.
>
> Really depends on who is monitoring and for what reasons. Also depends
> if the wrong limits trigger alarms, which in turn may trigger all sort
> of (software or hardware) events.

Yes, if you rely on that then things can indeed get problematic.

> The workaround won't work completely for you anyway, as running
> "sensors -s" won't get your Vbat reading back. We will have to do it
> explicitly in the driver's resume function.
>
> More generally, my first tests suggest that saving and restoring the
> "Value RAM" is neither required (all values read from the sensors are
> useless) nor sufficient (there are other register values which get
> lost.) Some register values are reverted to their default values, which
> suggests these registers are as volatile as the "Value RAM". Other
> values change arbitrarily, suggesting that the BIOS is explicitly
> setting them to different values at resume time.
>
> If we want to be able to deal with all chips and all BIOS bugs, there's
> a lot of work ahead.
>
>> (...)
>> Maybe people don't notice or care too if _some_ values are missing.
>> Especially when those values are not vital. CPU temp, fan speeds etc ok,
>> but how many typical users monitor the VBAT voltage?
>
> Actually everyone should, a dead batter can have very bad consequences.

It is a very reliable way for CMOS clear.

>> The VBAT voltage is not shown in BIOS, while other values are. Maybe the
>> BIOS is at fault here, and the problem needs to be tackled there.
>
> It is very frequent that the BIOS doesn't display the values for all
> available sensors. This is a vendor decision, there's nothing we can or
> should do.

It's not about being displayed, I meant that there could be a 
relationship between the values shown in the BIOS and the values set by 
the BIOS. That is, VBAT is not displayed in the BIOS and is 0 after 
resuming. The other values are reported in the BIOS (I'd have to check 
that again now just to be sure) and get set at boot and after resume too 
(at least that's the assumption). So maybe the BIOS engineers simply 
didn't care about that value or forgot about it. But never mind, that's 
just speculation and doesn't help either, as long as it can be dealt 
with in the module.

> I'm working on my test system now. It has a different chip (W83627THF)
> supported by a different driver (w83627hf) but the logic should be very
> similar. When I'm done with my case, I'll post my results and do the
> same for the w83627ehf driver.

Thanks, I'd be very interested in your suspend/resume code (learn 
something new). May I assume you have the same problem (at least with 
min/max) values then?

Harald

-- 
`Experience is the best teacher.'

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
