From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <20040922200446.GC4256@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com> <41506099.8000307@web.de> <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost> <1095854048.18365.75.camel@localhost> <20040922122848.M14129@linux-fr.org> <1095877951.18365.232.camel@localhost>
In-Reply-To: <1095877951.18365.232.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>, Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>

Hi Adrian:

* Adrian Cox <adrian@humboldt.co.uk> [2004-09-22 19:32:31 +0100]:
> On Wed, 2004-09-22 at 14:38, Jean Delvare wrote:
> 
> > Aha, this is an interesting point (which was missing from your previous
> > explanation). The base of your proposal would be to have several small i2c
> > "trees" (where a tree is a list of adapters and a list of clients) instead of
> > a larger, unique one. This would indeed solve a number of problems, and I
> > admit that it is somehow equivalent to Michael's classes in that it
> > efficiently prevents the hardware monitoring clients from probing the video
> > stuff. The rest is just details internal to each "tree". As I understand it,
> > each video device would be a tree on itself, while the whole hardware
> > monitoring stuff would constitute one (bigger) tree. Correct?
> 
> I've been rereading the code, and it could be even simpler. How about
> this:
> 
> 1) The card driver defines an i2c_adapter structure, but never calls
> i2c_add_adapter(). The only extra thing it needs to do is to initialise
> the semaphores in the structure.
> 2) The frontend calls i2c_transfer() directly.
> 3) The i2c core never gets involved, and there is never any i2c_client
> structure.

Yes, almost...

Why force your card driver to re-implement i2c_smbus_read_byte() and all
its relatives?  Go ahead and define the i2c_client structure(s) as well,
but don't i2c_attach_client().  Sensors drivers do their probing before
attaching the client, so I know that works.

> This gives us the required reuse of the I2C algo-bit code, without any
> of the list walking or device probing being required.

Ditto, *plus* you can still reuse all the i2c_core helper routines that
require a client structure.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
