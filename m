From: mill.tek@verizon.net (MillTek)
Date: Sat, 06 Jan 2007 05:06:34 +0000
Subject: [lm-sensors] Problem with MSI K9N6SGM-V motherboard sensors
Message-Id: <459F2E5A.608@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <459CA045.7050603@verizon.net>
In-Reply-To: <459CA045.7050603@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks guys,

I ran the isadump that Hans requested.  Here are the results;

 isadump -k 0x87,0x87 0x4e 0x4f
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x4e and data register 0x4f.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 03 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 05 41 20 19 34 00 80 5e 40 00 00 00 08 0e 00 00
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 03 78 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 07 ff ff ff 04 ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 38 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Let me know if this legible.  I'm having problems with fonts here and 
this came out very disjointed.

Jim




Hans Edgington wrote:
> Hi Jim & David,
>
> The fintek f71882fg or EPoX EP1308 has the same chip-id, but can't find
> anything about it on the net. From the pictures I can find, it could be the
> chip in the top right corner of the mobo. Lm-sensors 2.10.1 won't detect it
> you would need the on in the svn.
>
> You could also check by running
> isadump -k 0x87,0x87 0x4e 0x4f
> And post the results.
>
> If it is the f71882fg then the driver is being developed and is almost
> finished. I will post it here as soon as it is.
>
> Regards,
> Hans
>
>
>   


