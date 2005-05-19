From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors and grsecurity
Message-Id: <41C993CC.4060408@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have been trying to get sensors and grsecurity playing nicely however
it seems that this is impossible if /dev/port restrictions are enabled.
 Unfortunately, these restrictions come along with the ones on /dev/kmem
and /dev/mem, so I don't really want to disable them.

If my W83697HF only detects on the ISA bus, is it going to be impossible
to read data from it without access to /dev/port?

Thanks,

David
