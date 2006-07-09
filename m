From: mikpolniak@adelphia.net (mikepolniak)
Date: Sun, 09 Jul 2006 20:29:01 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <20060709202901.GA3066@debamd64>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 21:30 Sun 09 Jul     , Rudolf Marek wrote:
> Hello Mike,
> 
> >   Success... found at address 0x0290
> 
> This works.
> 
> Ok so only one problem left in sub ite_isa_detect
> 
> Please can you take a look to that routine and find out which return it takes?
> (I don't know much perl but I guess you will be able to hack  out some "printf"
> there)
> 
> moreover please can you provide me a dump of
> isadump -f 0x290
> 
16:28 >>isadump -f 0x290
WARNING! Running this program can cause system crashes, data loss and
worse!
I will probe address range 0x200 to 0x2ff.
Continue? [Y/n] 
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
0290: ff ff ff ff 00 0a 00 00 ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

