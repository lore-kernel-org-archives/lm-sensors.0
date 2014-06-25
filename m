From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 20:45:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] sensors-detect: Add detection of NCT7802Y
Message-Id: <20140625204534.GA14652@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 25, 2014 at 01:42:26PM -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  1 +
>  prog/detect/sensors-detect | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 

Register maps for NCT7802Y:

Bank 0:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 3f 00 00 2d 20 2e 00 00 ce d7 00 83 96 d3 00    .?..- ...??.???.
10: ff ff ff f8 00 64 00 00 00 00 00 00 00 11 00 00    ...?.d.......?..
20: 00 81 7d 03 03 03 03 03 00 04 ee 80 f4 32 40 00    .?}?????.????2@.
30: 55 00 55 00 55 00 55 00 55 00 64 64 64 64 64 ff    U.U.U.U.U.ddddd.
40: 00 ff 00 ff 00 ff 00 cc cc ff ff ff f8 f8 f8 7f    .......??...????
50: 3f 07 8f bf 3f 00 3f 00 00 00 00 00 00 00 00 00    ?????.?.........
60: 00 00 7f 00 21 00 00 00 44 00 00 00 d1 02 01 01    ..?.!...D...????
70: 7f 84 84 84 53 53 53 80 0a 00 80 00 00 ff ff ff    ????SSS??.?.....
80: 3b 3c 4b 5a 5f 00 4c a5 ff ff ff ff ff ff ff ff    ;<KZ_.L?........
90: 3b 3c 4b 5a 5f 00 4c a5 ff ff ff ff ff ff ff ff    ;<KZ_.L?........
a0: 36 37 43 4f 5f 00 b2 d8 ff ff ff ff ff ff ff ff    67CO_.??........
b0: 47 00 00 00 00 00 00 00 00 00 ff ff ff ff 00 0b    G..............?
c0: 00 08 3d 3d 00 00 00 39 33 33 ff 00 00 00 40 00    .?=...933....@.
d0: 00 aa 0a 0a 0a 0a 02 f2 81 1e 00 18 07 41 7f 70    .?????????.??A?p
e0: e4 00 00 00 00 00 00 00 00 00 00 00 00 00 10 f0    ?.............??
f0: 00 30 00 ff 00 05 ff ff 00 08 07 01 ff 50 c3 21    .0...?...???.P?!

Bank 1:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 91 00 30 00 00 00 00 00 64 64 00 00 00 00 00    ??.0.....dd.....
10: 00 00 00 00 00 00 00 f2 92 f8 80 f8 80 f8 80 01    .......?????????
20: 2e 01 06 00 02 09 00 1b 00 f9 00 00 00 00 00 00    .??.??.?.?......
30: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: 01 91 00 30 00 00 00 00 00 64 64 00 00 00 00 00    ??.0.....dd.....
50: 00 00 00 00 00 00 00 f2 ab f8 80 f8 80 f8 80 01    .......?????????
60: 2e 02 06 00 02 09 00 5f 00 f9 00 00 00 00 00 00    .??.??._.?......
70: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 91 00 30 00 00 00 00 00 64 64 00 00 00 00 00    ??.0.....dd.....
90: 00 00 00 00 00 00 00 f2 ab f8 80 f8 80 f8 80 01    .......?????????
a0: 2e 02 06 00 02 09 00 5f 00 f9 00 00 00 00 00 00    .??.??._.?......
b0: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 01 91 00 30 00 00 00 00 00 64 64 00 00 00 00 00    ??.0.....dd.....
d0: 00 00 00 00 00 00 00 f2 ab f8 80 f8 80 f8 80 01    .......?????????
e0: 2e 02 06 00 02 09 00 5f 00 f9 00 00 00 00 00 00    .??.??._.?......
f0: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
