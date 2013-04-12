From: "BICHON, Quentin" <q-bichon@ti.com>
Date: Fri, 12 Apr 2013 16:48:22 +0000
Subject: Re: [lm-sensors] request for TMP432
Message-Id: <06BD56040955684AB7DB9D4C50FFEB7E119769@DNCE04.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
In-Reply-To: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Yes you can even though it just 'works' for now, maybe some problems will arise in the future...

Best,
Quentin


Texas Instruments Deutschland GmbH, Haggertystr. 1, D-85356 Freising. Amtsgericht M?nchen HRB 40960. Gesch?ftsf?hrer: Dr. Wolfram Tietscher. Vorsitzender des Aufsichtsrates: Edgar Frank

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]
Sent: Friday, April 12, 2013 5:34 PM
To: BICHON, Quentin
Cc: Jean Delvare; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] request for TMP432

On Fri, Apr 12, 2013 at 07:49:02AM +0000, BICHON, Quentin wrote:
> Hi,
>
> Thanks a lot for your help and updates and improvements !
> The driver is working fine so far. I will provide you with feedbacks if there are any issues.
>
Mind if I add a Tested-by tag to the patch ?

Thanks,
Guenter

> Best,
> Quentin
>
>
> Texas Instruments Deutschland GmbH, Haggertystr. 1, D-85356 Freising.
> Amtsgericht M?nchen HRB 40960. Gesch?ftsf?hrer: Dr. Wolfram Tietscher.
> Vorsitzender des Aufsichtsrates: Edgar Frank
>
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Thursday, April 11, 2013 3:48 PM
> To: Jean Delvare
> Cc: BICHON, Quentin; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] request for TMP432
>
> On Thu, Apr 11, 2013 at 10:36:19AM +0200, Jean Delvare wrote:
> > Hi Quentin,
> >
> > On Thu, 11 Apr 2013 08:15:10 +0000, BICHON, Quentin wrote:
> > > This stand-alone driver is very appreciated by the team, however they are using the following kernel version:
> > > Linux version 2.6.32.27-Cavium-Octeon And the code on the driver
> > > is apparently not compatible.
> > >
> > > Do you know if some minor changes could fix this?
> >
> > Most certainly yes. The same problem happens for every single driver
> > and so far I have always been able to add compatibility code to make
> > it work. For all i2c-related compatibility issues I have a separate
> > header file common to all the drivers I maintain. The latest version
> > can be seen at:
> >
> > http://khali.linux-fr.org/devel/misc/adt7410/i2c-compat.h
> >
> > So adding this file and the following line near the top of the
> > tmp401 driver should solve most issues:
> >
> > #include "i2c-compat.h"
> >
>
> Quentin,
>
> I added Jean's file (with some additions) to the repo, so all your engineers should have to do is to run "git update" and rebuild.
>
> > There may be a few remaining issues left, I'll leave them to Guenter.
> >
> > Quentin, your testing is very appreciated. Would you or someone in
> > your team also be able to review Guenter's patches? This would speed
> > up upstream integration.
> >
> Yes, that would be very helpful.
>
> Thanks,
> Guenter
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
