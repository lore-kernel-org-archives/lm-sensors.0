From: Andre.Weidemann@web.de (=?ISO-8859-1?Q?Andr=E9_Weidemann?=)
Date: Fri, 17 Feb 2006 11:04:04 +0000
Subject: [lm-sensors] CPU amd MB temperature never change on Asus A7N8X
Message-Id: <43F5ADA4.3080401@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F1EFBB.5060607@web.de>
In-Reply-To: <43F1EFBB.5060607@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I am using the above mainboard in my server and would like to read the 
CPU and Motherboard temperature. I am running Kernel 2.6.15.1 and the 
lm_sensors package (2.9.2).
The mainboard has the asb100 built in(soldered on) and calling "sensors"
always shows the output below. The CPU Temp(AMD) is *always* 25?C and 
the Power Temp(what ever it is) is at scary 127?C.

Output:

asb100-i2c-1-2d

Adapter: SMBus nForce2 adapter at 5500
VCore 1:   +1.66 V  (min =  +1.52 V, max =  +1.68 V)       ALARM
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.05 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)
-12V (reserved):
           -12.51 V  (min =  -0.00 V, max =  -0.00 V)
-5V (reserved):
            -5.25 V  (min =  -0.00 V, max =  -0.00 V)
CPU Fan:  4560 RPM  (min = 1997 RPM, div = 4)
Chassis Fan:
              0 RPM  (min = 3994 RPM, div = 2)
Power Fan:   0 RPM  (min = 3994 RPM, div = 2)
M/B Temp:    +42 C  (high =   +45 C, hyst =   +40 C)
CPU Temp (Intel):
              +19 C  (high =   +60 C, hyst =   +50 C)
Power Temp:
             +127 C  (high =   +45 C, hyst =   +40 C)
CPU Temp (AMD):
              +25 C  (high =   +60 C, hyst =   +50 C)
vid:      +1.600 V  (VRM Version 9.0)
alarms:



Any Ideas what is going wrong here?

  Andr?.


