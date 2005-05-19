From: erict@alum.rpi.edu (erict@alum.rpi.edu)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: Ticket #: 1659   it87: it8712f module stops working
Message-Id: <2a7601c4343a$058ab360$2801010a@mail2world.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083021688.1553.27.camel@localhost>
In-Reply-To: <1083021688.1553.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i was under the impression that the IT87 only supported thermistors. i
was at work without the docs. but after reading more of the datasheet
last night i realize it supports diodes, thermistors and resistors. 

so if one does not override the sensor type in sensors.conf lm_sensors
uses whatever settings the bios sets? i dind't know that. i guess i
should read more of the datasheet. is sensor type a register setting?

for kicks, i'll try to use just i2c and see if i still get a bus
collision.

and then all i have left to do is go in and try to measure the resistors
on the voltage dividers. as well as confirm how the id lines are hooked
up...

i'll send my sensors.conf when i am confident i have it all working.

thanks for all your help.
-eric 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040507/89194168/attachment.html
