From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 20:09:05 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <20071118210905.2fc574d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Nov 2007 18:10:24 +0100, Alexander Kiel wrote:
> Hi Jean,
> 
> > May I ask what shell (and version) you're using? Both sequences above
> > return 255 here.
> 
> bash -version says:
> 
> GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)
> Copyright (C) 2005 Free Software Foundation, Inc.

That's fairly recent. I'm running 3.1.17(1)-release, and something even
older on my w83627ehf test machine.

> 
> I have a fresh and totaly normal installed Ubuntu 7.10 32-bit without
> any modifications. My user account and its homedir is also new. The bad
> is that this is likely the most used distributation is the next year.

Ubuntu's marketing appears to be very efficient ;) Ubuntu may be very
popular, but it's still only one Linux distribution amongst a dozen
successful one.

> 
> > It would take a broken shell to do what you describe, if that's
> > possible at all. The following command should answer your question:
> > 
> > echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
> > 
> > Here, it prints the expected error message, then 255.
> 
> --------------------------------------------------------------------------
> root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable ; echo
> 255 > /tmp/pwm1 ; cat /tmp/pwm1
> bash: echo: write error: Invalid argument
> 0
> 255
> root@alex:~# cat /tmp/pwm1
> 0
> 255
> --------------------------------------------------------------------------
> 
> As you can see it prints the error message, the 0 and the 255. And you
> can see both go into /temp/pwm1.
> 

Bummer. That's your shell keeping the initial output (which it failed
to write to pwm1_enable) in some internal buffer and writing it to pwm1
later. I'd say shell bug, and a big one at that. And security-related,
too. I tested on my openSuse 10.3 laptop which has bash version
3.2.25(1) as your system does, and couldn't reproduce the problem
there. Thus I would suspect a Ubuntu-specific patch.

> --------------------------------------------------------------------------
> root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable
> 2>/dev/null ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
> 0
> 255
> --------------------------------------------------------------------------
> 
> Here the error goes to /dev/null.
> 
> --------------------------------------------------------------------------
> root@alex:~# echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable
> >/dev/null 2>/dev/null ; echo 255 > /tmp/pwm1 ; cat /tmp/pwm1
> 255
> --------------------------------------------------------------------------
> 
> And so the 0.

But then there's no error anymore (you never write
to /sys/class/hwmon/hwmon0/device/pwm1_enable) so it's hardly relevant.

> 
> > I meant that the patch is functionally incorrect, not that I was not
> > able to apply it (although it is, indeed, technically incorrect, for
> > it's reverted and not in unified format.)
> 
> Ok. Excuse me. This was a simple diff between the two files. I have no
> experiences in creating a real patch.

OK. Basic rules are:
* Use -u (for unified diff format).
* Original version goes first on the command line, new version goes
  last.

E.g.: diff -u pwmconfig.orig pwmconfig

> > An additional > /dev/null can certainly hurt, as it overwrites the
> > previous > $ENABLE, meaning that you do NOT write the value to the
> > sysfs file at all. It doesn't make a difference for you because writing
> > 0 to pwm1_enable doesn't actually work with the w83627ehf driver, but
> > your change breaks drivers for which it works.
> 
> Ok. Thats a good point. I thought that it redirects the hanging zero
> to /dev/null. But I see echo 0 is the command and > $ENABLE is the
> regirection of the stdout. But why does pwm1_enable not consume the 0
> and throws the error afterwards?

pwm1_enable returns an error, so it can't consume anything. It's up to
the shell to blast the unused data before going on, but in your case it
doesn't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
