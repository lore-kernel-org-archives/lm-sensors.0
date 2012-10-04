From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Oct 2012 16:22:19 +0000
Subject: Re: [lm-sensors] sensors-detect changes monitor settings on hp pavilion dv7
Message-Id: <20121004162219.GA29817@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAq1RJmLU+cyc59=3fnm-ZNZckk0t-qkcE=2rWNHMfj0HedKSQ@mail.gmail.com>
In-Reply-To: <CAAq1RJmLU+cyc59=3fnm-ZNZckk0t-qkcE=2rWNHMfj0HedKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 04, 2012 at 11:30:45AM -0400, Andrew Potter wrote:
> Hi, I wasn't quite sure from the information on lm-sensors.org how to open
> an official ticket, but the details of my problem are here:
> 
> https://bbs.archlinux.org/viewtopic.php?pid70583
> 
> Basically, when I probe i915 gmbus panel (i2c-2) with sensors-detect, when
> it probes address 0x4f my monitor settings (I think the sharpness mostly)
> are changed drastically.  This is persistent over any operating system and
> reboot, leading me to believe a) its a hardware issue, or b) nothing
> usually touches whatever values were changed.  Any help would be greatly
> appreciated, in the forum post I've also included some experimentation with
> i2c-tools.  The problem originally occured on an Arch Linux system.  Let me
> know if you need anything else!
> 
Sensors-detect should tell you:
"Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems."

Apparently it does cause trouble on your system. Problem is that some I2C
devcies interpret I2C read requests as command to do something ... in your case,
it looks like some device interprets a read on address 0x4f as request to change
some monitor settings.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
