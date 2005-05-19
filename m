From: fako@freemail.hu (Holub Zoltan)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: sensors bug?
Message-Id: <Pine.LNX.4.58.0401181400350.32054@terminal.dnsalias.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I think it's a bug:

+12V:     +12.10 V  (min =  +0.00 V, max =  +0.00 V)
-12V:     -12.35 V  (min =  -0.00 V, max =  -0.11 V)
-5V:       -5.01 V  (min =  -3.27 V, max =  -0.00 V)
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
vid:      +3.500 V

strace says:
open("/sys/bus/i2c/devices/0-002d/temp_min1", O_RDONLY) = -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get TEMP1 data!\n", 29ERROR: Can't get TEMP1 data!
) = 29

/sys/bus/i2c/devices/0-002d:
$ ls *temp*
temp_hyst1  temp_hyst3   temp_input2  temp_max1  temp_max3
temp_hyst2  temp_input1  temp_input3  temp_max2

$ cat temp_input1
3250   (32.5 Celsius)


I'm using kernel 2.6.1 and lm_sensors 2.8.3
sensors:
w83781d-i2c-0-2d
Adapter: SMBus ALI15X3 adapter at e800

I didnt patched any i2c or sensors in the kernel.
With kernel 2.6.0 everything works fine.


fako

