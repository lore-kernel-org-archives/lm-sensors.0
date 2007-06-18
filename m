From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 18 Jun 2007 15:12:19 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <191fb4ca0706180812n4c2359a4y7fb8486af87e3720@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 6/18/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg, hi Simon,
>
> On Fri, 15 Jun 2007 09:08:59 -0700, Juerg Haefliger wrote:
> > On 6/15/07, Simon Farnsworth <simon.farnsworth@onelan.co.uk> wrote:
> > > Juerg Haefliger wrote:
> > > > Simon,
> > > >
> > > > If you feel adventurous, you can add device ID 0x85 to the smsc47b3=
97
> > > > driver which also supports the sch5037 chip. You'd have to modify it
> > > > as follows:
> > > >
> > > > static int __init smsc47b397_find(unsigned short *addr)
> > > > {
> > > >        u8 id, rev;
> > > >
> > > >        superio_enter();
> > > >        id =3D superio_inb(SUPERIO_REG_DEVID);
> > > >
> > > > -        if ((id !=3D 0x6f) && (id !=3D 0x81)) {
> > > > +        if ((id !=3D 0x6f) && (id !=3D 0x81) && (id !=3D 0x85)) {
> > > >                superio_exit();
> > > >                return -ENODEV;
> > > >        }
> > > >
> > > Did this, and the chip is found, but the numbers I get back look wron=
g:
> > >
> > > dmesg output from the module:
> > > smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 2)
> > >
> > > sensors output:
> > >
> > > # sensors
> > > smsc47b397-isa-0480
> > > Adapter: ISA adapter
> > > temp1:       +44=B0C
> > > temp2:       +53=B0C
> > > temp3:       +26=B0C
> > > temp4:      -128=B0C
> > > fan1:     2011 RPM
> > > fan2:       82 RPM
> > > fan3:     1262 RPM
> > > fan4:     1095 RPM
> >
> > Well I think that looks pretty good.
>
> I agree it looks quite good. temp4 and fan2 are probably not connected,
> thus the wrong values, but the 6 other values look just fine.
>
> > > temp1 and temp2 both look likely for CPU, while temp3 might well be
> > > system temperature. temp4 is completely out, and I'm not sure how I'd
> > > relate the fan speeds to the fans in the system (I have a fan in the
> > > front, a CPU fan, and a fan in the PSU.
> >
> > Run some stress tests like 'stress' or 'cpuburn-in' to correlate temps
> > to CPUs. Are the fans automatically adjusted? If yes, this should also
> > tell you which one is the CPU fan, assuming it spins up under load.
> > Alternatively, you can unplug one fan at a time to correlate the
> > physical reality to the readings.
>
> So it looks like we could easily add support for this chip. Juerg, can
> you please take care of it? Pick list:
>
> * patch for sensors-detect
> * patch for the smsc47b397 driver
> * update Devices in the wiki

Will do.

...juerg


> Thanks,
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
