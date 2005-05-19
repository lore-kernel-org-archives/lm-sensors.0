From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Die revision codes
Message-Id: <20030720225452.3747240a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I am working for the LM Sensors project, which is an effort of building
and providing some essential tools for monitoring the hardware health of
Linux systems. You may take a look at our project page there:
  http://www.lm-sensors.nu/

Amongst many other tools, we have one that detects the sensor chipsets
on I2C busses. In order to have reliable detection routines, we need to
know as much as possible about sensor chipsets than can be found in PCs.
The datasheets available on your website are very great and useful, but
unfortunately some details are unclear or missing. Here are some
questions I would very like to have answers to. This would make our
support for your chipsets better.

All questions are aimed at the "stepping/die revision code" register.

* LM81
The datasheet is unclear about the stepping (register 0x3F). The comment
says the revisions will start with 1, but the power-on default is said
to be "0000 0011", that is, 3. Which value should we trust?

* LM83
No stepping value is given for the LM83. Can you give us the possible
values?

* LM86, LM89, LM90
The datasheets say the die revision codes start at 0x11, 0x31 and 0x21
respectively, and will increment by one everytime there is a revision to
the die. To which extent can the die revisions be increased? Are the
whole 0x11-0x20, 0x31-0x40 and 0x21-0x30 ranges used?

Thanks a lot for your help and time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
