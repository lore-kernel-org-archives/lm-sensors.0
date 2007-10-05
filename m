From: Stian Jordet <liste@jordet.net>
Date: Fri, 05 Oct 2007 11:11:17 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <47061BD5.6060800@jordet.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Which version of lm-sensors have you been using for your test? Versions
> from 2.9.1 to 2.10.4 (inclusive) are annoyingly shifting channel
> numbers by one for bmc. This doesn't explain everything you observed,
> but could still have interfered with your diagnostics. So I suggest
> that you try either lm-sensors SVN (either the stable branch or the
> upcoming 3.0 version):
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4912-20071002.t=
ar.bz2
> http://dl.lm-sensors.org/lm-sensors-3/snapshots/lm-sensors-3-r4914-200710=
02.tar.bz2
>  =20
Jean,

thanks for your reply :) I was using 2.10.4, but installed the snapshot=20
now. This is way beyond me, but I got a quite different result now:

bmc-isa-0003
Adapter: ISA adapter
SCSI-N Volt:
           +1.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard 1.5V:
           +1.98 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard 2.5V:
           +1.89 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard 3.3V:
           +3.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard 12V:
          +15.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard 5V:
           +4.79 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Baseboard -12V:
          -12.11 V  (min =3D  +0.00 V, max =3D  +0.00 V)
PwrShare Fan 3:
          4680 RPM  (min =3D    0 RPM)
PwrShare Fan 2:
          2520 RPM  (min =3D    0 RPM)
PwrShare Fan 1:
          2520 RPM  (min =3D    0 RPM)
Baseboard Fan 6:
          2610 RPM  (min =3D    0 RPM)
Baseboard Fan 7:
          2730 RPM  (min =3D    0 RPM)
Baseboard Fan 8:
          2850 RPM  (min =3D    0 RPM)
Baseboard Fan 5:
          2880 RPM  (min =3D    0 RPM)
Baseboard Fan 3:
          2730 RPM  (min =3D    0 RPM)
Baseboard Fan 4:
          2970 RPM  (min =3D    0 RPM)
Baseboard Fan 1:
          2760 RPM  (min =3D    0 RPM)
PwrShare Temp:
           -12.8=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Processor 4 Temp:
            +6.1=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Processor 3 Temp:
            +2.6=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Processor 2 Temp:
            +2.6=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Processor 1 Temp:
            +2.5=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Basebrd PXB Temp:
            +2.4=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)
Basebrd PCI Temp:
            +3.0=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)

The voltages looks a little better (Probably still wrong, but I have no=20
idea), but the temperatures were better earlier ;) But that might be=20
another bug in lm-sensors with regard to bmc? Or is that an ipmisensors=20
workaround to get past a lm-sensors bug that is now fixed?

I'll have to wait untill I'm back home to see if each sensor now=20
corresponds to the right label in lm-sensors.

Thanks for the help :)

Regards,
Stian

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
