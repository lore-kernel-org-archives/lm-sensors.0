From: "Mildred Ki'Lya" <mildred593@online.fr>
Date: Sun, 25 Apr 2010 14:55:09 +0000
Subject: Re: [lm-sensors] fancontrol EeePC,
Message-Id: <4BD457CD.6070907@online.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3334097408283498700=="
List-Id: <lm-sensors.vger.kernel.org>
References: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
In-Reply-To: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3334097408283498700==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2DC53DF75872ECAF67C2FEEA"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DC53DF75872ECAF67C2FEEA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2010 01:21 PM, Jean Delvare wrote:
> Hi Mildred,
>
> On Sun, 25 Apr 2010 09:35:58 +0200, Mildred Ki'Lya wrote:
>  =20
>> Hi,
>>
>> I am using fancontrol for my new EeePC, and when fancontrol exit (when=
 I
>> reboot for example) the fans are set to manual mode at full speed.
>>
>> Aparently, the source code of fancontrol first tries to set the fan to=
 safe
>> mode, and if it doesn't work, set it to manual at full speed. Apparent=
ly,
>> the EeePC safe mode is the same as automatic mode. So when we write "0=
" to
>> pwm1_enable, if we read it again, we'll see "2".
>>    =20
> This is a bug in the eeepc driver. If it doesn't support mode 0, it
> should return -EINVAL when one tries to set it.
>  =20

Well, I didn't think this was a bug, from what I read, mode 0
corresponds to safe mode which is the automatic mode on the EeePC, and
of course since this is the same as the mode 2 (automatic), when we read
the file back we get 2.

But you certainly know better about this, so I'm not pressing the issue
further.

If I understand how fancontrol works, when the mode 0 doesn't work, it
set the pwm to mnual mode (1) and maximum speed. Do you think that is a
good choice given that for some laptops where the default mode is the
automatic mode (2) ? That would be a perfectly acceptable fallback when
fancontrol isn't in charge.

Do you think there is possibility in the future that fancontrol reset
the fan state to automatic when it quits (when specified in the
configuration) ? I'd be willing to work on a patch if that were the case.=



Mildred

--=20
Mildred Ki'Lya
=E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80 =EF=BD=8D=EF=BD=89=EF=BD=8C=EF=BD=84=EF=BD=92=EF=BD=85=EF=
=BD=84=EF=BC=95=EF=BC=99=EF=BC=93=EF=BC=A0=EF=BD=8F=EF=BD=8E=EF=BD=8C=EF=BD=
=89=EF=BD=8E=EF=BD=85=EF=BC=8E=EF=BD=86=EF=BD=92 =E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82 Jabber, GoogleTalk: <mildred@jabber.fr>
=E2=94=82 Website: <http://ki.lya.online.fr>           GPG ID: 9A7D 2E2B
=E2=94=82 Fingerprint: 197C A7E6 645B 4299 6D37 684B 6F9D A8D6 9A7D 2E2B



--------------enig2DC53DF75872ECAF67C2FEEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvUV9AACgkQb52o1pp9LivcngCfdM5gpf745x3Jx2DT/WWqy5k+
gT0Anj02otHdfU4ixQBf4LlDUXspu8D5
=w+U7
-----END PGP SIGNATURE-----

--------------enig2DC53DF75872ECAF67C2FEEA--


--===============3334097408283498700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3334097408283498700==--
