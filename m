From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2012 12:34:05 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121023143405.1f6fbf71@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Oct 2012 14:08:10 +0200, Harald Judt wrote:
> Am 23.10.2012 13:45, schrieb Jean Delvare:
> > It is very frequent that the BIOS doesn't display the values for all
> > available sensors. This is a vendor decision, there's nothing we can or
> > should do.
> 
> It's not about being displayed, I meant that there could be a 
> relationship between the values shown in the BIOS and the values set by 
> the BIOS. That is, VBAT is not displayed in the BIOS and is 0 after 
> resuming. The other values are reported in the BIOS (I'd have to check 
> that again now just to be sure) and get set at boot and after resume too 
> (at least that's the assumption).

The fact is that on these chips, all inputs are always monitored except
Vbat, temp2 and temp3. And temp2 and temp3 are monitored by default. So
no active step is needed in the BIOS to get all the values they are
displaying.

> So maybe the BIOS engineers simply 
> didn't care about that value or forgot about it. But never mind, that's 
> just speculation and doesn't help either, as long as it can be dealt 
> with in the module.

You are prefectly right, the BIOS doesn't bother enabling Vbat
monitoring because it does not display the Vbat value anyway. The
driver enables Vbat monitoring because it does display the value, but
forgets to re-enable it at resume. This is one of the things we must
fix.

> > I'm working on my test system now. It has a different chip (W83627THF)
> > supported by a different driver (w83627hf) but the logic should be very
> > similar. When I'm done with my case, I'll post my results and do the
> > same for the w83627ehf driver.
> 
> Thanks, I'd be very interested in your suspend/resume code (learn 
> something new). May I assume you have the same problem (at least with 
> min/max) values then?

I had never tried suspending this specific machine, I'm only using it
to test and fix the w83627hf driver. Yes, some (curiously not all)
limits go wrong on resume, but that's not the only register values
which are lost. I suspect the rest is mainly BIOS bugs, where the
hardware monitoring chip configuration done by the BIOS at boot time is
not replayed at resume time, while it should. As I don't expect it to
be fixed in the BIOS on that 2005 machine, we'll have to work around it
in the driver I suppose.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
