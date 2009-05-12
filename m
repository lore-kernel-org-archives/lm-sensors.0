From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 20:37:29 +0000
Subject: Re: [lm-sensors] Specific configurations - Gigabyte mainboard
Message-Id: <20090512223729.3bd23a90@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200905091227.09847.hka@qbs.com.pl>
In-Reply-To: <200905091227.09847.hka@qbs.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 15:56:48 +0200, Hubert Kario wrote:
> On Monday 11 May 2009 15:08:51 Jean Delvare wrote:
> > This is true of all (almost) motherboards out there. Still, we want to
> > present the inputs in a user-friendly way for users sticking to the
> > planned usage of the fan headers. Presumably, anyone able to diverge
> > from this will be able to adjust the configuration file accordingly.
> 
> I've seen somwhere an idea (probably in the archives) for lm-sensors to keep 
> very mainboard specific configurations for all mainbords and copy apropriate 
> config files to /etc/sensors.d depending on DMI values?

Yes, we have a long running plan like that.

> that's why I put there the exact same labels as the ones printed on the 
> mainboard. 
> 
> we could make the labels human readable and in comments before each of them 
> put the header label:
> 
> # CPU_FAN header 
> label fan1 "CPU Fan"
> # SYS_FAN2 header
> label fan2 "Sys Fan 2"
> # PWR_FAN header
> label fan3 "Power Fan"
> # SYS_FAN1 header
> label fan4 "Sys Fan 1"

Yes, this sounds reasonable.

> 
> > > >
> > > > >         label temp1 "Sys Temp"
> > > > >         label temp2 "Tcase Temp"
> > > >
> > > > Why "Tcase" and not just "Case"?
> > >
> > > because it's the Tcase temp of a CPU (temperature of an IHS)
> > >
> > > I bet "Case Temp" would be read as ambient temperature by most people
> > > (temperature inside the computer case), making it Tcase should clear the
> > > confusion, especially when after putting "tcase temp" to google one does
> > > recive "C2Q/C2D Temp Guide" as first result and "Tcase/Tjunction/Temp
> > > question" as second
> >
> > Ah, OK. Then why not just "CPU Temp"? This would be much clearer. It's
> > not like you have other CPU temperature sensors on the chip.
> 
> in every C2D are 3 temperature sensors, and in every Core 2 Quad a 5 ones:
> one Tcase - temperature of the CPU casing (which max temperature is published 
> by intel as the maximum safe operational temperature), this temperature is 
> read by the mainboard using a sensor inside CPU die,
> and Tjunction0, Tjunction1 for C2D and Tjunction0-4 for C2Q which is read 
> using coretemp driver by CPU itself ─ those sensors are inside each core's 
> hotspot and trigger emergency shutdown if CPU is overheating (usually around 
> 95-100°C), with highly overclocked CPUs the gradient between Tcase and 
> Tjunction can reach 8-9°C ─ so rather substantial
> 
> as such there's not one CPU temperature to measure but several, this one is 
> known as Tcase. 
> 
> oh, and one more thing - mobile CPUs don't have IHS, so they don't have Tcase, 
> if sensors report a CPU Temp (not the coretemp ones) it's completely external 
> to the CPU

Thanks for the detailed explanation. However my initial concern
remains. Obviously you are very knowledgeable when it comes to CPU
internals, but average PC users may not be. I pretty much doubt that
they will think "CPU" when reading "Tcore". For the average user, it
seems better, albeit technically less accurate, to label the Tcase
temperature as "CPU Temp" and coretemp temperatures as "CPU Core 0
Temp", "CPU Core 1 Temp", etc.

> > > BTW, I couldn't use "compute" with "Core 0" and "Core 1" labels (I wanted
> > > to calibrate my core temperatures)
> > > line:
> > >
> > >  compute "Core 0" @ +3, @ -3
> > >
> > > was completely ignored...
> >
> > Compute statements take symbolic names, not labels, as their first
> > parameter. Try:
> >
> >   compute temp1 @ +3, @ -3
> 
> but there are no labels defined for coretemp to change temp1 to "Core 0", i'm 
> confused...

Ah, I get it now. The coretemp driver is one of the few drivers
implementing kernel-provided labels. libsensors reads these labels from
sysfs and processes them even in the absence of configuration file.
Thus you never get to see the symbolic name for these entries, not even
with "sensors -c /dev/null". You can just guess that a single
temperature input would be "temp1", and check in sysfs.

I admit this could be improved, I'll post a proposal to the list right
now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
