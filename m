From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 24 Feb 2006 04:31:10 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <20060224043110.GA19534@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Juerg:

* Juerg Haefliger <juergh at gmail.com> [2006-02-22 18:02:27 -0800]:
> Thanks for the hint. You're right, I didn't have the "name" attribute
> implemented but after fixing this, it still doesn't work. See the
> strace output below, it looks like sensors is going after i2c-adapter
> which of course is not there. Am I missing something here?

Hmmm... I guess it's a libsensors bug - try this patch.

Jean: comments?

Index: lib/sysfs.c
=================================RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
retrieving revision 1.4
diff -u -r1.4 sysfs.c
--- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
+++ lib/sysfs.c	24 Feb 2006 05:23:58 -0000
@@ -171,7 +171,7 @@
 	int ret = 0;
 
 	if (!(cls = sysfs_open_class("i2c-adapter"))) {
-		ret = -SENSORS_ERR_PROC;
+		/* not an error - sensors completely without I2C is possible */
 		goto exit0;
 	}
 
Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


