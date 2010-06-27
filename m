From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Jun 2010 11:01:00 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100627130100.1a4aa524@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 27 Jun 2010 10:35:53 -0000, Lars Kr.Lundin wrote:
> On Fri, Jun 25, 2010 at 11:17:08AM +0200, Jean Delvare wrote:
> >
> > Can you please wait a bit in this screen and try to gather other sample
> > values for +12V? If you can gather 2 or 3 different samples, we may be
> > able to guess the scaling factor.
> >
> 
> > 2.62V in sensors for 11.776V in the BIOS suggests a scaling factor of
> > about 4.5. For something more accurate, we need more samples from both
> > the BIOS (see above) and the it87 driver. "sensors" only displays 2
> > decimal places, so better get the exact reading from sysfs directly:
> >
> > cat /sys/class/hwmon/hwmon*/device/in4_input
> >
> > If you can gather 2 or 3 samples of each, finding the scaling factor
> > should be reasonably easy.
> 
> Good idea. I temporarily modified /usr/sbin/fancontrol to log the in4
> to a file, so the values would be logged right before and after reboot,
> i.e. close in time to my BIOS readout.
> 
> The BIOS +12V readout changes in increments of 64mV and the in4 in
> increments of 16mV. The ratio between the values is exactly 4.

This is the standard scaling factor then. Alright.

> 
> > > (I wonder if this could have the slightest relevance, but my board is
> > > powered by a 200W PW-200-M from MINI-Box).
> >
> > Wow, this is cute :) Yes, this probably explains why your voltages are
> > rather below the average.
> 
> Thanks. :-)
> 
> Since my BIOS +12V was quite a bit below 12V, I took the opportunity to
> increase the voltage of my external 12V PSU, since this caused the +12V
> to increase. The new +12V and in4 voltages also have a ratio of exactly 4.
> 
> Unfortunately, the in4 readout seems to indicate that the voltage on the
> +12V rail of my PW-200-M drops when the CPU goes from idle to fully
> loaded. With a short, thick (load-speaker) cable between the PW-200-M
> and the external 12V PSU this drop is 128mV, with a longer, thinner
> cable this drop can exceed 600mV. :-(
> 
> But now I can at least monitor my +12V via LM sensors. :-)
> 
> > We can write the sensor chip drivers (and have done so for many
> > already: LM63, LM99 etc.) but the I2C access to these chips is the
> > graphics driver's job. Which are improving over time in this respect,
> > so it should work someday. I'm not actively working on this though
> > (probably due to the lack of nVidia card in my systems.)
> 
> OK, thanks for the info.
> 
> I have updated
> http://www.eso.org/~llundin/sff/sensors.conf
> with the complete voltage labeling + scaling.

I've updated the lm-sensors.org wiki copy.

> Many thanks for helping with this,
> -Lars Lundin.
> PS. I have one or two other mainboards. If I happen to find some new
> configuration info for them, what is the best way to provide that
> to the LM sensors project?

If you intend to become a regular contributor, we can create a wiki
account for you. If not, just keep posting your findings to the
discussion list and we'll take care.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
