From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: CPU temp does not update
Message-Id: <20050124200048.3a33a43f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

> I cannot get the CPU temp to update, from  cold (after being powered
> down  overnight for example) sensors will report a temp of approx
> 16-17c and it  will not move. If I run for a while and reboot, CPU
> temp will then show  something like 45-50c and again it will not move.
> In both cases this is  similar to the temp reported by BIOS as the
> system boots. I think I have shown the relevant information below.
> 
> Any suggestions will be gratefully received.

You configuration looks OK. I would like you to test and answer the
following:

1* Do the voltage and fan speeds change? IOW, is the whole chip stuck or
only the temperature channels?

2* If you sit in the BIOS, can you see the temperatures change, or not?

3* If you unload and reload the w83627hf driver, do the temperatures
(sometimes) change?

4* Please provide a dump of the chip (isadump 0x295 0x296).

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
