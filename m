From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: linux 2.6.6 & w83627hf module & Q-Fan
Message-Id: <20040606050330.GD10118@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516101015.GA19126@nospam.com>
In-Reply-To: <20040516101015.GA19126@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rutger:

* rutger@nospam.com <rutger@nospam.com> [2004-05-16 12:10:15 +0200]:
> Hi,
> 
> I've got a question about the w83627thf sensors which can be found on
> a Asus p4p800 motherboard. The comment of the driver (w83627hf.c)
> indicates:
> 
>     Note: automatic ("cruise") fan control for 697, 637 & 627thf not
>     supported yet.
> 
> This is called 'Q-Fan' by Asus. How can I support this? Is this not
> implemented because of lack of hardware, lack of time or lack of
> knowledge?

I have an Asus P4C800E Deluxe, also with w83627thf.  Lack of time is
always an issue though. :)  As for knowledge, we haven't settled on
an interface for temperature vs. PWM automagic yet.  Nonetheless,
the driver shouldn't do this...

> The problem is I want to be able to read the CPU temperature without
> disabling Q-Fan. When I insmod the module now, the fan speeds up to
> maximum speed without reason.

But I don't see that behaviour here.  Actually, QFAN doesn't seem to do
much for me whether it's enabled in BIOS or not.  Anyway, I read through
the driver again keeping your report in mind... I can't see the problem.

Dumb question: you *are* loading w83627hf (and not w83781d) right?

Could you send me the results of `isadump 0x295 0x296` after a fresh
reboot - without ever having loaded the w83627hf driver?  And again,
the results of the same command after you load the driver.  Once more
after you run `sensors -s` (if that is what does it).  Thanks.

Also, I'm curious... does QFAN control all of the fans or just the
CPU fan (fan2) for you?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
