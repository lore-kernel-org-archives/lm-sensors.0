From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 07 Sep 2007 03:01:04 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0709062001n3a54df8avdb72b14ef650ff24@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


> Hi Juerg,
>
> On Tue, 4 Sep 2007 11:54:20 -0700, Juerg Haefliger wrote:
> > > On Sun, 02 Sep 2007 14:57:32 +0200, Juergen Bausa wrote:
> > > > dme1737-i2c-0-2e
> > > > Adapter: SMBus nForce2 adapter at 4c00
> > > > V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> > > > Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > > > V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > > V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > > V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > > > V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > > Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > > Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > > > CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > > > CPU_Fan:     0 RPM  (min =3D    0 RPM)
> > > > ERROR: Can't get fan3 data!
> > > > ERROR: Can't get fan5 data!
> > > > ERROR: Can't get fan6 data!
> > > > CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> > > > ERROR: Can't get pwm5 data!
> > > > ERROR: Can't get pwm6 data!
> > > > cpu0_vid: +1.550 V  (VRM Version 2.4)
> > >
> > > Juerg, sensors shouldn't be displaying these errors for optional fans
> > > and pwms. Can you please provide a patch fixing this? It should be
> > > pretty easy.
> >
> > Hmm... An ignore statement would take care of this. Do you have
> > something else in mind?
>
> No, users shouldn't have to add ignore statements to hide these errors,
> the errors shouldn't be displayed in the first place. And as reported
> by Juergen, adding ignore statements doesn't even work in the case of
> the dme1737.
>
> We must rework the checks in the dme1737 printing functions to process
> the ignore statements properly, and to only display errors for missing
> features, not missing channels. I'm attaching the patch I have come up
> with. I can't test it as I do not have the hardware. Juergen, can you
> please test and report?
>
> Juerg, can you please review and test too?

Ok I'm officially confused now. Your patch only prevents error
messages if ignore statements are added. Is that the intended
behavior?


...juerg


> Admittedly this libsensors interface is confusing, the good news is
> that the future library handles the ignore statements all by itself so
> all these problems are gone :)
>
> --
> Jean Delvare
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
