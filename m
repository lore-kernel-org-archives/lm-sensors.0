From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Jan 2008 19:41:26 +0000
Subject: Re: [lm-sensors] Needed support for SMSC LPC47M292
Message-Id: <20080106204126.2cb139be@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <477E2B2A.5010707@gmail.com>
In-Reply-To: <477E2B2A.5010707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Antonio,

On Fri, 04 Jan 2008 12:48:42 +0000, Antonio RAGO wrote:
> Hi all
> I'm writing you about an LPC47M292 chip.
> I have and ibm thinkcenter with kernel 2.6.22-3-686 (debian)
> and I'm trying to recognize the sensors.
> sensors-detect claim that there is the chip 
>     `SMSC LPC47M292 Super IO Fan Sensors'
> and I've loaded the corresponding module
> but even if the module is loaded and according to the messages log it's 
> the right one
> when I try to run sensors, the program claims that no chipset has been 
> found.
> (In the following i'm reporting also i2c stuff even if it seems to me 
> that they are useless)
> 
> raven:~# sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> raven:~# ls -l /dev/i2c*
> crw-rw---- 1 root root 89, 0 2008-01-04 10:58 /dev/i2c-0
> raven:~# lsmod | head -6
> Module                  Size  Used by
> smsc47m1                9508  0
> i2c_isa                 4192  0
> i2c_dev                 7140  0
> i2c_i801                8656  0
> i2c_core               23552  3 i2c_isa,i2c_dev,i2c_i801
> raven:~# dmesg  | tail -1
> smsc47m1: Found SMSC LPC47M292
> (...)
> raven:~# dpkg -l lm-sensors
> (...)
> ii  lm-sensors                    1:3.0.0-4                     
> utilities to read temperature/voltage/fan sensors
> 
> Maybe I'm missing something, but it seems to me that it's not working.
> I can easily do any test on this computer if it's needed.

This is indeed strange. Please provide the output of:
strace sensors
ls -l /sys/class/hwmon
ls -R /sys/class/hwmon/*

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
