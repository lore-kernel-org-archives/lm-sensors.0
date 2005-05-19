From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Xeon II motherboard and CPU temp readings
Message-Id: <20040618212248.GA2661@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
In-Reply-To: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Homer:

What a small world, eh?

Assuming I can actually help you, will you give me a break on my
email account? ;)

* Homer Wilson Smith <homer@lightlink.com> [2004-06-18 16:12:54 -0400]:
> 
>      Running Redhat 8.0, 2.4.20-24.8smp, sensors 2.6.3

That version of sensors is almost 3 years old, just FYI.

>      Dual Xeon motherboard only shows one temp reading for
> CPU's and no fan readings at all.
> 
>      Using the w83627hf-isa-0290 driver.
> 
>      Am I doing something wrong or can this been fixed?
> 
>      Pointers to RTFM welcome.

That's pretty much the answer for the fans...

http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/fan-divisors

But for the temp sensors, you'll probably  need to get an updated version of
our software - the xeontemp driver wasn't added until (I think) 2.8.something
and we're now at 2.8.7.

You'll need both the I2C package and lm_sensors2 package.  This old message
might also be useful when building for RH (says 9, but applies to 8 also)

http://archives.andrew.net.au/lm-sensors/msg03904.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
