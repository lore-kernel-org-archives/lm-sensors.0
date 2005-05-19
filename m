From: marcin_ml@sekretarka.no-ip.org (Marcin =?iso-8859-2?q?Ka=B3u=BFa?=)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: clockchips via SMBus - sorry for offtopic but I can't find any help
Message-Id: <200405121723.29867.marcin_ml@sekretarka.no-ip.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello
I searched the net quite a lot to find any information on accessing mainboard 
PLL's under linux but couldn't find anything.
For windows there are many programs that can change FSB and other parameters 
without the need to reboot the PC, but they are of course closed source.
However I can't find anything about it for linux except your's icspll driver - 
can anybody give me any hint where to start looking for it (I'm particularly 
interested in nforce2 PLL/ amd 2500+ barton). 
I know there are drivers in kernel but only for mobile versions.
Can anybody tell me where's the catch - for MS there are so many progs that 
support so many chips and nothing for linux? Are these information not freely 
available? too expensive to get? 
The reason I'm looking for it is that I wanted to write some kind of 
program/daemon that would monitor system load and if it's completely idle - 
turn the clocks down to reduce heat production.
Has anybody seen something like this anywhere
Thanks for any help
Martin
