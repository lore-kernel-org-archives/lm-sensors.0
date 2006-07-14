From: com.ea@tinet.org (com.ea)
Date: Fri, 14 Jul 2006 11:35:44 +0000
Subject: [lm-sensors] Linux 2.6.16 kernel and "Can't access
Message-Id: <720fb29ntpochc6cnhqukmgllfgg1ptrse@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B726B3.9030704@winbond.com>
In-Reply-To: <44B726B3.9030704@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 14 Jul 2006 12:00:03 +0200, you wrote:

>Hi Keith,
>> I've installed lm_sensors v2.10.0 on a Linux system running a 2.16.6
>> kernel. That's a Debian kernel, but I've also tried with a 2.6.17.4
>> vanilla kernel.
>> 
>> lm_sensors builds and installs fine, and sensors-detect runs and detects
>> i2c-i801. The 'sensors' command gives 'Can't access procfs/sysfs file'.
>> The FAQ suggests ensuring that /sys is mounted and populated (it is),
>> and that i2c-proc is loaded. That module is not loaded, but it doesn't
>> seem to be in the 2.16.6 kernels.
>> 
>> Should I have an i2c-proc module? If not, any further suggestions would
>> be welcome - thanks.
>Can you give the output of sensors-detect and output of `ls /sys/bus/i2c/drivers/*`.
>I think it may because it has not find any hwmon chips OR library linked to "sensors"
>is not the right one.
>
>-- 
>Best Regards
>Yuan Mu

Yep, also be sure that you have libsysfs installed, because libsensors needs it.
The debian packages are called: libsysfs1 and libsysfs2

Regards
Carlos

Carlos Olalla
com.ea at tinet.org
http://www.tinet.org/~com.ea

