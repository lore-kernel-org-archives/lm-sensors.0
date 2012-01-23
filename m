From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jan 2012 17:29:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for G781
Message-Id: <20120123182948.5f218c60@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327335989-10214-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327335989-10214-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 09:24:13 -0800, Guenter Roeck wrote:
> On Mon, 2012-01-23 at 12:08 -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Mon, 23 Jan 2012 08:26:29 -0800, Guenter Roeck wrote:
> > > GMT G781 is a ADM1032-compatible temperature sensor chip.
> > > Add support to the LM90 driver.
> > > 
> > > Cc: Mike Gorchak <lestat@i.com.ua>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > v2:
> > > - Drop device ID 0x03, since its existence is not confirmed.
> > >   Instead, accept device ID 0x01 on both 0x4c and 0x4d.
> > > - Drop referring to G781-1; we don't do that for other chips either,
> > >   and it is not clear if it is even possible to distinguish G781 from G781-1.
> > > - Add G781 information to Kconfig, lm90 documentation
> > > - Mention G781 support in lm90.c file comments
> > > - Modify formatting to better match file formatting
> > > 
> > >  Documentation/hwmon/lm90 |    5 +++++
> > >  drivers/hwmon/Kconfig    |    3 ++-
> > >  drivers/hwmon/lm90.c     |   19 ++++++++++++++++++-
> > >  3 files changed, 25 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
> > > index 9cd14cfe..d8f1e66 100644
> > > --- a/Documentation/hwmon/lm90
> > > +++ b/Documentation/hwmon/lm90
> > > @@ -118,6 +118,11 @@ Supported chips:
> > >      Addresses scanned: I2C 0x48 through 0x4F
> > >      Datasheet: Publicly available at NXP website
> > >                 http://ics.nxp.com/products/interface/datasheet/sa56004x.pdf
> > > +  * GMT G781
> > > +    Prefix: 'g781'
> > > +    Addresses scanned: I2C 0x4c, 0x4d
> > > +    Datasheet: Publicly available, for example from
> > > +    		http://www.datasheetarchive.com/G781-datasheet.html
> > 
> > Not sure if we really want to document the availability from a 3rd
> > party site. There may be legal concerns. If the datasheet isn't
> > publicly available for download from the vendor, it might have been
> > obtained under NDA in the first place.
> > 
> > It probably doesn't add much value anyway... I guess it was found by
> > googling, the reader can do the same.
> > 
> I agree; lets drop it. Wasn't sure about that myself. Want me to
> resubmit ?

No need to resubmit.

> > All the rest looks good, so:
> > 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Let me know if you want me to pick this in my tree as the maintainer of
> > the lm90 driver.
> > 
> Your call; I also have the multi-line comment patch pending for it. I
> would suggest either you take both patches, or I do. I am fine either
> way.

I'll take them both. Easier that way, if more lm90 patches come I'll be
the one to review them anyway.

Mike, please test this new patch and confirm it works OK for you.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
