From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: lmsensors:updating ticket?
Message-Id: <20020423093009.A29366@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


OK, I made that tweak for you.


Phil

On Tue, Apr 23, 2002 at 03:34:59AM -0700, John M. Choi wrote:
> Sorry to bother you, but on the website, it said you were the main PR
> guy, so I hope you don't mind. I posted a ticket, #867, for some code to
> initialize the Tyan s2460 and have recently figured out that there is a
> mistake. Is there a way to update the entry or should I just create a new
> ticket? In case, here is the proposed update:
> 
> >From the W83627HF/F pdf datasheet from Winbond, page 93, Revision 1.0
> released Nov. 2000, the last line that writes data, 'outb(0x0a, PORT1);'
> should actually be 'outb(0xaa, PORT1);'.
> 
> Basically, I believe this addresses Warning #2, I hope/think/guess.
> 
> What is the best way to change this and what should I do? Should I repost
> the updated code in its entirety?
> 
> Thanks.
> 
> John
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
