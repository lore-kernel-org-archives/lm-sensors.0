From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [RESEND3] Dallas 1-wire protocol implementation.
Message-Id: <20040706090101.GD4880@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086602640.7694.71.camel@uganda>
In-Reply-To: <1086602640.7694.71.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi !

Sorry again for the long delay to answer :(

On Sun, Jun 20, 2004 at 04:51:31PM +0400, Evgeniy Polyakov wrote:
> Hello.
> I have some notes about such devices and design of the Linux kernel w1
> implementation.
> 
> 1. After rereading specs for various *<->w1 master
> devices I found that all they do support bit interface since it is
> required by w1 search algorithm. 
Yes, the DS2490 can access the bus using bit mode.

> Maybe some devices exist that drive
> some register when they found new slave device on the bus and provide
> it's address in other register, and also such devices require flags that
> indicates that search must be proceeded or stopped.
> I don't now about such devices, but if they exist one can easily
> update w1 master operations structure to support search callback for
> it, and main master's ->process() routing to call it instead of default
> bit-banging w1_search() call. I will do it if you provide datasheet.
The DS2490 has a function that can be call that does the whole search
process automatically. It returns the list of devices found.
 
> 2. By design I leave main master's ->process() call as easy as possible
> and move all data processing out to slave device drivers(family
> drivers). Master just searches for devices on the bus, requests it's
> drivers and provide them all needed functionality.
> Now I extended a bit w1 master operations to support read_/write_byte()
> and reset_bus() calls, so if provided they will be called before bit
> operations.
Good

> So in case of DS2490 you just need to write driver implementing read_bit
> and write_bit operations using some USB commands, then register it as
> master. Any slave devices that will be found in bus connected to DS2490
> will use automatically any operations that you will provide, but they
> actually needs only bit operations. Others are just extensions.
Ok, using read_bit with the DS2490 is a little like using soft OpenGL
with a graphic card that supports all the functions in hard. However, 
I don't have any time to look at that by now. You already a very good 
job by writing such drivers, and I suggest to include these patches as
they are now, it will be possible to improve them later, it is already 
a very good start.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
