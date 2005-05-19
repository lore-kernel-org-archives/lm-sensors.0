From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Kernel-2.6.0-test10 odd problem
Message-Id: <3FC4F5AA.4090907@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126101901.4993a062.zippo752001@comcast.net>
In-Reply-To: <20031126101901.4993a062.zippo752001@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

and you have sysfs mounted?


zippo wrote:

> Agreed, but i don't need it to detect i know what sensors i have, and have a special sensors.conf file from tyan. sensors -s doesn't work. That's all that matters. i2c isn't being placed into the kerenel.
> 
> On Wed, 26 Nov 2003 11:14:10 -0500
> "Mark Studebaker" <mds@paradyne.com> wrote:
> 
> 
>>sensors-detect doesn't support 2.6 yet
>>(as stated on our home page)
>>
>>zippo wrote:
>>
>>
>>>I am testing lm_sensors on a Tyan k7x-pro, (amd756, w83781d, which are both in the kernel. I got the CVS and installed it. I also built i2c support, (yes CONFIG_I2C_PROC), and ran mkdev.sh (witch worked) but when i run sensors -s, or sensors-detect i get
>>>
>>>[root@zippo01 /home/zippo/sensors/]#sensors
>>>Can't access /proc file
>>>Unable to find i2c bus information;
>>>For 2.6 kernels, make sure you have mounted sysfs!
>>>For older kernels, make sure you have done 'modprobe i2c-proc'!
>>>
>>>
>>>that is the error when i run sensors-detect:
>>>
>>>Couldn't open /proc/bus/i2c?!? at prog/detect/sensors-detect line 4184, <STDIN> line 4.
>>>
>>>and there no i2c in /proc, i was wondering if i am doing something wrong or what.
>>>a copy of my lsmod:
>>>
>>>Module                  Size  Used by
>>>w83781d                30976  0 
>>>i2c_amd756              5504  0 
>>>i2c_algo_bit            9608  0 
>>>i2c_sensor              2944  1 w83781d
>>>i2c_dev                 8960  0 
>>>i2c_core               20612  5 w83781d,i2c_amd756,i2c_algo_bit,i2c_sensor,i2c_dev
>>>nvidia               1532952  12 
>>>
>>
>>
> 

