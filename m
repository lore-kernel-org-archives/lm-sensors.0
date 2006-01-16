From: arvidjaar@newmail.ru (Andrey Borzenkov)
Date: Mon, 16 Jan 2006 19:40:05 +0000
Subject: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Message-Id: <200601162240.09985.arvidjaar@newmail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz>
In-Reply-To: <43CAB1B7.6020903@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 23:33, Rudolf Marek wrote:
> Well it seems this ali 15x3 has maybe same hardware bug? It was mentioned
> already here: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket 30
>
[...]
> Since I dont own the motherboard with this chip (nor the datasheet) and t=
he
> resulting driver was hard to read I just left this issue. I hope it can
> help now.

Actually it did. I realized that 15x3 you sent attempted recovery while=20
current 1535 not. After some experiments I came up with this patch (it is n=
ot=20
meant for inclusion but only for discussion) that seems to work. I had hard=
=20
rime finding the exact place where to retry command but now I get

Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04=
,=20
TYP=10, CMD=01, ADD=99, DAT0=05, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=14,=20
TYP=10, CMD=01, ADD=99, DAT0,, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=04=
,=20
TYP=10, CMD=10, ADD=98, DAT0,, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Error: command never=20
completed
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=04,=20
TYP=10, CMD=10, ADD=98, DAT0,, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Adapter hung, retrying af=
ter=20
reset
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (pre): STS=00=
,=20
TYP=00, CMD=10, ADD=98, DAT0,, DAT1=10
Jan 16 22:20:14 cooker kernel: i2c_adapter i2c-0: Transaction (post): STS=
=14,=20
TYP=00, CMD=10, ADD=98, DAT0,, DAT1=10

so it appears to recover nicely. Does it look like it returns correct value=
=20
after retry?

I intend to squash errors, leaving only the first occurence but making it m=
ore=20
verbose. Probably:

Error: command never completed. It is probably hardware bug
Command will be retried after controller is reset
further occurences of this error won't be reported as long as retry is=20
sucessful

is wording OK (I am not native english speaker)?

regards

- -andrey

- --- linux-2.6.15/drivers/i2c/busses/i2c-ali1535.c	2006-01-03=20
06:21:10.000000000 +0300
+++ i2c-ali1535.c	2006-01-16 22:22:51.000000000 +0300
@@ -311,8 +311,8 @@ static int ali1535_transaction(struct i2
 	}
=20
 	/* check to see if the "command complete" indication is set */
- -	if (!(temp & ALI1535_STS_DONE)) {
- -		result =3D -1;
+	if (!result && !(temp & ALI1535_STS_DONE)) {
+		result =3D -2;
 		dev_err(&adap->dev, "Error: command never completed\n");
 	}
=20
@@ -344,6 +344,7 @@ static s32 ali1535_access(struct i2c_ada
 	int temp;
 	int timeout;
 	s32 result =3D 0;
+	int retry =3D 1;
=20
 	down(&i2c_ali1535_sem);
 	/* make sure SMBus is idle */
@@ -360,6 +361,7 @@ static s32 ali1535_access(struct i2c_ada
 	/* clear status register (clear-on-write) */
 	outb_p(0xFF, SMBHSTSTS);
=20
+retry:
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
@@ -424,7 +426,14 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
=20
- -	if (ali1535_transaction(adap)) {
+	if (((result =3D ali1535_transaction(adap)) =3D -2) && retry--) {
+		/* Adapter hung and was reset; retry */
+		dev_dbg(&adap->dev, "Adapter hung, retrying after reset\n");
+		result =3D 0;
+		goto retry;
+	}
+
+	if (result) {
 		/* Error in transaction */
 		result =3D -1;
 		goto EXIT;
=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFDy/aZR6LMutpd94wRAoBlAJ0ZLlhPMIBC5Fmz0Iw4NBoNjM7wfwCUCB0t
+sFjdErqBnZatcpLmiPTKA=3D
=3DMW/Q
-----END PGP SIGNATURE-----

