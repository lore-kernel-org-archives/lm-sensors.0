From: remy.de.ruysscher@marketxs.com (Remy de Ruysscher)
Date: Mon, 07 Nov 2005 14:59:52 +0000
Subject: [lm-sensors] Problem with WINBOND_W83792D
Message-Id: <BE81C2566829DC43849F0373D0CBCAA2140234@SRV-EXCHBE02.thecamelsnose.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Following up instructions:
 
See: http://secure.netroedge.com/~lm78/readticket.cgi?ticket 93
 
 
[root@Hahn /]# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +4.08 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.07 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +11.55 V  (min = +10.83 V, max = +13.19 V)
-12V:      +0.82 V  (min = -13.16 V, max = -10.90 V)
-5V:       +1.90 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.56 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 2848 RPM, div = 2)
fan2:        0 RPM  (min = 2848 RPM, div = 2)
fan3:        0 RPM  (min =  712 RPM, div = 8)
temp1:       -48??C  (high =  +124??C, hyst =  +125??C)   sensor = thermistor
temp2:     -48.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
temp3:     -48.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled
 
arp-i2c-0-61
Adapter: SMBus I801 adapter at 1100
 
 
[root@Hahn /]# i2cdump 0 0x29
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x29, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

 
 

Met vriendelijke groet / kind regards,

Remy de Ruysscher

Operations Engineer 
H. Walaardt Sacr?straat 413
1117 BM Schiphol Oost
The Netherlands
T   +31 (0)20 5025800
F   +31 (0)20 5025 801
M   +31 (0)6 24748987
E   remy.de.ruysscher@marketxs.com <mailto:remy.de.ruysscher@marketxs.com> 

I    www.marketxs.com <http://www.marketxs.com/>  

 
______________________________
DISCLAIMER: This e-mail message is intended for the addressee(s) or authorized recipient only. If you are not the addressee, or an authorized recipient, you are specifically advised that any use, distribution, publication, copying or repetition of this information is prohibited. If you have received this information in error, please notify us immediately (+31 (0)20 50 25 800) and destroy this message.
