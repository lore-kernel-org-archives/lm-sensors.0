From: IB-Ammer@t-online.de (=?iso-8859-1?Q?Dr._Markus_Ammer=2C_Ingenieurb=FCro_Ammer?=
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: sensors on Athlon 1000 and Asus A7V VIA KT133
Message-Id: <000c01c1e2ff$a9e96e30$0700a8c0@ibammer>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

System :Athlon 1000 system (motherboard Asus A7V VIA KT133) 
Sensor: as99127f
OS    SuSE Linux 7.2, Kernel 2.4.16
sensors version 2.6.0


1) sensors-detect does not work correctly. It detects a 686 with i2c-isa.
    What works:
Module                  Size  Used by
w83781d                16704   0  (unused)
i2c-viapro              3696   0  (unused)
i2c-proc                5904   0  [w83781d]
i2c-core               12352   0  [w83781d i2c-viapro i2c-proc]


2) temp2 (CPU) obviously is double the raw value.
LVCool-Idle loop   temp2 = 35,5?C (BIOS)  18 (raw) (36?C WinNT)
100% load          temp2 = 50?C   (BIOS)  25 (raw) (50?C  -"- )

cad10:~ # sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.77 V  (min =  +1.66 V, max =  +2.03 V)
+3.3V:     +3.53 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.01 V  (min = +10.79 V, max = +13.11 V)
-12V:     -11.92 V  (min = -12.32 V, max = -15.06 V)       ALARM
-5V:       -4.98 V  (min =  -4.50 V, max =  -5.48 V)
fan1:     5400 RPM  (min = 3000 RPM, div = 2)
fan2:     5152 RPM  (min = 3000 RPM, div = 2)
MB:       +33.0?C   (limit = +60?C, hysteresis = +50?C)
CPU:      +38.4?C   (limit = +120?C, hysteresis = +100?C)
vid:      +1.85 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm enabled

3) I do "modprobe w83781d" in a startup script  Is there a devicename /dev/xyz which is connected from sensors ? Modules could be loaded automatically then on first startup of sensors if configured within modules.conf.


With regards,
Dr. M. Ammer

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020413/779a0e63/attachment.html
