From: allen@clarke-aj.freeserve.co.uk (Allen Clarke)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: lm92.c
Message-Id: <000801c223a2$9e58a980$0100a8c0@heuwey>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

just grabbed the cvs today (4/7/2002) to get lm-sensors working on a VIA EPIA board, whilst compiling I had a compilation error, it appears that there is a missing #ifdef

kernel/chips/lm92.c:413: parse error before string constant
kernel/chips/lm92.c:413: warning: data definition has no type or storage class
make: *** [kernel/chips/lm92.o] Error 1

./lm_sensors2/kernel/chips/lm92.c    line 413
MODULE_LICENSE("GPL");


looking through all the other files they have
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

I've stuffed in the #ifdef....#endif on my local copy (which seems to be OK now)

As I don't know my arse from my elbow when it comes to cvs (never have been one for version control, always hated having to use sccs) and I assume that access is restricted anyway, I thought it best to just email this one to you (it should get picked up fairly quickly anyway as it stops the compile.

Cheers

Allen Clarke

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020704/906036dd/attachment.html
