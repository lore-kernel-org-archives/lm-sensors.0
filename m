From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: PC87591x
Message-Id: <Pine.LNX.4.58.0503241057270.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42418B75.3080707@web.de>
In-Reply-To: <42418B75.3080707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi enrico.

i think this might help you

10:19 < ruik> look to page 408
10:20 < ruik> you will see IO register map
10:20 < ruik> that has also "our" devices
10:20 < Khali> true
10:20 < ruik> this is risc processor
10:20 < ruik> so adress write is IO write
10:20 < Khali> but what do I do with these 16-bit register addresses?
10:20 < ruik> registers are mapped to memory
10:20 < ruik> of controller
10:20 < ruik> and now we must find out way
10:21 < Khali> but memory of controller is different from host memory,
right?
10:21 < ruik> how to access this memory space
10:21 < ruik> yes it is
10:21 < ruik> maybe on page 313
10:21 < ruik> is such interface
10:22 < ruik> or somewhere near
10:22 < ruik> it is simply the question of finding some registers
10:22 < ruik> that we write that Address from datasheet and wait for
results
10:23 < ruik> Host Bus to Core Bus Access Translation
10:23 < ruik> I think this is what we want
10:23 < Khali> page?
10:26 < ruik> 5.3.3 Indirect Memory Read and Write Transaction
10:26 < ruik> 300
10:27 < Khali> aha
10:27 < Khali> interresting...
10:28 < Khali> that makes sense
10:28 < ruik> Yes the locking between domains
10:28 < ruik> lock access for microprocessor inside the chip
10:29 < ruik> and classic CPU access on page 300
10:30 < Khali> now, where are these 5 registers? ;)
10:31 < ruik> Shared Memory Host Register Map ?
10:31 < ruik> this ?
10:31 < Khali> logical device 0xf ?
10:32 < ruik> Shared Memory Host
10:32 < ruik> The base address is defined by LDN 0F16 (Section 5.3.8 on
page 303).
10:32 < ruik> yep
10:32 < ruik> (from page 421)
10:32 < Khali> ok
10:32 < Khali> I get it now...
10:32 < Khali> so we would have to grab logical device 0xf
10:32 < Khali> read the base address
10:32 < Khali> go there
10:32 < Khali> and use the 5 registers at this address to read/write all
the rest?
10:33 < ruik> if you mean  Shared Memory Host Register
10:33 < ruik> than yes
10:33 < Khali> that's all clear to me now
10:33 < Khali> thanks :)

Regards

Rudolf
