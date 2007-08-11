From: Sebastian Flothow <lists@flothow.de>
Date: Sat, 11 Aug 2007 18:25:44 +0000
Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <27ffb5bd19bfd2c5b2a3bf6baabdc3ba@flothow.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
In-Reply-To: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am 7. Aug 2007 um 03:49 Uhr schrieb George Joseph ((dev)):
> Hmmm.  2.6.16 is definitely not going to work but 2.6.21 should compile
> fine.  In fact, I just tried it again on a freshly untarred 2.6.21.6
> with no errors.  If you tried the older driver, make sure it's
> completely cleaned out. Did the patch apply cleanly?

Yes, I applied it to a freshly untarred 2.6.21.6 as well. There were=20
slight offsets, but I think that shouldn't matter:

|=A0magrathea linux-2.6.21.6 # patch -p1 < ../asc76xx-2.6.21.patch
| patching file Documentation/hwmon/asc76xx
| patching file drivers/hwmon/asc76xx.c
| patching file drivers/hwmon/Kconfig
| Hunk #1 succeeded at 153 (offset 11 lines).
| patching file drivers/hwmon/Makefile
| Hunk #1 succeeded at 21 (offset 1 line).

However, I just found that it seems to be caused by my config - if I=20
use the default config (except for enabling asc76xx, of course), it=20
compiles fine, yet if I use my usual .config I get the error:

|   CC [M]  drivers/hwmon/asc76xx.o
| drivers/hwmon/asc76xx.c: In function 'asc76xx_detect':
| drivers/hwmon/asc76xx.c:1077: error: 'struct asc76xx_chip' has no=20
member named 'smb_addr'
| make[2]: *** [drivers/hwmon/asc76xx.o] Error 1
| make[1]: *** [drivers/hwmon] Error 2
| make: *** [drivers] Error 2

This is lines 54 through 64 of drivers/hwmon/asc76xx.c:

| struct asc76xx_chip {
|     char *name;
|     enum chips chip_type;
|     u8 chip_mask;
|     u8 company_reg;
|     u8 company_id;
|     u8 verstep_reg;
|     u8 verstep_id;
|     void (*setup) (struct i2c_client * client);
|     u8 addresses[4];
| };

No smb_addr there indeed, so it seems one of my config options breaks=20
your driver. Any idea what I should look for?


> I've got some info on C1E and EIST on the XBX2 specifically at
> http://www.peakin.com/xbx2/index.html

Thanks, useful page. There's just one thing which seems unclear to me:=20
is Tjmax equal to Tcontrol, or is it even higher (kind of a hard=20
limit)?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
