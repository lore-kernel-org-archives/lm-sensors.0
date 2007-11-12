From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 12 Nov 2007 08:31:20 +0000
Subject: Re: [lm-sensors] ksensors ported to 3.x.x
Message-Id: <47380F58.7090306@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <473759E4.1070301@hhs.nl>
In-Reply-To: <473759E4.1070301@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Aurelien Jarno wrote:
> Hans de Goede a =E9crit :
>> Hi all,
>>
>> A tarbal with ksensors 0.7.3 ported to lm_sensors-3.x is available from:
>> http://www.lm-sensors.org/wiki/Download
>>
>> Note, its a tarbal, since the patch I did is incremental to a lot of oth=
er=20
>> patches as upstream has been dead for a while.
>>
>> If someone wants to see the last increment (the one adding lm_sensors-3x=
=20
>> support) let me know.
>>
>=20
> I confirm that the upstream is dead, but I should still have CVS access
> to the project. Would it be possible to send me the patch that adds
> lm_sensors-3x support? I would also be interested by other patches.
>=20

I'm afraid not, I can send a patch consisting of all Debian + Fedora fixes,=
 I=20
can even first send a patch with the Debian patches and then a few incremen=
tal=20
patches with the Fedora fixes (including lm_sensors-3x support), porting th=
e=20
lm_sensors-3x patch to CVS / 0.7.3 is not worth it IMHO, especially since m=
ost=20
of the other fixes are very much worth their while.

> BTW, if somebody is interested to continue upstream work, just ask me, I
> think I have enough privileges on the sourceforce project to give CVS
> access. Unfortunately I personally don't have time to work on that.
>=20

I think that would be great, but alas I do not have the time, nor any=20
experience with QT / KDE.

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
