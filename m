From: tvann@extremenetworks.com (Timothy Vann)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Any work done on subordinate buses?
Message-Id: <CEA6A588893A0A47915874C1E8FF2307A4CC4A@rtp-msexch-01.rtp.extremenetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CEA6A588893A0A47915874C1E8FF2307A4CC39@rtp-msexch-01.rtp.extremenetworks.com>
In-Reply-To: <CEA6A588893A0A47915874C1E8FF2307A4CC39@rtp-msexch-01.rtp.extremenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the response.  Is this code in the CVS tree or do I need to pull
it from somewhere else?  I see you mention the list archive but I'm not sure
how to get at that.

Regards,
Tim

-----Original Message-----
From: Brian Kuschak [mailto:bkuschak@yahoo.com]
Sent: Thursday, February 26, 2004 3:27 AM
To: Mark Studebaker; Timothy Vann
Cc: 'lm78@stimpy.netroedge.com'; bkuschak@yahoo.com
Subject: Re: Any work done on subordinate buses?



Yes, my driver was written to support any arbitrary
levels of i2c muxes or i2c bus switches in just about
any topology.  Tim, I think it will work for you -
you'll just have to write a small function if your bus
switch is different from the 954x.

Mark, I started on those changes you suggested, but my
project was soon cancelled and I decided to take a
leave of absence for several months.  I'm currently
living in New Zealand and I don't have easy access to
that driver right now.  I believe the list archives
should have a copy of my post of the driver.  If not,
let me know and I'll try to dig up a copy.

Tim, see the file I wrote in Documentation/i2c for a
description of the driver and how to use it.  Feel
free to contact me if you have any questions.

Regards,
Brian


--- Mark Studebaker <mds4@verizon.net> wrote:
> We received a fairly complete driver for the Philips
> 954x chips in November from Brian Kuschak.
> We made some suggestions for improvement and
> renaming but the discussion ended and
> we haven't received anything since. Brian do you
> have an update for us?
> 
> 
> 
> 
> Timothy Vann wrote:
> > I'm working on a project where I have a single
> SMBUS connected to an I2C
> > switch which fans out to different cards.  I was
> wondering if there had been
> > any work done to support this sort of setup?  If
> not any suggestions on the
> > best approach?  I had thought about doing a chip
> driver for the switch that
> > could select the subordinate bus but I'm not sure
> the best way to add the
> > subordiante buses such that the switch gets set
> properly when a subordinate
> > bus is accessed.
> > 
> > Regards,
> > Tim Vann
> > tvann@extremenetworks.com
> > 
> > PS - I'm not on the mailing list so please respond
> directly, also if someone
> > could add me to the mailing list I would
> appreciate it.
> > 
> > 
> 


__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools
