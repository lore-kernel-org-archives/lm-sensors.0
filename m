From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 18:01:48 +0000
Subject: Re: [lm-sensors] also recognise /etc/modprobe.conf (Fedora patch)
Message-Id: <468FD50C.9010601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707195630.3cfded29@hyperion.delvare>
In-Reply-To: <20070707195630.3cfded29@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>       Author: jwrdegoede
>>         Date: Fri Jul  6 21:13:50 2007
>> New Revision: 4566
>>    Changeset: http://lm-sensors.org/changeset/4566
>>
>> Modified:
>>    lm-sensors/trunk/prog/detect/sensors-detect
>>
>> Log:
>> also recognise /etc/modprobe.conf (Fedora patch)
> 
>> --- /lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect (revision 4562)
>> +++ /lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect (revision 4567)
>> @@ -2168,6 +2168,8 @@
>>      $modules_conf = '/etc/modules.conf';
>>    } elsif (-f '/etc/conf.modules') {
>>      $modules_conf = '/etc/conf.modules';
>> +  } elsif (-f '/etc/modprobe.conf') {
>> +    $modules_conf = '/etc/modprobe.conf';
>>    } else { # default
>>      $modules_conf = '/etc/modules.conf';
>>    }
> 
> Very good. We should have done this a long time ago, I think that all
> the distributions out there were patching sensors-detect that way.
> 
> I would go even further:
> 
> * We can probably drop support for /etc/conf.modules entirely?
> 
> * If both /etc/modprobe.conf and /etc/modules.conf are present, it is
> likely that /etc/modprobe.conf should be used, so I we should test it
> first.
> 
> * If neither file is found, the default could depend on the kernel
> version. Defaulting to /etc/modules.conf for a 2.6 kernel-based system
> is rather unlikely to be correct.
> 

I fully agree, with all of the above. My perl-foo is not all that good, so the 
last bullet / point (default depending on kernel version) is probably best 
handled by someone else. I can implement the other 2 points if you want, but 
those are so trivial that when someone does 3 he can easily do them too, 
eitherway let me know.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
