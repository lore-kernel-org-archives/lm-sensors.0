From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <20040805045131.GD4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Burt:

* Burt Janz <bjanz@mac.com> [2004-08-04 07:12:09 -0400]:
> On Tuesday 03 August 2004 10:08 pm, Mark M. Hoffman wrote:
> > First of all, you are confusing some terms.  I2C is a multi-master
> > bus, period.  There is no such multi-master "mode".  All of our i2c
> > host adapter drivers should operate properly on a bus with other
> > masters - if not that's a bug.
> 
> Er, I may not have explained my needs properly.
> 
> I am adding support to allow the MPC5200 to operate simultaneously as *both* a 
> master *and* a slave on a bus.  It must be able to send commands to the bus 
> when in master mode, receive commands when in slave mode, and reside on the 
> bus with at least one other MPC5200.  This would provide a true multi-master 
> environment: multiple masters which would need to negotiate for control of 
> the bus, but act as slaves when not acting as masters.
> 
> > I think you just want to add slave support to i2c host adapters.
> 
> If the above fits, then -- yes: the device will be in slave mode and 
> responding to requests, but will occasionally *originate* commands as a 
> master on a bus with at least one other master.
> 
> I'm not trying to quibble -- I'm just trying to explain my needs as clearly as 
> I can...

OK, I think I get your intended distinction now... not just adding slave
support... but also adding the ability to change the host from a master
to a slave and back while the driver is loaded, maybe even operating
as both simultaneously.  Is that it?

Well that's a feature - let's call it "adapter mode switching" - that
we obviously don't support.  I'm not sure anyone's ever even considered
it or asked for it before.  I wonder what kind of system it is that
this is required?

<snip>

> > Again with the terminology.  :)  I think you're asking if someone has
> > implemented host adapter slave support...  well, it's in the i2c package
> > TODO list for a long time now.  If you're adding support for kernel 2.4,
> > you'll probably be maintaining it yourself - we're not inclined to accept
> > new features, and Marcelo is definitely not accepting patches for I2C.
> 
> Ok, that (unfortunately) answers my questions.  If no patches are being 
> accepted for I2C (I assume for the 2.4 kernel), then I will go my own route 
> and develop a stand-alone driver for my needs.
> 
> > However, development continues on kernel 2.6.  If you come up with
> > something good for 2.4, maybe someone here could port it to 2.6.  I.e.
> > whatever you come up with, we'd like to see it... good luck.
> 
> Let's see what happens.  My driver will probably *NOT* use the I2C 
> architecture, since it will be far easier for me to build a standalone driver 
> than to try to enhance an intricate architecture that I will have to support 
> on my own (re. "not accepting patches").  And, since we don't plan on going 
> to the 2.4 kernel for a while (embedded system), porting to the 2.6 kernel is 
> - for now - a non-issue.

As long as maintainers are demanding some level of API stability, by the
time you're ready to move to 2.6 you won't be able to add the support you
need there either.  I.e. if you have requirements for the I2C layer, let's
hear them - or better yet, send patches. :)

> Let me know if you're still interested in seeing my driver after I have 
> finished it.

Driver source outside the I2C layer is probably better than nothing w.r.t.
understanding what is lacking in the I2C layer; yes please send it.

> Thanks for your help!

What little it's been, sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
