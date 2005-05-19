From: bjanz@mac.com (Burt Janz)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <200408050706.30751.bjanz@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 05 August 2004 12:51 am, Mark M. Hoffman wrote:
> Hello Burt:
>
[snip]
> OK, I think I get your intended distinction now... not just adding slave
> support... but also adding the ability to change the host from a master
> to a slave and back while the driver is loaded, maybe even operating
> as both simultaneously.  Is that it?

Precisely.  I don't expect to be operating in both modes simultaneously on the 
same port... but, since the MPC5200 does have 2 I2C ports, it is quite 
possible that one might be in "slave" and the other in "master" at the same 
time.

> Well that's a feature - let's call it "adapter mode switching" - that
> we obviously don't support.  I'm not sure anyone's ever even considered
> it or asked for it before.  I wonder what kind of system it is that
> this is required?

I didn't think it was supported in the I2C code for 2.4.25 - at least, I 
wasn't able to find it :-)

The MPC5200 is being implemented as the controller for a system which monitors 
telecom operations (can't say much more - I'm sure you understand).  There 
are multiple local devices which it must control/query as a local "master".  
And, since there will be several MPC5200-based boards in the system, each 
MPC5200 must respond as a "slave" to the parent controller.  This allows the 
parent to control individual devices on each of the slave boards, and allows 
the slave boards to be "swapped" without affecting operations.

I think it's pretty neat...

[snip]

> As long as maintainers are demanding some level of API stability, by the
> time you're ready to move to 2.6 you won't be able to add the support you
> need there either.  I.e. if you have requirements for the I2C layer, let's
> hear them - or better yet, send patches. :)

No, I have no requirements for the I2C layer.  In fact, I'm coding up my 
driver to be compatible with the IPMI kit so we can eventually use IPMI to 
interface to the driver and be able to take advantage of high-level 
command/response structures.  Simple read() and write() leave a lot to be 
desired, especially with complex command sequences :-)

> Driver source outside the I2C layer is probably better than nothing w.r.t.
> understanding what is lacking in the I2C layer; yes please send it.

If I can get the OK, then you'll get the driver.  The code should be fairly 
easy to understand: I'm segmenting the driver source so the concepts can be 
rolled back into the I2C kit for 2.4.25... or 2.6.

I'm *sure* that someone else will eventually ask "Gee, how do we make our xyz 
system act as both a slave *and* a master..." :-)

\burt

-- 
Burt Janz
603.880.0482
bjanz@bit-net.com
www.ccsneinc.com/bjanz
