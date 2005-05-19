From: patyoung13@hotmail.com (Pat Young)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: No sensors found. Ticket: 1939
Message-Id: <BAY102-F20217FD8020B37144FE5CCC2400@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>You must have a SiS PCI bus adapter, but possibly hidden or too new. Pleas=
e=20
>send
>the output of "lcpsi -v" and "lspci -n" to the sensors mailing-list.

>>Probing for =B4Winbond W83627HF Super IO Sensors=B4
>>   Failed! (0x88)

>Could be a Winbond W83627EHF chip. Search your board for it if you have=20
>physical
>access. A preliminary, limited driver exists, see our New Drivers page=20
>and/or
>contact the mailing-list. We=B4d need hardware to complete the driver.

>Khali 2005-03-22

Hi,

This is concerning Ticket: 1939.  I do indeed have a Winbond W83627HF.  The=
=20
most recent sensors-detect script does find it:

Probing for `Winbond W83627EHF Super IO Sensors'
  Success... found at address 0x0290

I have downloaded the patch but must admit I am new to the use of the patch=
=20
command.  I have read the man page and am not sure as to what the -p<num>=20
should be.  I receive the following:

[root@mj asus]# patch < linux-2.6.12-rc1-i2c-w83627ehf-rc1.diff
can't find file to patch at input line 4
Perhaps you should have used the -p or --strip option?
The text leading up to this was:
--------------------------
|diff -ruN linux-2.6.12-rc1/drivers/i2c/chips.orig/Kconfig=20
linux-2.6.12-rc1/drivers/i2c/chips/Kconfig
|--- linux-2.6.12-rc1/drivers/i2c/chips.orig/Kconfig    2005-03-18=20
12:43:11.000000000 +0100
|+++ linux-2.6.12-rc1/drivers/i2c/chips/Kconfig 2005-03-18=20
15:25:49.000000000 +0100
--------------------------
File to patch:

[root@mj asus]# patch -p1 < linux-2.6.12-rc1-i2c-w83627ehf-rc1.diff
can't find file to patch at input line 4
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -ruN linux-2.6.12-rc1/drivers/i2c/chips.orig/Kconfig=20
linux-2.6.12-rc1/drivers/i2c/chips/Kconfig
|--- linux-2.6.12-rc1/drivers/i2c/chips.orig/Kconfig    2005-03-18=20
12:43:11.000000000 +0100
|+++ linux-2.6.12-rc1/drivers/i2c/chips/Kconfig 2005-03-18=20
15:25:49.000000000 +0100
--------------------------
File to patch:

This is probably a very simple fix but as I said I have never used the patc=
h=20
command.  What am I doing wrong?  Is there another way I should be doing=20
this?  Any assistance is greatly appreciated.

Regards,

Pat

