From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <20041019034308.GB18098@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2004-10-18 22:54:57 +0200]:
> Quoting myself:
> 
> > * Composite module
> > I don't know how this can be done in the lm_sensors tree. Hint anyone?
> 
> I finally came to a sort of composite module. Thanks go to my beloved
> one for the idea of simply including i2c-amd756-s4882.c from
> i2c-amd756.c. Simple and unusual but it does what we need. We don't even
> need to alter the Makefile stuff.
> 
> Mark, does this second approach please you more than my original one?
> The changes to the original file are reduced to their minimal form.

Heh, OK.  Could you just make sure that 'touch i2c-amd756-s4882.c'
causes make to rebuild the object?  I think the auto dependency magic
will figure that out, but I'm not sure.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
