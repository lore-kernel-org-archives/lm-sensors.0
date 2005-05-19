From: dan@sandworm.co.uk (Daniel Heath)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: GL520SM Problem
Message-Id: <1084022241.6755.316.camel@alpine>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am attempting to hack together a 2.6 port of the GL520SM chip driver. 
I am a little confused as to the relationship between temp2_input, and
vin4_input values.  

The way I understand it, the GL520SM can either be configured to monitor
ambient temperature, or the 4th voltage input.  This is done by
setting/unsetting the 4th bit of the config register.

However when I set the mode bit, the value of the temp2_input register
does not change.  I would have expected it to switch over to the
vin4_input reading, and not remain the exact same value.  Also the
alarms do not trigger when the mode bit is set, and vin4_input is out of
range of vin4_max, and vin4_min.

Is there some kind of reset I have to do on the chip other than just
setting the mode bit?

Regards,

Daniel

