From: paul.aviles@palei.com (Paul Aviles)
Date: Tue, 08 Nov 2005 18:18:32 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <20051108161341.M82895@palei.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 8 Nov 2005 15:02:17 +0100 (CET), Jean Delvare wrote
> Hi Paul,
> 
> Sorry but this just can't be true. In 2.6.9, hardware monitoring 
> data is found under /sys/bus/i2c (or more exactly $sysfs/bus/i2c 
> where $sysfs is your sysfs mount point). If "sensors" work, then 
> /sys/bus/i2c must be populated. Check again.

OK, my bad, I was looking under /proc instead. Yes, there are there.
> 
> Do you refer to the fan control features? They should be under
> /sys/bus/i2c/devices/0-002e, search for pwm* files.

I used to run this to lower the speeds of the fans and I guess the format is 
now different. 

echo "0.2 32.0 98.0 1.0 .0.0" > /proc/sys/dev/sensors/`/bin/ls -
1 /proc/sys/dev/sensors |  grep -v eeprom | grep -v chips | tail -1 `/pwm2_cfg

Under the new location, the file I think is related is fanX_pwm. When I do a:
cat fan1_pwm
64

and I tried with echo "32" > fan1_pwm but it does not change the value even 
logged in as root.

When I try pwmconfig I get.

./pwmconfig: line 116: 0-002e/fan3_pwm_enable: Permission denied
  0-002e/fan1_input ... speed was 7952 now 7952
./pwmconfig: line 101: 0-002e/fan3_pwm_enable: Permission denied
    no correlation
  0-002e/fan2_input ... speed was 6150 now 6122
./pwmconfig: line 101: 0-002e/fan3_pwm_enable: Permission denied
    no correlation
  0-002e/fan3_input ... speed was 8095 now 8181
./pwmconfig: line 101: 0-002e/fan3_pwm_enable: Permission denied
    no correlation

> 
> > adm1027-i2c-0-2e
> > Adapter: SMBus I801 adapter at 1480
> > +2.6V:     +2.591 V  (min =  +2.47 V, max =  +2.73 V)
> 
> +2.6V isn't a usual VCC value, how did you come up with this label?
> 
> > vid:      -3.425 V  (VRM Version 9.1)
> 
> Wow. Not good. What value does /sys/bus/i2c/devices/0-002e/cpu0_vid
> contain?

cat /sys/bus/i2c/devices/0-002e/cpu0_vid
-3425

I don't remember where I got that value. I think what I did was to compare 
the values I got back from sensors and tried to compared with what the BIOS 
shows for the voltages so this may be completly off.  I need to recheck my 
stuff later today.


Thanks again.

Paul

