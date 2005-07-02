From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 02 Jul 2005 17:47:59 +0000
Subject: [lm-sensors] My 333 DIMMs are only being recognised as 266 by
Message-Id: <42C6B708.8080900@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <d8jidr$7rp$1@saturn.local.net>
In-Reply-To: <d8jidr$7rp$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Rudolf,
> 
> thanks for the reply, but isn't this more or less what decode-dimms.pl does too?  That
> is my understanding.  I know this is probably a little OT on this list, but I was hoping
> someone could take a look at the listing from decode-dimms (http://jessen.ch/files/spd-decoded)
> and explain to me (very slowly) what makes this DIMM 266MHz and not 333MHz ? 

Hi again,

I have time now after exams and yes now I know where to look. :)

Cycle Time (SDRAM) highest CAS latency	6ns
6ns -> 166MHz * 2 = DDR333 * 8B -> PC2666 (2700)

So the DIMM is capable of running at "333MHz".

Did you tried to upgrade the BIOS?

regards

Rudolf

