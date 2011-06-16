From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Jun 2011 18:33:18 +0000
Subject: Re: [lm-sensors] drivers w83627ehf
Message-Id: <20110616183318.GA19646@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Filipe,

On Thu, Jun 16, 2011 at 02:04:48PM -0400, Hotmail wrote:
> Dear Mr Roeck
>=20
> I found a helpful page (for you) since I cant make heads or tails of it, =
it
> indicates values and that fans speeds can be controlled at least in windo=
ws
>=20
> http://jamie.lentin.co.uk/hardware/asrock_ion330/
>=20
Interesting and useful information. Not sure if/how we can use that to write
an actual driver for it; fan control on the chip seems to be handled outside
the NCT chip.=20

Copying the mailing list for input.

> It states as far as I understand that the fans and fans speeds are and can
> be set, since with this driver nothing happens, I have to wonder, because=
 of
> the information seems to indicate that its true.
>=20
> Executing on terminal
>=20
> perl -le 'sysopen($raw_port,"/dev/port",O_RDWR); foreach my $p
> (0x4932,0x4934,0x4936) {
>   sysseek $raw_port,$p,0;sysread $raw_port,$res,2; printf("0x%x:
> %s\n",$p,unpack("S",$res)*60); }'
>   # Super"silent" (level 1)
>=20
> gives me this output
>=20
> 0x4932: 2820
> 0x4934: 9600
> 0x4936: 4260
>=20
> looking at the results since the system only has two fan headers and fans
> that
>=20
> 0x4932: 2820 =3D case fan since its a 2500rpm fan
> 0x4934: 9600 =3D Cpu fan since its a 8000rpm fan
>=20
> Executing cat /proc/ioports gives me the below results, I pastebinit to m=
ake=20
> it easier.
>=20
> http://pastebin.com/ZSXfiRMA
>=20
> The third fan is mute in my not so expert option. Even if it exists the=20
> values
> make no sense for the actual system fans speeds.
>=20
> Idk if this info helps you, I hope with this information that the Asrock =
ION
> and HT have a more complete driver and sensors3.conf values.
>=20
> about the min max values I dont have a clew how to set them
>=20
> > +54.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  sensor =3D =
diode
>=20
> no clew any help is appreciated.
>
You set the desired limits in /etc/sensors3.conf and then execute "sensors =
-s"
to write the limits into the device.
=20
> Im not really a maths person nor a expert by any means, Im hoping only..
>=20
> Lastly I have posted this=20
> http://x3webworx.wordpress.com/2011/06/09/asrock-ion-330-cpu-sensor-linux=
-drivers/
>=20
> Thats all am able to contribute to the community is there on this blog.
>=20
> Sorry if Im being a pain, if I am let me know...
>=20
No problem, glad to help.

Thanks,
Guenter

> Thank you for your help and support
>=20
> Filipe Oliveira
>=20
>=20
> =20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
