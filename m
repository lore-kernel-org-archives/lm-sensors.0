From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Apr 2013 16:40:14 +0000
Subject: Re: [lm-sensors] request for TMP432
Message-Id: <20130410164014.GA21127@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
In-Reply-To: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[ added the mailing list back to Cc: - it somehow got lost ]

On Wed, Apr 10, 2013 at 04:30:12PM +0000, BICHON, Quentin wrote:
> Ok, thanks for the answer again.
> Yes, I would be interested to have the stand-alone driver. I will forward that to the technical team interested by it and they may be able to give productive feedbacks as well.
> 
The stand-alone driver is now available at https://github.com/groeck/tmp401.

Thanks,
Guenter

> Thanks,
> Quentin
> 
> 
> Texas Instruments Deutschland GmbH, Haggertystr. 1, D-85356 Freising. Amtsgericht M?nchen HRB 40960. Gesch?ftsf?hrer: Dr. Wolfram Tietscher. Vorsitzender des Aufsichtsrates: Edgar Frank
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Wednesday, April 10, 2013 6:18 PM
> To: BICHON, Quentin
> Subject: Re: [lm-sensors] request for TMP432
> 
> On Wed, Apr 10, 2013 at 03:58:56PM +0000, BICHON, Quentin wrote:
> > Hi Guenter,
> >
> > Thank you for your answer.
> > So, if I understand correctly this is still a beta version? If I use the current version of the tmp401, will it be safe to use?
> 
> The current tmp401 driver won't work for TMP432. I can make it available as stand-alone driver on github if you are interested in testing it.
> 
> Yes, you could call it beta. I don't expect any problems with it, so it should be safe to use. Of course, one never knows.
> 
> > How long usually last the review feedback period?
> >
> Depends. If I get review feedback in a week or so, it might make it into the 3.10 kernel, otherwise I'll wait for 3.11.
> 
> Guenter
> 
> > Thanks,
> > Quentin
> >
> >
> > Texas Instruments Deutschland GmbH, Haggertystr. 1, D-85356 Freising.
> > Amtsgericht M?nchen HRB 40960. Gesch?ftsf?hrer: Dr. Wolfram Tietscher.
> > Vorsitzender des Aufsichtsrates: Edgar Frank
> >
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Sent: Wednesday, April 10, 2013 5:16 PM
> > To: BICHON, Quentin
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] request for TMP432
> >
> > On Wed, Apr 10, 2013 at 03:04:47PM +0000, BICHON, Quentin wrote:
> > > Hi,
> > >
> > > I am working for TI and I would be interested in a driver solution for the TMP432.
> > >
> > > I think we can help if needed providing samples for instance.
> > >
> > > Thank you,
> > > Best,
> > > Quentin
> > >
> > Hi Quentin,
> >
> > TI provided samples, so we are fine there.
> >
> > I already submitted a patch series[1], adding support for TMP432 to
> > the
> > tmp401 driver. I am waiting for review feedback right now, which is the more challenging part nowadays.
> >
> > Thanks,
> > Guenter
> >
> > [1] http://thread.gmane.org/gmane.linux.drivers.sensors/32191
> >
> >
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
