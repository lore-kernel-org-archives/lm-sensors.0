From: Bjoern Gerhart <oss@extracloud.de>
Date: Tue, 29 Nov 2011 08:38:51 +0000
Subject: Re: [lm-sensors] [f75387] modifying f75375s module
Message-Id: <CABRa2T+=3hEMXCZCJ7YZDRfPDF6CQNvo56kdrfmNhWTbcT45-Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3788323958243017794=="
List-Id: <lm-sensors.vger.kernel.org>
References: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
In-Reply-To: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
To: lm-sensors@vger.kernel.org

--===============3788323958243017794==
Content-Type: multipart/alternative; boundary=000e0ce0db0077be1504b2db8c39

--000e0ce0db0077be1504b2db8c39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Monday, November 28, 2011 6:14 PM
> Subject: Re: [lm-sensors] [f75387] modifying f75375s module

> If you have a patch adding support for the F75387, can you
> submit it to
> the list ? After all, you are asking for support, so it would only be
> fair to give something back.

This is my current patch for adding f75387 support. However, meanwhile I
know because of the 11-bit temp handling the original chip model is not
supported any more yet:

--- linux-2.6.39.4-orig/drivers/hwmon/f75375s.c 2011-11-23
09:48:00.000000000 +0100
+++ linux-2.6.39.4/drivers/hwmon/f75375s.c      2011-11-25
16:16:51.000000000 +0100
@@ -40,7 +40,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] =3D { 0x2d, 0x2e, I2C_CLIENT_END =
};

-enum chips { f75373, f75375 };
+enum chips { f75373, f75375, f75387 };

 /* Fintek F75375 registers  */
 #define F75375_REG_CONFIG0             0x0
@@ -58,7 +58,8 @@
 #define F75375_REG_VOLT_HIGH(nr)       (0x20 + (nr) * 2)
 #define F75375_REG_VOLT_LOW(nr)                (0x21 + (nr) * 2)

-#define F75375_REG_TEMP(nr)            (0x14 + (nr))
+#define F75375_REG_TEMP_READ_MSB(nr)   (0x14 + (nr))
+#define F75375_REG_TEMP_READ_LSB(nr)   (0x14 + (nr) + 6)
 #define F75375_REG_TEMP_HIGH(nr)       (0x28 + (nr) * 2)
 #define F75375_REG_TEMP_HYST(nr)       (0x29 + (nr) * 2)

@@ -111,6 +112,10 @@
       s8 temp[2];
       s8 temp_high[2];
       s8 temp_max_hyst[2];
+       /* f75387: For remote temperature reading, it uses signed 11-bit
+        * values with LSB =3D 0.125 degree Celsius, left-justified in 16-b=
it
registers.
+        */
+       s16 temp11[2];
 };

 static int f75375_detect(struct i2c_client *client,
@@ -122,6 +127,7 @@
 static const struct i2c_device_id f75375_id[] =3D {
       { "f75373", f75373 },
       { "f75375", f75375 },
+       { "f75387", f75387 },
       { }
 };
 MODULE_DEVICE_TABLE(i2c, f75375_id);
@@ -205,8 +211,12 @@
       if (time_after(jiffies, data->last_updated + 2 * HZ)
               || !data->valid) {
               for (nr =3D 0; nr < 2; nr++) {
-                       data->temp[nr] =3D
-                               f75375_read8(client, F75375_REG_TEMP(nr));
+                       /* First assign the most significant byte,
therefore shift it by 8 bits */
+                       data->temp11[nr] =3D
+                               f75375_read8(client,
F75375_REG_TEMP_READ_MSB(nr)) << 8;
+                       /* ..then assign the least significant byte without
changing MSB */
+                       data->temp11[nr] =3D
+                               data->temp11[nr] | f75375_read8(client,
F75375_REG_TEMP_READ_LSB(nr));
                       data->fan[nr] =3D
                               f75375_read16(client, F75375_REG_FAN(nr));
               }
@@ -491,6 +501,17 @@
       return count;
 }

+#define TEMP11_FROM_REG(reg)   ((reg) / 32 * 125)
+
+static ssize_t show_temp11(struct device *dev, struct device_attribute
*attr,
+               char *buf)
+{
+       int nr =3D to_sensor_dev_attr(attr)->index;
+       struct f75375_data *data =3D f75375_update_device(dev);
+       return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
+}
+
+
 #define show_fan(thing) \
 static ssize_t show_##thing(struct device *dev, struct device_attribute
*attr, \
                       char *buf)\
