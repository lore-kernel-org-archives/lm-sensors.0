From: aurel32@debian.org (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: update_lock
Message-Id: <20040331145311.GA29677@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 31, 2004 at 10:45:47AM +0200, Jean Delvare wrote:

[...]

> That's right. BTW, Aurelien Jarno and I decided to get rid of the
> caching mechanism in the pcf8574 and pcf8591 drivers as we ported them
> to 2.6. It seemed to be a problem not being able to get the values in
> real-time for such devices, since they are used in very particular
> conditions. I don't think it is a problem because such devices are not
> present on motherboards and I don't expect many people to use these
> drivers. And these devices don't seem to stop when you read from them
> (actually it's the contrary, they sample the inputs as you read them.
> 
> Aurelien, can you confirm this?
I confirm that. For the pcf8574, the 8-bit input port is sampled during
the first clock of the data byte, and for the pcf8591, each bit is
sampled just before being sent.

> That said there's still a problem. The pcf* drivers accept all chips
> within their address ranges, because the chips are plain undetectable.
> So if someone was to load them and they actually try to drive a
> hardware monitoring chip instead, continuous readings from the sysfs
> files could prevent the chip from working (left apart the fact that the
> driver is likely to confuse the chip even without continuously reading,
> but there's nothing we can do there).
You're right that it can cause some problems, on my system I need to
load the ds1621 module before the pcf8591 otherwise my ds1621 chip is
recognized as a pcf8591.

> Maybe we could add a security warning in the kernel configuration help
> text for these two drivers? (something like "This driver is potentially
> dangerous if used on inappropriate hardware.  Including it into the
> kernel is discouraged, module is prefered.  Do not load this module
> unless you know you need it.")
That could be an idea. To be honest, I don't see other alternative as
the chips are very stupids; the pcf8574 doesn't have any control
register, and the pcf8591 has one control register but only writable.

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
