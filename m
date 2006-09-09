From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 09 Sep 2006 23:38:49 +0000
Subject: [lm-sensors] VT1211-ISA-6000 &  procfs/sysfs
Message-Id: <45035089.4040809@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45034A2F.2020701@programmers.ch>
In-Reply-To: <45034A2F.2020701@programmers.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc Kalberer wrote:
> Hi,
> I dont know if my problem is related to lm-sensors or VT1211 I2C patch 
> but I have the following prob when executing sensors -s :
>
> vt1211-isa-6000: Can't access procfs/sysfs file for writing;
>
> Conclusion : pwmconfig  give me a : No sensors found!
>
> Sys is populated,  kernel is a pure vanilla 2.6.18-rc5 patched with the 
> one given at 
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-new-driver.patch.  
> With the latest lm_sensors-2.10.0 and gcc4.0.3-1
>
> I both compile the full set of the I2C drivers in modules or built-in.  
> It gave me the same result.
>
> Hardware is EPIA M10000.
>
> It is supposed to work, but it doesn't ? Any Idea of the prob ? 
>
> I joined :
> 1) strace sensors -s
> 2) lspci
> 3) dmesg
>
> ++
>
> Marc
>
> sensor:
> ------------------------------------------
> execve("/usr/local/bin/sensors", ["sensors", "-s"], [/* 18 vars */]) = 0
> uname({sys="Linux", node="mediabox", ...}) = 0
>   

this suggests that you didnt run as root.

> write(2, "vt1211-isa-6000: Can\'t access pr"..., 61vt1211-isa-6000: 
> Can't access procfs/sysfs file for writing;
> ) = 61
> write(2, "Run as root?\n", 13Run as root?
> )          = 13
> exit_group(1)                           = ?
>
>   