@@ -525,12 +546,14 @@
       show_in_max, set_in_max, 3);
 static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,
       show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+/* static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0); */
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,
       show_temp_max_hyst, set_temp_max_hyst, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,
       show_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+/* static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1); */
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
       show_temp_max_hyst, set_temp_max_hyst, 1);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
@@ -689,6 +712,8 @@
               name =3D "f75375";
       else if (chipid =3D=3D 0x0204 && vendid =3D=3D 0x1934)
               name =3D "f75373";
+       else if (chipid =3D=3D 0x0410 && vendid =3D=3D 0x1934)
+               name =3D "f75387";
       else
               return -ENODEV;

@@ -711,7 +736,7 @@

 MODULE_AUTHOR("Riku Voipio");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("F75373/F75375 hardware monitoring driver");
+MODULE_DESCRIPTION("F75373/F75375/F75387 hardware monitoring driver");

 module_init(sensors_f75375_init);
 module_exit(sensors_f75375_exit);

> The relevant entries of your configuration file as well as
> the output of
> "sensors" might help.

This is the relevant part of my sensors3.conf file:
# /etc/sensors3.conf
#
chip "F75387-*"
  ignore temp1
  label temp2    "CPU_Temp"
  set temp2_min   0
  set temp2_max   80
  ignore fan1
  ignore fan2

..and this is the corresponding output of the sensors command:
[root@wnlpos ~]# LANG=3DC sensors
f75387-i2c-0-2e
Adapter: SMBus SCH adapter at 0400
in0:          +1.65 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in1:          +1.09 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in2:          +1.06 V  (min =3D  +0.00 V, max =3D  +2.04 V)
in3:          +1.02 V  (min =3D  +0.00 V, max =3D  +2.04 V)
fan1:         366 RPM  (min =3D   97 RPM)
fan2:         366 RPM  (min =3D 5882 RPM)
temp1:         -0.2 C  (high =3D +100.0 C, hyst =3D +95.0 C)
temp2:        +41.5 C  (high =3D +100.0 C, hyst =3D +95.0 C)

> Not sure I understand. Are you saying that "sensors -s" does
> not work ?

I'm wondering why the labels of the normal sensors command are not getting
interpreted and why the thresholds (in this case temp2_max) do not have any
effect. The "ignore" statements also do not have any effect. After each
modification of sensors3.conf I reloaded the module for the changes to take
effect.

When strace'ing the sensors command, some output line looks like this:
open("/sys/class/hwmon/hwmon0/device/temp2_label", O_RDONLY) =3D -1 ENOENT
(No such file or directory)

For support the "label" statements with the above sensors command, would it
be required to create such a label file for each sensor?

> You might want to remove such disclaimers from e-mails sent to public
> lists, at least if you don't want your e-mail to be ignored
> (or deleted
> as requested).

Sorry for that. I changed my email handling now for avoiding my company's
disclaimer.

Bj=F6rn

