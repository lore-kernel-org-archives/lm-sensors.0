From: "Ger vermeulen" <geve002@casema.nl>
Date: Tue, 05 Jun 2012 21:38:31 +0000
Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgUKFAAAQAAAASqq+MtO/REiR9DlN9oxJ4gEAAAAA@casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Guenter Roeck
> Sent: Tuesday, 05 June, 2012 23:22
> To: Ger vermeulen
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces
> wrong values with lm-sensors 3.3.2
> 
> On Tue, Jun 05, 2012 at 05:05:23PM -0400, Ger vermeulen wrote:
> >
> >
> > > -----Original Message-----
> > > From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> > > sensors.org] On Behalf Of Guenter Roeck
> > > Sent: Tuesday, 05 June, 2012 22:34
> > > To: geve002@casema.nl
> > > Cc: lm-sensors@lm-sensors.org
> > > Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces
> > > wrong values with lm-sensors 3.3.2
> > >
> > > On Tue, 2012-06-05 at 15:10 -0400, Ger vermeulen wrote:
> > >
> > > [ ... ]
> > >
> > > >
> > > > The workaround you suggested to change the tjmax is not possible for
> my
> > > > coretemp.ko unknown symbol.
> > > >
> > > Not sure I understand. What command do you execute, and what exactly
> is
> > > the output ?
> > >
> > > > So a work around can be adding to /etc/sensors3.conf
> > > >
> > > > chip "coretemp-isa-0000"
> > > >      label temp1 "Core0"
> > > >      compute temp1 @+35,@-35
> > > >
> > > > chip "coretemp-isa-0001"
> > > >      label temp1 "Core1"
> > > >      compute temp1 @+35,@-35
> > > >
> > > > Is this correct?
> > > >
> > > It shows you the correct temperature. So, yes, it is one way to solve
> > > the problem. Do you really need the "label" line ?
> > >
> > > Thanks,
> > > Guenter
> > >
> > >
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
> >
> >
> > root@atom:~# insmod
> > /lib/modules/2.6.37.6-smp/kernel/drivers/hwmon/coretemp.ko tjmax5
> > insmod: error inserting
> > '/lib/modules/2.6.37.6-smp/kernel/drivers/hwmon/coretemp.ko': -1 Unknown
> > symbol in module
> >
> Try "modprobe coretemp force_tjmax5" instead.
> 
> Guenter
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

root@atom:/etc# modprobe coretemp force_tjmax5
FATAL: Error inserting coretemp
(/lib/modules/2.6.37.6-smp/kernel/drivers/hwmon/coretemp.ko): Unknown symbol
in module, or unknown parameter (see dmesg)

Thanks, Ger


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
