From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: linking against libsensors
Message-Id: <20040617171623.GA3760@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406170815240.13125@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406170815240.13125@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* James Olin Oden <joden@lee.k12.nc.us> [2004-06-17 08:20:07 -0400]:
> created the link and my test programed linked fine.  My question is, is 
> there away to tell the ld (or ld through gcc) to use a particular version 
> of a .so (for instance I had a libsensors.so.1 and a libsensors.so.1.2.1)?

I don't think so - that would defeat one reason for using a shared library.
If you want to nail down the exact library version at compile time, then pass
the '-static' option to gcc/ld during the link stage.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
