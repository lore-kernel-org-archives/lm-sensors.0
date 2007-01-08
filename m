From: nromer@arcmailtech.com (Noah Romer)
Date: Mon, 08 Jan 2007 23:52:16 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <200701081552.17752.nromer@arcmailtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 07 January 2007 03:08, Rudolf Marek <r.marek at assembler.cz> wrote:
> They did the mistake. It should be w83627hf instead of W83792D.
> It should contain the power failure on some GPIO pin, plus chassis 
> intrusion. 
> 
> If you don't need this. Do not load the hf driver. It is twice there because 
> it can be accessed via i2c or via isa.

Well, there's no module loaded for it and commenting out the w83627hf line 
in /etc/sysconfig/lm_sensors has no impact. I'll have to check if it's 
compiled into the kernel. What sort of power failure is the sensor detecting? 
These boxes usually have redundant power supplies, and it would be cool if we 
could pick up a failure off via lm_sensors.
 
> CPU1 Core Voltage, Offset 0x10  -> in0
> CPU2 Core Voltage, Offset 0x11  -> in1
> -12V Voltage, Offset 0x14 -> in3
> +1.5V Voltage, Offset 0x15 -> in4
> +3.3V Voltage, Offset 0x16 -> in5
> +12V Voltage, Offset 0x17 -> in6
> +5V Voltage, Offset 0x18 ->in7
> 5Vsb Voltage, Offset 0x19 -> in8
> Battery Voltage, Offset 0x1a -> in9

Ah. I was reading the 0x11 - > 0x14 jump in offsets as meaning that I needed 
to skip in2 and in3. Fixed that, the output looks more reasonable:

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VCoreA:    +1.22 V  (min =  +0.92 V, max =  +1.49 V)   
VCoreB:    +1.26 V  (min =  +0.92 V, max =  +1.49 V)   
Vtt:       +1.18 V  (min =  +1.08 V, max =  +1.33 V)   
-12V:      +0.50 V  (min =  +0.38 V, max =  +0.69 V)   
+1.5V:     +1.49 V  (min =  +1.34 V, max =  +1.65 V)   
+3.3V:     +3.30 V  (min =  +2.96 V, max =  +3.63 V)   
+12V:     +11.90 V  (min = +10.75 V, max = +13.25 V)   
+5V:       +4.97 V  (min =  +4.49 V, max =  +5.50 V)   
5VSB:      +4.92 V  (min =  +4.49 V, max =  +5.50 V)   
VBAT:      +3.25 V  (min =  +2.99 V, max =  +3.66 V)   
fan2:     5000 RPM  (min =  712 RPM)                   
fan3:     5192 RPM  (min =  712 RPM)                   
fan4:     4804 RPM  (min =  712 RPM)                   
CPU1 Temp: +25.2?C  (high = +80.0?C, hyst = +75.0?C)   
CPU2 Temp: +24.2?C  (high = +80.0?C, hyst = +75.0?C)   
temp3:     +26.2?C  (high = +80.0?C, hyst = +75.0?C)   
temp4:     +24.8?C  (high = +80.0?C, hyst = +75.0?C)   
temp5:       +28?C  (high =   +50?C, hyst =   +45?C)   
temp6:       +92?C  (high =  +100?C, hyst =   +95?C)   
cpu0_vid: +1.075 V  (VRM Version 10.0)
cpu1_vid: +0.000 V  (VRM Version 10.0)

> > temp6:       +92?C  (high =  +100?C, hyst =   +95?C)   
> 
> I'm suspecting that this temperature channel is disabled. Please can you 
> check the temp6_mode file?
> 
> The path to file is something like this, please fix it.
> 
> cat /sys/class/hwmon/hwmon?/device/temp6_mode

There is no temp6_mode file. Only three files in /sys/class/hwmon:
/sys/class/hwmon/hwmon2/uevent
/sys/class/hwmon/hwmon1/uevent
/sys/class/hwmon/hwmon0/uevent

There's group of temp6 files in the the devices 
heirarchy: /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp6*
-- 
Noah Romer <nromer at arcmailtech.com>
GPG Key Fingerprint: 944E C2F8 EBEC BCC7 EEA9  9381 1B21 0098 CC8D 45BA

