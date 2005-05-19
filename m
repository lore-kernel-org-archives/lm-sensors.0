From: bjanz@mac.com (Burt Janz)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <200408040712.09678.bjanz@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 03 August 2004 10:08 pm, Mark M. Hoffman wrote:
> Hello Burt:
>
> bjanz@bit-net.com bounced, so I scraped this address off the web
> page in your signature.  Check your reply-to?

Very strange... unless the bit-net server was down.  Bit-Net is my ISP, but 
all email is forwarded directly to a postfix server on my own system.  Most 
people reply directly and I get the emails.... I just checked it, and 
bjanz@bit-net.com caught a test message... hmmm...

I'm behind a firewall here at work, so I have to use the mac.com address to 
send mail *out*.  Replying to bjanz@mac.com should work.

> First of all, you are confusing some terms.  I2C is a multi-master
> bus, period.  There is no such multi-master "mode".  All of our i2c
> host adapter drivers should operate properly on a bus with other
> masters - if not that's a bug.

Er, I may not have explained my needs properly.

I am adding support to allow the MPC5200 to operate simultaneously as *both* a 
master *and* a slave on a bus.  It must be able to send commands to the bus 
when in master mode, receive commands when in slave mode, and reside on the 
bus with at least one other MPC5200.  This would provide a true multi-master 
environment: multiple masters which would need to negotiate for control of 
the bus, but act as slaves when not acting as masters.

> I think you just want to add slave support to i2c host adapters.

If the above fits, then -- yes: the device will be in slave mode and 
responding to requests, but will occasionally *originate* commands as a 
master on a bus with at least one other master.

I'm not trying to quibble -- I'm just trying to explain my needs as clearly as 
I can...

> On page 7 of the Philips I2C bus specification (V2.1) [1] there is
> a table of terms, a diagram, and some text that will make this clear.  It
> is required reading especially for pedants. :)

Yeh, I got the doc right here... :-)

[snip]

> It's the first I've heard of the Denx kit.  What is *it* based on?  What
> we have in CVS is somewhat different from what's in official 2.4, and
> they're not likely to ever get back in sync.

Denx supports the PPC architecture, not the x86 architecture.  The current kit 
is based on 2.4.25.

> Have you seen our CVS?  There are already *slave_send and *slave_recv
> place-holders.  Not in use, AFAIK; also not sure why not *slave_xfer
> as you mention.

I have not seen your CVS.

In my exploration of the 2.4.25 kernel, I did find the slave_send and 
slave_recv function pointers.  But, my needs are a bit more deep... or, at 
least, I think they are.  There are other implications as well: how do I 
retrofit IPMI to allow for the special devices I'm using, what commands will 
be appropriate, etc.

> Again with the terminology.  :)  I think you're asking if someone has
> implemented host adapter slave support...  well, it's in the i2c package
> TODO list for a long time now.  If you're adding support for kernel 2.4,
> you'll probably be maintaining it yourself - we're not inclined to accept
> new features, and Marcelo is definitely not accepting patches for I2C.

Ok, that (unfortunately) answers my questions.  If no patches are being 
accepted for I2C (I assume for the 2.4 kernel), then I will go my own route 
and develop a stand-alone driver for my needs.

> However, development continues on kernel 2.6.  If you come up with
> something good for 2.4, maybe someone here could port it to 2.6.  I.e.
> whatever you come up with, we'd like to see it... good luck.

Let's see what happens.  My driver will probably *NOT* use the I2C 
architecture, since it will be far easier for me to build a standalone driver 
than to try to enhance an intricate architecture that I will have to support 
on my own (re. "not accepting patches").  And, since we don't plan on going 
to the 2.4 kernel for a while (embedded system), porting to the 2.6 kernel is 
- for now - a non-issue.

Let me know if you're still interested in seeing my driver after I have 
finished it.

Thanks for your help!

\burt

-- 
Burt Janz
603.880.0482
bjanz@bit-net.com
www.ccsneinc.com/bjanz
