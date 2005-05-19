From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Problem with "sensors -s"
Message-Id: <3E7F6222.1060902@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E7EA3D2.60309@astro.physics.upenn.edu>
In-Reply-To: <3E7EA3D2.60309@astro.physics.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'd like to see:

ls -dl /proc
ls -dl /proc/sys
ls -dl /proc/sys/dev
ls -dl /proc/sys/dev/sensors

Also, try setting some limits the old fashion way (as root):

cd /proc/sys/dev/sensors/it87-isa-0290
echo "0.5 1.0" > in1

Anything special logged in syslog/messages?

Lastly, double check (I know you looked once) that you only have a 
single libsensors installed:

ldconfig -v | grep libsensors


Phil


Derek Dolney wrote:

> Jean Delvare wrote:
>
>> (please reply to the list, not to me only)
>>
>>  
>>
>>> I run sensors -s (as root!) and get this message:
>>>
>>> ----------------------snip-------------------------
>>> it87-isa-0290: Can't access /proc file for writing;
>>> Run as root?
>>> ----------------------snip-------------------------
>>>
>>> The i2c-proc IS inserted.
>>>
>>> I am using lm_sensors-2.7.0. I am using a 2.4.20 kernel patched with 
>>> i2c-2.7.0 support.
>>>   
>>
>>
>> Could you make sure you have only *one* libsensors on your system and
>> that it matches the version of sensors you are using?
>>
>>
> There is only one libsensors, the one that came with lm_sensors-2.7.0. 
> It is libsensors.so.1.3.0.
>
>>  
>>
>>> But I seem to be limited not being able to do sensors -s.
>>>
>>> What should I do? Please help!
>>>   
>>
>>
>> If the above doesn't work, please send the output of the following
>> command:
>>
>> ls -lR /proc/sys/dev/sensors/
>>
>>  
>>
> Here is that output:
>
> localhost lib # ls -lR /proc/sys/dev/sensors/
> /proc/sys/dev/sensors/:
> total 0
> -rw-r--r--    1 root     root            0 Mar 24 11:53 chips
> dr-xr-xr-x    2 root     root            0 Mar 24 11:53 it87-isa-0290
>
> /proc/sys/dev/sensors/it87-isa-0290:
> total 0
> -r--r--r--    1 root     root            0 Mar 24 11:53 alarms
> -rw-r--r--    1 root     root            0 Mar 24 11:53 fan1
> -rw-r--r--    1 root     root            0 Mar 24 11:53 fan2
> -rw-r--r--    1 root     root            0 Mar 24 11:53 fan3
> -rw-r--r--    1 root     root            0 Mar 24 11:53 fan_div
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in0
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in1
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in2
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in3
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in4
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in5
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in6
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in7
> -rw-r--r--    1 root     root            0 Mar 24 11:53 in8
> -rw-r--r--    1 root     root            0 Mar 24 11:53 temp1
> -rw-r--r--    1 root     root            0 Mar 24 11:53 temp2
> -rw-r--r--    1 root     root            0 Mar 24 11:53 temp3
> -r--r--r--    1 root     root            0 Mar 24 11:53 vid
>
>> Just another question: Do you have any other patch added to your
>> kernel,
>> such as the ptrace bugfix?
>
>
> I am running gentoo-sources-2.4.20-r2, which is a heavily patched 
> kernel  based on one of the -ac kernels. Yes, it contains the ptrace 
> patch.
>
