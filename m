From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Dec 2008 15:44:29 +0000
Subject: Re: [lm-sensors] sensord exits on any error
Message-Id: <20081214164429.3972b6fe@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/ypo=OydpXxGrwkbY8xb8+p3"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
In-Reply-To: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
To: lm-sensors@vger.kernel.org

--MP_/ypo=OydpXxGrwkbY8xb8+p3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andy,

On Fri, 12 Dec 2008 15:45:35 -0600 (CST), Andy Poling wrote:
> It is kind of embarrassingly simple.  I hope a unified diff is acceptable.

A unified diff is perfect. However I do not think the fix is as simple
as you suggested. The original code has a rather fragile way to handle
sleep times between actions, and now that failures no longer break the
loop, odd things can happen. In particular, with your patch, I hit a
case where the system log would get filled at a very high rate on
permanent errors, presumably because sleep() was called with negative
values.

Please see my attached patch which hopefully fixes all the issues. It
worked fine for me. Main differences with your original patch:
* Errors on reloadLib() are logged.
* Errors are logged using sensorLog() instead of syslog().
* Error messages use %d instead of %m. %m read errno but the sensord
  code doesn't set errno.
* Each of the 3 actions are handled separately, even if one fails, the
  other ones are attempted.

Please give it a try and report.

Thanks,
-- 
Jean Delvare

--MP_/ypo=OydpXxGrwkbY8xb8+p3
Content-Type: text/x-patch; name=sensord-survive-transient-errors.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=sensord-survive-transient-errors.patch

Index: prog/sensord/sensord.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- prog/sensord/sensord.c	(r=C3=A9vision 5564)
+++ prog/sensord/sensord.c	(copie de travail)
@@ -85,27 +85,30 @@
=20
   sensorLog (LOG_INFO, "sensord started");
=20
-  while (!done && (ret =3D=3D 0)) {
-    if (ret =3D=3D 0)
-      ret =3D reloadLib ();
-    if ((ret =3D=3D 0) && scanTime) { /* should I scan on the read cycle? =
*/
-      ret =3D scanChips ();
-      if (scanValue <=3D 0)
-        scanValue +=3D scanTime;
+  while (!done) {
+    ret =3D reloadLib ();
+    if (ret)
+      sensorLog (LOG_NOTICE, "config reload error (%d)", ret);
+    if (scanTime && (scanValue <=3D 0)) {
+      if ((ret =3D scanChips ()))
+        sensorLog (LOG_NOTICE, "sensor scan error (%d)", ret);
+      scanValue +=3D scanTime;
     }
-    if ((ret =3D=3D 0) && logTime && (logValue <=3D 0)) {
-      ret =3D readChips ();
+    if (logTime && (logValue <=3D 0)) {
+      if ((ret =3D readChips ()))
+        sensorLog (LOG_NOTICE, "sensor read error (%d)", ret);
       logValue +=3D logTime;
     }
-    if ((ret =3D=3D 0) && rrdTime && rrdFile && (rrdValue <=3D 0)) {
-      ret =3D rrdUpdate ();
+    if (rrdTime && rrdFile && (rrdValue <=3D 0)) {
+      if ((ret =3D rrdUpdate ()))
+        sensorLog (LOG_NOTICE, "rrd update error (%d)", ret);
       /*
        * The amount of time to wait is computed using the same method as
        * in RRD instead of simply adding the interval.
        */
       rrdValue =3D rrdTime - time(NULL) % rrdTime;
     }
-    if (!done && (ret =3D=3D 0)) {
+    if (!done) {
       int a =3D logTime ? logValue : INT_MAX;
       int b =3D scanTime ? scanValue : INT_MAX;
       int c =3D (rrdTime && rrdFile) ? rrdValue : INT_MAX;
@@ -117,10 +120,7 @@
     }
   }
=20
-  if (ret)
-    sensorLog (LOG_INFO, "sensord failed (%d)", ret);
-  else
-    sensorLog (LOG_INFO, "sensord stopped");
+  sensorLog (LOG_INFO, "sensord stopped");
=20
   return ret;
 }

--MP_/ypo=OydpXxGrwkbY8xb8+p3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/ypo=OydpXxGrwkbY8xb8+p3--
