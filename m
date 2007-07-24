From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 24 Jul 2007 22:52:31 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241552t20002089ofd8cf04a2908df88@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi cilly,


> On Jul 24, 2007, at 11:44 PM, Juerg Haefliger wrote:
>
> Hi Juerg,
>
> thanks a lot for your help!

No prob. That's why I'm listed as the maintainer of the vt1211 driver :-)


> > Please also reply to the list. Other people might be interested as
> > well.
>
> Yes, I realized it after sending, missing Reply-To-Header. So I
> resent it to the list, too.

Oh yeah, I didn't see that.


> > Yeah, 1.250V for VRM8.5 means that all the VID inputs read 0. I don't
> > think they are connected. On the other hand now the vid and VCore kind
> > of match :-) But VCore should really be 1.4V for a Nehemiah in an EBGA
> > package. The only way to confirm this is to hook up a voltmeter to the
> > Vcore voltage.
>
> VRM9.1 lists 1.850V so VID inputs read 0.

Correct.


> > Interesting, you don't have a 'compute in2' line (which is correct)
> > but the in2 voltage doesn't return 1.4V. So that leaves only two
> > conclusions:
> > 1) The reported Vcore of 1.22V is the correct value. If you do have a
> > voltmeter, please check.
>
> I do have an voltmeter, but I am not going to measure, since it
> really am afraid of killing the cpu of a short.

Sure, don't do it if you're not comfortable.


> > 2) There are scaling resistors on the Vcore input pin of the vt1211.
> > Assuming Vcore should be 1.4V, you can add the following compute line:
> >
> > compute in2  @ * (1 +  1.47 / 10),  @ / (1 +  1.47 / 10)
>
> Your computing line is working:
>
> vt1211-isa-6000
> Adapter: ISA adapter
> +3.3V:     +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +2.5V:     +2.38 V  (min =3D  +2.38 V, max =3D  +2.63 V)   ALARM
> VCore:     +1.40 V  (min =3D  +1.35 V, max =3D  +1.44 V)

Dead on!


> +5V:       +4.66 V  (min =3D  +4.51 V, max =3D  +5.49 V)
> +12V:     +11.49 V  (min =3D +10.77 V, max =3D +13.21 V)
> +3.3V:     +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> Case Fan:    0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Fan:     0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Temp:  +45.4 =B0C  (high =3D   +85 =B0C, hyst =3D   +79 =B0C)
> Int Temp:  +61.0 =B0C  (high =3D   +65 =B0C, hyst =3D   +60 =B0C)
> vid:      +1.250 V  (VRM Version 8.5)
>
> Now other voltages are computed correctly.
>
> Well, the values still might need some adjustments, since I can't
> believe, that 2.5V is 2.38 and 12V is 11.49. What do you think about it?

11.49 is not unreasonable and 2.38V could just be due to tolerances of
the scaling resistors. I get the following readings on my M10000:

vt1211-isa-6000
Adapter: ISA adapter
+3.3V:     +3.31 V  (min =3D  +0.00 V, max =3D  +4.42 V)
+2.5V:     +2.40 V  (min =3D  +0.00 V, max =3D  +3.16 V)
VCore:     +1.39 V  (min =3D  +0.00 V, max =3D  +2.63 V)
+5V:       +4.61 V  (min =3D  +0.00 V, max =3D  +6.31 V)
+12V:     +12.02 V  (min =3D  +0.00 V, max =3D +14.99 V)
+3.3V:     +3.23 V  (min =3D  +0.00 V, max =3D  +4.18 V)
Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Fan:  4311 RPM  (min =3D    0 RPM, div =3D 2)
CPU Temp:  +46.3=B0C  (high =3D  +190=B0C, hyst =3D   -78=B0C)
Int Temp:  +59.0=B0C  (high =3D  +204=B0C, hyst =3D    +0=B0C)
vid:      +1.250 V  (VRM Version 8.5)

You can see that my 2.5V is also low but I just measured it and it
reads 2.504V. So I guess we should modify the compute line.

compute in1  @ * (1 + 2.4 / 10),  @ / (1 + 2.4 / 10)

That results in 2.50V on my system, dead on! Looks like the boards use
a 2.4K instead of the VIA recommended 2K scaling resistor.

While we're at it, the 5V is also low. 4.66V on my system whereas the
voltmeter shows 5.02V. That compute line needs some fiddling too.

compute in3  @ * (1 +  16 / 10),  @ / (1 +  16 / 10)

Maybe one of these days I'll try to measure the actual values of the
scaling resistors but I'm too lazy right now :-)


...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
