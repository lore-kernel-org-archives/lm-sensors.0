From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 25 Jul 2007 00:07:48 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241707v2fa06f4ana954f04293926be9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Bi cilly,


> Hi Juerg,
>
> > No prob. That's why I'm listed as the maintainer of the vt1211
> > driver :-)
>
> Yeah, I recognized already, had to patch my kernel with vt1211 before.
>
>
> > 11.49 is not unreasonable and 2.38V could just be due to tolerances of
> > the scaling resistors. I get the following readings on my M10000:
> >
> > vt1211-isa-6000
> > Adapter: ISA adapter
> > +3.3V:     +3.31 V  (min =3D  +0.00 V, max =3D  +4.42 V)
> > +2.5V:     +2.40 V  (min =3D  +0.00 V, max =3D  +3.16 V)
> > VCore:     +1.39 V  (min =3D  +0.00 V, max =3D  +2.63 V)
> > +5V:       +4.61 V  (min =3D  +0.00 V, max =3D  +6.31 V)
> > +12V:     +12.02 V  (min =3D  +0.00 V, max =3D +14.99 V)
> > +3.3V:     +3.23 V  (min =3D  +0.00 V, max =3D  +4.18 V)
> > Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 2)
> > CPU Fan:  4311 RPM  (min =3D    0 RPM, div =3D 2)
> > CPU Temp:  +46.3=B0C  (high =3D  +190=B0C, hyst =3D   -78=B0C)
> > Int Temp:  +59.0=B0C  (high =3D  +204=B0C, hyst =3D    +0=B0C)
> > vid:      +1.250 V  (VRM Version 8.5)
> >
> > You can see that my 2.5V is also low but I just measured it and it
> > reads 2.504V. So I guess we should modify the compute line.
> >
> > compute in1  @ * (1 + 2.4 / 10),  @ / (1 + 2.4 / 10)
> >
> > That results in 2.50V on my system, dead on! Looks like the boards use
> > a 2.4K instead of the VIA recommended 2K scaling resistor.
>
> may be a 2nd release of the board, or why would they use higher
> resistors?

Who knows? There are other things the VIA engineers did that I don't
understand. For example not implementing fan control on the M10000.


> > While we're at it, the 5V is also low. 4.66V on my system whereas the
> > voltmeter shows 5.02V. That compute line needs some fiddling too.
> >
> > compute in3  @ * (1 +  16 / 10),  @ / (1 +  16 / 10)
> >
> > Maybe one of these days I'll try to measure the actual values of the
> > scaling resistors but I'm too lazy right now :-)
>
> with your computing lines I get:
>
> vt1211-isa-6000
> Adapter: ISA adapter
> +3.3V:     +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +2.5V:     +2.46 V  (min =3D  +2.37 V, max =3D  +2.63 V)
> VCore:     +1.40 V  (min =3D  +1.35 V, max =3D  +1.44 V)
> +5V:       +5.05 V  (min =3D  +4.51 V, max =3D  +5.51 V)
> +12V:     +11.49 V  (min =3D +10.77 V, max =3D +13.21 V)
> +3.3V:     +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> Case Fan:    0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Fan:     0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Temp:  +44.4 =B0C  (high =3D   +85 =B0C, hyst =3D   +79 =B0C)
> Int Temp:  +60.0 =B0C  (high =3D   +65 =B0C, hyst =3D   +60 =B0C)
> vid:      +1.250 V  (VRM Version 8.5)

Looks pretty good.


> I am using PE 10000:
>
> http://www.via.com.tw/en/products/mainboards/motherboards.jsp?
> motherboard_idE1
>
> You may see, I am running it fanless Nehemiah C3 1 GHz, cooled
> passively with heatpipe:
>
> http://www.serener.com/pro_01.html

Uh-huh, very nice case!


> One final question, which line do you use to compute temp1:
>
>      compute temp1 (@ - 65) / 0.9686, (@ * 0.9686) + 65
>      #compute temp1  (@ - 83.869) / 0.9528,  (@ * 0.9528) + 83.869
>      #compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
>      ## i use a linear approximation of the via hw tool value->temp
> mapping table:
>      ## temp =3D (71.0/73.0)*x-72.41
>      #compute temp1 (@*71)/73-72.41, (@+72.41)*73/71

I'm using the default:
compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869

Even though it's for an Ezra and I don't really trust the readings. I
couldn't get an answer from VIA whether this is the correct
computation for the Nehemiah CPU or not.
A while ago, somebody wrote to the list about not being happy with the
default and investigating further. Maybe you can search the archives
and contact that person to figure out what he found out. Or there's
always the possibility of attaching a thermal probe to CPU case and
use the thermal resistance values in the Nehemiah datasheet to
correlate driver and voltmeter readings.

...juerg


> Regards,
>
> c.
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
