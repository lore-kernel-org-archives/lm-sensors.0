From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] typo in drivers/i2c/busses/i2c-ixp4xx.c
Message-Id: <1108646856.3324.84.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1108642776.3324.82.camel@icampbell-debian>
In-Reply-To: <1108642776.3324.82.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-02-17 at 13:15 +0000, Ben Dooks wrote:
> On Thu, Feb 17, 2005 at 12:19:35PM +0000, Ian Campbell wrote:
> > Hi Deepak,
> > 
> > I was looking at your ixp4xx gpio i2c driver for inspiration (for a
> > similar pxa2xx one) and I just happened to notice a tiny typo.
> 
> I didn't think the pxa2xx series allow their i2c pins to be
> anything other than special function?

I beleive that is correct. What I am doing is turning a couple of the
GPIO lines into a second (and in fact a third) i2c bus.

(please don't ask why three buses are required -- historical
accident :-( ).

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
