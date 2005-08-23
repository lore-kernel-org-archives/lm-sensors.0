From: phil@philedelbrock.com (Phil Edelbrock)
Date: Tue, 23 Aug 2005 06:55:32 +0000
Subject: [lm-sensors] Fw: Processes causing CPU to overheat
Message-Id: <7C03092E-BD95-4D06-8914-960A2ECC5435@philedelbrock.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <430A5153.2040604@linux-migration.net>
In-Reply-To: <430A5153.2040604@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Aug 22, 2005, at 4:27 PM, Jon Roland wrote:

> Thanks for your response. No, it's not dust. Problem hasn't  
> recurred, so I can't open the case to see if the fan has stopped or  
> slowed when the temp begins to rise, but that is an obvious next  
> move if it does.

Yeah, you should be able to peg that CPU to 100% usage forever  
without an overheat.  The ITE 8712F /does/ have a dedicated CPU fan  
speed control, so it's possible something is mucking with it to make  
it shut off or slow down that fan.

>
> Of course, mechanical problems would not correlate with CPU load,  
> processes, and disk load, stopping the CPU fan (or increasing power  
> to the CPU) when the nice usage (not system or user) pegs at 100%,  
> and dropping back to normal when the first perl process is killed,  
> which also causes all the other perl processes to end, and the nice  
> usage to drop to zero. Nothing else causes the CPU temp to rise. I  
> have done this process kill twice now, so it is not a coincidence.

Well, if you did have a slow CPU fan (say, all the time), it's likely  
the CPU temp would remain low when it's not under load.  It would  
just make it rise a lot quicker when it got busy (as you may be  
experiencing).

And, 'nice' processes will heat up a cpu as fast as any other  
process. It's just a process queue priority thing.  The CPU never  
knows the difference what a 'nice' process is vs. another one.

>
> I don't know why my log file is truncated at 80 columns to reveal  
> more information about those perl processes.

You could try using ps instead.  You can specify a columns value  
there (e.g. ps aux --colsP0).  It could be processes processing log  
files or something.

Good luck!


Phil
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 2373 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050823/7a813001/smime.bin
