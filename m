From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Wed, 12 Dec 2012 15:14:30 +0000
Subject: Re: [lm-sensors] Fried CPU?
Message-Id: <201212121514.qBCFEUe8026422@mx1.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201212101840.qBAIe73K013644@mx1.lsn.net>
In-Reply-To: <201212101840.qBAIe73K013644@mx1.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, December 12, 2012 7:35 AM
> To: Leslie Rhorer
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Fried CPU?
> 
> Hi Leslie,
> 
> On Tue, 11 Dec 2012 09:51:52 -0600, Leslie Rhorer wrote:
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > > On Mon, 10 Dec 2012 12:40:07 -0600, Leslie Rhorer wrote:
> > > > reported a correct temperature to the BIOS, but that `sensors` is
> > > > reporting garbage.
> > >
> > > Even more so when using the asus_atk0110 driver, which gets its
> > > readings straight from the BIOS.
> >
> > I don't understand what you mean.  What is even more so?
> 
> I meant that I share your skepticism with regards to temperature values
> being reported properly in the BIOS and improperly in Linux, because
> asus_atk0110 isn't a native driver but an ACPI driver. It doesn't read
> the values from the hardware directly, instead it asks the ACPI BIOS
> for them. So the very same BIOS code supposedly provides the BIOS
> values and the Linux values as far as monitoring is concerned.

OK.

> > > > (...)
> > > > I did run the `sensors-detect` command prior to shutting the
> > > > system down in order to check something.
> > >
> > > When did you do that exactly? sensors-detect is known to have caused
> > > serious trouble on a small number of systems, but given the history of
> > > your system this doesn't seem like the prime suspect for your specific
> > > problem.
> >
> > It was run just prior to swapping out the solid state cooling for the
> liquid
> > cooing when the replacement arrived.
> >
> > > What motherboard is this?
> >
> > Asus Crosshair II Formula
> 
> Nobody else reported to us using that motherboard.
> 
> > > Which version of lm-sensors or sensors-detect did you use?
> >
> > 1:3.1.2-6
> 
> OK. This is a bit old but as far as I can see all known SMBus detection
> issues were already fixed in this version. This makes me believe it is
> unlikely that sensors-detect caused the issues you're seeing. This
> could still be the case if Asus used some overclocking chip connected
> to the SMBus and behaving differently from every other chip we've seen
> before.
> 
> In the event this is really what happened, here is the recommended
> procedure which did help some users in the past (no guarantee of
> course):
> * Power off the machine, switch the PSU off, unplug from the wall
>   outlet.
> * Remove the backup battery, clear the CMOS.
> * Wait for 10 minutes.
> * Put the backup battery back, plug, switch on.
> * Load the BIOS defaults.

Actually, I had to do just that to get the machine to boot prior to sending
out my last message, but while the machine did boot afterwards, it was still
sending out a bogus value for the CPU temp.  It has been stable for the last
couple of days, though.

> But then again the most likely is that your CPU got partly damaged
> while the pump was dead.

Yeah, that seems to be the case.  Damn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
