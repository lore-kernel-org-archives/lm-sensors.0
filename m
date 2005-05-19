From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Fans speed problems
Message-Id: <42177669.6060202@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001701c511a9$48eddae0$3224050a@avilespaxp>
In-Reply-To: <001701c511a9$48eddae0$3224050a@avilespaxp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the file doc/chips/lm85 has extensive documentation on this
if you need more help after reading that let us know.


Paul Aviles wrote:
> one more time I need the help of the masters... :-)
> 
> I have a weird server that does not have the regular values values 
> inside /proc for fan speed control. The files inside 
> /proc/sys/dev/sensors/lm85-i2c-0-2e  are
> 
> -rw-r--r--  1 root root 0 Feb 13 03:32 fan1
> -rw-r--r--  1 root root 0 Feb 13 03:32 fan2
> -rw-r--r--  1 root root 0 Feb 13 03:32 fan3
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm1
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm1_cfg
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm1_zone
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm2
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm2_cfg
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm2_zone
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm3
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm3_cfg
> -rw-r--r--  1 root root 0 Feb 13 03:32 pwm3_zone
> 
> The content of fanX is like:
> 
> cat fan1
> 4800 9424
> 
> cat fan2
> 4800 6271
> 
> cat fan3
> 2200 11226
> 
> Where the first field is the minimim RPM and the second is the actual RPM
> 
> The content of pwmX_zone is like:
> 
> cat pwm1_zone
> 1
> 
> cat pwm2_zone
> 3
> 
> cat pwm3_zone
> 1
> 
> I have no idea what those are.
> 
> The content of  the pwmX_cfg is like:
> 
> cat pwm1_cfg
> 0.2 64.0 38.0 1.0 0.0
> 
> cat pwm2_cfg
> 0.2 64.0 98.0 1.0 0.0
> 
> cat pwm3_cfg
> 0.2 64.0 38.0 1.0 0.0
> 
> Also, no idea what each value represents.
> 
> The first weird thing is that when you go to the bios there is a section 
> that shows you the real time rpms of the fans. If I disconnect one fan 
> at the time, I can identify which fan is which.  There are 2 fans in the 
> front, the one in the front right is #1, front left is # 2 and back left 
> is # 3.
> 
> Sensors reports them differently I think for example.
> 
> Fan1:      9310 RPM  (min = 4800 RPM)
> Fan2:      6264 RPM  (min = 4800 RPM)
> Fan3:     11157 RPM  (min = 2200 RPM)
> 
> If I disconnect fan 1 it thinks is fan 3 and vice versa.  Here is my 
> sensors.conf
> 
> chip "lm85-*" "adt7463-*"
> 
>    ignore pwm1
>    ignore pwm2
>    ignore pwm3
>    ignore in4
>    ignore fan4
> 
>    label fan1 "Fan1"
>    label fan2 "Fan2"
>    label fan3 "Fan3"
> 
>    label pwm1 "pwm1 fan"
>    label pwm2 "pwm2 fan"
>    label pwm3 "pwm3 fan"
> 
>    set fan1_min 4800
>    set fan2_min 4800
>    set fan3_min 2200
> 
> pwmconfig fails as it does not recognize the values from the /proc 
> files. Has anyone experience this and any idea how to control the speed?
> 
> I can slow them down by playing with values like
> 
> echo "0.2 10.0 38.0 1.0 0.0" > /proc/sys/dev/sensors/lm85-i2c-0-2e/pwm1_cfg
> 
> but I have no idea what the values are supposed to represent and I am 
> afraid I will damage the board.
> 
> Any assitance will be appreciated.
> 
> Regards,
> 
> Paul;
> 
> 
> 
> 

