From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 07 Jul 2007 20:51:43 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: detect more SMSC chips
Message-Id: <191fb4ca0707071351i58eefba4rb656ab79bf71af7f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707050932w43ccb9fbub40e4b3098a71f36@mail.gmail.com>
In-Reply-To: <191fb4ca0707050932w43ccb9fbub40e4b3098a71f36@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


On 7/7/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Thu, 5 Jul 2007 09:32:06 -0700, Juerg Haefliger wrote:
> > This patch adds more known SMSC Super IO chips to sensors-detect.
>
> Wow, this is a long list. I'm curious where you got it.

By collecting datasheets from the web and running sensors-detect and
opening up computers at work :-)


> > --- lm-sensors.orig/prog/detect/sensors-detect        2007-07-05 08:07:30.332663000 -0700
> > +++ lm-sensors/prog/detect/sensors-detect     2007-07-05 09:15:28.194801000 -0700
> > @@ -1770,6 +1770,76 @@ use vars qw(@chip_kern24_ids @chip_kern2
> >       driver => "via-smbus-only",
> >       devid => 0x77,
> >        },
> > +      {
> > +     name => "SMSC FDC37B72x Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x4c,
> > +      },
> > +      {
> > +     name => "SMSC FDC37B78x Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x44,
> > +      },
> > +      {
> > +     name => "SMSC FDC37C672 Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x40,
> > +      },
> > +      {
> > +     name => "SMSC FDC37M707 Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x42,
> > +      },
> > +      {
> > +     name => "SMSC FDC37M81x Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x4d,
> > +      },
>
> Are you sure these use the standard register map? All the other SMSC
> FDC* chips use the flat SMSC-specific mapping.

I'm pretty sure that's correct. Not all of the FDC chips use the flat
mapping but I'll double-check.


> > +      {
> > +     name => "SMSC LPC47B34x Super IO",
> > +     driver => "not-a-sensor",
> > +     devid => 0x56,
> > +      },
> > +      {
> > +     name => "SMSC LPC47B357 Super IO",
> > +     # no datasheet
> > +     devid => 0x5d,
> > +      },
> > +      {
> > +     name => "SMSC LPC47B37x Super IO",
> > +     driver => "to-be-written",
> > +     devid => 0x52,
>
> That's not OK. For "to-be-written", you need to give the logical device
> number for the hardware monitoring function.

Oh, right. I was under the impression it defaults back to 0xa if not specified.


> BTW, we usually append
> "Sensors" (or "Fan Sensors", etc...) to the name for Super-I/O chips
> with sensors functions.

OK, will do.


> > +      },
> > +      {
> > +     name => "SMSC LPC47N252 Super IO",
> > +     driver => "to-be-written",
> > +     devid => 0x0e,
> > +      },
> > +      {
> > +     name => "SMSC LPC47U33x Super IO",
> > +     driver => "to-be-written",
> > +     devid => 0x54,
> > +      },
> > +      {
> > +     name => "SMSC SCH3112 Super IO",
> > +     driver => "dme1737",
> > +     devid => 0x7c,
> > +      },
> > +      {
> > +     name => "SMSC SCH3114 Super IO",
> > +     driver => "dme1737",
> > +     devid => 0x7d,
> > +      },
> > +      {
> > +     name => "SMSC SCH3116 Super IO",
> > +     driver => "dme1737",
> > +     devid => 0x7f,
> > +      },
> > +      {
> > +     name => "SMSC SCH4307 Super IO",
> > +     driver => "to-be-written",
> > +     devid => 0x90,
> > +      },
> >      ],
> >      # Non-standard SMSC detection callback and chip list. These chips differ
> >      # from the standard ones listed above in that the device ID register
>
> I am also worried that the SMSC chip list starts being quite long and
> it's easy to add duplicates without noticing. It would be better if the
> list was consistently sorted by either name or devid.

True, I'll sort the list by chip name.

...juerg


> Thanks,
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
