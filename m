From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <1081848436.18624.442.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2004-04-13 at 12:10, Eugene Surovegin wrote:

> > > No, it doesn't. Please read any 4xx IBM manual. 
> > > Your code starts 1-byte _write_ transaction with whatever crap was in
> > > output FIFO. You clear TCT field in IICx_CNTL, and it means _1_byte_
> > > will be transfered _after_ i2c address.
> > 
> > But this generates irq on ACK and driver can catch this.
> > It is correct behaviour but yes it costs something.
> 
> You are missing my point, your code is NOT CORRECT, you are programming chip for 
> 1 byte write but doesn't fill FIFO with any data. This will probably result with 
> random garbage written to the device.
> 
> In my book this very bad programming and I'm not gonna add such code to the 
> driver, sorry.

Ok, agree, with unknown devices on the bus it is not safe.
The main idea is to issue irq on ACK.

Kinda patch.

--- 1.5/drivers/i2c/i2c-ibm_iic.c       Fri Apr  9 20:48:20 2004
+++ edited/drivers/i2c/i2c-ibm_iic.c    Tue Apr 13 13:07:36 2004
@@ -338,6 +338,11 @@
        DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, 0, cntl);
  
        /* Start transfer */
+       out_8(&iic->cntl, cntl);
+
+       udelay(100);
+
+       cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_HMT;
        out_8(&iic->cntl, cntl);
  
        /* Wait for completion */

Works.

> > > > I have tested with this (as you say) "hack" max663x chip.
> > > 
> > > So what? You are lucky and it "works" with you particular chip, it
> > > doesn't mean it'll work with another. I have a board here where even
> > > 1-byte _read_ access locks the bus completely (device is write-only
> > > clock driver).
> > 
> > It works always.
> 
> No, it doesn't always work. If the device is read-only? 
> Could you provide a list of 4xx platforms and I2C devices you have tested your 
> patch with? And don't forget that in embedded world you can have some 
> micro-controller attached to i2c bus with some software running on it 
> implementing i2c slave...
> 
> > You just writes something to something. It is quite normal behaviour for
> > write enabled devices.
> 
> You are kidding, right? Can you guarantee that this random write will not 
> corrupt device state?
> 
> I cannot.

Ok. Agree, I was wrong. Writing only safe when it is safe.
With unknown devices it is not safe.

> > Actually those transaction is terminated by the others.
> 
> which "others"? Can you elaborate?

Issue Halt Master Transfer signal.

> > > What _initialization_ are you talking about? I'm using this driver on
> > > several different custom boards in production systems.
> > 
> > i2c layer uses SMBUS_QUICK mode to find devices on the bus.
> > With current ibm iic driver it always succeeds no matter is device there
> > or not.
> 
> I know how i2c layer does this and I believe this is not the right approach. In 
> general case you cannot just write some random garbage to some random device 
> and expect everything to work after wards.
> 
> Just because this "works" with your device doesn't mean it'll work with another.
> 
> > Probably better idea to implement autodetection method in adapter's
> > driver itself and provide it to generic i2c layer and call it only when
> > it is presented and proven to be safe.
> 
> The problem is that "autodetection" safeness is _device_ dependent, not adapter. 
> In other words, you can be sure that it's safe to "scan" the bus if devices 
> attached will behave properly.

Yep.
So, with such kind of hardware any autodetection will not work at all
and it can't even be connected to adapter controlled by default linux
i2c core.
Your hardware don't like reading, others don't like writing...
Atutodection works like it works and it is not worth to discuss
something which will not be changed.


> I already told you, that I have a real hw (IBM 440GP ref board) where simple 
> read scan locks i2c bus.
> 
> > > Actually we have following situation:
> > 1. Do not use autodetection mechanism, forcing inserting and so forth.
> > 2. Use some kind of "hacks" to emulate i2c layer autoprobing with
> > 0-length transactions when it is safe to do.
> 
> I _think_ my patch is OK, think about it. It always returns "TRUE" for 
> the address you are trying to "scan". Your detection code MUST check whether 
> your expected device exists at this address (and not some other device) using 
> device-specific access. Matt already mentioned some example of such code.
> If something ACKs on particular address doesn't mean there is a device you are 
> expecting.

And what if hardware can't tell about itself?

If we have i2c "standard" in linux kernel for 0-length autodetection any
adapter should follow it.

> As I mentioned in my previous e-mail, there is a way to implement 0-length 
> transactions using bit-banging. I personally don't see any point in doing this 
> but you are welcome to submit the patch and if it's OK I'll add it to the 
> driver.

What about above patch?

> Eugene.
-- 
	Evgeniy Polaykov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040413/57fb50f8/attachment.bin
