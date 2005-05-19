From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: rpm of 0 with smsc47m1 does not cause alarm
Message-Id: <4187A901.2050401@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41879A3F.3050304@earthlink.net>
In-Reply-To: <41879A3F.3050304@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> 
> 1* Tell us which version of lm_sensors you are using, with which Linux
> kernel.

I am running the CVS version of lm_sensors updated on October 15.

I am running a modified Red Hat 9 kernel, based on the last errata 
kernel from Red Hat, 2.4.20-31.9bigmem.  The only modifications that are 
related to sensors are the removal of the old version from the kernel. 
The CVS version of lm_sensors and i2c are rebuilt independently from the 
kernel.

> 
> 2* Provide a dump of the chip (isadump -f 0x0680 0x80).

# isadump -f 0x0680 0x80

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 00 01 00 18 ff e7 18 00 00 18 00 00 00 00 00
10: 02 06 67 18 c0 00 00 00 00 00 00 00 00 00 03 03
20: 81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
30: 00 00 00 05 05 04 04 01 00 04 84 84 00 01 01 05
40: 05 05 04 05 04 05 04 01 01 00 00 00 84 13 04 57
50: 00 00 00 00 00 00 14 14 f0 ff ff 68 68 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Thanks again,
   David
