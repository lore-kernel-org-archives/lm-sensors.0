From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Sep 2007 09:53:27 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <20070906115327.79e9261b@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_LI/IaRVXv=3P0mwt38/c+PU"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--MP_LI/IaRVXv=3P0mwt38/c+PU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Juerg,

On Tue, 4 Sep 2007 11:54:20 -0700, Juerg Haefliger wrote:
> > On Sun, 02 Sep 2007 14:57:32 +0200, Juergen Bausa wrote:
> > > dme1737-i2c-0-2e
> > > Adapter: SMBus nForce2 adapter at 4c00
> > > V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> > > Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > > V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > > V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > > CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > > CPU_Fan:     0 RPM  (min =3D    0 RPM)
> > > ERROR: Can't get fan3 data!
> > > ERROR: Can't get fan5 data!
> > > ERROR: Can't get fan6 data!
> > > CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> > > ERROR: Can't get pwm5 data!
> > > ERROR: Can't get pwm6 data!
> > > cpu0_vid: +1.550 V  (VRM Version 2.4)
> >
> > Juerg, sensors shouldn't be displaying these errors for optional fans
> > and pwms. Can you please provide a patch fixing this? It should be
> > pretty easy.
>=20
> Hmm... An ignore statement would take care of this. Do you have
> something else in mind?

No, users shouldn't have to add ignore statements to hide these errors,
the errors shouldn't be displayed in the first place. And as reported
by Juergen, adding ignore statements doesn't even work in the case of
the dme1737.

We must rework the checks in the dme1737 printing functions to process
the ignore statements properly, and to only display errors for missing
features, not missing channels. I'm attaching the patch I have come up
with. I can't test it as I do not have the hardware. Juergen, can you
please test and report?

Juerg, can you please review and test too?

Admittedly this libsensors interface is confusing, the good news is
that the future library handles the ignore statements all by itself so
all these problems are gone :)

--=20
Jean Delvare

--MP_LI/IaRVXv=3P0mwt38/c+PU
Content-Type: text/x-patch; name=sensors-dme1737-hide-errors.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensors-dme1737-hide-errors.patch

Index: prog/sensors/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- prog/sensors/chips.c	(r=C3=A9vision 4783)
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
@@ -6063,16 +6063,16 @@
=20
   if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_FAN(i), &label,
 				   &valid) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_FAN(i), &cur) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_FAN_MIN(i), &min) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_FAN_ALARM(i), &alarm)) {
-    if (valid) {
+      valid) {
+    if (!sensors_get_feature(*name, SENSORS_DME1737_FAN(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_FAN_MIN(i), &min) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_FAN_ALARM(i), &alarm))=
 {
       print_label(label, 10);
       printf("%4.0f RPM  (min =3D %4.0f RPM)  %s\n",=20
 	     cur, min, alarm ? "ALARM" : "");
+    } else {
+      printf("ERROR: Can't get fan%d data!\n", i);
     }
-  } else {
-    printf("ERROR: Can't get fan%d data!\n", i);
   }
   free(label);
 }
@@ -6085,15 +6085,15 @@
=20
   if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_PWM(i), &label,
 				   &valid) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_PWM(i), &cur) &&
-      !sensors_get_feature(*name, SENSORS_DME1737_PWM_ENABLE(i), &enable) =
&&
-      !sensors_get_feature(*name, SENSORS_DME1737_PWM_FREQ(i), &freq)) {
-    if (valid) {
+      valid) {
+    if (!sensors_get_feature(*name, SENSORS_DME1737_PWM(i), &cur) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_PWM_ENABLE(i), &enable=
) &&
+        !sensors_get_feature(*name, SENSORS_DME1737_PWM_FREQ(i), &freq)) {
       print_label(label, 10);
       printf("%4.0f      (enable =3D %1.0f, freq =3D %6.0f Hz)\n", cur, en=
able, freq);
+    } else {
+      printf("ERROR: Can't get pwm%d data!\n", i);
     }
-  } else {
-    printf("ERROR: Can't get pwm%d data!\n", i);
   }
   free(label);
 }

--MP_LI/IaRVXv=3P0mwt38/c+PU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_LI/IaRVXv=3P0mwt38/c+PU--
