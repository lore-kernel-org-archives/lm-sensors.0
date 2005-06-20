From: atis@mikrotik.com (Atis Elsts)
Date: Mon, 20 Jun 2005 16:33:32 +0000
Subject: [lm-sensors] Ticket 2005
Message-Id: <200506201735.55466.atis@mikrotik.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506161659.57761.atis@mikrotik.com>
In-Reply-To: <200506161659.57761.atis@mikrotik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 20 June 2005 16:53, Jean Delvare wrote:
> Hi Atis,
>
> Atis Elsts wrote:
> > Uhm. I'm confused here, because i2cdump and i2cdetect says:
> > "Error: Could not open file `/dev/i2c-1': No such device"
>
> You need to modprobe i2c-dev, sorry for not telling you before.
>
# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 72 6b c8 c8 c5 2c 24 24 89 08 ff ff ff ff ff ff    rk???,$$??......
30: 4d 4d 4d 00 00 00 00 00 00 00 00 00 00 00 5c 68    MMM...........\h
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
60: 80 80 e8 88 4d 4d 4d 38 2d 2d 45 41 41 24 40 00    ????MMM8--EAA$@.
70: 4d 4d 4d 09 09 09 09 09 09 00 00 00 40 00 ec 18    MMM??????...@.??
80: 1e a4 0e 00 00 6a 37 00 06 00 40 40 09 09 0b 00    ???..j7.?.@@???.
90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00    ???????Z?...#...
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
                                                                         
Related information from syslog:

Jun 20 17:14:25 localhost syslog.info klogd: i2c-core.o: i2c core module 
version 2.9.1 (20050412)
Jun 20 17:14:26 localhost syslog.info klogd: i2c-proc.o version 2.9.1 
(20050412)
Jun 20 17:14:26 localhost syslog.info klogd: i2c-i801 version 2.7.0 (20021208)
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Version 2.7.0 (20021208)
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: See 
http://www.penguincomputing.com/lm_sensors for more info.
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Detecting device at 0,0x2e 
with COMPANY: 0x5c and VERSTEP: 0x68
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Autodetecting device at 
0,0x2e ...
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Detected SMSC chip
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Unrecognized 
version/stepping 0x68 Defaulting to Generic LM85.
Jun 20 17:14:26 localhost syslog.warn klogd: lm85: Assigning ID 0 to Generic 
LM85 at 0,0x2e
Jun 20 17:14:26 localhost syslog.warn klogd: lm85(0): Initializing device
Jun 20 17:14:26 localhost syslog.warn klogd: lm85(0): LM85_REG_CONFIG is: 0x05
Jun 20 17:14:26 localhost syslog.warn klogd: lm85(0): Setting CONFIG to: 0x05
Jun 20 17:14:27 localhost syslog.warn klogd: lm85(0): Reading config values

Thanks.
