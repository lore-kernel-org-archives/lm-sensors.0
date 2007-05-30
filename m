From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 30 May 2007 21:45:28 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <191fb4ca0705301445s32dcfeeer5b39bcad1986cdc9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Keith,

Make sure you have the ipmisensors and ipmi_msghandler modules
installed. Check if there are any entries under /sys/class/hwmon.
Check /var/log/messages, it should read something like the following
after loading the ipmisensors module:

May 30 14:37:54 clim1 kernel: ipmisensors - IPMI BMC sensors interface
May 30 14:37:54 clim1 kernel: ipmisensors: Registered IPMI 2.0 BMC
over interface 0
May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0xc0
May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0x8
May 30 14:37:54 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 1"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 2"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 3"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 4"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 5"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 6"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 7"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 8"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
an 9"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
sensor "Fan 10"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
sensor "Fan 11"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
sensor "Fan 12"
May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor "F=
ans"
May 30 14:37:55 clim1 kernel: ipmisensors: Skipping SDR type 0x8
May 30 14:37:55 clim1 kernel: ipmisensors: all sensors detected
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 27:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp1 "Temp =
6"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 26:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp2 "Temp =
5"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 25:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp3 "Temp =
4"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 24:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp4 "Temp =
3"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 23:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp5 "Temp =
2"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 22:
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0xc9; mask=3D0x00=
30)
May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp6 "Temp =
1"
May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
threshold for upper limit
May 30 14:37:55 clim1 kernel: ipmisensors: registered 6 temp, 0 volt,
0 current, 0 fan sensors


Running sensors works fine for me:

clim1:~# sensors
bmc-isa-0000
Adapter: ISA adapter
temp1:      +0.0=B0C  (high =3D    +7=B0C, hyst =3D    +0=B0C)
temp2:     +44.0=B0C  (high =3D    +6=B0C, hyst =3D    +0=B0C)
temp3:     +40.0=B0C  (high =3D    +6=B0C, hyst =3D    +0=B0C)
temp4:     +31.0=B0C  (high =3D   +10=B0C, hyst =3D    +0=B0C)
temp5:      +0.0=B0C  (high =3D   +10=B0C, hyst =3D    +0=B0C)
temp6:     +18.0=B0C  (high =3D    +4=B0C, hyst =3D    +0=B0C)


...juerg




On 5/30/07, Keith Romberg <romberg@ucar.edu> wrote:
> No one has any experience with these board or the sensors on it?  I was
> kind of hoping for something....
>
> Keith
>
> Keith Romberg wrote:
> > Hello,
> >
> > I have a Quad MP Xeon Intel SRSH4 system where the motherboard has
> > BMC/IPMI onboard sensors.  I would really like to be able to monitor the
> > sensors with lm_sensors.  The system is running FC6 with all the latest
> > versions including lm_sensors.  The kernel is 2.6.20 patched with the
> >
> > 'ipmisensors experimental'
> >
> > kernel patch from
> >
> > http://bmcsensors-26.sourceforge.net/
> >
> > Running sensors-detect find these sensors, but does not know about the
> > chips.
> >
> > - IPMI BMC KCS ( confidence 4, driver bmcsensors )
> > - ITE ( unknown chip with ID 0xee19 )
> > - PC8741x ( unknown chip with ID 0xee19 )
> > - SMSC ( unknown chip with ID 0xee19 )
> > - VIA/Winbond/Fintek ( unknown chip with ID 0xee19 )
> >
> > After loading all the modules it says to, running sensors gives the
> > classic message that no sensors where found.  Does anyone know if the
> > sensors and/or chips are supported or ever will be?
> >
> > I have also read that Xeon processors have an onboard temperature sensor
> > and that the xeontemp module could be used to read it.  Looking at my
> > kernel modules, I do not see it in the i2c directories or do I see an
> > option for it in the kernel config file.  How do I get that module?
> >
> > Thanks,
> > Keith
> >
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
