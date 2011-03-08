From: "Emiliano Carnati" <carnati@ebneuro.com>
Date: Tue, 08 Mar 2011 10:04:20 +0000
Subject: [lm-sensors] [PATCH v4] hwmon: Add support for Texas Instruments
Message-Id: <45F112C42A94430E9AE76618BCA68C9F@CARNATI>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2518976093702027675=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============2518976093702027675==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0110_01CBDD80.93660440"

This is a multi-part message in MIME format.

------=_NextPart_000_0110_01CBDD80.93660440
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Dirk,=20
thanks for your work!=20

I've used your code in my system and it works fine, except for a small =
bug when the
code checks for the end of conversion flag (it should be negated)

I've extended it to work with ADS1115 (the 16 bit version) and below =
there
is the "patch of patch v4"

I hope it would be useful for someone else.

Thanks again

Emiliano.

<<<<<< start of patch >>>>>>
diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 4572024..6025a90 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -53,6 +53,12 @@ struct ads1015_data {
  struct mutex update_lock; /* mutex protect updates */
  struct attribute *attr_table[ADS1015_CONFIG_CHANNELS + 1];
  struct attribute_group attr_group;
+ int   id;
+};
+
+enum ads1015_num_id {
+ ADS1015 =3D 0,
+ ADS1115,
 };
