From: Scott Shanafelt <sgshanaf@gmail.com>
Date: Mon, 30 Aug 2010 20:55:53 +0000
Subject: [lm-sensors] SuperMicro X7SPE-HF configuration
Message-Id: <70021574-9260-4E1E-88F8-AE313D6A94B8@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail-4--48124091"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--Apple-Mail-4--48124091
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I am attaching my working SuperMicro X7SPE-HF configuration file for =
addition to your configurations section on the wiki (I do not have an =
account).  I found that none of the existing super micro config were =
accurate for this newer board, so I spent a fair amount of time getting =
this right.  Hope others will benefit.

This should also be exactly accurate for a SuperMicro X7SPA-HF, and is =
also likely the same for the X7SPA-L, X7SPA-H, X7SPE-H.

Regards,
Scott Shanafelt



--Apple-Mail-4--48124091
Content-Disposition: attachment;
	filename=sensors3.conf
Content-Type: application/octet-stream;
	name="sensors3.conf"
Content-Transfer-Encoding: 7bit

chip "w83627dhg-*"

	label in0 "Vcore"
	label in1 "Vnbcore"
	label in2 "AVCC"
	label in3 "3VCC"
		set in3_min 3.3 * 0.90
		set in3_max 3.3 * 1.10
	label in4 "VDIMM"
	label in5 "+5V"
		compute in5 @*4, @/4
	label in6 "+12V"
		compute in6 @*16, @/16
		set in6_min 12 * 0.90
		set in6_max 12 * 1.10
	label in7 "VSB"
	label in8 "Vbat"

	label fan1 "fan1"
		ignore fan1
	label fan2 "fan2"
		ignore fan2
	label fan3 "fan3"
		ignore fan3
	label fan4 "Case Fan"
	label fan5 "fan5"
		ignore fan5

	label temp1 "MB Temp"
	label temp2 "CPU Temp"
	label temp3 "Case Temp"

	ignore cpu0_vid

--Apple-Mail-4--48124091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Apple-Mail-4--48124091--
