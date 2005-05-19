From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: LM75 detection reworked
Message-Id: <20040703105636.6ba726d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As a consequence of the discovery that the LM77 is not compatible with
the LM75, I have been reworking the LM75 detection process in both
sensors-detect (yesterday) and the lm75 driver (today). The main idea is
to take benefits of the no register addresse which always return the
last read value. Additionally, the driver now checks the unused bits (I
was surprises that it wasn't done yet, since it's a common technique).
Anyone with a good old LM75 chip, or supposedly compatible chip, or
reputedly not compatible and possibly misdetected chip, is welcome to
give it a try and report.

If it works OK, I'll send a similar change to Greg for 2.6.

-- 
Jean Delvare
http://khali.linux-fr.org/
