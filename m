From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 15:38:19 +0000
Subject: Re: [lm-sensors] [PATCH] lm85: extend to support emc6d103 chips
Message-Id: <20110218153819.GA27981@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5E343702000078000329C1@vpn.id2.novell.com>
In-Reply-To: <4D5E343702000078000329C1@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 18, 2011 at 09:54:56AM -0500, Jean Delvare wrote:
> Hallo Jan,
> 
> On Fri, 18 Feb 2011 08:18:26 +0000, Jan Beulich wrote:
> > The interface is identical emc6d102, so all that needs to be added are
> > some definitions and their uses.
> > 
> > Registers apparently missing in emc6d103:A2 compared to emc6d103:A0,
> > emc6d103:A1, and emc6d102 (according to the data sheets), but used
> > unconditionally in the driver: 62[5:7], 6D[0:7], and 6E[0:7]. For that
> > reason, A2 stepping chips don't get enabled for the time being.
> 
> The EMC6D103 datasheet on smsc.com doesn't mention revision A2, so I'm
> curious where you got this information?
> 
Ah, this made me look.

This is really EMC6D103S.
See http://www.smsc.com/media/Downloads_Public/Data_Sheets/6d103s.pdf.

So it should not be listed as step A2, but separately as EMC6D103S
(and it does not have to be mentioned in the code for now, since it is
really a different chip).

> BTW, could you please provide a dump of your chip? I'd like to add it
> to my collection. Use i2cdump with the i2c-dev kernel driver.
> 
> > 
> > Signed-off-by: Jan Beulich <jbeulich@novell.com>
> > 
> > ---
> >  drivers/hwmon/Kconfig |    2 +-
> >  drivers/hwmon/lm85.c  |   20 ++++++++++++++++++--
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> Sorry for being a little late in the game, but can you please also
> update Documentation/hwmon/lm85?
> 
> The patch looks good otherwise.
> 
... except as mentioned above, I think you should remove the reference
to the A2 step entirely.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
