From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 21 Feb 2008 13:00:28 +0000
Subject: Re: [lm-sensors] ASM58 Mozart-2 Driver
Message-Id: <20080221130028.GG27110@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c83dfc$bdb0e980$3912bc80$@net>
In-Reply-To: <000301c83dfc$bdb0e980$3912bc80$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Eric:

* Jean Delvare <khali@linux-fr.org> [2008-01-13 19:48:30 +0100]:
> Hi Mark,
> 
> On Sun, 16 Dec 2007 14:33:41 -0500, Mark M. Hoffman wrote:
> > Hi Eric:
> > 
> > * Eric <resdrywall@bellsouth.net> [2007-12-13 21:55:09 -0500]:
> > >    I found a driver below but I cannot find docs on how to add it or if it is
> > >    compatible
> > > 
> > > 
> > > 
> > >    [2]http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015735.html
> > > 
> > > 
> > > 
> > >    lm sensors version: sensors version 2.8.7 with libsensors version 2.8.7
> > > 
> > > 
> > > 
> > >    I looked at the later versions readme and did not see reference to this
> > >    being supported. Please let me know if this is possible because I have a
> > >    lot of interest in the applications that use it.
> > 
> > For whatever reason, it looks like the work-in-progress on this driver
> > was abandoned.  Any volunteers to fix it up and resubmit it?  It looks
> > mostly finished.  I'll fix it up myself if nobody gets to it.
> 
> I'd rather do it myself so that you can spend your time on something
> else, like... reviewing my own patches ;)

Well, I just started to do this 10 minutes ago but I didn't get very
far...

> --- /dev/null
> +++ b/Documentation/hwmon/asm58
> @@ -0,0 +1,42 @@
> +Kernel driver asm58
> +=========> +
> +Supported Chips:
> +* Asus ASM58 Mozart-2
> +* Asus AS2K129R Mozart-2
> +* Asus ??? Mozart-2
> +  All three seem to be the same save for exterior markings
> +  Prefix: 'asm58'
> +  Addresses scanned: I2C 0x77
> +  Datasheet: not available
> +
> +
> +Description
> +-----------
> +
> +This chip is discontinued and unsupported by the manufacturer. The driver was
> +developed with xmbmon205 source as a reference.  It is found on
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That, plus no Signed-off-by from the author = I'm not touching this.

Sorry.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
