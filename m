From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 01 Oct 2005 08:37:25 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <pgbsj15hd23fav5snhp68pbpot4j1jfdti@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Resend as fatal mailer-daemon error ate it]

On Sun, 25 Sep 2005 20:08:59 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>Sorry for the delay,
That's okay...


>> # isadump -y -f 0x290 16
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: 01 ff ff 00 00 00 1a 80 ff ff ff ff 00 00 00 00
>
>Hm, that's odd. The device is supposed not to decode offsets 0-4 and 7.
>I checked on my own LM78 and it actually doesn't (they all return
>0xff). I suspect that you have another device mapped in the same I/O
>region, maybe in such a way that there is no major conflict, but it
>still makes the LM78 very hard to detect.

Hmm, so an ISA NIC at 0x280 is probably a bad idea?  Wasn't showing 
in /proc/ioports as the driver wasn't loaded.  Sorry about that, me 
not think of it.

Removing the offending NIC, we get:

root@silly:~# isadump -y -f 0x290 16
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff 40 01 ff ff ff ff ff ff ff ff ff

root@silly:~# sensors-detect
[...]
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Success!
    (confidence 6, driver `lm78')
[...]

Okay, since I eyeballed an LM78-J I think we now know where I goofed :o)

Dunno how many people using NICs from a dozen years ago with 0x280 
and irq 3, but it is a standard setting on older ISA NICs, only 
today tracking different issue on another box do I see NIC using 
I/O offsets 0..0x1f.

Cheers,
Grant.

