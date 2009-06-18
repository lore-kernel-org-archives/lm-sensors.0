From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Date: Thu, 18 Jun 2009 17:09:33 +0000
Subject: [lm-sensors] dme1737 sensors force_start
Message-Id: <SNT106-W242B7EE77BE87384F8FE15BA3D0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi,

I am using Debian 5.0 with 2.6.30 kernel and my board has SCH3114 chip. Upo=
n booting I get the following messages in the dmesg:
[   70.012233] dme1737 dme1737.3184: Found a SCH311x chip at 0x0c70
[   70.012326] dme1737 dme1737.3184: Device is not monitoring. Use the forc=
e_start load parameter to override.
[   70.013552] dme1737 dme1737.3184: Failed to initialize device.
[   70.013653] dme1737: probe of dme1737.3184 failed with error -14

So naturally the sensors-detect and sensors did not work.

Upon loading the module the following way:
modprobe dme1737 force_start

it started working fine.

Any ideas why I need to give force_start? Is this a chip /BIOS/OS issues?

In the past I have other boards which used the same chipset but in those I =
never had to give the force_start option.

I am using sensors version 3.0.2 with libsensors version 3.0.2

Thanks.

Kushal Koolwal

I do blog at http://blogs.koolwal.net/




_________________________________________________________________
Microsoft brings you a new way to search the web.  Try  Bing=99 now
http://www.bing.com?form=3DMFEHPG&publ=3DWLHMTAG&crea=3DTEXT_MFEHPG_Core_ta=
gline_try bing_1x1
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
