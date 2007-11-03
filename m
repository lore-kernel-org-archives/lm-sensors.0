From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Nov 2007 18:25:05 +0000
Subject: Re: [lm-sensors] LM75: "ERROR: Can't get temperature data!"
Message-Id: <20071103192505.54f057e2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1194039013.25315.2.camel@louie>
In-Reply-To: <1194039013.25315.2.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Fri, 02 Nov 2007 16:30:13 -0500, Michael Brian Willis wrote:
> I am having trouble getting my LM75 temp sensor to work on a custom
> embedded system. I have two MAX1619 chips that appear to be recognized
> by the "sensors" command. Also, "sensors-detect" seems to find
> everybody. However, I get "ERROR: Can't get temperature data" for the
> LM75 when I run the "sensors" command (see below).  
> 
> --------
> [root@myboard]# sensors
> max1619-i2c-0-19
> Adapter: MPC adapter
> M/B Temp: 33.00 (temp1)
> CPU Temp: 0.00 (temp2)
> 
> max1619-i2c-0-1a
> Adapter: MPC adapter
> M/B Temp: 30.00 (temp1)
> CPU Temp: 127.00 (temp2)
> 
> lm75-i2c-0-48
> Adapter: MPC adapter
> ERROR: Can't get temperature data!
> 
> Here are some relevant version numbers: 
> Denx Linux kernel: 2.6.21
> libsensors: 2.10.5
> sysfsutils: 2.1.0
> i2ctools: 3.0.0

Note: i2ctools doesn't matter here.

> --------
> 
> I have the LM75 kernel module loaded: 
> [root@myboard]# lsmod
> Module                  Size  Used by
> lm75                    4592  0
> max1619                 5776  0
> 
> Any help anybody can provide is greatly appreciated, 

Odd. Please check that no older libsensors version gets in the way
(sensors -v). If you have strace installed, please provide the output
of "strace sensors".

Also, please provide the output of "ls -lR /sys/class/hwmon/*/device/".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
