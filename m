From: dgallagher@starnetusa.net (Dom Gallagher)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: Support tickets #310, #384 and #667
Message-Id: <5.1.1.2.2.20020904230835.01970628@maild.starnetinc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just a heads-up regarding these tickets and the Asus P3V4X, as the tickets 
don't appear to have a successful resolution.

I was experiencing exactly the same issues mentioned in all 3 tickets.  The 
stock sensors.conf from version 2.6.4 both fixes the temperature (temp2 
sensor) issue and more importantly the massive slowdown (almost exactly 1/4 
speed).

To confirm your guesses:

The temp alarm is what's causing the slowdown, of this I am 100% sure.  If 
I change the settings on the temp sensor 'compute' entry to trigger an 
alarm, I get massive slowdown.  When I change it back, it fixes the issue.
However, this reversal does not happen if I do not force as99127f detection 
(it stays unbearably slow until reboot).

Forcing as99127f rather than relying on 'automatic' detection via the 
w8378xd driver uses the correct sensor.conf entries, and works well all 
round.  Incidentally, sensor-detect does not detect either of the two chip 
drivers, just the base i2c-viapro.

Great piece of software, if one that causes interesting light and sound 
shows in our colo room ;)

D.
-- 
Dom Gallagher (dgallagher@starnetusa.net)
Development Engineering
StarNet/MegaPOP - http://www.megapop.net
WX is wireless - http://www.starnetwx.net

This message is sent in confidence to the addressees.
It may contain privileged, proprietary, or confidential information.

