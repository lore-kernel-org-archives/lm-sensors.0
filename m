From: DOSProfi@web.de (Enrico Bartky)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: PC87591x
Message-Id: <42418B75.3080707@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I read (and try to understand) the PC87591x spec. 
(http://www.national.com/ds.cgi/PC/PC87591E.pdf). The problem is, the 
temperature is only readable through the whole pc87591x memory. And in 
some versions the ADC controller for temp. readings is disabled. To 
enable this, it is neccessary to set a bit.

But how to read/write the pc87591x memory?
It is possible to map the memory to a address of the bios memory ( 
0xFFE0 0000 - 0xFFFF FFFF ) through the LDN 0x0F and the register 0xF4.

If the mapping is activated, how to read the address 0xFFE0 0000 ???? 
cat /proc/iomem says 0xFF80 0000 - 0xFFFF FFFF is reserved. I also tried 
it with ioremap.

Is anybody working on this? Or can help?

EnricoB
