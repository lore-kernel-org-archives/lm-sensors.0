From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 driver
Message-Id: <20030703184041.GA2250@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 03, 2003 at 08:34:31PM +0200, Jean Delvare wrote:
> 
> > > I finished writting the driver you requested. Note that I don't own
> > > a LM83 myself, so it is *completely untested*. It compiles, but I
> > > can't promise much more. This is my first driver, so expect to
> > > encounter some problems before it works.
> > 
> > Care to make a 2.5 patch too?  :)
> 
> I will, but I prefer to make sure the driver works OK before that. And
> also, it is a minimalistic driver for now (doesn't handle alarms, alarms
> mask and so on) so maybe it would be better to enhance it on the 2.4
> side and port it later to 2.5 than the contrary.

Why?  2.5 can have minimal drivers :)

And it will get better coverage than the sensors cvs tree I bet...

thanks,

greg k-h
