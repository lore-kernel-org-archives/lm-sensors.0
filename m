From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Fri, 02 Dec 2005 02:45:28 +0000
Subject: [lm-sensors] Re: [Patch 11/31] V4L (0999) Some funcions now static
Message-Id: <1133464867.23362.15.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1133400730.21135.62.camel@localhost>
	 <20051201201121.1c09cec7.khali@linux-fr.org>
In-Reply-To: <20051201201121.1c09cec7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, js@linuxtv.org, LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>

Em Qui, 2005-12-01 ?s 20:11 +0100, Jean Delvare escreveu:
> Hi Mauro,
> 
> [As a side note, it looks like there have been some distribution
> problems with this patchset... I can only see 0/31 (twice) on LKML and
> 11/31 didn't make it to the lm-sensors list as it was supposed to. I
> received it twice though.]
	In fact, all were sent to lkml... for some unknown reason, my ISP
didn't sent it (or lkml anti-spam rules filtered?). I even tried to send
a second time...
> 
> > From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> >
> > - Some funcions are now declared as static
> > - Added a I2C code for InfraRed.
> 
> Unrelated changes, this should have been two separate patches. Also,
> "I2C driver ID" would better describe what the second change is about
> than "I2C code".
	Ok. I'll do it next time. I tried to consolidate into one due the
ammount of patches we have to send. Up now, we sent more than 250
patches, just v4l updates to 2.6.15.
> 
> > --- git.orig/drivers/media/video/ir-kbd-i2c.c
> > +++ git/drivers/media/video/ir-kbd-i2c.c
> > @@ -278,7 +278,7 @@ static int ir_probe(struct i2c_adapter *
> >
> > static struct i2c_driver driver = {
> > 	.name           = "ir remote kbd driver",
> > -	.id             = I2C_DRIVERID_EXP3, /* FIXME */
> > +	.id             = I2C_DRIVERID_I2C_IR,
> > 	.flags          = I2C_DF_NOTIFY,
> > 	.attach_adapter = ir_probe,
> > 	.detach_client  = ir_detach,
> 
> That's a poor ID name you chose. The second "I2C" is totally redundant,
> and "IR" is a bit short and could mean about anything. Please change it to
> I2C_DRIVERID_IRKBD or I2C_DRIVERID_INFRARED or something.
	Ok. (We have also other non-i2c ir.. that's why I called it I2C_IR).
I'll prepare a patch for it. I2C_DRIVERID_INFRARED seems a good name.
> 
> Thanks,
Cheers, 
Mauro.

