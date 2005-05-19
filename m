From: chb@tzis.net (Christoph Breitler)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <1074960882.5941.3.camel@Technetium.pse.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Sam, den 24.01.2004 schrieb Jean Delvare um 16:54:
> > Here is the Output of ls -l /sys/bus/i2c/devices/0-0290
> > 
> > lrwxrwxrwx    1 root     root           38 2004-01-24 14:42
> > /sys/bus/i2c/devices/0-0290 -> ../../../devices/platform/i2c-0/0-0290
> 
> Hehe this is of course a link :/ Try "ls -lL" instead, or whatever will
> give us the list of files within the directory with permissions.

Oh right :). Here is the output of all files, and permissions.

-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 alarms
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 beep_enable
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 beep_mask
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 detach_state
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_div1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_div2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_input1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_input2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_min1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 fan_min2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input0
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input3
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input4
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input5
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input6
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input7
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 in_input8
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max0
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max2
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max3
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max4
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max5
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max6
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max7
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_max8
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min0
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min2
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min3
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min4
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min5
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min6
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min7
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 in_min8
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 name
drwxrwxrwx    2 root     root            0 2004-01-24 14:42 power
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 pwm1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 pwm2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 pwm_enable2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 sensor1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 sensor2
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 temp_hyst1
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 temp_hyst2
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 temp_input1
-rwxrwxrwx    1 root     root         4096 2004-01-24 14:42 temp_input2
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 temp_max1
-rwxrwxrwx    1 root     root            0 2004-01-24 17:08 temp_max2

Strange thing is that all is 777  :/ 


