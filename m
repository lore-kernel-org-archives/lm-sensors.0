From: pgaige@cadesis.com (=?ISO-8859-1?Q?Gaig=E9_Pierre?=)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: beeping issues
Message-Id: <3F1EEEA0.8030906@cadesis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721094037.55d98610.khali@linux-fr.org>
In-Reply-To: <20030721094037.55d98610.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi folks,
> 
> The three of you reported a similar problem when using lm_sensors. You
> complained about your PC beeping as soon as you load the w83781d module.
> All of you have an Asus motherboard (P4B533, P4B266 and P4S8X,
> respectively) with an AS99127F monitoring chipset.
> 
> We lack documentation about the AS99127F, which explains why we are
> having difficulties understanding why what happens happens.
> 
> I would like you do to some tests to help us find out what the problem
> is. Here is a wishlist:
> 
> 1* The output of sensors (while the PC is beeping).

as99127f-i2c-0-2d
Adapter: SMBus SiS645 adapter at 0xe600
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.60 V  (min =  +1.26 V, max =  +1.53 V)       ALARM
VCore 2:   +1.53 V  (min =  +1.26 V, max =  +1.53 V)
+3.3V:     +3.39 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.07 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.48 V  (min = +10.79 V, max = +13.11 V)
-12V:     -12.08 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.58 V  (min =  -0.00 V, max =  -0.00 V)
fan1:     2800 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
temp1:       +36?C  (limit =  +60?C)
temp2:     +36.0?C  (limit = +120?C, hysteresis = +100?C)
temp3:     +35.0?C  (limit = +120?C, hysteresis = +100?C)
vid:      +1.400 V
alarms:
beep_enable:
           Sound alarm enabled

> 2* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/beep" (or
> whatever the file is at for you).

1 32767

> 3* Does the beeping stop if you echo "0" to that file?

no

> 4* Does the beeping stop if you echo "0 32768" to that file?

no

> 5* Does the beeping stop if you echo "0 0" to that file?

no

> 6* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/alarms"
> (or whatever the file is at for you).

1

> 7* The output of "i2cdump 0 0x2d" (or whatever the values are supposed
> to be on your system). You better unload w83781d before running this
> command.
> 

[root@PC pierre]# i2cdump 0 0xe600
Error: Address out of range!
Syntax: i2cdump I2CBUS ADDRESS [MODE] [BANK [BANKREG]]
   MODE is 'b[yte]', 'w[ord]', 's[mbusblock], or 'i[2cblock]' (default b)
   Append MODE with 'p' for PEC checking
   I2CBUS is an integer
   ADDRESS is an integer 0x00 - 0x7f
   BANK and BANKREG are for byte and word accesses (default bank 0, reg 
0x4e)
   BANK is the command for smbusblock accesses (default 0)
   Installed I2C busses:
     i2c-0       smbus           SMBus SiS645 adapter at 0xe600 
  Non-I2C SMBus adapter
No size specified (using byte-data access)
Error: Could not open file `/dev/i2c-0' : No such device

> Thanks for your help, I hope we'll find some way to solve the problem. 
> 

Something is wrong with the last command but don't know what other 
address value I have to give to the command.
Hope this help ...
Pierre
