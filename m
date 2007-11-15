From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 15 Nov 2007 09:52:01 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <473C16C1.7070104@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4738C247.4030501@hhs.nl>
In-Reply-To: <4738C247.4030501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:
> Jean Delvare wrote:
>> Hi Hans,
>>
>> On Tue, 13 Nov 2007 22:08:48 +0100, Hans de Goede wrote:
>>> Jean Delvare wrote:
>>>> So, are you done with your porting work? If so, and if you didn't find
>>>> any problem with the new libsensors API, is there any reason to delay
>>>> the release of lm-sensors 3.0.0 any further?
>>> I'm not done with my porting work, next on the list is net-snmp,=20
>>> which looks easy to fix, I'll take a shot at it tomorrow. Then we=20
>>> also have an xfce applet=20
>>
>> I am interested in net-snmp as well, so maybe we can work on this
>> together. Well, you'll certainly be quicker than me on the code, but I
>> can review your patch and push it in opensuse.
>>
>=20
> Hmm,
>=20
> While coordinating my work with the Fedora net-snmp maintainer I got=20
> attended that upstream us already working on this:
> http://sourceforge.net/mailarchive/message.php?msg_name=AE77C0A0A0DC9B49B=
AA800A119E82EA207CD5D83%40EDM-GOA-EXCC-1A.goa.ds.gov.ab.ca=20
>=20
>=20
> However the upstream work is a complete rewrite of the sensors code in=20
> net-snmp, as I have no idea when that will be stable and I don't want to =

> completely break the development branch of Fedora (quite a few things=20
> require net-snmp) I'll also be writing a patch against the current=20
> stable net-snmp release, I already took a look and the code is quite=20
> isolated, fixing this for the current stable net-snmp release should be=20
> quite easy.
>=20

Ok,

Scrap that, upstream has finished lm_sensors-3.x support and the Fedora=20
net-snmp maintainer has decided to backport the sensors infra changes +=20
lm_sensors-3.x.x support to the current stable net-snmp, patch available he=
re:
http://cvs.fedoraproject.org/viewcvs/devel/net-snmp/net-snmp-5.4.1-sensors3=
.patch?rev=3D1.1

Shall I add this to the wiki? Its a bit intrusive.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
