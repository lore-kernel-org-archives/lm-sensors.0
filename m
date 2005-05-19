From: beejay@gentoo.org (Benjamin Judas)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <1099508524.11618.21.camel@antares.hausnetz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Following an IRC-request by Jean here:

this is a log-excerpt that shows the life of the driver from loading
until bailing out:

Oct 31 22:03:05 antares kernel: i2c-core: driver asb100 registered.
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: found normal
i2c_range entry for adapter 1, addr 0028
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=00, CMDO, ADDP, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Error: no response!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=00, CMDO, ADDP, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: found normal
i2c_range entry for adapter 1, addr 0029
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=00, CMDO, ADDR, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Error: no response!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=00, CMDO, ADDR, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: found normal
i2c_range entry for adapter 1, addr 002a
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=00, CMDO, ADDT, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Error: no response!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=00, CMDO, ADDT, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: found normal
i2c_range entry for adapter 1, addr 002b
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=00, CMDO, ADDV, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=00, CMDO, ADDV, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=08, CMDN, ADDW, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=08, CMDN, ADDW, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (pre):
CNT=08, CMDO, ADDW, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: SMBus busy (0x40).
Resetting...
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Successfull!
Oct 31 22:03:05 antares kernel: i2c_adapter i2c-1: Transaction (post):
CNT=08, CMDO, ADDW, DAT0=00, DAT1=FF
Oct 31 22:03:05 antares kernel: asb100.o: detect failed, bad chip id
0x00!




--=20

Benjamin Judas

---------------------------------------------------------------------      =
                           =20
Gentoo-developer                        http://dev.gentoo.org/~beejay
Giessen, Germany                                http://www.gentoo.org

GPG-Key         : 0xC31DEDD8
Key-Fingerprint : 4E65 AAFE 785B 61D8 E4D9  1671 E017 87B7 C31D EDD8
Jabber          : beejay@im.gentoo.org


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041103=
/9e77f68c/attachment.bin
