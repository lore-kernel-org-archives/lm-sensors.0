From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: LM-sensors Q
Message-Id: <20020924115615.A15392@mercury.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Harry:

(cc'ed to sensors mailing list)

I do not have personal experience using mkpatch; I find it very easy to
build everything as modules.  However, it looks to me like you built
everything correctly.

> I then need to do a configure, make deps, make BZImage, etc, correct?

Yes of course.

Did sensors-detect find an I2C or SMBus?  The ASUS sensor chip requires one.
A quick look at asus.com says your board has Intel 82801BA (ICH2), which
is supported.  Send me the output of sensors-detect if you're still having
problems.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

* harry <harry@dr-data.net> [2002-09-24 10:48:59 -0700]:
> Hey dude,
> 
> sorry for the interruption but I had a quick question I hope you will help 
> me with.
> 
> I have an ASUS P4B266 MB, which is listed as having the AS99127F sensor at 
> the MBM site.
> 
> I have sucessfully built and installed the lm_sensors-2.6.5 code, but hve 
> no joy when I run sensors-detect WRT MB sensor (it does find my TV tuner 
> card).
> 
> Accoring to the LM-monitor site, you wrote a patch for the ASUS chip. I 
> wanted to quickly confirm the following (I'm not a hacker, and I really 
> want to avoid messing up my system or going through hoops for little 
> gain):
> 
> 
> 1. I have ran the mkpatch.pl script against my current kerenl source and 
> there were no errors. May I assume that all is cool with the kernel source 
> and i2c stuff as a result?
> 
> 2. The Readme and mkpatch link is a little vauge about the need to rebuild 
> the newly patched kernel. A dumb question I'm sure, but after doing:
> 
> " Later on, you will want to apply the diffs:
>   cd /usr/src/linux
>   patch -p1 -E < /tmp/lm_sensors-diffs
> "
> 
> I then need to do a configure, make deps, make BZImage, etc, correct?
> 
> 
> Thanks in advance; I hope these questions were not exceedingly lame.
> 
> PS> The link for mkpatch:
> 
> http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/doc/mkpatch
> 
> does not include the ".pl" extension that is now present on the mkpatch 
> script:
> 
> "The patch file is written to stdout; any errors are written to stderr.
> So you will want to capture the output:
>   mkpatch/mkpatch . /usr/src/linux > /tmp/lm_sensors-diffs"
> 
> [root@dr-data lm_sensors-2.6.5]# ls mkpatch/
> Config.in  FILES  INCLUDES  mkpatch.pl  Module.mk
> 				^^^^^^^
> Thanks again!
> 
