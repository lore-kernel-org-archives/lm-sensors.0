From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Thu, 16 Jun 2005 13:17:56 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <20050616111650.80901.qmail@web31003.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

--- Jean Delvare <khali@linux-fr.org> wrote:

> 
> Hi Hugo,
> 
> On 2005-06-15, Hugo Vanwoerkom:
> > I have an Epox EP-8VTAI mobo and my situation is
> > exactly that of ticket 1944, except I run kernel
> > 2.6.10.
> >
> > I would like to remedy the situation, can someone
> > suggest the steps to take? Given that I have
> kernel
> > programming experience, but no hardware monitoring
> > equipment.
> >
> > Am I way off base?
> 
> Looks so. The W83687THF is a rare chip, not listed
> on Winbond's site, we
> have no datasheet for it, this explains why we don't
> support it.
> 
> We may add experimental detection support to
> sensors-detect if you
> provide the output of the following command:
> 
> isadump -k 0x87,0x87 0x2e 0x2f 0x0b
> 
> You'll need a recent version of isadump (lm_sensors
> 2.9.1 or CVS). If it
> doesn't seem to provide any useful information, try
> 0x4e 0x4f instead
> of 0x2e 0x2f.
> 
> Chunhao, do you have information about the W83687THF
> chip? Could Winbond
> release a datasheet for that chip? There's not much
> we can do without
> that.
> 

Thanks for the quick answer.
This is the dump of 0x2e 0x2f:

Script started on Thu 16 Jun 2005 06:02:21 AM CDT
/Thu Jun 16-06:02:21HDB1# isadump -k 0x87,0x87 0x2e
0x2f 0x0b
WARNING! Running this program can cause system
crashes, data loss and worse!
I will probe address register 0x2e and data register
0x2f.
Probing bank 11 using bank register 0x07.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 85 42 ff 00 40 00 00 ff 50 03 f0 01 00 00 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 02 90 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 11 3f ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
/Thu Jun 16-06:02:25HDB1# exit
exit

Script done on Thu 16 Jun 2005 06:02:27 AM CDT

Dump for 0x4e and 0x4f has all ff.

For some reason my posts are not being routed from
lm-sensors to my email address, I have noted that on
other lists.

Let me know if I can help, be glad to.
Thanks again.

Hugo








		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html
