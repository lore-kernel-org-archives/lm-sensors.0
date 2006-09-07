From: A.Huisman@inter.nl.net (Age Huisman)
Date: Thu, 07 Sep 2006 12:10:21 +0000
Subject: [lm-sensors] Answer Epox
Message-Id: <200609071410.21618.A.Huisman@inter.nl.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I got a answer from Epox :

Dear Age,

Sorry for that due to the datesheed is confidential.So we can't share it to
you.
But we can share the register for you reference.That's all we can share to
you.
See attachment.

Thank you for your interest in EPoX products and contacting our support
department. If you reply ensure to include all previous E-mail text. It will
prevent unnecessary delays and guarantee the fastest possible response.

Best Regards,

========================Technical Support (AFA)
EPoX Computer Co., LTD. (Head office)
E-Mail : support at epox.com.tw
Web : www.epox.com
Please provide previous E-mail text if replying.
Specifications subject to change without notice.


ISA bridge index port 295h.
ISA bridge data port 296h.

Address		Attribute		Description
===========================================20h		RO			VCC3V reading. The unit of reading is 8mV.
21h		RO			V1(Vcore)reading. The unit of reading is 8mV.
22h		RO			V2 reading. The unit of reading is 8mV.
23h		RO			V3 reading. The unit of reading is 8mV.
24h		RO			V4 reading. The unit of reading is 8mV.
25h		RO			V5 reading. The unit of reading is 8mV.
26h		RO			V6 reading. The unit of reading is 8mV.
27h		RO			VSB3V reading. The unit of reading is 8mV.
28h		RO			VBAT reading. The unit of reading is 8mV.
===========================================72h		RO			Temperature 1 reading. The unit of reading is
					1 degree C. At the moment of reading this reg.
74h		RO			Temperature 2 reading. The unit of reading is
					1 degree C. At the moment of reading this reg.
76h		RO			Temperature 3 reading. The unit of reading is
					1 degree C. At the moment of reading this reg.
===========================================A0h		RO			FAN1 count reading(MSB). At the moment of
					reading this register, the LSB will be latched
					. This will prevent from data updating when 
					reading. To read the fan count correctly, read
					MSB first and followed read the LSB.
A1h		RO			FAN1 count reading(LSB).
B0h		RO			FAN2 count reading(MSB). At the moment of
					reading this register, the LSB will be latched
					. This will prevent from data updating when 
					reading. To read the fan count correctly, read
					MSB first and followed read the LSB.
B1h		RO			FAN2 count reading(LSB).
C0h		RO			FAN3 count reading(MSB). At the moment of
					reading this register, the LSB will be latched
					. This will prevent from data updating when 
					reading. To read the fan count correctly, read
					MSB first and followed read the LSB.
C1h		RO			FAN3 count reading(LSB).
D0h		RO			FAN4 count reading(MSB). At the moment of
					reading this register, the LSB will be latched
					. This will prevent from data updating when 
					reading. To read the fan count correctly, read
					MSB first and followed read the LSB.
D1h		RO			FAN4 count reading(LSB).
===========================================The formula is voltage divided formula as following below:

VIN = V(+12V) * (R2 / (R1 + R2)) where V(+12V) is the analog input voltage.
===========================================The formula is fan count / RPM calculated formula as following below:

RPM = (1.5 * 10 ^ 6) / Count where ^ is the exponent symbol.
===========================================
Age Huisman




