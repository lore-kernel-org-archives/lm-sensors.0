From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BUG] i2c-viapro oops on bad SMBus Block Read
Message-Id: <20030805210754.457c1946.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!

I have found a reproducible bug in i2c-viapro (lm_sensors-2.8.0). When
the device replies to SMBus Block Read with an absurdly large length,
this driver accepts it without checking and overruns the data buffer.
Tried with VT8325 and VT82C686.

To reproduce the bug, you need to have a device which will reply to a
SMBus Block Read with a large length. A DIMM EEPROM can be used for
this - many of them return 0xff for addresses >=3D 0x80. Then a simple
"i2cdump 1 0x52 s 0x80" gives this (rather useless) oops:

Unable to handle kernel paging request at virtual address ffffffff
 printing eip:
ffffffff
*pde =3D 00002063
*pte =3D 00000000
Oops: 0000
i2c-dev i2c-viapro binfmt_misc nfsd lockd sunrpc autofs4 sd_mod snd-pcm-oss=
 snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-mpu401-uart snd-rawmidi sn=
d-seq-device snd-ac97-codec snd soundcore snd-page-alloc keybdev mousedev 8=
139too mii ipx hid input usb-uhci usbcore ide-scsi scsi_mod ide-cd cdrom is=
ofs zlib_inflate loop nls_koi8-r nls_cp866 vfat fat radeonfb via686a i2c-pr=
oc i2c-isa i2c-core agpgart rtc xfs =20
CPU:    0
EIP:    0010:[<ffffffff>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: ffffffff   ecx: caa4db9c   edx: 00000000
esi: ffffffff   edi: ffffffff   ebp: ffffffff   esp: c40f7f98
ds: 0018   es: 0018   ss: 0018
Process i2cdump (pid: 2659, stackpage=C40f7000)
Stack: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff fffff=
fff=20
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff fffff=
fff=20
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff fffff=
fff=20
Call Trace:
Code:  Bad EIP value.

Obviously all the stack is trashed with the 0xff bytes from SMBus.

I have made a patch to fix the problem; it just limits the returned
length to 32. Maybe it would be better to return an error instead of
silently truncating? (The current code silently limits block writes to
32 bytes.)

Other bus drivers may also have a similar problem. It may be triggered
with buggy or misdetected hardware.


--- lm_sensors-2.8.0/kernel/busses/i2c-viapro.c.viapro-buffer-overrun	2003-=
07-03 05:30:13 +0400
+++ lm_sensors-2.8.0/kernel/busses/i2c-viapro.c	2003-08-05 20:46:25 +0400
@@ -271,6 +271,8 @@
 		break;
 	case VT596_BLOCK_DATA:
 		data->block[0] =3D inb_p(SMBHSTDAT0);
+		if (data->block[0] > 32)
+			data->block[0] =3D 32;
 		i =3D inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i =3D 1; i <=3D data->block[0]; i++)
 			data->block[i] =3D inb_p(SMBBLKDAT);


--=20
Sergey Vlasov
