From: Arne =?utf-8?q?St=C3=A4cker?= <arnestaecker@web.de>
Date: Sun, 07 Oct 2007 14:30:59 +0000
Subject: [lm-sensors] Unknown chip on Dell Latitude D630
Message-Id: <200710071631.00273.arnestaecker@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
when I run sensors-detect, I get:

...
Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x3201
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown non-standard chip with ID 0x13
...

I'm using Gentoo (x86), kernel 2.6.22.9, lm-sensors 2.10.4.

regards
 Arne

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
