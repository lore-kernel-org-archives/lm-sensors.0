From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030805222340.3799d819.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 12:37:15 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > Does this affect my sound? 
> 
> It could, if your sound chip is using the i2c bus.
> 
> (Flash of Insight)
> 
> OMG, that's it. You just found the reason why everything dies each time
> you try to install lm_sensors. Let's see if I'm right.
> 
> You have been trying to install i2c-2.8.0 and lm_sensors 2.8.0.
> 
> You have a PPC system and use an audio driver that relies on the I2C bus
> (DAC3550A or TAS3001C).
> 
> You have been installing i2c from its own directory, you did *not* use
> the i2c kernel patch.
> 
> You use Gnome, and Gnome tries to setup the sound at startup, because it
> will sometime play sound on particular events (or simply setups the ESD
> sound daemon).
Here you are right and wrong. As Gnome is not starting anymore because I do not have the newest version of Orbit and libbonobo (Debian packages are not released yet - I am running unstable) I am now running KDE. If I do depmod -a I get: 

depmod: *** Unresolved symbols in /lib/modules/2.4.21-ben2/kernel/drivers/sound/dmasound/dmasound_pmac.o 

My feeling tells me you must be right.

> Am I wrong on any point? If I'm not, I fully understand what happened. I
> have been wrong pretending this wasn't our fault, because it actually is
> (well, sort of).
> 
> (It does *not* explain why sensors-detect locks on the ISA bus scanning,
I was not the ISA Bus it was the check afterwards, I think it did not check for that in the last lm-sensors version I thouhgt it started an I... (bad memory chip in my brain - sorry).

> but it explains the trouble you have been encountering after installing
> lm_sensors, or, more precisely, i2c-2.8.0).
Ok, how do I get my sound back? I could just install my latest kernel-image I think that would help.

Thanks for feedback.
Zeno

-- 
Mit freundlichen Gruessen / Best regards

Zeno Davatz
Strategie und Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
