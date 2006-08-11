From: ConiKost@gmx.de (Conrad Kostecki)
Date: Fri, 11 Aug 2006 13:29:11 +0000
Subject: [lm-sensors] Sensors are not working :(
Message-Id: <001301c6bd4a$225d7ea0$0200a8c0@N620c>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060809112359.285100@gmx.net>
In-Reply-To: <20060809112359.285100@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!
Here is your Info:

BlackBox ~ # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
1000-101f : 0000:00:0f.0
6000-6007 : 0000:00:0f.0
  6000-6007 : CS5535 ACB0
6100-61ff : 0000:00:0f.0
  6100-61ff : cs5535_gpio
6200-623f : 0000:00:0f.0
9c00-9c3f : 0000:00:0f.0
  9c00-9c03 : PM1a_EVT_BLK
  9c0c-9c0d : PM2_CNT_BLK
  9c10-9c13 : PM_TMR
  9c18-9c1f : GPE0_BLK
  9c28-9c29 : PM1a_CNT_BLK
9d00-9d7f : 0000:00:0f.0
9e00-9e07 : 0000:00:01.0
  9e00-9e05 : ACPI CPU throttle
ac1c-ac1f : 0000:00:01.0
de80-deff : 0000:00:0f.3
  de80-deff : CS5535 Audio
df00-dfff : 0000:00:0d.0
  df00-dfff : 8139too
eff0-efff : 0000:00:0f.2
  eff0-eff7 : ide0


BlackBox ~ # lspci -n
00:01.0 0600: 1022:2080 (rev 30)
00:01.1 0300: 1022:2081
00:01.2 1010: 1022:2082
00:0d.0 0200: 10ec:8139 (rev 10)
00:0e.0 0280: 8086:4220 (rev 05)
00:0f.0 0601: 1022:2090 (rev 02)
00:0f.2 0101: 1022:209a (rev 01)
00:0f.3 0401: 1022:2093 (rev 01)
00:0f.4 0c03: 1022:2094 (rev 02)
00:0f.5 0c03: 1022:2095 (rev 02)
00:0f.6 0c03: 1022:2096 (rev 02)
00:0f.7 0c03: 1022:2097 (rev 02)


BlackBox ~ # i2cdetect -l
i2c-0   smbus           CS5535 ACB0                             Non-I2C 
SMBus adapter


BlackBox ~ # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
BlackBox ~ # i2cdetect 1
Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or 
directory

Conrad
----- Original Message ----- 
From: "Jean Delvare" <khali at linux-fr.org>
To: <ConiKost at gmx.de>
Cc: "LM Sensors" <lm-sensors at lm-sensors.org>
Sent: Wednesday, August 09, 2006 3:06 PM
Subject: Re: [lm-sensors] Sensors are not working :(


Hi,

> I got here installed Gentoo Linux with Kernel 2.6.18-rc4.
> I got this mini pc:
> http://www.dtresearch.com/prod_webDT168.html
> There seems to be the LM82 Sensors but i just can't get this working.
> sensors-detect don't find any sensors :(
> I enabled Geode Access Bus, lm83 modules (its supports lm82), and
> the i2c modules...

I suspect that your i2c bus doesn't work properly, or you have only one
bus recognized (you should have two) and the LM82 chip is connected to
the other one. Please provide the output of:

cat /proc/ioports

lspci -n

i2cdetect -l

i2cdetect 0

i2cdetect 1

-- 
Jean Delvare


