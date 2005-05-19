From: shawn.starr@datawire.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Ticket # 1046 - More info
Message-Id: <200211050957.33015.shawn.starr@datawire.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have upgraded kernel to 2.5.46 lm_sensors is still working fine.

The i2c chipset is AMD 768 (MPX).  Those beeps should be there if there should 
be an ALARM. So, that's ok.

I don't believe i have one of those ASUS sensor chips since the w83782d is 
working(?).

------------------------------------------------------------------------------------------------------

Reply from support:

beeps are messed up on some w83782d?s.
you can echo 0 0 > /proc/sys/dev/sensors/w83782d-i2c-0-2d/beep
which should stop it.

On the error, never seen that before, but I wouldn?t worry about it,
it seems to be working anyway.
What adapter are you using? (i2c-piix4, for example)
Then maybe we can track it down.
email us sensors@stimpy.netroedge.com, reference your ticket number.

MDS 11/4/02

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net
