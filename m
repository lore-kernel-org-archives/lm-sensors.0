From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307191419.00005.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Freitag, 18. Juli 2003 10:42 Jean Delvare wrote:
> Done. Please checkout and test! I expect it to return a confidence value
> of 7 if the device was just powered up, and 4 if not. In any case, it is
> greater than the confidence 1 returned for the PCF8574A so
> sensors-detect should tell you to use the saa1064 driver.

I am very happy to tell you the detection has worked perfectly. The PCF8574 
at 0x20 has been detected with a confidence of one, the SAA1064 at 0x38 and 
0x3b has first been mis-detected (PCF8574A, conf 1), then correctly 
detected as a SAA1064 (confidence 4, not freshly powered-up). The module 
parameters are then accurate (load saa1064 first, tell pcf8574 to ignore 
0x38 and 0x3b). Well done!

Greetings,
Sascha
