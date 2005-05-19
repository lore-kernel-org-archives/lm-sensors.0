From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: i2c adapter question
Message-Id: <20020906161652.X16408@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D79362B.6A8976C4@attbi.com>
In-Reply-To: <3D79362B.6A8976C4@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


You may be interested in the parallel port I2C driver.  It turns your
parallel port into an I2C bus w/o needing additional hardware!

All our documentation and code is at the URL Albert mentioned.


Phil

On Fri, Sep 06, 2002 at 07:11:39PM -0400, Albert Cranford wrote:
> I'm forwarding you to the i2c/sensors mail list.
> Have you seen the hardware monitor web site?
> http://secure.netroedge.com/~lm78/
> 
> Frans Englich wrote:
> > 
> > Hello Albert,
> > 
> > I've goggle'd the web and searched for an mailinglist suitable for my question
> > but couldn't come up with anything. Thus, I bug you..
> > 
> > Simply, I need a cheap and feature rich i2c adapter with support in the i2c
> > Linux kernel subsystem. It must be external peripheral , parallel/rs-232 or
> > perhaps USB is fine.
> > It's quite alright if that means I have to build it myself(then I 'only' need
> > the circuit design paper)
> > 
> > If you know a source/Documentation relevant to this and which perhaps answers
> > my question I would be glad to recieve it.
> > 
> > Keep up the good work.
> > 
> > cheers,
> > Frans Englich
> 
> -- 
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
