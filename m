From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 15:38:23 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro PDSMi+
Message-Id: <20080506173823.36d65db3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482051E8.605@caps-entreprise.com>
In-Reply-To: <482051E8.605@caps-entreprise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 06 May 2008 17:12:38 +0200, Romain Dolbeau wrote:
> Romain Dolbeau wrote:
> > Jean Delvare wrote:
> >> * The connector for the 6th fan. I thought it was fan6 but you seem to
> >>   believe it's fan7. My system only had 2 fans so I will trust you.
> >=20
> > Mine have 3 in a 1U, I suspect this is a leftover from the X7DBE.
>=20
> Fans are at 23, 25, 27, 29, 2B and 2F according to AllSuperD.ini, so it
> seems I had done my homework properly back then :-)

Hmm, do we have the same AllSuperD.ini file? Mine says:

[Item]
BusType=3D1
Item_Name=FAn6/CPU Fan Speed
Comp_Name=FAn6/CPU
Item_ID=3DItem_FAN6
Item_Cat=FAN
ChipCode=11
Slave/
Offset-                    <--
ParaIndex1=3DDivisor6
ParaIndex2=FAN6H
Monitor=3DTRUE
Source=3D0

This is with file V.131 (10/06/06) - if you have a newer one, can you
please send it to me in private? Thanks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
