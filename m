From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: SMBus device access
Message-Id: <20040919235156.GA3652@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094810411.26391.757.camel@localhost>
In-Reply-To: <1094810411.26391.757.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Nils:

* Nils Faerber <nils.faerber@kernelconcepts.de> [2004-09-10 13:31:55 +0200]:
> Oh, and while we are at it ;)
> The PIC I have hanging to the SMBus not only has a display connectoed to
> it but also some push buttons, i.e. user input.
> It is not perfectly clear to me how I should best query those buttons.
> Is it possible for the SMBus to generate interrupts on button presse or
> do I have to poll those?

If you want your SMBus slave to generate an interrupt, you'll need to have
a third wire which is an optional part of the spec: #SMBALERT.  You can
read about it on page 55:

http://www.smbus.org/specs/smbus20.pdf

Unfortunately, the lm_sensors project I2C stack doesn't have support for
this.  But you could add it... :)

> At least at first glance it seems that the SIS96x does not use
> interrupts at all...

This is a separate issue.  The SIS96x bus driver does not use interrupts
to drive the bus, even though it could.  Whether or not it could support
the optional #SMBALERT mechanism - I don't know, because I don't have a
datasheet for it (only a similar one).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
