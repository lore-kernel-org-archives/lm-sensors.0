From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: [PATCH ] LM87: Add code to retry reads on error
Message-Id: <HZZACpPm.1097665355.8475400.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
In-Reply-To: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> In the w83l785ts driver I do return the last know value for that
>> register, passed as an additional parameter by the caller. It doesn't
>> help for the first read, of course, and tends to hide errors, but is
>> IMHO better than arbitrarily returning 0.
>
>I see what you did.  I'm not a C coder, so I'm not sure I can pull it
>off.  I will see what I can do.

My method needs more changes to the code since it alters the function
prototype. If you don't feel a need for it in your case, let's not
change anything.

>> There's something strange in your patch, methinks. You issue warnings on
>> read errors, but you don't actually issue an error message if you are
>> not able to recover from the successive errors. You may provide a patch
>> against CVS that fixes that and I'll apply it.
>
>Yeah, I thought of that after I sent the patch off.   The patch I have
>been using logs when the maximum number of retries has been exhausted.
>I held back from sending a patch to my patch until I got some feedback :^)

And does it actually happen? The delay between retries may be
experimented with. I came with a very simple model but other approaches
could lead to better results in some cases. Feel free to alter the
delays and see if it helps.

>> You'll see I have commited my own changes to the lm87 driver too. They
>> mostly fix brokenesses in macros, which make the driver handle negative
>> temperatures correctly, and, more interestingly, make it round voltages
>> properly.
>
>Sounds like good stuff.  I hadn't noticed any problems, but that doesn't
>mean they weren't there.

The negative temperature problem was obviously not important, I wonder
who needs this. The voltage rounding issues were rather clean though. If
you set limits in /etc/sensors.conf, "sensors -s && sensors" would
yield different values, off by a few mV each time. For example, my VCore
limits are 1.7V +/- 5%. They were reading (IIRC) 1.56V-1.77V, and after
the fixes read 1.60V-1.79V, which is nearer from what I asked for.

>Yes, I have the same case.   We have two products that use the LM87 (and
>another on the way).  One uses one configuration, and the other uses the
>second configuration.  At this time, I have a total hack in the spec
>file that makes a copy of the lm87.c file, patches it for the additional
>temperature input and adds and entry to the make file to build it when
>the rest of the modules are built.   Ugly, but since I don't code in C
>(yet), doing this was something well within my skills (and it does work
>fine, as long as you remember to load the right driver version).

I suspect that you can simply set CFLAGS to -DLM87_EXT2 to alter the
output. It might be easier than to copy/patch the file.

>I haven't tried this, so I really don't know.  I expect it be correct on
>one board.  The second board is still in development and has more BIOS
>bugs than you can count, so I'm pretty sure setting up the sensor chips
>isn't done correctly yet.

Do you suggest that you have a new product using LM87 chips? I thought
these chips were pretty old and not used for new designs anymore.

Thanks,
Jean Delvare
