From: aurelien@aurel32.net (=?ISO-8859-1?Q?Aur=E9lien_Jarno?=)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Preliminary version of the sis5595 driver for Linux 2.6
Message-Id: <41F6797D.2050402@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125003630.GA21545@bode.aurel32.net>
In-Reply-To: <20050125003630.GA21545@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Aurelien,
> 
> 
>>Here is a new version of the patch. As some of the changes you suggested
>>also apply to the lm78 driver, you will also find a patch for it.
> 
> 
> That's great. Comments about your lm78 patch:
> 
> 
>>@@ -83,7 +83,6 @@
>> {
>> 	if (rpm = 0)
>> 		return 255;
>>-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
>> 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
>> }
 >
> I don't think it is sufficient, as negative rpm values will now return
> undetermined values. Replacing the "= 0" test with "<= 0" should
> fix that, right?

Actually FAN_TO_REG is always call with a positive value (eg through 
strtoul if read from the user), so I though it is ok. However it's 
better to do the test again there as the driver could evolve. Changed.

> 
>> {
>> 	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
>>-	return nval<0 ? (nval-500)/1000+0x100 : (nval+500)/1000;
>>+	return nval<0 ? -(nval-500)/1000 : (nval+500)/1000;
>> }
> 
> 
> Hm, why did you add a "-" here? Looks fine without it (and broken with
> it).
You're right. Changed.

> 
>>-		if (!request_region(address, LM78_EXTENT, "lm78")) {
>>+		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {
> 
> 
> This one is already in 2.6.11-rc2, so don't do it or it'll collide.
Ok, removed.

> About sis5595, I missed a detail:
> 
> 
>>+      ERROR2:
>>+	kfree(data);
>>+      ERROR1:
>>+	release_region(address, SIS5595_EXTENT);
>>+      ERROR0:
>>+	return err;
> 
> 
> labels should be left-aligned. Also I think that labels named
> "exit_free", "exit_release" and "exit" would be prefered.
Fixed.

> And of course my comments on the lm78 patch apply to sis5595 also. Other
> than that I'm fine with your code, feel free to send it to Greg once it
> is generated against and tested with 2.6.11-rc2-mm1 (or wherever the
> latest i2c subsystem is when you do it).
Ok. I am planning to do that this evening. Should I also send a patch to 
Grer for the lm78? Anyway, I'll show you my latest patches on IRC this 
evening.

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno               GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
