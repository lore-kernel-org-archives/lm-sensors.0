From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Jun 2011 19:29:52 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <20110617212952.5c5b14a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dave,

On Fri, 17 Jun 2011 18:30:53 +0100 (BST), everythingsfree@lineone.net wrote:
> Guenter & Jean, thanks for the continued help.
>=20
> I got slightly bogged=20
> down yesterday attempting to upgrade my install - I tried 'apt-get=20
> update' which downloaded a few things but didn't fix the problem so I=20
> then tried 'apt-get upgrade' (I'm not sure on the difference between=20
> the two...) which downloaded even more and then got into trouble,=20
> ending with a segmentation fault!  I rebooted and continued but got=20
> more issues and had to stop as it was getting late.
>=20
> I've since resumed=20
> and managed to get where I am now with what I hope is a fully upgraded=20
> install but I still get the same compile errors.
>=20
> So, I've grabbed=20
> Jean's file and followed Guenter's instructions to build and install=20
> those, all went well.  On running 'sensors' I still get 'N/A' for the=20
> core temps but at least I only get two:
>=20
> coretemp-isa-0000
> Adapter: ISA=20
> adapter
> Core 0:           N/A  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
> Core 1:           N/A  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

Actually this reminds me of similar issues that were reported before and
never solved:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027716.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-September/029501.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November/030521.html

The errors look slightly different because of older versions of
lm-sensors, but the problem is the same: the MSR_IA32_THERM_STATUS
register fails to return a valid value.

It would be interesting to check from user-space and see what the raw
MSR read returns. You'll need the msr kernel driver, as well as the
msr-tools package.

# rdmsr -p 0 -x 0x19c
# rdmsr -p 1 -x 0x19c
# rdmsr -p 2 -x 0x19c
# rdmsr -p 3 -x 0x19c

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
