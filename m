From: "David Balnaves" <david@utopia.cable.nu>
Date: Mon, 22 Sep 2008 11:31:28 +0000
Subject: Re: [lm-sensors] unknown VRM version
Message-Id: <6A9AB5D3EFA54A27A4C63C9BFB00A732@gamma>
List-Id: <lm-sensors.vger.kernel.org>
References: <45E76B64FBD6468F9A21FC6ED504138D@gamma>
In-Reply-To: <45E76B64FBD6468F9A21FC6ED504138D@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh.. sorry.  And most importantly, this worked as a fix for the unnecessary 
log messages.

-- 
David Balnaves
URSYS Pty. Ltd
13 Burwood Rd. Burwood NSW 2134 Australia
Ph 02 8745 2832 Fax 02 8745 2828
david.balnaves@ursys.com.au
----- Original Message ----- 
From: "David Balnaves" <david@utopia.cable.nu>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: <lm-sensors@lm-sensors.org>
Sent: Monday, September 22, 2008 9:27 PM
Subject: Re: [lm-sensors] unknown VRM version


> Hi Jean,
>
> Thanks for the help.
>
> I found that /etc/init.d/lm-sensors was a convenient place to put the 
> modification.
>
> -- 
> David Balnaves
> URSYS Pty. Ltd
> 13 Burwood Rd. Burwood NSW 2134 Australia
> Ph 02 8745 2832 Fax 02 8745 2828
> david.balnaves@ursys.com.au
> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "David Balnaves" <david@utopia.cable.nu>
> Cc: <lm-sensors@lm-sensors.org>
> Sent: Monday, September 22, 2008 6:33 PM
> Subject: Re: [lm-sensors] unknown VRM version
>
>
>> Hi David,
>>
>> On Mon, 22 Sep 2008 13:54:50 +1000, David Balnaves wrote:
>>> Thanks for the reply.
>>>
>>> wintermute:~# uname -r
>>> 2.6.20.3-ubuntu1
>>>
>>> wintermute:~# cat /proc/cpuinfo
>>> processor : 0
>>> vendor_id : Geode by NSC
>>> cpu family      : 5
>>> model   : 9
>>> model name      : Unknown
>>> stepping  : 1
>>> cpu MHz   : 266.648
>>> fdiv_bug  : no
>>> hlt_bug   : no
>>> f00f_bug  : no
>>> coma_bug  : no
>>> fpu    : yes
>>> fpu_exception   : yes
>>> cpuid level     : 2
>>> wp     : yes
>>> flags   : fpu tsc msr cx8 cmov mmx cxmmx
>>> bogomips  : 533.87
>>> clflush size    : 32
>>
>> I am reasonably certain that the Geode CPUs have no VID pins, so it is
>> expected that this particular feature of the PC87366 isn't used on your
>> system.
>>
>> The annoying "Requested unsupported VRM version" message that fills
>> your logs has been fixed in kernel 2.6.22. For earlier kernel versions,
>> there is no direct way to disable this warning message, but the
>> following workaround should work:
>>
>> * Search for the "vrm" file under /sys. It should be reachable as
>>  either /sys/devices/platform/pc87366.26144/vrm
>>  or /sys/class/hwmon/hwmon0/device/vrm.
>>
>> * Write value 90 to that file:
>>  echo 90 > /sys/devices/platform/pc87366.26144/vrm
>>
>> After doing that, the warning message should no longer be logged.
>> You'll have to reiterate the operation after each reboot so you
>> probably want to add the command in some local boot script.
>>
>> -- 
>> Jean Delvare
>>
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
