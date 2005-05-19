From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: LM93 support...
Message-Id: <20040608215551.764be4b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0B63FBDC.8F541A79-ON85256EAD.005F1444@nc.tekelec.com>
In-Reply-To: <OF0B63FBDC.8F541A79-ON85256EAD.005F1444@nc.tekelec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Presently the company for which I work is going to deploy some servers
> (whose motherboards we design) with the
> LM93 sensor chip.   I am tasked with making lm sensors work with this
> chip. I am currently trying to research where you
> guys are with support for this, but I figured I would send you a
> direct email to let you know of my intent.  Also, I am absolutely
> positive that as our prototype hardware arrives I could either with me
> as a go between or through some easier arrangement
> get you access to hardware with an LM93 on it.

Looks like a really new chip, never heard of it. So nobody is working on
it.

> Personally, I would
> love to find that someone else more experienced with this
> has already started coding the LM93 driver, and that I could assist in
> anyway possible, but if not I am definately willing to
> do the coding myself and in that respect would gladly accept any
> guidance, criticism or flames (if it doesn't kill you it makes
> you stronger (-;).

As I said, no work is in progress and nothing is planned. I will
personally not write such a driver since I already have too much to care
about. The chip looks really complete and the driver promises to be big
and interesting (especially, I saw that it has two 6-pin VID inputs,
which is something totally new).

I just added LM93 support to sensors-detect (not commited, we are in
feature-freeze state at the moment). I also added the LM93 to our new
drivers page.

If you intend to write a driver for this chip, the easiest way is
probably to start from an existing driver (either lm85 or lm87, since
the LM93 is more or less their successor). Then just ask when you have
questions.

Good luck.

-- 
Jean Delvare
http://khali.linux-fr.org/
