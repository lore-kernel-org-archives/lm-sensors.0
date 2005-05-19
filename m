From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Sensor support for IBM PC300GL
Message-Id: <20040908083647.M6204@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <NEEELJAJHCPEEENILLCFEECMCGAA.jim@hartslag.com>
In-Reply-To: <NEEELJAJHCPEEENILLCFEECMCGAA.jim@hartslag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 7 Sep 2004 21:57:09 +0200, Jim Deij wrote

> I have an IBM PC300GL (6275-500) machine running with Debian unstable
> (kernel 2.4.26-1-686). I installed your sensor package via apt, but
> whenever I start the sensors-detect script it tells me:
> [code]
>  System vendor: IBM
>  BIOS version: PDKT31AUS
> Sorry, we won't let you go on. IBM systems are known to have
> serious problems with lm_sensors, resulting in hardware failures.
> For more information, see README.thinkpad or
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.
> [/code]

True, we have a detection mechanism in sensors-detect.

> I see in the release files on your site that you are working on the IBM
> problem, but is there any possibility for you to add in the support for my
> PC300GL machine? This motherboard is (as far as I know) also used in old
> Netfinity 3000 systems, although they had different BIOS'es. So that would
> help users with those systems aswell.

True, I am working on this for quite some time now. The plan is to
transparently workaround the Thinkpad issue (which really is an Atmel AT24RF08
issue) in the userspace tools (already done) and the 2.6 kernel drivers (not
done yet). We do *not* plan to do it on the 2.4 kernel drivers because mixing
an old i2c subsystem with new lm_sensors drivers would then be more dangerous
than ever (there is no such problem with 2.6 because all drivers are part of
the main tree so we know for sure that versions won't be mixed. Anyway, you
can still do the change manually on your 2.4 kernel if you don't want to move
to 2.6.

I'm somewhat busy with real life these days, but still I'd like to help you to
get lm_sensors working on your system. We only had one person trying this
before (on a PC300PL). If it works for you as well I'll be able to go on with
removing the detection in sensors-detect and updating the 2.6 kernel drivers.

First step is to make sure that you are using lm_sensors 2.8.7 or CVS. Do NOT
use any earlier version since the hack suggested below would most likely BREAK
your system. 2.8.7 is the first version including my changes that supposedly
safely works around the problem. The IBM detection was left in place just to
make sure the new method had no side effect. I guess it doesn't have any since
we had no complaint so far.

Let me insist. DO NOT DO THE FOLLOWING IF YOUR ARE USING AN LM_SENSORS VERSION
EARLIER THAN 2.8.7.

Once you know for sure you are using at least lm_sensors 2.8.7, you can
manually disable the IBM check in sensors-detect. Add "return 1;" as the first
line of sub safe_system_vendor and you should be done. Then run sensors-detect
and report the full result. We'll see what your system holds and what can be
done with it.

If you confirm that your system reboots fine after doing all this, then this
means that my changes really work as intended and I'll plain drop the IBM
detection from the sensors-detect script. It already lasted too long.

Thanks.

-- 
Jean Delvare 
http://khali.linux-fr.org/