=20
 static s32 ads1015_read_reg(struct i2c_client *client, unsigned int =
reg)
@@ -78,6 +84,7 @@ static int ads1015_read_value(struct i2c_client =
*client, unsigned int channel,
  unsigned int k;
  struct ads1015_data *data =3D i2c_get_clientdata(client);
  int res;
+ int msec;
=20
  mutex_lock(&data->update_lock);
=20
@@ -89,6 +96,14 @@ static int ads1015_read_value(struct i2c_client =
*client, unsigned int channel,
  pga =3D (config >> 9) & 0x0007;
  fullscale =3D fullscale_table[pga];
=20
+ /* for ADS1115, get the conversion time */
+ if(data->id =3D=3D ADS1115)
+ {
+  msec =3D (config >> 5) & 0x0007;
+  msec =3D 128 >> msec;
+ }
+ else
+  msec =3D 1;
  /* set channel and start single conversion */
  config &=3D ~(0x0007 << 12);
  config |=3D (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
@@ -98,12 +113,12 @@ static int ads1015_read_value(struct i2c_client =
*client, unsigned int channel,
  if (res < 0)
   goto err_unlock;
  for (k =3D 0; k < 5; ++k) {
-  schedule_timeout(msecs_to_jiffies(1));
+  schedule_timeout(msecs_to_jiffies(msec));
   res =3D ads1015_read_reg(client, ADS1015_CONFIG);
   if (res < 0)
    goto err_unlock;
   config =3D res;
-  if (config & (1 << 15))
+  if (~(config) & (1 << 15))
    break;
  }
  if (k =3D=3D 5) {
@@ -118,7 +133,10 @@ static int ads1015_read_value(struct i2c_client =
*client, unsigned int channel,
=20
  mutex_unlock(&data->update_lock);
=20
- *value =3D DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
+ if(data->id =3D=3D ADS1115)
+  *value =3D DIV_ROUND_CLOSEST(conversion * fullscale, 0x7fff);
+ else=20
+  *value =3D DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
=20
  return 0;
=20
@@ -133,7 +151,7 @@ static ssize_t show_in(struct device *dev, struct =
device_attribute *da,
 {
  struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
  struct i2c_client *client =3D to_i2c_client(dev);
- int in;
+ int in =3D 0;
  int res;
=20
  res =3D ads1015_read_value(client, attr->index, &in);
@@ -239,7 +257,9 @@ static int ads1015_probe(struct i2c_client *client,
   err =3D PTR_ERR(data->hwmon_dev);
   goto exit_remove;
  }
-
+=20
+ data->id =3D id->driver_data;
+=20
  return 0;
=20
 exit_remove:
@@ -251,7 +271,8 @@ exit:
 }
=20
 static const struct i2c_device_id ads1015_id[] =3D {
- { "ads1015", 0 },
+ { "ads1015", ADS1015 },
+ { "ads1115", ADS1115 },
  { }
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
<<<<<< end of patch >>>>>>


-----------------------------


Emiliano Carnati


------=_NextPart_000_0110_01CBDD80.93660440
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3Dtext/html;charset=3Diso-8859-1 =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.19019"></HEAD>
<BODY style=3D"PADDING-LEFT: 10px; PADDING-RIGHT: 10px; PADDING-TOP: =
15px"=20
id=3DMailContainerBody leftMargin=3D0 topMargin=3D0 bgColor=3D#ffffff=20
CanvasTabStop=3D"true" name=3D"Compose message area">
<DIV><FONT size=3D2 face=3DArial>Hi Dirk, <BR>thanks for your work! =
</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>I've used your code in my system and it =
works fine,=20
except for a small bug when the<BR>code checks for the end of conversion =
flag=20
(it should be negated)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>I've extended it to work with ADS1115 =
(the 16 bit=20
version) and below there<BR>is the "patch of patch v4"</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>I hope it would be useful for someone=20
else.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>Thanks again</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>Emiliano.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>&lt;&lt;&lt;&lt;&lt;&lt; start of patch =

&gt;&gt;&gt;&gt;&gt;&gt;<BR>diff --git a/drivers/hwmon/ads1015.c=20
b/drivers/hwmon/ads1015.c<BR>index 4572024..6025a90 100644<BR>---=20
a/drivers/hwmon/ads1015.c<BR>+++ b/drivers/hwmon/ads1015.c<BR>@@ -53,6 =
+53,12 @@=20
struct ads1015_data {<BR>&nbsp;&nbsp;struct mutex update_lock; /* mutex =
protect=20
updates */<BR>&nbsp;&nbsp;struct attribute =
*attr_table[ADS1015_CONFIG_CHANNELS +=20
1];<BR>&nbsp;&nbsp;struct attribute_group =
attr_group;<BR>+&nbsp;int&nbsp;&nbsp;=20
id;<BR>+};<BR>+<BR>+enum ads1015_num_id {<BR>+&nbsp;ADS1015 =3D=20
0,<BR>+&nbsp;ADS1115,<BR>&nbsp;};<BR>&nbsp;<BR>&nbsp;static s32=20
ads1015_read_reg(struct i2c_client *client, unsigned int reg)<BR>@@ =
-78,6 +84,7=20
@@ static int ads1015_read_value(struct i2c_client *client, unsigned int =

channel,<BR>&nbsp;&nbsp;unsigned int k;<BR>&nbsp;&nbsp;struct =
ads1015_data *data=20
=3D i2c_get_clientdata(client);<BR>&nbsp;&nbsp;int res;<BR>+&nbsp;int=20
msec;<BR>&nbsp;<BR>&nbsp;&nbsp;mutex_lock(&amp;data-&gt;update_lock);<BR>=
&nbsp;<BR>@@=20
-89,6 +96,14 @@ static int ads1015_read_value(struct i2c_client *client, =

unsigned int channel,<BR>&nbsp;&nbsp;pga =3D (config &gt;&gt; 9) &amp;=20
0x0007;<BR>&nbsp;&nbsp;fullscale =3D =
fullscale_table[pga];<BR>&nbsp;<BR>+&nbsp;/*=20
for ADS1115, get the conversion time */<BR>+&nbsp;if(data-&gt;id =3D=3D=20
ADS1115)<BR>+&nbsp;{<BR>+&nbsp;&nbsp;msec =3D (config &gt;&gt; 5) &amp;=20
0x0007;<BR>+&nbsp;&nbsp;msec =3D 128 &gt;&gt;=20
msec;<BR>+&nbsp;}<BR>+&nbsp;else<BR>+&nbsp;&nbsp;msec =3D =
1;<BR>&nbsp;&nbsp;/* set=20
channel and start single conversion */<BR>&nbsp;&nbsp;config &amp;=3D =
~(0x0007=20
&lt;&lt; 12);<BR>&nbsp;&nbsp;config |=3D (1 &lt;&lt; 15) | (1 &lt;&lt; =
8) |=20
(channel &amp; 0x0007) &lt;&lt; 12;<BR>@@ -98,12 +113,12 @@ static int=20
ads1015_read_value(struct i2c_client *client, unsigned int=20
channel,<BR>&nbsp;&nbsp;if (res &lt; 0)<BR>&nbsp;&nbsp;&nbsp;goto=20
err_unlock;<BR>&nbsp;&nbsp;for (k =3D 0; k &lt; 5; ++k)=20
{<BR>-&nbsp;&nbsp;schedule_timeout(msecs_to_jiffies(1));<BR>+&nbsp;&nbsp;=
schedule_timeout(msecs_to_jiffies(msec));<BR>&nbsp;&nbsp;&nbsp;res=20
=3D ads1015_read_reg(client, ADS1015_CONFIG);<BR>&nbsp;&nbsp;&nbsp;if =
(res &lt;=20
0)<BR>&nbsp;&nbsp;&nbsp;&nbsp;goto =
err_unlock;<BR>&nbsp;&nbsp;&nbsp;config =3D=20
res;<BR>-&nbsp;&nbsp;if (config &amp; (1 &lt;&lt; =
15))<BR>+&nbsp;&nbsp;if=20
(~(config) &amp; (1 &lt;&lt;=20
15))<BR>&nbsp;&nbsp;&nbsp;&nbsp;break;<BR>&nbsp;&nbsp;}<BR>&nbsp;&nbsp;if=
 (k =3D=3D=20
5) {<BR>@@ -118,7 +133,10 @@ static int ads1015_read_value(struct =
i2c_client=20
*client, unsigned int=20
channel,<BR>&nbsp;<BR>&nbsp;&nbsp;mutex_unlock(&amp;data-&gt;update_lock)=
;<BR>&nbsp;<BR>-&nbsp;*value=20
=3D DIV_ROUND_CLOSEST(conversion * fullscale, =
0x7ff0);<BR>+&nbsp;if(data-&gt;id =3D=3D=20
ADS1115)<BR>+&nbsp;&nbsp;*value =3D DIV_ROUND_CLOSEST(conversion * =
fullscale,=20
0x7fff);<BR>+&nbsp;else <BR>+&nbsp;&nbsp;*value =3D =
DIV_ROUND_CLOSEST(conversion *=20
fullscale, 0x7ff0);<BR>&nbsp;<BR>&nbsp;&nbsp;return 0;<BR>&nbsp;<BR>@@ =
-133,7=20
+151,7 @@ static ssize_t show_in(struct device *dev, struct =
device_attribute=20
*da,<BR>&nbsp;{<BR>&nbsp;&nbsp;struct sensor_device_attribute *attr =3D=20
to_sensor_dev_attr(da);<BR>&nbsp;&nbsp;struct i2c_client *client =3D=20
to_i2c_client(dev);<BR>-&nbsp;int in;<BR>+&nbsp;int in =3D =
0;<BR>&nbsp;&nbsp;int=20
res;<BR>&nbsp;<BR>&nbsp;&nbsp;res =3D ads1015_read_value(client, =
attr-&gt;index,=20
&amp;in);<BR>@@ -239,7 +257,9 @@ static int ads1015_probe(struct =
i2c_client=20
*client,<BR>&nbsp;&nbsp;&nbsp;err =3D=20
PTR_ERR(data-&gt;hwmon_dev);<BR>&nbsp;&nbsp;&nbsp;goto=20
exit_remove;<BR>&nbsp;&nbsp;}<BR>-<BR>+&nbsp;<BR>+&nbsp;data-&gt;id =3D=20
id-&gt;driver_data;<BR>+&nbsp;<BR>&nbsp;&nbsp;return=20
0;<BR>&nbsp;<BR>&nbsp;exit_remove:<BR>@@ -251,7 +271,8 @@=20
exit:<BR>&nbsp;}<BR>&nbsp;<BR>&nbsp;static const struct i2c_device_id=20
ads1015_id[] =3D {<BR>-&nbsp;{ "ads1015", 0 },<BR>+&nbsp;{ "ads1015", =
ADS1015=20
},<BR>+&nbsp;{ "ads1115", ADS1115 },<BR>&nbsp;&nbsp;{=20
}<BR>&nbsp;};<BR>&nbsp;MODULE_DEVICE_TABLE(i2c,=20
ads1015_id);<BR>&lt;&lt;&lt;&lt;&lt;&lt; end of patch=20
&gt;&gt;&gt;&gt;&gt;&gt;<BR></FONT></DIV>
<DIV>
<DIV><SPAN style=3D"FONT-FAMILY: Arial; COLOR: #333333; FONT-SIZE: =
10pt">
<P><FONT color=3D#000000></FONT><FONT color=3D#000000></FONT><FONT=20
color=3D#000000></FONT><FONT=20
color=3D#000000></FONT><BR>-----------------------------<BR></P>
<P><STRONG>Emiliano =
Carnati</STRONG><BR></P></SPAN></DIV></DIV></BODY></HTML>

------=_NextPart_000_0110_01CBDD80.93660440--



--===============2518976093702027675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2518976093702027675==--

