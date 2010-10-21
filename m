From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Thu, 21 Oct 2010 07:55:25 +0000
Subject: Re: [lm-sensors] help with module k10temp
Message-Id: <1468.75.142.173.238.1287647725.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010210630.31285.envite@rolamasao.org>
In-Reply-To: <201010210630.31285.envite@rolamasao.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Hello all:
>
> Firstly, thanks for lm-sensors
>
> Secondly, please CC me since I'm not on the list
>
> My problem is that I have a new computer, and running sensors-detect says:
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no):
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           Success!
>     (driver `k10temp')
> AMD Family 11h thermal sensors...                           No
> Intel Core family thermal sensor...                         No
> Intel Atom thermal sensor...                                No
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
>
> (lots of more testing here)
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `it87':
>   * ISA bus, address 0x228
>     Chip `ITE IT8720F Super IO Sensors' (confidence: 9)
>
> Driver `k10temp':
>   * Chip `AMD Family 10h thermal sensors' (confidence: 9)
>
> Warning: the required module k10temp is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability.
>
> To load everything that is needed, add this to /etc/modules:
> #----cut here----
> # Chip drivers
> it87
> #----cut here----
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones!
>
>
>
> Then I am able to modprobe it87 but I can not modprobe k10temp, and it
> seems
> that it is not compiled into the kernel, since I get no info from it:
>
> # sensors
> it8720-isa-0228
> Adapter: ISA adapter
> in0:         +0.98 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +1.50 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:         +3.38 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in3:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:         +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in5:         +2.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in7:         +3.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> Vbat:        +3.14 V
> fan1:       2848 RPM  (min =3D    0 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:       1273 RPM  (min =3D    0 RPM)
> fan5:          0 RPM  (min =3D    0 RPM)
> temp1:       +42.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r > thermistor
> temp2:       +51.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal
> diode
> temp3:       +48.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r > thermistor
> cpu0_vid:   +0.713 V
>
>
>
> How to address this?
>
> If recompile the kernel is the way, Where to touch config to add the
> module?
>
> Thanks
>
> Noel
> er Envite
>

Check this URL:

http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginke=
rnel2.6.31

The title of the FAQ entry does not match your issue, but the nature of
the problem might match the content of the FAQ entry.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
