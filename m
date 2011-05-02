From: Mike Eneboe <meneboe@ridgellc.com>
Date: Mon, 02 May 2011 17:22:31 +0000
Subject: [lm-sensors] Adding 83627ehf input to sensors
Message-Id: <4DBEE857.3010709@ridgellc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Lanner 8875B and it implements power supply fault sensing on 2 
GPIO bits (36 and 37) of 83627ehf chip.  I cannot figure out how to 
integrate those 2 pins into the sensors functionality so that I can get 
simpler enclosure monitoring for ALL aspects.

Can you give me a clue on how to do this?

I'm using Ubuntu 10.04 LTS.

Regards,

Mike Eneboe
Ridge Partners, LLC

P.S. Does anyone have a link to a comprehensive document for how all the 
signals are brought into the OS and how to link them to ACPI?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
