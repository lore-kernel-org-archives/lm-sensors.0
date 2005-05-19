From: williamschnell@operamail.com (William)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <opr7xsq5lbk46x2i@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello;
Still doesn't work, this is what I get now:
[root@localhost william]# sensors -s
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!
[root@localhost william]# modprobe i2c_sensor
[root@localhost william]# sensors -s
No sensors found!

I must have done something, but can't think what it could be.

William



On Wed, 12 May 2004 14:17:08 +0200 (CEST), Jean Delvare  
<khali@linux-fr.org> wrote:

>
>> I've installed kernel-tmb-2.6.5-1.tmb.5mdk-1-1mdk.i586.rpm, and still no
>> temperatures. Several instances of Vcore 1, all showing different  
>> voltages.
>> This might tell me something, but don't know what it means:
>> [root@localhost bin]# find / -name *libsensors.so.3
>> /home/william/lm_sensors-2.8.6/lib/libsensors.so.3
>> /home/william/lm_sensors-2.8.5/lib/libsensors.so.3
>> /usr/local/lib/libsensors.so.3
>> [root@localhost bin]# cd /usr/local/lib
>> [root@localhost lib]# sensors -s
>> sensors: error while loading shared libraries: libsensors.so.3: cannot
>> open shared object file: No such file or directory
>> [root@localhost lib]#
>>
>> There's a feeling that I need install instructions for dummies at this
>> point. Comment please?
>
> Most likely you don't have /usr/local/lib in your library search path,
> or you forgot to run ldconfig after installing lm_sensors.
>
> Check in /etc/ld.so.conf. If you see no "/usr/local/lib" line, add it.
> Then run "ldconfig". Hopefully sensors will now find it.
>
> I invite you to get rid of any older version of sensors or libsensors you
> could have in /usr/bin and /usr/lib, respectively. Such files could have
> been installed through a distribution package and would get in the way
> of your newly installed files, possibly causing trouble.
>
> Jean



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
