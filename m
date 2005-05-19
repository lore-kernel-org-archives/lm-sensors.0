From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: [PATCH ] LM87: Add code to retry reads on error
Message-Id: <416C9165.8030607@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
In-Reply-To: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Hi David,
> 
> 
>>This patch adds code to retry if there are any read errors.   This
>>code has been copied almost verbatim from the LM93 driver (Thanks,
>>Mark!).  
> 
> 
> Thanks, applied (with some edition).
> 
> I suspect Mark copied it from my w83l785ts driver ;) Open source code
> rules.

:^)

> 
> BTW this may make us think of integrating the mechanism into the i2c
> layer itself. If more chips and hardware setups need a similar function,
> it may be preferable that we avoid duplicating code.

For us, we need the functionality.   I agree that it probably belongs in
the i2c layer, but this works (and was amazingly easy to implement).

> 
> 
>>Just as in the LM93, it's not clear what the right thing would be to
>>do if the retries all fail, so I return 0, just as the LM93 does.
> 
> 
> In the w83l785ts driver I do return the last know value for that
> register, passed as an additional parameter by the caller. It doesn't
> help for the first read, of course, and tends to hide errors, but is
> IMHO better than arbitrarily returning 0.

I see what you did.  I'm not a C coder, so I'm not sure I can pull it 
off.  I will see what I can do.

> 
> There's something strange in your patch, methinks. You issue warnings on
> read errors, but you don't actually issue an error message if you are
> not able to recover from the successive errors. You may provide a patch
> against CVS that fixes that and I'll apply it.

Yeah, I thought of that after I sent the patch off.   The patch I have 
been using logs when the maximum number of retries has been exhausted.
I held back from sending a patch to my patch until I got some feedback :^)

> 
> You'll see I have commited my own changes to the lm87 driver too. They
> mostly fix brokenesses in macros, which make the driver handle negative
> temperatures correctly, and, more interestingly, make it round voltages
> properly.

Sounds like good stuff.  I hadn't noticed any problems, but that doesn't 
mean they weren't there.

> 
> I plan to commit more changes soon. In particular, the init step is
> totally weird. Reseting the chip makes it forget the way the BIOS had
> configured it. The lm87 driver also has the drawback that you need to
> change a couple defines to get it to work according to your physical
> setup. When I ported the driver to Linux 2.6, I changed that and had the
> driver read the configuration from the chip instead. On my board, the
> BIOS configures it as it should, so it works really great.
> 
> Are you in a similar case? Did you have to change the defines before
> compiling the driver? 

Yes, I have the same case.   We have two products that use the LM87 (and 
another on the way).  One uses one configuration, and the other uses the 
second configuration.  At this time, I have a total hack in the spec 
file that makes a copy of the lm87.c file, patches it for the additional 
temperature input and adds and entry to the make file to build it when 
the rest of the modules are built.   Ugly, but since I don't code in C 
(yet), doing this was something well within my skills (and it does work 
fine, as long as you remember to load the right driver version).

> Did you ever try to dump the chips contents before
> loading the lm87 driver and check if the BIOS had configured it for you?

I haven't tried this, so I really don't know.  I expect it be correct on
one board.  The second board is still in development and has more BIOS 
bugs than you can count, so I'm pretty sure setting up the sensor chips 
isn't done correctly yet.


> The main configuration register is at 0x16; if it doesn't read 0x00 at
> boot time, then it means that your BIOS changed it. It reads 0x04 for
> me, because the chip is wired for 4 voltages and 3 temperatures (as
> opposed to the default 6 voltages and 2 temperatures).

I'll give a peek and see what I can see.




