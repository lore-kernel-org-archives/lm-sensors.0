From: Johannes Truschnigg <johannes.truschnigg@gmx.at>
Date: Sun, 19 Oct 2008 15:02:26 +0000
Subject: Re: [lm-sensors] Problem with it87 module from Linux 2.6.26 onward
Message-Id: <200810191702.31489.johannes.truschnigg@gmx.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7741694943321832001=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20081018211807.1d1f17a5@hyperion.delvare>
In-Reply-To: <20081018211807.1d1f17a5@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============7741694943321832001==
Content-Type: multipart/signed; boundary="nextPart1296491.8QfGX7IJo6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1296491.8QfGX7IJo6
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Jean, Andrew and List!

On Saturday 18 October 2008 21:18:07 Jean Delvare wrote:
> Hallo Johannes,
>
> Adding the lm-sensors list in Cc, as well as Andrew Paprocki who has
> been working on the it87 driver lately.

Great, thanks for redirecting the noise I generated to the proper location =
:)

>
> On Sat, 18 Oct 2008 19:18:15 +0200, Johannes Truschnigg wrote:
> > Dear Linux kernel module authors,
> >
> > I'm the owner of an ASUS M2NPV-VM mainboard which features a chip driven
> > by the it87 module. I used the PWM capabilities of this chip to reduce =
my
> > system's noise level, by having its fan speeds regulated via `fancontro=
l`
> > from lm_sensors, as the BIOS-provided PWM regulation isn't good enough
> > (the fans spin at full speed despite CPUtemp being lower than 40=B0C,
> > etc.). However, this mechanism stopped working as soon as I upgraded to
> > the 2.6.26 kernel. I was able to dig up a commentary on some mailing li=
st
> > that this "bug" I hit was introduced by choice, and that I could probab=
ly
> > work around it by specifying "fix_pwm_polarity=3D1" as a parameter to t=
he
> > module. I suppose it would work, if the debug ringbuffer wouldn't conta=
in
> >
> > ### snip ###
> > it87 it87.656: PWM configuration looks sane, won't touch
> > ### snip ###
> >
> > after loading the module accordingly. Is there a way to _really_ force
> > 2.6.25's behavior in this manner? Or am I doing it wrong, and there's
> > another way I can get what I want, which is PWM working the way I would
> > like it to?
>
> There's no way to force the polarity change, for your own good. If you
> did not need to pass fix_pwm_polarity=3D1 before, then passing it now
> will not solve your problem.

I see, thanks for clearing that up.

>
> > I'd really appreciate getting an answer on that matter - thank you in a=
ny
> > way for taking your time!
>
> The it87 driver did not change between kernel 2.6.25 and kernel 2.6.26:
> http://www.eu.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel=
%2Fv
>2.6%2Fpatch-2.6.26.bz2

Hmm, that indeed is interesting...

> So, I have a hard time believing that fan speed control is working with
> kernel 2.6.25 and doesn't work with kernel 2.6.26 without any other
> change to your system. You'll have to do more tests to figure out what
> exactly broke fan speed control on your system.

You are right indeed; I had 2.6.25 running with the Gentoo patchset applied=
 (=20
http://dev.gentoo.org/~dsd/genpatches/ ), and switched to vanilla for 2.6.2=
6.
The file /sys/class/hwmon/hwmon1/device/pwm1 disappeared in turn,=20
and "fancontrol" finds itself unable to regulate the system fans according =
to=20
my preferences. Skimming over the patches' descriptions, I couldn't find=20
anything that'd denote changed to it87, or sth. else that could be related =
to=20
my problem, however. I'm not at the machine right now, and would not want t=
o=20
risk switching kernels and reboot the box blindly without a chance of getti=
ng=20
near it the next two weeks. I'll check asap whether or not fancontrol works=
=20
again with gentoo-sources (2.6.27), and let you all know about success or=20
failure, if you don't mind.


> Please also explain in more details what the actual problem is. "It
> stopped working" doesn't tell us much.

Hope my above paragraph serves a bit better than my initial report - for sa=
ke=20
of completeness, when starting fancontrol, I now get:

###snip###
Enabling PWM on fans...
/usr/sbin/fancontrol: line 232: hwmon1/device/pwm1: No such file or directo=
ry
Error enabling PWM on /sys/class/hwmon/hwmon1/device/pwm1
Aborting, restoring fans...
/usr/sbin/fancontrol: line 189: hwmon1/device/pwm1: No such file or directo=
ry
Verify fans have returned to full speed
###snip###


Thank you very much for your kind and prompt reply! FOSS support actually=20
rocks :)
=2D-=20
with best regards:
=2D Johannes Truschnigg ( johannes.truschnigg@gmx.at )

www: http://johannes.truschnigg.info/
phone: +43 650 2 133337
jabber: johannes.truschnigg@gmail.com

Please do not bother me with HTML-eMail or attachments. Thank you.

--nextPart1296491.8QfGX7IJo6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI+0wHnnUApj8OcoIRAl4WAKCXVn4AJhAF2eTBQkTp7lwv5EFsYACglbEq
dDx2pTU1JSWElEkaq35cozc=
=SGVw
-----END PGP SIGNATURE-----

--nextPart1296491.8QfGX7IJo6--


--===============7741694943321832001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7741694943321832001==--
