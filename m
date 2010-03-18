From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 18 Mar 2010 13:39:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add basic support for lm64 to	lm63.c
Message-Id: <20100318133912.GA6714@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1268855722-18457-1-git-send-email-mjg@redhat.com> <20100318084135.15fb1996@hyperion.delvare>
In-Reply-To: <20100318084135.15fb1996@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Here's the dump from the lm64.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 34 3e 00 03 08 46 00 46 00 03 08 46 00 46 00 00    4>.??F.F.??F.F..
10: 60 10 00 00 00 00 e5 00 00 7b 1f 1f 00 00 00 00    `?....?..{??....
20: 00 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .d..............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 af 0f ff ff 00 00 05 08 00 05    ......??....??.?
50: 00 04 32 05 46 06 5a 07 5f 0b 64 0d 69 10 69 10    .?2?F?Z?_?d?i?i?
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: c0 20 2a d1 19 01 0d 00 00 00 00 00 00 00 00 00    ? *????.........
c0: 00 00 00 00 00 00 00 27 00 00 00 00 00 00 00 02    .......'.......?
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 51    ..............?Q

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
