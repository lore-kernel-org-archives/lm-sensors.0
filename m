From: JesseD@VersaLogic.com (Jesse Davis)
Date: Tue, 06 Dec 2005 00:22:41 +0000
Subject: [lm-sensors] Sensors for ADM1032
Message-Id: <DE69869583DEF2488E588C2908121E100DB839@vlmail1.versalogic.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there.

I work in the support department for Versalogic Corporation. We have a
board called the EBX-12. This board contains the ADM1032 chip that
should be supported by the lm90 module. The Smbus adapter is
successfully located but the Analog Devices chip is not successfully
probed. I have attached my output from "sensors-detect", "i2cdetect" and
"i2cdump". I know that this device works because I possess a DOS utility
that detects the internal CPU temperature.

Other information:
Fedora 3 kernel 2.6.9
lm-sensors version 2.8.7
Running as root user.

Thank you for any help or guidance you can provide.
Jesse Davis
VersaLogic Corporation
541-485-8575
2175 West 7th Avenue
Eugene, OR      97402



 <<sensors.txt>> 

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051206/50907449/sensors-0001.txt
