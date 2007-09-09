From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Sep 2007 15:20:41 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <20070909172041.7c30b57e@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_4pninQRu6JH_FitB2GR1ilj"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--MP_4pninQRu6JH_FitB2GR1ilj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Juerg,

On Thu, 6 Sep 2007 20:01:04 -0700, Juerg Haefliger wrote:
> > We must rework the checks in the dme1737 printing functions to process
> > the ignore statements properly, and to only display errors for missing
> > features, not missing channels. I'm attaching the patch I have come up
> > with. I can't test it as I do not have the hardware. Juergen, can you
> > please test and report?
> >
> > Juerg, can you please review and test too?
> 
> Ok I'm officially confused now. Your patch only prevents error
> messages if ignore statements are added. Is that the intended
> behavior?

No, it's not. See how confusing the API is, it managed to fool me.
sensors_get_label() succeeds even for missing features!

Attached is an updated patch. Voltages and temperatures part is
unchanged (honor ignore statements), fans and pwms part is much more
simple (simply ignore errors). Please test and report.

-- 
Jean Delvare

--MP_4pninQRu6JH_FitB2GR1ilj
Content-Type: text/x-patch; name=sensors-dme1737-hide-errors-v2.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensors-dme1737-hide-errors-v2.patch

Index: prog/sensors/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- prog/sensors/chips.c	(r=C3=A9vision 4791)
+++ prog/sensors/chips.c	(copie de travail)
@@ -6016,17 +6016,17 @@
=20
   if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_IN(i), &label,
 				   &valid) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_IN(i), &cur) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_IN_MIN(i), &min) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_IN_MAX(i), &max) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_IN_ALARM(i), &alarm)) {
-    if (valid) {
+      valid) {
+    if (!sensors_get_feature(*name, SENSORS_DME1737_IN(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_IN_MIN(i), &min) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_IN_MAX(i), &max) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_IN_ALARM(i), &alarm)) {
       print_label(label, 10);
       printf("%+6.2f V  (min =3D %+6.2f V, max =3D %+6.2f V)  %s\n",
 	     cur, min, max, alarm ? "ALARM" : "");
+    } else {
+      printf("ERROR: Can't get in%d data!\n", i);
     }
-  } else {
-    printf("ERROR: Can't get in%d data!\n", i);
   }
   free(label);
 }
@@ -6039,18 +6039,18 @@
=20
   if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_TEMP(i), &label,
 				   &valid) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_TEMP(i), &cur) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MIN(i), &min) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MAX(i), &max) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_ALARM(i), &alarm) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_FAULT(i), &fault)) {
-    if (valid) {
+      valid) {
+    if (!sensors_get_feature(*name, SENSORS_DME1737_TEMP(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MIN(i), &min) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MAX(i), &max) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_TEMP_ALARM(i), &alarm)=
 &&
+        !sensors_get_feature(*name, SENSORS_DME1737_TEMP_FAULT(i), &fault)=
) {
       print_label(label, 10);
       print_temp_info(cur, max, min, MINMAX, 0, 0);
       printf("%s%s\n", fault ? "FAULT  " : "", alarm ? "ALARM" : "");
+    } else {
+      printf("ERROR: Can't get temp%d data!\n", i);
     }
-  } else {
-    printf("ERROR: Can't get temp%d data!\n", i);
   }
   free(label);
 }
@@ -6071,8 +6071,6 @@
       printf("%4.0f RPM  (min =3D %4.0f RPM)  %s\n",=20
 	     cur, min, alarm ? "ALARM" : "");
     }
-  } else {
-    printf("ERROR: Can't get fan%d data!\n", i);
   }
   free(label);
 }
@@ -6092,8 +6090,6 @@
       print_label(label, 10);
       printf("%4.0f      (enable =3D %1.0f, freq =3D %6.0f Hz)\n", cur, en=
able, freq);
     }
-  } else {
-    printf("ERROR: Can't get pwm%d data!\n", i);
   }
   free(label);
 }

--MP_4pninQRu6JH_FitB2GR1ilj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_4pninQRu6JH_FitB2GR1ilj--
