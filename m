From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Super-IO
Message-Id: <4047E115.5060709@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040229094305.202636c1.khali@linux-fr.org>
In-Reply-To: <20040229094305.202636c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I got it from common sense and experience in testing.
If there is no chip there that responded to the enable sequence,
then when you attempt to read the device ID, nothing responds.
I suppose that either all zeros or all ones is possible,
depending on motherboard implementation (i.e. are there pullups on the bus).

Jean Delvare wrote:
> Hi all,
> 
> I've changed our exit sequence policy for super io chips (and added some
> new ones).
> 
> The "OxAA" sequence seems to be the exit counterpart of the "password"
> sequence used to enter chips. Looks like chips implement it so that we
> don't need to return *all* devices to the wait-for-key state as said in
> the PNP ISA spec (what writing 0x02 to register 0x02 does). So in case
> we detected a chip we know, use its exit sequence if it has one. If not,
> use the standard (more intrusive) PNP ISA way.
> 
> It's not perfect yet since the exit sequence doesn't really depend on
> chips but on chip families, so we should group chips by family to limit
> the number of probes and risks of messing something up. Also, the Nat'l
> chips do not have an enter sequence so they are likely to answer *all*
> enter sequence, so we are likely to use the bad exit sequence here
> (although it doesn't matter much; since there is no enter sequence,
> there is no real need for an exit sequence).
> 
> Anyway I tested the new code on an IT8712F and it seems to work. More
> tests welcome.
> 
> MDS, I could see that you consider device IDs of 0xFF as "not detected".
> Couldn't find anything of that kind in any spec. Where did you get that
> from? Shouldn't we also consider 0x00 the same? I got that on my laptop.
> 
> Thanks.
> 
