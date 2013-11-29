From: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Date: Fri, 29 Nov 2013 08:00:04 +0000
Subject: Re: [lm-sensors] How can temp_crit for virtual device be set?
Message-Id: <CAKDaYSGGStNrVr+aupPSdzam48NedKMsBJ2-d8N2ShjxDjY5Hg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5297B848.4080906@gmail.com>
In-Reply-To: <5297B848.4080906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

OK, thanks for that clarification. Do you have a tip on how I could go
about to  set it through ACPI?

Who (which program/demon/whatever) is responsible for creating this virtual
device and its settings?


On Thu, Nov 28, 2013 at 11:05 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 28 Nov 2013 22:40:24 +0100, Thomas Mitterfellner wrote:
> > Hello!
> >
> > My laptop (toshiba satellite l770-116, Intel HM65 mainboard) shuts down
> > frequently when I run CPU intensive tasks. I guess (but I could not find
> > out for sure) that the temp1_crit setting of for the acpitz-virtual-0
> > device may be the culprit. It seems to me that a
> > pretty low value of 84=B0C is set here. This is the same value I see wh=
en
> > I do acpi -V (cf. output below). I noticed that sometimes (I haven't
> > found out under which circumstances) this value is set at 99=B0C, which
> > seems more reasonable to me as it corrensponds more closely to the value
> > shown for the physical devices (100=B0C), and allows for reasonable usa=
ge
> > of the laptop.
> >
> >
> > I tried adding these values:
> >
> > chip "acpitz-virtual-0"
> >   set temp1_crit 99.0
> >
> > To /etc/sensors.d/coretemp, but when doing sensor -s, I get:
> >
> > Error: File /etc/sensors.d/coretemp, line 3: Failed to set value
> > acpitz-virtual-0: At least one "set" statement failed
> >
> > So, how can I adjust the temp_crit1 value of the acpitz-virtual-0 devic=
e?
>
> You can't, thermal zones are read-only at least through the hwmon
> interface. If anything can be done, this is through ACPI.
>
> --
> Jean Delvare
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
