From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: IPMI (BMC) lm-sensors
Message-Id: <20020808145503.T10637@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mostly it's because there hasn't been the effort/time/interest.  
There are also some mild arguments against depending on platform
specific features, like IPMI, instead of driving the hardware directly
(a POSIX thing), but we'd like to see an IPMI driver.

The implementation would be pretty basic, I would think.  It would be 
like a chip driver (see chips/lm75.c) which doesn't depend on a bus 
driver.  Since this could migrate into the mainstream kernel, it would 
need to support, or at least cleanly stub out, on unsupport 
architectures instead of causing compiling nightmares.

Mark, any comments on this?


Phil

On Thu, Aug 08, 2002 at 05:24:34PM -0400, GOBEILLE,BOB (HP-FtCollins,ex1) wrote:
> Phil,
> I see from the lm-sensors newdrivers web page that there is no support
> planned for IPMI (BMC).  Is this because the lm-sensors developers don't
> think that IPMI support belongs in lm-sensors or because no one has had the
> time to do it or because no one has hardware with a BMC?
> 
> I work in the Hewlett Packard Linux R&D lab and I would sure like lm-sensors
> to talk IPMI so that existing tools that use lm-sensors will work with the
> BMC machines that we have.  We don't have anyone in the lab who is very
> familiar with lm-sensors so if we tried to contribute this we would be
> starting from scratch.  This is still a possibility but I wanted to get an
> idea if there was a philisophical argument against putting IPMI into
> lm-sensors.
> 
> Thanks,
> Bob Gobeille
> Hewlett Packard Corporation
> Bob.Gobeille@hp.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
