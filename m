From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: max1617a
Message-Id: <20040515084558.6acb8b29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509133827.04734a7e.khali@linux-fr.org>
In-Reply-To: <20040509133827.04734a7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

Sorry for the delay, been busy.

> 1* I'm running lm_sensors 2.8.6
> 2* Linux kernel 2.6.5 (but with some chenges in DRI section) i2c
> compilet as modules
> 3* Full output in attachment (sens.txt)

OK, your MAX1617A is probably at 0x4d, but sensors-detect doesn't think
it is a MAX1617A. Please provide a full dump of the chip so that I have
a chance to understand why:

i2cdump 0 0x4d

"0" is the bus number, it could be different from 0, depends on how much
bus drivers you have and the order in which they loaded. If 0 doesn't
work, try 1, 2... etc until it works ;)

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
