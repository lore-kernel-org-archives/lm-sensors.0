From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors and grsecurity
Message-Id: <20041222174625.3fd7589c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41C993CC.4060408@edeca.net>
In-Reply-To: <41C993CC.4060408@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have been trying to get sensors and grsecurity playing nicely
> however it seems that this is impossible if /dev/port restrictions are
> enabled.
> Unfortunately, these restrictions come along with the ones on /dev/kmem
> and /dev/mem, so I don't really want to disable them.
> 
> If my W83697HF only detects on the ISA bus, is it going to be
> impossible to read data from it without access to /dev/port?

The sensors-detect script uses /dev/port, but the driver itself
obviously doesn't (since it belongs to kernel space). Thus there should
be no issue (other than sensors-detect not working, but if you already
know which devices you have, you don't need it anyway.

-- 
Jean Delvare
http://khali.linux-fr.org/
