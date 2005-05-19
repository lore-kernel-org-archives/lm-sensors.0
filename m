From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: CVS write access
Message-Id: <20020920103817.W20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


For this first round, could you send a diff?  I'd be happy to review
it and submit it for you.  Then, I will ask to have you added to the
cvs writers list.  Thanks in advance for the help with the coding!


Phil

On Fri, Sep 20, 2002 at 01:26:22PM -0400, Dave Johnson wrote:
> I have made some improvements and a couple bug fixes in the lm_sensors2
> sources, and would like to contribute them to the codebase.  
> 
> The main change was to implement vrm settings other than 8.2 for the lm87
> module.  This is the chip used on Supermicro's P4LDR and possibly other
> motherboards.  Another change was to fix the W83781D_INIT_IN_[01] macros,
> to account for the fact that vid is now scaled by 1000 rather than 100.
> 
> Also I modified the library chips.c to separate out the adm1023 from
> the others, since it scales remote_temp values by 1000.
> 
> I could send you diffs, but I've been using cvs for nearly 10 years
> now, and it would be easier for me to just check them in.
> 
> As a username, I'd prefer "ddj"...  the password hash is
> 
> [snip!]
> 
> Thanks,
> 
> 	-- ddj
> 
> 	Dave Johnson
> 	ddj@cascv.brown.edu
> 	Brown University TCASCV
> 	(401) 863-7294

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
