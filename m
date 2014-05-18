From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 18 May 2014 08:19:10 +0000
Subject: Re: [lm-sensors] Dell Latitude E6440 & i8k
Message-Id: <20140518101910.35059ee7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please leave the list in Cc.

On Sun, 18 May 2014 00:52:13 +0200, Pali Roh=E1r wrote:
> Do you know if there is any way to extract BIOS SMM code? Or it=20
> is something which is not possible to do from OS/kernel side?

If you download a BIOS update for your laptop from Dell, the SMM code
is certainly somewhere in the binary blob which gets flashed to the
EEPROM. But extracting that code from there would certainly be
challenge.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
