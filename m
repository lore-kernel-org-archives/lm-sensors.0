From: tvann@extremenetworks.com (Timothy Vann)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Any work done on subordinate buses?
Message-Id: <CEA6A588893A0A47915874C1E8FF2307A4CC39@rtp-msexch-01.rtp.extremenetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm working on a project where I have a single SMBUS connected to an I2C
switch which fans out to different cards.  I was wondering if there had been
any work done to support this sort of setup?  If not any suggestions on the
best approach?  I had thought about doing a chip driver for the switch that
could select the subordinate bus but I'm not sure the best way to add the
subordiante buses such that the switch gets set properly when a subordinate
bus is accessed.

Regards,
Tim Vann
tvann@extremenetworks.com

PS - I'm not on the mailing list so please respond directly, also if someone
could add me to the mailing list I would appreciate it.
