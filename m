From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 17 Mar 2007 13:39:53 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070317143953.cbb80c83.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Fri, 16 Mar 2007 22:07:52 +0100, Hans-J?rgen Koch wrote:
> Well, I really appreciate good code quality. If this is the price, I'm willing 
> to pay it. Actually, I thank you for helping me so much.

Patch accepted, will be in next -mm, and from there will go to 2.6.22.
Thanks :)

> > Can you please test the user-space support now? I suspect that we need
> > to update libsensors at least to match the name change of the "speed"
> > file. We're about to release lm_sensors 2.10.3 (in a few days now) and
> > I'd like it to support your new driver properly.
> 
> Yes, but not so soon, sorry. I'm not at home the whole next week and will not 
> have any sensors hardware available. After that, I might find some time to 
> have a look. I have an LM93 driver almost ready, so that'll be the next thing 
> I'll keep you busy with :-) In the course of that development I can have a 
> short look at user space stuff, too.

I've made the minimum fix for the 2.10.3 release, so that at least no
error is displayed. Feel free to propose further improvements later.
I've also updated the Devices on our wiki to reflect the current state
of the MAX6650/MAX6651 support.

If you start working on the lm93 driver, make sure to search the
mailing list archives first. I remember that the driver was already
ported to Linux 2.6, but never reviewed. This was some times ago
though, many things changed in the kernel meanwhile, so it's up to you
whether you want to start from an old port or from scratch. Beware, the
lm93 driver is a fat beast.

-- 
Jean Delvare

