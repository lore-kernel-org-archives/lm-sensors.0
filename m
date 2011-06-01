From: =?ISO-8859-1?Q?Per_Dal=E9n?= <per.dalen@appeartv.com>
Date: Wed, 01 Jun 2011 07:42:59 +0000
Subject: Re: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <4DE5ED83.9080702@appeartv.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040809090206010202080502"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528045113.GA8833@ericsson.com>
In-Reply-To: <20110528045113.GA8833@ericsson.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809090206010202080502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for finding this error. I have attached the patch you requested.

BR
Per

On 05/28/2011 06:51 AM, Guenter Roeck wrote:
> Hi all,
>=20
> I finally got MAX6642 samples, so I am able to play around with the chi=
p.
>=20
> The attached patch (on top of Per's most recent patch) works quite nice=
ly.
> Per, maybe you can just merge it with your patch and resubmit it.
>=20
> While testing the chip, I found another little problem: the fault attri=
bute is named
> temp_fault. That will have to be renamed to temp2_fault, first because =
it reflects
> a fault with the external diode and second to match the ABI. We will ne=
ed a separate
> patch to fix this problem.
>=20
> Here is the output of i2cdump for the MAX6642 (with open/unconnected ex=
ternal sensor).
>=20
> root@groeck-desktop:/home/groeck# i2cdump -y 5 0x48
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 18 ff 84 10 10 46 46 78 78 78 78 78 78 78 78 78    ?.???FFxxxxxxxxx
> 10: c0 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    ?@@@@@@@@@@@@@@@
> 20: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 30: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 40: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 50: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 60: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 70: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 80: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> 90: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> a0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> b0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> c0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> d0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> e0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
> f0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 4d 4d    @@@@@@@@@@@@@@MM
> root@groeck-desktop:/home/groeck# modprobe max6642
> root@groeck-desktop:/home/groeck# sensors
> max6642-i2c-5-48
> Adapter: i2c-devantech-iss at bus 001 device 007
> temp1:        +24.0=B0C  (high =3D +70.0=B0C)
> temp2:          FAULT  (high =3D +120.0=B0C)
>=20
> Thanks,
> Guenter


--------------040809090206010202080502
Content-Type: text/plain;
 name="0001-hwmon-max6642-wrong-temp_fault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hwmon-max6642-wrong-temp_fault.patch"

BUG: The temp_fault is wrong, it should be temp2_fault insteedd. 

Guenter: "While testing the chip, I found another little problem: the fault attribute is named temp_fault. That will have to be renamed to temp2_fault, first because it reflects a fault with the external diode and second to match the ABI."
Thanks Guenter for finding the bug.


Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---
diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 0f9fc40..0f30e1b 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -246,7 +246,7 @@ static SENSOR_DEVICE_ATTR_2(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
 			    set_temp_max, 0, MAX6642_REG_W_LOCAL_HIGH);
 static SENSOR_DEVICE_ATTR_2(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
 			    set_temp_max, 1, MAX6642_REG_W_REMOTE_HIGH);
-static SENSOR_DEVICE_ATTR(temp_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 
@@ -256,7 +256,7 @@ static struct attribute *max6642_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 
-	&sensor_dev_attr_temp_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	NULL

--------------040809090206010202080502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040809090206010202080502--
