From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: ticket 1415
Message-Id: <20031023043830.GA4097@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F95168B.5040305@yahoo.com.au>
In-Reply-To: <3F95168B.5040305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trevor:

* TN <tnuro@yahoo.com.au> [2003-10-23 09:52:02 +1000]:
> success.......I got the latest from cvs and sure enough, numbers! I'm 
> not sure about a couple of these (ie. the voltage sensors seem to have 1 
> or 2 weirdnesses about them), but it appears to be working. The fan 
> speed & temperatures seem to make sense and change in a sensible manner 
> (speed increases as temperature increases)

OK, first of all... I've committed another change to CVS.  You should now
see in1, fan3, and temp3 which we didn't see before.

For my P4C800E, I know these things for sure:

chip "w83627thf-*"

	label fan1 "Chassis Fan"
	label fan2 "CPU Fan"
	label fan3 "Power Fan"

I'm also assuming these:

	label temp1 "MB Temp"
	label temp2 "CPU Temp"
	label temp3 "PWR Temp"
	# PWR Temp is the 2 pin connector on the mainboard
	# unless you've actually connected a sensor...
	ignore temp3

I can't say anything about inX yet.

> One thing I've noticed is that on my physically accessible servers, the 
> temp readings seldom agree with the bios readings.....is there a 
> calivration process I need to go through ?

Yes, if possible.  There is no way for us to automate this.  Check 
/etc/sensors.conf for examples.  OTOH, if you're patient you can just wait
for me to do it. ;)  I have the feeling that more source code changes are
necessary yet anyway.

BTW my temp1/MB actually looks pretty good; it's the temp2/CPU that's low
by ~6C compared to BIOS.  It's also possible that neither is lying - if the
BIOS sits in a tight loop it could cause the CPU to heat up as compared to
a mostly idle/halted CPU running Linux.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
