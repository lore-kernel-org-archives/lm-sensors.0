From: Stelian Pop <stelian@popies.net>
Date: Fri, 30 Mar 2007 19:41:37 +0000
Subject: Re: [lm-sensors] possible error in ams-i2c.c
Message-Id: <1175283697.5403.7.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le vendredi 30 mars 2007 =E0 19:26 +0200, Jean Delvare a =E9crit :
[...]
> > > > Moreover, the loop logic is wrong: the ams_i2c_read should be
> > > > attempted a few times if it fails, with some delay between each
> > > > read. This is not what the code does...
[...]
> > -	int remaining =3D HZ / 20;
> > +	int count =3D 3, delay =3D HZ / 20;

> You don't really need a local variable for delay, you use it only
> once.

Well, the compiler would have optimized this away anyway.

> >  	ams_i2c_write(AMS_COMMAND, cmd);
> >  	mdelay(5);
>=20
> Not related with your patch, but whouldn't msleep() be more friendly
> with the rest of the system? It doesn't look like you need the delay to
> be exactly 5 ms.

The protocol was reverse engineered so I don't know for sure if there is
a need for a fixed timing here. But you're probably correct.

[...]

> Otherwise I'm fine with this patch, but please post it on the
> lm-sensors list so that others can comment.

Sure, I'm adding the CC:, but please keep me in CC: in replies since I'm
not subscribed.

>  I'll pick it there. Is it something we want in 2.6.21?

No, there is no need to hurry, it can wait for 2.6.22.

Thanks,

---

Fix sleep and retry logic in ams-i2c.

Signed-off-by: Stelian Pop <stelian@popies.net>
---
 drivers/hwmon/ams/ams-i2c.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ams/ams-i2c.c b/drivers/hwmon/ams/ams-i2c.c
index 0d24bdf..6f5b423 100644
--- a/drivers/hwmon/ams/ams-i2c.c
+++ b/drivers/hwmon/ams/ams-i2c.c
@@ -85,17 +85,17 @@ static int ams_i2c_write(u8 reg, u8 value)
 static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
 {
 	s32 result;
-	int remaining =3D HZ / 20;
+	int count =3D 3;
=20
 	ams_i2c_write(AMS_COMMAND, cmd);
-	mdelay(5);
+	msleep(5);
=20
-	while (remaining) {
+	while (count--) {
 		result =3D ams_i2c_read(AMS_COMMAND);
 		if (result =3D 0 || result & 0x80)
 			return 0;
=20
-		remaining =3D schedule_timeout(remaining);
+		schedule_timeout_uninterruptible(HZ / 20);
 	}
=20
 	return -1;
--=20
1.5.0.3


--=20
Stelian Pop <stelian@popies.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
