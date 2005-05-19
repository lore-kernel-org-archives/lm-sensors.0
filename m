From: ben@fluff.org.uk (Ben Dooks)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] typo in drivers/i2c/busses/i2c-ixp4xx.c
Message-Id: <20050218151916.GB28744@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1108642776.3324.82.camel@icampbell-debian>
In-Reply-To: <1108642776.3324.82.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 17, 2005 at 01:27:36PM +0000, Ian Campbell wrote:
> On Thu, 2005-02-17 at 13:15 +0000, Ben Dooks wrote:
> > On Thu, Feb 17, 2005 at 12:19:35PM +0000, Ian Campbell wrote:
> > > Hi Deepak,
> > > 
> > > I was looking at your ixp4xx gpio i2c driver for inspiration (for a
> > > similar pxa2xx one) and I just happened to notice a tiny typo.
> > 
> > I didn't think the pxa2xx series allow their i2c pins to be
> > anything other than special function?
> 
> I beleive that is correct. What I am doing is turning a couple of the
> GPIO lines into a second (and in fact a third) i2c bus.
> 
> (please don't ask why three buses are required -- historical
> accident :-( ).

Ok, sorry, jumped to wrong conclusion.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
