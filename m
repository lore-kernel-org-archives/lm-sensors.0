From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 11 Sep 2006 23:47:59 +0000
Subject: [lm-sensors] [patch] hwmon/pc87360: update vrm setting using
Message-Id: <4505F5AF.7090708@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


pc87360 currently hardcodes vrm = 90 (2.4 vintage).  Update it to use
newer code in hwmon-vid which reads cpuid to determine the correct vid.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

---

My board has an NSC SC-1100 (a 586-mmx class cpu), which is seen as 
unknown,
so perhaps theres more to do / investigate, but 'unknown' is certainly 
accurate at this point.

Looking at hwmon-vid.c, I note:
- it looks rather complete, at least for pentium 2 and up
- there are no i586's listed, from any vendor.
- I couldnt find anything at Intel website, or elsewhere

I reluctantly conclude that no VID standard existed back then.
Anyone have better / contradicting info ?

 pc87360.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc6-sk/drivers/hwmon/pc87360.c vrm/drivers/hwmon/pc87360.c
--- ../linux-2.6.18-rc6-sk/drivers/hwmon/pc87360.c      2006-08-14 21:19:24.000000000 -0600
+++ vrm/drivers/hwmon/pc87360.c 2006-09-11 13:55:15.000000000 -0600
@@ -917,7 +917,7 @@ static int pc87360_detect(struct i2c_ada
                        (i&0x02) ? "external" : "internal");

                data->vid_conf = confreg[3];
-               data->vrm = 90;
+               data->vrm = vid_which_vrm();
        }

        /* Fan clock dividers may be needed before any data is read */



