From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: flex scanner jammed
Message-Id: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After my freeze of ISA-Bus I get now:

Ok, now I get:

Next adapter: uni-n 0 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!

Next adapter: uni-n 1 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!

Next adapter: mac-io 0 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client at address 0x34 can not be probed - unload all client drivers first!
Client at address 0x56 can not be probed - unload all client drivers first!

Before lm-sensors successfully found several sensors but jammed at the ISA check...

When I type sensors now I get:
flex scanner jammed

Thanks for hints and Feedback.

Zeno
