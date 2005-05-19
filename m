From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: 1250
Message-Id: <3EDC0034.9050603@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You shouldn't actually need write permissions to the directory since 
user-space won't be creating or deleteing files in via686a-isa-6000...

And all the individual files have the right permisions...

David, what OS are you running on?  I had a similar problem on SuSE 
Linux 8 for 64-bit Opteron that was caused by sensors_proc_write having 
it's data violated by some other code...

Can you run 'strace -o sensors.strace sensors -s' and post the last 20 
or 30 lines of the sensors.strace file?.  I'm looking for pairs of calls 
to sysctl where the first works and the second has a strange (???) entry 
in the first argument to sysctl.

If so, I've got a patch that you can try...

:v)

Mark D. Studebaker wrote:
> devfs could be it. no other good ideas at the moment.
> 
> David wrote:
> 
>> ls -l /proc/sys/dev/sensors
>> total 0
>> -rw-r--r--    1 root     root            0 Jun  2 10:05 chips
>> dr-xr-xr-x    2 root     root            0 Jun  2 09:49 via686a-isa-6000
>>
>> ls -l /proc/sys/dev/sensors/via*
>> total 0
>> -r--r--r--    1 root     root            0 Jun  2 10:06 alarms
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 fan1
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 fan2
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 fan_div
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 in0
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 in1
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 in2
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 in3
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 in4
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 temp1
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 temp2
>> -rw-r--r--    1 root     root            0 Jun  2 10:06 temp3
>>
>> But even when I change the via686a-isa-6000 folder to have root write 
>> permissions it doesn't work.
>>
>> ls -l /proc/sys/dev/sensors
>> total 0
>> -rw-r--r--    1 root     root            0 Jun  2 10:07 chips
>> drwxr-xr-x    2 root     root            0 Jun  2 09:49 via686a-isa-6000
>>
>> So still get: sensors -s
>> via686a-isa-6000: Can't access /proc file for writing;
>> Run as root?
>>
>> I don't think the permission is staying either. Would devfs have 
>> something to do with this?
>>
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
