From: michaelnel@comcast.net (Michael Nelson)
Date: Fri, 08 Sep 2006 01:12:41 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060908011241.GA13735@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 07, 2006 at 09:34:35PM +0200, Rudolf Marek wrote:
> MIchael, or whoever with the DHG chip please:
> 
> Please unload the driver and do:
> 
> isaset -y 0x295 0x296 0x4e 0
> isadump -y 0x295 0x296

Here it is:

seahunt:~ # isaset -y 0x295 0x296 0x4e 0
seahunt:~ # isadump -y 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 4b 31 00 42 10 01 4b 01 01 3c 3c 0a 05
10: 01 59 50 00 00 01 01 3c 43 17 00 00 ff ff ff c5
20: 99 e3 cc cc 98 c6 97 1e ff c1 a1 c5 b2 c5 b2 d9
30: c4 c3 b1 cf bb e3 cd da c5 46 28 11 63 08 01 ff
40: 03 b0 20 de ff ff 00 f5 2d 00 20 84 88 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 24 04 05
60: 01 9b 31 52 9b 01 3c ff 12 ff 0a ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 04 ff 04 4b 31 00 42 10 01 4b 01 01 3c 3c 0a 05
90: 01 59 50 00 00 01 01 3c 43 17 00 00 ff ff ff c5
a0: 99 e3 cc cc 98 c6 97 1e ff c1 a1 c5 b2 c5 b2 d9
b0: c4 c3 b1 cf bb e3 cd da c5 46 28 11 63 08 01 ff
c0: 03 00 00 de ff ff 00 f5 2d 00 20 84 88 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 24 04 05
e0: 01 9b 31 52 9b 01 3c ff 12 ff 0a ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
seahunt:~ #

Hope that helps you.

Michael

-- 

San Francisco, CA

