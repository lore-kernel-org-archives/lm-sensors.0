From: Michele Baldessari <michele@acksyn.org>
Date: Sun, 24 Nov 2013 09:23:59 +0000
Subject: [lm-sensors] small regression: hwmon: (applesmc) Check key count before proceeding - 5f4513864304672
Message-Id: <20131124092359.4241e633@fante.int.rhx>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Henrik Rydberg <rydberg@euromail.se>
Cc: jwboyer@fedoraproject.org, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, bugzilla@colorremedies.com

Hi Henrik & Guenther,

via commit 5f4513864304672e6ea9eac60583eeac32e679f2 the following
code was added:
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 62c2e32..98814d1 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -525,16 +525,25 @@ static int applesmc_init_smcreg_try(void)
 {
        struct applesmc_registers *s =3D &smcreg;
        bool left_light_sensor, right_light_sensor;
+       unsigned int count;
        u8 tmp[1];
        int ret;
=20
        if (s->init_complete)
                return 0;
=20
-       ret =3D read_register_count(&s->key_count);
+       ret =3D read_register_count(&count);
        if (ret)
                return ret;
=20
+       if (s->cache && s->key_count !=3D count) {
+               pr_warn("key count changed from %d to %d\n",
+                       s->key_count, count);
+               kfree(s->cache);
+               s->cache =3D NULL;
+       }
+       s->key_count =3D count;
+
        if (!s->cache)
                s->cache =3D kcalloc(s->key_count, sizeof(*s->cache),
GFP_KERNEL); if (!s->cache)

The issue Chris has seen in Fedora on one MacBookPro4,1
(https://bugzilla.redhat.com/show_bug.cgi?id=1033414) is that this
machine returns a huge number from read_register_count() so now we will
try to allocate an insane amount of memory and we will barf:
[    8.603053] applesmc: key count changed from 261 to 1392508929

Dmidecode for this box is here:
https://bugzilla.redhat.com/attachment.cgi?id=828118

Do we need to special case this specific machine/smc version or should
we limit the kcalloc() call to a somewhat sane limit? Other thoughts?

Thanks,
Michele

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
