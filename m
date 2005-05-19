From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: ticket 1415
Message-Id: <20031021165335.GA24059@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F95168B.5040305@yahoo.com.au>
In-Reply-To: <3F95168B.5040305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* T Nuro <tnuro@yahoo.com.au> [2003-10-21 21:20:43 +1000]:
> -- so -- I started tinkering again (i've been sick for a week, so 
> haven't had a chance to experiment some more since my posting)
> I've always noticed that when I run sensors-detect, it seems to almost 
> always give me a different result each time I try it. Usually it bounces 
> between saying that it detects the ITE, winbond w83627thf and lm75 in 
> one case, and the next case would be only the winbond w83627thf and 
> lm75. I've always ignored the ITE chip module since every info page I 
> find on the net says that its got a winbond w83627thf......

Funny...

I tried to install lm_sensors on the very same board (Asus P4C800) last
night.  I didn't see sensors-detect recommend ITE.  Your board almost
certainly has the w83627thf - I can see by inspection that mine does.

(You wrote in the ticket):
> The error I get is:
> w83627thf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> ERROR: Can??t get alarm data!
> ERROR: Can??t get beep data!
> ERROR: Can??t get IN0 data!
> ERROR: Can??t get IN2 data!
> ERROR: Can??t get IN3 data!
> ERROR: Can??t get IN4 data!
> ERROR: Can??t get IN7 data!
> ERROR: Can??t get IN8 data!
> ERROR: Can??t get FAN1 data!
> ERROR: Can??t get FAN2 data!
> ERROR: Can??t get TEMP1 data!
> ERROR: Can??t get TEMP2 data!

Well, libsensors is indeed missing some code to support it - but that's as
far as I got.  I'll try to commit something to CVS tonight.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
