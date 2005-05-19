From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: I2c Bus driver for National Geode
Message-Id: <20020521102803.E20703@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CEA50F1.1010301@onair.dk>
In-Reply-To: <3CEA50F1.1010301@onair.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I don't think we have any code yet for the Geode systems.  But, since
they run Linux and are x86 compatible, it shouldn't be too hard if the
documentation is available (National is pretty good about that).

I encourage you to start a bus driver for the Geode! :')  It might be
compatible with an existing driver if the Geode is a close clone to
something else (like Intel PIIX4), or it may be a bit-banging kind
which I would suggest you start by copying and modifying another
existing bit-banging driver.  Lastly, you may need to write a more
custom driver (most likely).  Take a look through
lm-sensors/kernel/busses/i2c-* for examples.


Phil

On Tue, May 21, 2002 at 03:51:45PM +0200, Thomas Graversen wrote:
> Hi
> 
> I need a I2C bus driver for the National Geode.
> I can see that National is listed as a developer on this driver.
> 
> Do you have any information about the state of this driver ?
> Or just a contact within National.
> 
> I would like to offer my help writing this driver.
> 
> 
> Thomas Brinkmann Graversen
> 
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