--000e0ce0db0077be1504b2db8c39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi,</p>
<p>&gt; -----Original Message-----<br>
&gt; From: Guenter Roeck [mailto:<a href=3D"mailto:guenter.roeck@ericsson.c=
om">guenter.roeck@ericsson.com</a>]<br>
&gt; Sent: Monday, November 28, 2011 6:14 PM<br>
&gt; Subject: Re: [lm-sensors] [f75387] modifying f75375s module</p>
<p>&gt; If you have a patch adding support for the F75387, can you<br>
&gt; submit it to<br>
&gt; the list ? After all, you are asking for support, so it would only be<=
br>
&gt; fair to give something back.</p>
<p>This is my current patch for adding f75387 support. However, meanwhile I=
 know because of the 11-bit temp handling the original chip model is not su=
pported any more yet:</p>
<p>--- linux-2.6.39.4-orig/drivers/hwmon/f75375s.c 2011-11-23 09:48:00.0000=
00000 +0100<br>
+++ linux-2.6.39.4/drivers/hwmon/f75375s.c =A0 =A0 =A02011-11-25 16:16:51.0=
00000000 +0100<br>
@@ -40,7 +40,7 @@<br>
=A0/* Addresses to scan */<br>
=A0static const unsigned short normal_i2c[] =3D { 0x2d, 0x2e, I2C_CLIENT_EN=
D };</p>
<p>-enum chips { f75373, f75375 };<br>
+enum chips { f75373, f75375, f75387 };</p>
<p>=A0/* Fintek F75375 registers =A0*/<br>
=A0#define F75375_REG_CONFIG0 =A0 =A0 =A0 =A0 =A0 =A0 0x0<br>
@@ -58,7 +58,8 @@<br>
=A0#define F75375_REG_VOLT_HIGH(nr) =A0 =A0 =A0 (0x20 + (nr) * 2)<br>
=A0#define F75375_REG_VOLT_LOW(nr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x21 + (=
nr) * 2)</p>
<p>-#define F75375_REG_TEMP(nr) =A0 =A0 =A0 =A0 =A0 =A0(0x14 + (nr))<br>
+#define F75375_REG_TEMP_READ_MSB(nr) =A0 (0x14 + (nr))<br>
+#define F75375_REG_TEMP_READ_LSB(nr) =A0 (0x14 + (nr) + 6)<br>
=A0#define F75375_REG_TEMP_HIGH(nr) =A0 =A0 =A0 (0x28 + (nr) * 2)<br>
=A0#define F75375_REG_TEMP_HYST(nr) =A0 =A0 =A0 (0x29 + (nr) * 2)</p>
<p>@@ -111,6 +112,10 @@<br>
=A0 =A0 =A0 =A0s8 temp[2];<br>
=A0 =A0 =A0 =A0s8 temp_high[2];<br>
=A0 =A0 =A0 =A0s8 temp_max_hyst[2];<br>
+ =A0 =A0 =A0 /* f75387: For remote temperature reading, it uses signed 11-=
bit<br>
+ =A0 =A0 =A0 =A0* values with LSB =3D 0.125 degree Celsius, left-justified=
 in 16-bit registers.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 s16 temp11[2];<br>
=A0};</p>
<p>=A0static int f75375_detect(struct i2c_client *client,<br>
@@ -122,6 +127,7 @@<br>
=A0static const struct i2c_device_id f75375_id[] =3D {<br>
=A0 =A0 =A0 =A0{ &quot;f75373&quot;, f75373 },<br>
=A0 =A0 =A0 =A0{ &quot;f75375&quot;, f75375 },<br>
+ =A0 =A0 =A0 { &quot;f75387&quot;, f75387 },<br>
=A0 =A0 =A0 =A0{ }<br>
=A0};<br>
=A0MODULE_DEVICE_TABLE(i2c, f75375_id);<br>
@@ -205,8 +211,12 @@<br>
=A0 =A0 =A0 =A0if (time_after(jiffies, data-&gt;last_updated + 2 * HZ)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| !data-&gt;valid) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (nr =3D 0; nr &lt; 2; nr++) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;temp[nr] =3D<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f75375_read8(=
client, F75375_REG_TEMP(nr));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First assign the most sign=
ificant byte, therefore shift it by 8 bits */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;temp11[nr] =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f75375_read8(=
client, F75375_REG_TEMP_READ_MSB(nr)) &lt;&lt; 8;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ..then assign the least si=
gnificant byte without changing MSB */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;temp11[nr] =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;temp=
11[nr] | f75375_read8(client, F75375_REG_TEMP_READ_LSB(nr));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data-&gt;fan[nr] =3D<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f75375_read1=
6(client, F75375_REG_FAN(nr));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
@@ -491,6 +501,17 @@<br>
=A0 =A0 =A0 =A0return count;<br>
=A0}</p>
<p>+#define TEMP11_FROM_REG(reg) =A0 ((reg) / 32 * 125)<br>
+<br>
+static ssize_t show_temp11(struct device *dev, struct device_attribute *at=
tr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)<br>
+{<br>
+ =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+ =A0 =A0 =A0 struct f75375_data *data =3D f75375_update_device(dev);<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, TEMP11_FROM_REG(data-&g=
t;temp11[nr]));<br>
+}<br>
+<br>
+<br>
=A0#define show_fan(thing) \<br>
=A0static ssize_t show_##thing(struct device *dev, struct device_attribute =
*attr, \<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buf)\<br>
@@ -525,12 +546,14 @@<br>
=A0 =A0 =A0 =A0show_in_max, set_in_max, 3);<br>
=A0static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,<br>
=A0 =A0 =A0 =A0show_in_min, set_in_min, 3);<br>
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);<br>
+/* static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0); */=
<br>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);<br>
=A0static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,<br>
=A0 =A0 =A0 =A0show_temp_max_hyst, set_temp_max_hyst, 0);<br>
=A0static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,<br>
=A0 =A0 =A0 =A0show_temp_max, set_temp_max, 0);<br>
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);<br>
+/* static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1); */=
<br>
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);<br>
=A0static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,<br>
=A0 =A0 =A0 =A0show_temp_max_hyst, set_temp_max_hyst, 1);<br>
=A0static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,<br>
@@ -689,6 +712,8 @@<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name =3D &quot;f75375&quot;;<br>
=A0 =A0 =A0 =A0else if (chipid =3D=3D 0x0204 &amp;&amp; vendid =3D=3D 0x193=
4)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name =3D &quot;f75373&quot;;<br>
+ =A0 =A0 =A0 else if (chipid =3D=3D 0x0410 &amp;&amp; vendid =3D=3D 0x1934=
)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D &quot;f75387&quot;;<br>
=A0 =A0 =A0 =A0else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;</p>
<p>@@ -711,7 +736,7 @@</p>
<p>=A0MODULE_AUTHOR(&quot;Riku Voipio&quot;);<br>
=A0MODULE_LICENSE(&quot;GPL&quot;);<br>
-MODULE_DESCRIPTION(&quot;F75373/F75375 hardware monitoring driver&quot;);<=
br>
+MODULE_DESCRIPTION(&quot;F75373/F75375/F75387 hardware monitoring driver&q=
uot;);</p>
<p>=A0module_init(sensors_f75375_init);<br>
=A0module_exit(sensors_f75375_exit);<br></p>
<p>&gt; The relevant entries of your configuration file as well as<br>
&gt; the output of<br>
&gt; &quot;sensors&quot; might help.</p>
<p>This is the relevant part of my sensors3.conf file:<br>
# /etc/sensors3.conf<br>
#<br>
chip &quot;F75387-*&quot;<br>
=A0 ignore temp1<br>
=A0 label temp2 =A0 =A0&quot;CPU_Temp&quot;<br>
=A0 set temp2_min =A0 0<br>
=A0 set temp2_max =A0 80<br>
=A0 ignore fan1<br>
=A0 ignore fan2<br></p>
<p>..and this is the corresponding output of the sensors command:<br>
[root@wnlpos ~]# LANG=3DC sensors<br>
f75387-i2c-0-2e<br>
Adapter: SMBus SCH adapter at 0400<br>
in0: =A0 =A0 =A0 =A0 =A0+1.65 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.04 V)=
<br>
in1: =A0 =A0 =A0 =A0 =A0+1.09 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.04 V)=
<br>
in2: =A0 =A0 =A0 =A0 =A0+1.06 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.04 V)=
<br>
in3: =A0 =A0 =A0 =A0 =A0+1.02 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.04 V)=
<br>
fan1: =A0 =A0 =A0 =A0 366 RPM =A0(min =3D =A0 97 RPM)<br>
fan2: =A0 =A0 =A0 =A0 366 RPM =A0(min =3D 5882 RPM)<br>
temp1: =A0 =A0 =A0 =A0 -0.2 C =A0(high =3D +100.0 C, hyst =3D +95.0 C)<br>
temp2: =A0 =A0 =A0 =A0+41.5 C =A0(high =3D +100.0 C, hyst =3D +95.0 C)<br><=
/p>
<p>&gt; Not sure I understand. Are you saying that &quot;sensors -s&quot; d=
oes<br>
&gt; not work ?</p>
<p>I&#39;m wondering why the labels of the normal sensors command are not g=
etting interpreted and why the thresholds (in this case temp2_max) do not h=
ave any effect. The &quot;ignore&quot; statements also do not have any effe=
ct. After each modification of sensors3.conf I reloaded the module for the =
changes to take effect.</p>

<p>When strace&#39;ing the sensors command, some output line looks like thi=
s:<br>
open(&quot;/sys/class/hwmon/hwmon0/device/temp2_label&quot;, O_RDONLY) =3D =
-1 ENOENT (No such file or directory)</p>
<p>For support the &quot;label&quot; statements with the above sensors comm=
and, would it be required to create such a label file for each sensor?<br><=
/p>
<p>&gt; You might want to remove such disclaimers from e-mails sent to publ=
ic<br>
&gt; lists, at least if you don&#39;t want your e-mail to be ignored<br>
&gt; (or deleted<br>
&gt; as requested).</p>
<p>Sorry for that. I changed my email handling now for avoiding my company&=
#39;s disclaimer.<br></p>
<p>Bj=F6rn</p>

--000e0ce0db0077be1504b2db8c39--


--===============3788323958243017794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3788323958243017794==--
