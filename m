From: mikpolniak@adelphia.net (mikepolniak)
Date: Tue, 11 Jul 2006 15:03:15 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <20060711150315.GA2890@debamd64>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 16:11 Tue 11 Jul     , Rudolf Marek wrote:
> Hello Mike,
> 
> Thanks for the chip dump.
> 
> I would like to know what happen now:
> (unload the it87 module)
> rmmod it87
> isadump -y -f 0x290
> isaset -y -f 0x295 0x58
> isadump -y -f 0x290
> isaset -y -f 0x295 0x55
> isadump -y -f 0x290
> isaset -y -f 0x295 0xAA
> isadump -y -f 0x290
> 
> I need this so I can fix the detection script.

9:46 >>rmmod it87
10:55 >>isadump -y -f 0x290
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff ff aa ff ff ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10:55 >>isaset -y -f 0x295 0x58
10:55 >> isadump -y -f 0x290
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff 90 58 90 90 ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10:55 >> isaset -y -f 0x295 0x55
10:56 >> isadump -y -f 0x290
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff 50 55 50 50 ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10:57 >>isaset -y -f 0x295 0xAA
10:57 >>isadump -y -f 0x290
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff ff aa ff ff ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

