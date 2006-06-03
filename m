From: js@linuxtv.org (Johannes Stezenbach)
Date: Sat, 03 Jun 2006 09:52:17 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <20060603095217.GA7027@linuxtv.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 02, 2006, Mark M. Hoffman wrote:
> * Nathan Lutchansky <lutchann at litech.org> [2006-06-01 16:48:58 -0400]:
> > So, that's why the patch is as limited as it is.  It takes care of all the
> > obvious parts of adapting the I2C subsystem to the device model and leaves
> > the existing probing mechanism the way it is, but provides a clean path 
> > for embedded platforms to explicitly instantiate their devices without 
> > probing.
> > 
> > I hope that makes my motivations more clear.  -Nathan
> 
> I already understood these two goals:
> (1) Adapt I2C to better fit the kernel driver model.
> (2) Allow client devices to be attached without probing.
> 
> I am beginning to get the impression, from later emails in this thread
> by Hans and Manu, that (2) is really closer to...
> 
> (3) Allow precise control over I2C bus traffic for adapters that require it.
> 
> What I have in mind should satisfy these goals.  Again, I'll try to get out
> some patches as soon as I can.

Sorry, I've been busy and not paying attention to this thread.

I once tried to summarize DVB probing mechanism / requirements
in an old mail:
http://www.linuxtv.org/pipermail/v4l-dvb-maintainer/2006-March/000779.html


HTH,
Johannes

