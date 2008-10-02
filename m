From: Raj Mathur <raju@linux-delhi.org>
Date: Thu, 02 Oct 2008 14:59:26 +0000
Subject: Re: [lm-sensors] High temperatures on Intel DG31PR
Message-Id: <200810022021.27174.raju@linux-delhi.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200809101453.36339.raju@linux-delhi.org>
In-Reply-To: <200809101453.36339.raju@linux-delhi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thursday 02 Oct 2008, Jean Delvare wrote:
> On Thu, 2 Oct 2008 18:12:35 +0530, Raj Mathur wrote:
> > sensors-detect seems to find the sensors fine (transcript at
> > bottom). However now I find that some of the temperatures seem to
> > be unreasonably high.  Please see Sys Temp (76.0C) and Aux Temp
> > (127.0C) in the sensors output under.
>
> 127 degrees C typically means that no thermal sensor is connected to
> that input. So you can ignore this input.

Thanks, that's what I suspected, glad to have it confirmed.

> 76 degrees C is admittedly very high, but then again it depends what
> it is measuring. Don't trust the default labels which may or may not
> apply to your motherboard. You should compare with what the BIOS
> says. Also look at the motherboard documentation, in my experience
> Intel board have a good description of where the thermal sensors are
> located.

The BIOS reports it as "Motherboard Temperature".  It keeps slowly=20
varying in the 72-76 degrees C range.

I'm afraid hardware isn't really my domain, so even though I do have the=20
document it doesn't make much sense to me.  What I do gather from from=20
the technical specs=20
(http://download.intel.com/support/motherboards/desktop/dg31pr/sb/e14051001=
us.pdf)=20
is that there are thermal sensors in the CPU(s), the I/O Controller Hub=20
(ICH7) and the Graphics and Memory Controller Hub (GMCH).  If I=20
correlate that information with the sensors-detect output and eliminate=20
the core temperatures, it seems that the 76 degrees C is in the ICH7=20
(though I could be totally wrong).

In any case, from experience, is a temperature of 76C in the ICH or the=20
GMCH a cause of concern?  If this is in the normal range for=20
motherboard temperatures I'll stop worrying about my system running hot=20
right now :)  If it looks high, I'll ask my hardware supplier to check=20
the board out for faults.  All advice appreciated.

Regards,

-- Raju

> If the temp1 value never changes, you may try changing the sensor
> type and see if you get better values. But the BIOS should have set
> the proper type for you already.
>
> > Is this normal/expected?  If not, any solution for this issue?  I'd
> > be glad to provide any other information required.
> >
> > *** sensors output
> > -------------------------------
> > w83627dhg-isa-0290
> > Adapter: ISA adapter
> > VCore:       +1.05 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:        +10.61 V  (min =3D  +2.53 V, max =3D  +4.75 V)   ALARM
> > AVCC:        +3.33 V  (min =3D  +3.66 V, max =3D  +2.99 V)   ALARM
> > 3VCC:        +3.31 V  (min =3D  +2.26 V, max =3D  +3.17 V)   ALARM
> > in4:         +1.82 V  (min =3D  +0.78 V, max =3D  +1.58 V)   ALARM
> > in5:         +1.26 V  (min =3D  +1.11 V, max =3D  +1.17 V)   ALARM
> > in6:         +0.31 V  (min =3D  +1.48 V, max =3D  +1.23 V)   ALARM
> > VSB:         +3.30 V  (min =3D  +1.28 V, max =3D  +2.34 V)   ALARM
> > VBAT:        +3.18 V  (min =3D  +3.58 V, max =3D  +3.10 V)   ALARM
> > Case Fan:    803 RPM  (min =3D 1163 RPM, div =3D 8)  ALARM
> > CPU Fan:     917 RPM  (min =3D 2280 RPM, div =3D 8)  ALARM
> > Aux Fan:       0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> > fan4:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> > fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> > Sys Temp:    +76.0=B0C  (high =3D  +1.0=B0C, hyst =3D +43.0=B0C)  ALARM=
=20
> > sensor =3D diode
> > CPU Temp:    +35.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r > > diode AUX Temp:   +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)  ALARM
> >  sensor =3D thermistor
> > cpu0_vid:   +2.050 V
> >
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +53.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)
> >
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 1:      +51.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)
>
> According to coretemp your CPU isn't too hot, so you really don't
> have to worry for the CPU.

--=20
Raj Mathur                raju@kandalaya.org      http://kandalaya.org/
       GPG: 78D4 FC67 367F 40E2 0DD5  0FEF C968 D0EF CC68 D17F
PsyTrance & Chill: http://schizoid.in/   ||   It is the mind that moves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
