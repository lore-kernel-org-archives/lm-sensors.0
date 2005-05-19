From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [RESEND3] Dallas 1-wire protocol implementation.
Message-Id: <1089127478.6114.457.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086602640.7694.71.camel@uganda>
In-Reply-To: <1086602640.7694.71.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Aurelien, Jean, Greg and all other developers.

I want to thank Aurelien and Jean for their support.
I greatly appreciate your help.

If this project for some reasons will not be included into the Linux
kernel I will continue to work with it and find a place for hosting.

On Tue, 2004-07-06 at 13:01, Aurelien Jarno wrote:
> Hi !
> 
> Sorry again for the long delay to answer :(
> 
> On Sun, Jun 20, 2004 at 04:51:31PM +0400, Evgeniy Polyakov wrote:
> > Hello.
> > I have some notes about such devices and design of the Linux kernel w1
> > implementation.
> > 
> > 1. After rereading specs for various *<->w1 master
> > devices I found that all they do support bit interface since it is
> > required by w1 search algorithm. 
> Yes, the DS2490 can access the bus using bit mode.
> 
> > Maybe some devices exist that drive
> > some register when they found new slave device on the bus and provide
> > it's address in other register, and also such devices require flags that
> > indicates that search must be proceeded or stopped.
> > I don't now about such devices, but if they exist one can easily
> > update w1 master operations structure to support search callback for
> > it, and main master's ->process() routing to call it instead of default
> > bit-banging w1_search() call. I will do it if you provide datasheet.
> The DS2490 has a function that can be call that does the whole search
> process automatically. It returns the list of devices found.

Okey, now I have DS9490R and will write simple bit-banging driver for
it. It will easily be integrated into existing schema.
Next step will be to replace w1_search() with master's call with
callbacks.
I do think it is not needed but it may be easily integrated too.

> > 2. By design I leave main master's ->process() call as easy as possible
> > and move all data processing out to slave device drivers(family
> > drivers). Master just searches for devices on the bus, requests it's
> > drivers and provide them all needed functionality.
> > Now I extended a bit w1 master operations to support read_/write_byte()
> > and reset_bus() calls, so if provided they will be called before bit
> > operations.
> Good
> 
> > So in case of DS2490 you just need to write driver implementing read_bit
> > and write_bit operations using some USB commands, then register it as
> > master. Any slave devices that will be found in bus connected to DS2490
> > will use automatically any operations that you will provide, but they
> > actually needs only bit operations. Others are just extensions.
> Ok, using read_bit with the DS2490 is a little like using soft OpenGL
> with a graphic card that supports all the functions in hard. However,

All those functionality actually not needed.
It MUST be implemented using bit-banging in hardware or software, but
with current approach we may control each bit and see for example bus
collisions.
We may understand that wires are too long or some device do not support
protocol, Dallas' hardware may say only "good" or "bad" but it is all
lyrics...
I will extend current design to support hardware search.

>  
> I don't have any time to look at that by now. You already a very good 
> job by writing such drivers, and I suggest to include these patches as
> they are now, it will be possible to improve them later, it is already 
> a very good start.

Thank you.

-- 
	Evgeniy Polaykov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040706/f2a7cee5/attachment.bin
