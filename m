From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 15 Jan 2006 20:33:59 +0000
Subject: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Message-Id: <43CAB1B7.6020903@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200601142223.35838.arvidjaar@newmail.ru>	<200601150045.30942.arvidjaar@newmail.ru>	<200601152212.31491.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru>
In-Reply-To: <200601152248.07800.arvidjaar@newmail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Andrey Borzenkov <arvidjaar@newmail.ru>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hello all,

>=20
> this appears simply a probing for non-existent i2c ports (correct me if I=
 am=20
> wrong) presumably by eeprom driver.

yes I think you are right. (ADD/2 is the address of chip, that it tries to =
access)

> Second block are errors from lm90 for different registers:
>=20
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=
=04,=20
> TYP=10, CMD=01, ADD=99, DAT0=A0, DAT1=10
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=14,=20
> TYP=10, CMD=01, ADD=99, DAT0), DAT1=10
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=
=04,=20
> TYP=10, CMD=08, ADD=98, DAT0), DAT1=10
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Error: command never=20
> completed
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=04,=20
> TYP=10, CMD=08, ADD=98, DAT0), DAT1=10
> Jan 15 22:24:02 cooker kernel: lm90 0-004c: Register 0x8 read failed (-1)
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=
=04,=20
> TYP=10, CMD=07, ADD=98, DAT0), DAT1=10
> Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=14,=20
> TYP=10, CMD=07, ADD=98, DAT0), DAT1=10
>=20
> Here I do not see SMBus errors - it appears really that i2c device did no=
t=20
> respond. OTOH interesting is that there is no timeout. Apparently command=
=20
> completed without setting DONE bit. As I have zero knowledge about hardwa=
re I=20
> cannot interpret it. Next driver resets SMBus and it works for some time =

> again. Judging by comments in source, it apprently signifies hung ali1535=
,=20
> not external i2c device (it is using KILL, and "this doesn't seem to clea=
r=20
> the controller if an external device is hung")

Well it seems this ali 15x3 has maybe same hardware bug? It was mentioned a=
lready here:
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket 30

> In the log below you can see that the ALI15X3 chip seems to keep in idle-=
state
> without reporting "done", but it does not turn in "busy" state. I patched=
 the
> driver to do the reset procedure (with ALI15X3_T_OUT) after the error, but
> afterwards, the chip turns to "busy" state until next reboot.

And it continued:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013808.html

I asked for a patch and what I have received like a month after is patch th=
at works for them:

> Dear Rudolf,
>=20
> unfortunately i do not have cvs installed on my machine. I hope it's okay=
 if
> i send you the complete patched module (the only file i changed was the
> i2c-ali15x3.c) so you can do the patch yourself. Since i'm not a experien=
ced
> driver developer i do not know what you ment with your last sentence and i
> did not find any remarks on the website.
>=20
> However, feel free to contact me if you have still any questions.
>=20
> This version works fine and without any problems over many days in our te=
st
> system.
>=20
> Regards,
> Claudio Klingler

I'm putting it into attachment. (this is against the lmsensors CVS so 2.4 d=
river)

Since I dont own the motherboard with this chip (nor the datasheet) and the=
 resulting driver was hard to read I just left this issue.
I hope it can help now.

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ali15x3.c
Type: text/x-csrc
Size: 16990 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060115=
/0b2bfd6b/i2c-ali15x3-0001.bin
