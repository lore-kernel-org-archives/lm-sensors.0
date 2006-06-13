From: ymu@winbond.com (Yuan Mu)
Date: Tue, 13 Jun 2006 08:58:36 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <448E7E3C.6050601@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,
>> Sounds interesting, i think we do not need to do this now since the=20
>> machine did not
>> reboot for 3 days, maybe the reason is they use a aeroengine as the=20
>> cpufan...
>> I will dig what you said after finish the schedule about 793 :)
>> Now I got it work on FC5 and FC4, but FC3 met the same problem as i=20
>> met before,
>> maybe i801 driver missing ICH7 PCI ID, and i'm trying to make it work :(
>=20
> CHeck the PCI IDS, for new kernels you can check the history on each file=
s:
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dhistory;h=86bc843a268058df558844b6bf64531617fbc698;f=3Ddrivers/i2c/busse=
s/i2c-i801.c=20
>=20
>=20
> And also through the trac.
> http://www.lm-sensors.org/log/lm-sensors/trunk/kernel/busses/i2c-i801.c
>=20

Thanks , it works now :)


--=20
Best Regards
Yuan Mu


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged =
confidential information contained in this email is intended for use only b=
y the addressees as indicated by the original sender of this email. If you =
are not the addressee indicated in this email or are not responsible for de=
livery of the email to such  a person, please kindly reply to the sender in=
dicating this fact and delete all copies of it from your computer and netwo=
rk server immediately. Your cooperation is highly appreciated. It is advise=
d that any unauthorized use of confidential information of Winbond is stric=
tly prohibited; and any information in this email irrelevant to the officia=
l business of Winbond shall be deemed as neither given nor endorsed by Winb=
ond.

