From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 05:54:29 +0000
Subject: Re: [lm-sensors] try to run MAKEDEV if i2c-dev device files
Message-Id: <46907C15.6090300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707215305.6211e914@hyperion.delvare>
In-Reply-To: <20070707215305.6211e914@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>       Author: jwrdegoede
>>         Date: Fri Jul  6 21:39:39 2007
>> New Revision: 4571
>>    Changeset: http://lm-sensors.org/changeset/4571
>>
>> Modified:
>>    lm-sensors/trunk/prog/detect/sensors-detect
>>
>> Log:
>> try to run MAKEDEV if i2c-dev device files are missing before aborting (adapted fedora patch)
> 
>> --- /lm-sensors/trunk/prog/detect/sensors-detect (revision 4568)
>> +++ /lm-sensors/trunk/prog/detect/sensors-detect (revision 4571)
>> @@ -2175,6 +2175,9 @@
>>    }
>>  
>>    if (!($use_devfs || $use_udev)) {
>> +    if (! -c '/dev/i2c-0' && -x '/sbin/MAKEDEV') {
>> +      system("/sbin/MAKEDEV i2c");
>> +    }
>>      if (-c '/dev/i2c-0') {
>>        $dev_i2c = '/dev/i2c-';
>>      } else { # default
> 
> Another good catch, and maybe we can improve it a bit.
> 
> First of all, a question: how many i2c device nodes does your MAKEDEV
> create? The one I have in Slackware 9.1 only creates i2c-0 and i2c-1.
> This might not be sufficient. Not our fault though.
> 

Mine version create i2c-0 - i2c-7

> Secondly, MAKEDEV was in /dev on Slackware, so maybe we could test both
> locations?
> 

I had laready thought about that, as it used to be in /dev with Fedora / RH 
once too, but that was a long time ago. I thought al distro's would have fixed 
that by now.

I'll add checking for and running of /dev/MAKEDEV to svn in a couple of minutes.

> Then, the good news is that we should be able to drop the reference to
> prog/mkdev/mkdev.sh, and finally delete it from the lm-sensors package
> (in branch 3.0.0). I don't plan to move it to i2c-tools. On new systems
> it's not needed. On old systems, MAKEDEV should do the work.

Agreed.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
