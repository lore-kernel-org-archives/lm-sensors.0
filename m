From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 02 Jul 2008 18:27:21 +0000
Subject: [lm-sensors] vt1211 fan control script
Message-Id: <191fb4ca0807021127n6ed962efy3a0a31b2a6dc2b21@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I wrote a little script for manual fan control of the VT1211. It's
special as it puts the VT1211 PMW controller in automatic mode and
sets the temp thresholds to extreme levels to simulate manual control.
This is necessary since the manual mode of the VT1211 is not working.

Would it be OK to include the script with lm-sensors or should I just
put it somewhere on the lm-sensors website?

Thanks
...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
