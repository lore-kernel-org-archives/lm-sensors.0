From: pdey@realmtech.net (Peter Dey)
Date: Tue, 07 Jun 2005 06:01:38 +0000
Subject: [lm-sensors] Maxilife LEDs?
Message-Id: <6.2.1.2.2.20050607135514.02284150@mail.realmtech.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I notice that it's possible to write to the LCD with the maxilife chipset, 
but was wondering if it would be possible to set the state of the LEDs on 
the front panel too?  As I understand, the data sheet for this chipset is 
only available under a NDA.

I believe this may be possible, because HP released some (proprietary) 
software for NT4 for "workstation locking", which illuminated the 'Lock' 
LED.  HP also modified the Intel ee100 driver on NT4 to illuminate the LAN 
LED upon activity.

I also believe the chipset has the ability to change the color of the Power 
LED from green to red...

Cheers,
Peter Dey

