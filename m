From: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: 2.5.54 lm_sensors stuff
Message-Id: <200301100001.59064.spstarr@sh0n.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I managed to get my sensors chip 

w83782d-i2c-0-2d
Adapter: SMBus AMD75x adapter at e4e0

Working with 2.5.54 but its very ugly hacking and backports some minor 
changes.

the w83782d driver isn't in 2.5.54 (haven't checked .55 yet) but this works 
with a few minor changes.

Shawn.

