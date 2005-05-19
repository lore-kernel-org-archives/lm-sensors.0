From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040416155439.GA14524@bytesex.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > At least with i2c you can even do zero-length reads, i.e. just send
> > the read address and watch whenever someone acks it or not, without
> > actually reading data.  Not sure whenever that is true for smbus as
> > well.
> 
> This is exactly a SMBus "quick command" with data bit 1, if I understood
> it correctly. This isn't what we do (we do "quick command" with data
> bit 0), but that's my second choice if it turns out that "receive byte"
> isn't possible as a probing command.

I'd prefeare a reading "quick command" over a "receive byte" as we don't
actually want read a byte on probing ...

  Gerd

-- 
http://bigendian.bytesex.org
