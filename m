From: ryszard@lach.name (Ryszard Lach)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Temperature measure problem
Message-Id: <20030527103557.GA11459@siaco.id.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030526190059.GA6938@siaco.id.pl>
In-Reply-To: <20030526190059.GA6938@siaco.id.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 27, 2003 at 12:12:25PM +0200, Jean Delvare wrote:
> 
> > I have lm-sensors installed and configured, but I suppose it does not
> > work properly.
> > 
> > I have a water-cooled PC. When I turn off the cooling system BIOS
> > shows CPU temp. growing starting from 25C with speed 3-4C per minute. 
> > 
> > When I do the same running linux and checking temperature using
> > sensors- Temp2/CPU does not change, Temp3 grows, but starting from
> > 33C, which(I suppose) is wrong.
> 
> Not necessarily. If you consider your Linux system takes approximatively
> 1 minute to start, and you then have to login and run the program, it
> may take up to 1 more minute, which justifies 8 more degrees. One could
> argue that it takes much less than 2 minutes, but on the other hand,
> chances are it generates much more heat that just sitting in the BIOS
> screen and do nothing.

I suppose then that immediately after shutdown and entering bios (let's
say after 1 minute after launching sensosrs) temp. in BIOS will be a
little higher then befoure running linux. And it is not.

Besides I don't know which sensor Temp2 indicates (why it does not
change) - I'm pretty sure it is not CPU sensor. How can I check/change
this?

> But it also may be wrong, as you suppose. You may try to add a
> converstion formula in your sensors.conf file to actually match your
> BIOS readings better. Let us know if you come to something interesting.

I'll do my best.


Best regards,

Richard.


-- 
