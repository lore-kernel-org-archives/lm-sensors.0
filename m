From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <20041108032839.GC16161@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again...

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-11-07 21:47:51 -0500]:
> Whatever we agree are legitimate reasons to cancel detection, I would like
> to add specific documentation for them.  I think a case can be made that
> there's *no* legitimate reason for a driver to halt detection that way...
> but I'm sure I'll hear otherwise.  As an interface, this interpretation
> of a return value (I failed so badly that you're not allowed to call me
> again) isn't my favorite.

After working on a patch for a bit... now I hate it.  Why does i2c_detect()
need to work that way?  

Back to where I started: anyone mind if I rewrite i2c_detect()?  A grep
said that drivers/i2c/chips/*.c are the only callers.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
