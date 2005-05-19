From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: bmcsensors howto?
Message-Id: <200409262351.56542.lists@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
In-Reply-To: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 22 September 2004 15:03, Jean Delvare wrote:
> On Wed, 22 Sep 2004 08:49:17 -0400, Mark Studebaker wrote
>
> > If it's not in the RPM and you're running a 2.4 kernel then get our
> > release from our website. We don't make the RPMs. If you're running
> > 2.6 then wait until the port is finished and included in the kernel.
>
> BTW Mark, could you care about reviewing the proposed bmcsensors port and
> submitting it to Greg once it is OK? I think only you have knowledge about
> BMC. I sure don't. I think I also remember you have hardware for testing,
> while I don't.

I tested this port on an Intel L440GX SMP board and unfortunately did not have 
much success.  I believe it is due to the fact the board does not implement 
IPMI 1.0 (or above).

There was a patch for 2.4.x to add support for my board to the IPMI code, thus 
making bmcsensors work for it.  Unfortunately, I use 2.6.  If the code from 
the 2.4 patch were somehow ported into the 2.6 bmcsensors driver, I could 
likely test the driver much more thoroughly.

I have contacted both the author of the 2.6 port and the 2.4 patch a number of 
times and neither have responded to me.  I am not competent enough to do the 
coding myself unfortunately, so I'll just have to hope somebody else with an 
interest manages to do it.

I am more than happy to test code on the board if people can supply it.

David
