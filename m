From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 22 Feb 2006 05:17:34 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <191fb4ca0602212117t592d02e1k8f7fd73ec6045db2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Yes I did register the device with the hwmon class. It shows up under
/sys/class/hwmon/hwmon0/device

...juerg


> Hi Juerg,
>
>> I rewrote the vt1211 driver to implement it as a platform driver but
>> now sensors doesn't see it anymore. The chip is registered at
>> /sys/devices/platform/vt1211.24576 but sensors (2.10.0) reports:
>> Can't access procfs/sysfs file
>> Unable to find i2c bus information;
>> For 2.6 kernels, make sure you have mounted sysfs and libsensors
>> was compiled with sysfs support!
>> For older kernels, make sure you have done 'modprobe i2c-proc'!
>>
>> SYSFS support is compiled into libsensors and kernel version is
>> 2.6.16-rc3-mm1.
>
> Did you register your driver with the hwmon class? libsensors scans
> /sys/class/hwmon for hardware monitoring chips. If you device doesn't
> show up there, it won't be found.
>
> --
> Jean Delvare

