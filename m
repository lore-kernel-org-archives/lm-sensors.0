From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 15 Sep 2011 20:57:28 +0000
Subject: Re: [lm-sensors] [RFC 1/2] add new hwmon-core interface v2
Message-Id: <1316120248.4630.3.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316119550.25490.14.camel@tellur>
In-Reply-To: <1316119550.25490.14.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lucas,

On Thu, 2011-09-15 at 16:45 -0400, Lucas Stach wrote:
> Hello Guenter and others,
> 
> I reworked my first proposal of the hwmon-core API and would like to get
> some feedback.
> 
> After switching to a table based approach, as suggested by Jonathan
> Cameron, the actual code is pretty minimal, most of the code are
> definitions on how the sysfs has to look like and enums for the
> interface. It got a lot cleaner and maintainable this way.
> 
> All in all it's about 800 LOC and should enable a noticeable reduction
> in code size for drivers using it; quantity could be named after porting
> the first drivers.
> 
> Please review and give some feedback if you find the time. I want to
> bring this forward and port over the adt7475 driver, but first I have to
> know if you think the new API has a chance to take off. In a second mail
> you will find some stupid dummy driver which shows how to use the new
> API.
> 
Approach seems much better then before. However, checkpatch reports:

total: 132 errors, 80 warnings, 1004 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch
or
      scripts/cleanfile

Please clean up and resubmit; with that many style errors, it is
difficult, at least for me, to read the code, much less to find the real
problems.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
