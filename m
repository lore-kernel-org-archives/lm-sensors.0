From: =?ISO-8859-1?Q?Per_Dal=E9n?= <per.dalen@appeartv.com>
Date: Wed, 01 Jun 2011 08:02:25 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <4DE5F211.2090003@appeartv.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040700060708020202010600"
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700060708020202010600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the new patch for sensors-detect.

Changed according to the suggestions from Jean Delvare:

* Check the manufacturer ID directly. Fastens the test if it's not a
Maxim chip.
* Read the other non-existing registers after the manufacturer ID.
* Read the other non-existing registers after the status.
* Removed NO_CACHE from manufacturer ID, Status and Configuration registe=
rs.

BR
Per

On 05/26/2011 09:33 PM, Jean Delvare wrote:
> Hi Per,
>=20
> On Thu, 26 May 2011 11:27:27 +0200, Per Dal=E9n wrote:
>> Changed according to the suggestions from Guenter Roeck:
>>
>> * Check the manufacturer ID directly. Fastens the test if it's not a
>> Maxim chip.
>> * Read the other non-existing registers after the manufacturer ID.
>=20
> THis is better but I'm not completely happy yet.
>=20
>> This patch adds detection of MAX6642 to sensors-detect.
>>
>> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
>> ---
>>
>> --- prog/detect/sensors-detect	(revision 5975)
>> +++ prog/detect/sensors-detect	(working copy)
>> @@ -848,6 +848,11 @@
>>  		i2c_addrs =3D> [0x2c, 0x2e, 0x2f],
>>  		i2c_detect =3D> sub { max6639_detect(@_); },
>>  	}, {
>> +		name =3D> "Maxim MAX6642",
>> +		driver =3D> "max6642",
>> +		i2c_addrs =3D> [0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f],
>=20
> Better written: [0x48..0x4f]
>=20
>> +		i2c_detect =3D> sub { max6642_detect(@_); },
>> +	}, {
>>  		name =3D> "Maxim MAX6655/MAX6656",
>>  		driver =3D> "max6655",
>>  		i2c_addrs =3D> [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
>> @@ -5779,6 +5784,36 @@
>>  	return 6;
>>  }
>>
>> +# Chip to detect: MAX6642
>> +# Registers used:
>> +#   0x02: Status register
>> +#   0x03: Configuration register
>> +#   0xfe: Manufacturer ID
>> +#   0x04,0x06,0xff: No registers
>> +# We use the 0x04,0x06 and 0xff addresses (unused) to improve the
>=20
> Space after comma please.
>=20
>> reliability.
>=20
> Please disable line wrapping in your e-mail client before sending patch=
es.
>=20
>> +# These are not real registers and will always return the last return=
ed
>> value.
>> +# This isn't documented.
>> +sub max6642_detect
>> +{
>> +	my ($file, $addr) =3D @_;
>> +	my ($man_id, $conf, $status);
>> +
>> +	$man_id =3D i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
>> +	return unless $man_id =3D=3D 0x4d;	# Maxim
>> +	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) !=3D $man_=
id;
>> +	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) !=3D $man_=
id;
>> +	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) !=3D $man_=
id;
>> +	$status =3D i2c_smbus_read_byte_data($file, 0x02, NO_CACHE);
>=20
> At this point you should check the unused status bits immediately (so
> that you can exit if they don't meet the expectations.) Then you should
> read non-registers 0x04, 0x06 and 0xff again. This is the only reliable
> way to make sure that there are no registers at these addresses. It is
> perfectly possible (though unlikely) that a given chip does have values
> 0x4d for all of registers 0x04, 0x06, 0xfe and 0xff.
>=20
> See max6657_detect() for an example.
>=20
>> +	$conf =3D i2c_smbus_read_byte_data($file, 0x03, NO_CACHE);
>=20
> NO_CACHE is not needed here, as this register 0x03 does exist. Only use
> NO_CACHE when you really need it, it's expensive!
>=20
>> +
>> +	# Bit 5, 3, 1 and 0 should be zero
>> +	return unless ($status & 0x2b) =3D=3D 0x00;
>> +	# The 4 lower bits should be zero
>> +	return unless ($conf & 0x0f) =3D=3D 0x00;
>> +
>> +	return 6;
>> +}
>> +
>>  sub max6655_detect
>>  {
>>  	my ($file, $addr) =3D @_;
>=20
>=20


--------------040700060708020202010600
Content-Type: text/plain;
 name="0001-hwmon-sensors_detect-Add-detection-of-MAX6642.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-hwmon-sensors_detect-Add-detection-of-MAX6642.patch"

This patch adds detection of MAX6642 to sensors-detect.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---
Index: prog/detect/sensors-detect
===================================================================
--- prog/detect/sensors-detect	(revision 5977)
+++ prog/detect/sensors-detect	(working copy)
@@ -848,6 +848,11 @@
 		i2c_addrs => [0x2c, 0x2e, 0x2f],
 		i2c_detect => sub { max6639_detect(@_); },
 	}, {
+		name => "Maxim MAX6642",
+		driver => "max6642",
+		i2c_addrs => [0x48..0x4f],
+		i2c_detect => sub { max6642_detect(@_); },
+	}, {
 		name => "Maxim MAX6655/MAX6656",
 		driver => "max6655",
 		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
@@ -5789,6 +5794,40 @@
 	return 6;
 }
 
+# Chip to detect: MAX6642
+# Registers used:
+#   0x02: Status register
+#   0x03: Configuration register
+#   0xfe: Manufacturer ID
+#   0x04, 0x06, 0xff: No registers
+# We use the 0x04,0x06 and 0xff addresses (unused) to improve the reliability.
+# These are not real registers and will always return the last returned value.
+# This isn't documented.
+sub max6642_detect
+{
+	my ($file, $addr) = @_;
+	my ($man_id, $conf, $status);
+
+	$man_id = i2c_smbus_read_byte_data($file, 0xfe);
+	return unless $man_id == 0x4d;	# Maxim
+	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) != $man_id;
+	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) != $man_id;
+	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) != $man_id;
+
+	$status = i2c_smbus_read_byte_data($file, 0x02);
+	# Bit 5, 3, 1 and 0 should be zero
+	return unless ($status & 0x2b) == 0x00;
+	return if i2c_smbus_read_byte_data($file, 0x04, NO_CACHE) != $status;
+	return if i2c_smbus_read_byte_data($file, 0x06, NO_CACHE) != $status;
+	return if i2c_smbus_read_byte_data($file, 0xff, NO_CACHE) != $status;
+
+	$conf = i2c_smbus_read_byte_data($file, 0x03);
+	# The 4 lower bits should be zero
+	return unless ($conf & 0x0f) == 0x00;
+
+	return 6;
+}
+
 sub max6655_detect
 {
 	my ($file, $addr) = @_;

--------------040700060708020202010600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040700060708020202010600--
