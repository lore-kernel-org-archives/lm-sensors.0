From: bennyc@rtunet.com (Benny Chen)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Writing new driver for FM3104 on Cirrus 9301 processor
Message-Id: <200504130348.j3D3mOi0012882@serv0.rtunet.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guys,
I have gone through much of the doco and really need your help. I am about
to embark on writing a driver for the RTC and Watch Dog timer for our
system.  I have some questions and hopefully you can help.
 
In our system, the FM3104 chip?s SCL and SDA line are connected to the EECLK
and EESDA (like GPIO) line on the processor.  Hence, I would need to use
some bit bang algo to talk to the chip.  But I would want to maximise the
use of existing code in the i2c directory but don?t know what I should be
writing.    
 
 
1.	For both the RTC and Watch dog drivers, do I need to write both the
adapter driver and Driver driver  or just a driver like the ds1307.c?
2.	Which existing src would be a good template for me?
3.	The DS1307. c code, it do not have an i2c_adapter structure defined,
Hence, how do it knows what algo it would use to talk to the DS1307 chip? 
 
Thank you so much for your help.
 
Regards,
 
Benny Chen
R & D Firmware Engineer
 
RTUnet Pty Ltd
Innovation Centre
90 Sippy Downs Drive
Sippy Downs Qld
4556
 
Phone +61 7 54594560
Fax +61 7 54594563
 

-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.9.7 - Release Date: 12/04/2005
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050413/6fd5f2d7/attachment.html
