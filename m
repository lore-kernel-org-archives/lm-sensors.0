From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 20:26:10 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <1297110370.24938.30.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Mon, 2011-02-07 at 14:53 -0500, Andrew Lutomirski wrote:
[ ... ]
> >
> > Anyway, please try again. I updated the code to fix the pwmX_enable bug.
> 
> Mostly works.
> 
> If I set pwm2_enable to 1, then pwm2 controls the fan.
> 
> If I try to set pwm2_enable to 5, I get:
> 
> # echo 5 >pwm2_enable
> bash: echo: write error: Invalid argument
> 
For now that is on purpose. Problem is that if SmartFanIV mode was not
initialized by the BIOS, it probably won't work. There are lots of
parameters which have to be configured. So one can not just let users
enable it without forcing them to configure all the other parameters ..
which is currently not possible with the sysfs ABI.

So this is really a one-way street for now.

Nuvoton's position on this matter is that fan control should be left to
the board vendor to prevent system damage, ie that users should not try
to configure it at all other than through the BIOS. They might have a
point.

> which means I can't undo what I just did.  (If I patch the driver to
> accept '5', then it works.)
> 
> Are there docs (e.g. a patch to Documentation/hwmon/w83627ehf, but an
> email explanation would do) for how SmartFan works, or, more
> generally, for how to program the various modes?  If you have a link

Not yet. I'll have to update the document before I can submit the
driver.

> to a datasheet, I can try to write something.
> 
I do have a datasheet, but it is unfortunately non-public. You would
have to request it from Nuvoton directly. It should not be a problem to
get it if you let them know what you need it for.

> In BIOS, I have settings related to target temperatures, minimum pwm
> output, etc.
> 
> Thanks for working on this driver!  I'd be happy to add my Tested-by:
> if you submit it upstream.
> 
Thanks a lot for your help testing it!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
