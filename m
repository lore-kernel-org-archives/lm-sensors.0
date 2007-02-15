From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Feb 2007 16:28:23 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070215172823.6c1a90df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alan,

On Thu, 15 Feb 2007 11:01:17 +0000, Alan Clucas wrote:
> Jean Delvare wrote:
> > OK, patch applied to lm-sensors SVN.
> > 
> > I'm still waiting for updated kernel and libsensors/sensors patches.
> 
> It is on my todo list still - been side tracked by some other things so 
> don't expect it until next week. Sorry.

No worry, we're in no hurry.

> I'm not going to try for >9 bit precision. An interesting side effect of 
> running i2cdump is to change it from 9 bit precision (which it shows it 
> is setup for the first time it is run after a reset) to the dump that 
> you saw in my earlier mail. Odd. (Which is why the kernel patch I posted 
> earlier did work for me).

This is really weird. I just can't explain it. Does my new code in
sensors-detect produce the same side effect?

-- 
Jean Delvare

