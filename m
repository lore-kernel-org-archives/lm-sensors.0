From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 10 Dec 2005 09:14:30 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <439A9C76.6080906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all

> The simple drawings didn't have either pin names or numbers so I wrote
> back to GBT support asking for this additional piece of information.
> 
> Now, assuming that we have this piece of information, how would we use
> it? I guess we could disable that GPIO somehow, but that fix is very
> specific to this motherboard... Isn't it likely that other motherboard
> would need some similar patch to prevent this kind of issue?

Yes this is verys specific to this motherboard, question is

1) why the SMI is generated when setting limits?
   (Possible answer like Yuan suggested that the fans limit are above zero? (and readings are 0)
   But this whould mean that actually writing to registeters will somehow do SMI which is I must admit strange
   Unfortunately I'm very busy this weeks so I dont have much time left to dig in the chip dumps.
   Perhaps someone else could spot why the SMI is generated?

2) why it hangs

> I guess what I'm wondering is, is it hard to support the SMI
> functionality and would that be a more generic solution that would
> make the kernel survive the SMI? Or is the issue rather with a GPIO
> setup as an interrupt triggering an interrupt for which there is no
> handler installed?

SMI is a very special interrupt. It is completly transparent to operating system. When
SMI will come it will switch the processor to so called System Management Mode.
It is similar to real mode but limited to small piece of memory. Even you cant find
the SMM routine in memory because it its "hidden" bellow the video RAM (0x0A0000) (ususally)
If this routine has a bug it will hang...

You can spot the SMI only by measuring clock in system. You wont notice if smi ever occured.
(SMI is rather anoying for realtime stuff on x86)

Lets try:

Generate the SMI from other source than the fans limits (if it hangs too)
Then we will know if the complete handler is wrong or only parts.

Also are you using HIGHMEM support in kernel? I guess this might be right reason why it fails
(Due to 4MB PAE)

If so please disable and try all stuff again. If it wont freeze we spot the bug.

So what to do:
1) why is SMI generated when writing limits?
2) if SMI fan event is specific to hang or any other SMI will hang too.
3) what about highmem?

Regards
Rudolf

