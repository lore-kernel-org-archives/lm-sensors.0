From: m.mcknight@yahoo.ca (Mark McKnight)
Date: Wed, 12 Apr 2006 15:35:57 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <20060412153557.27481.qmail@web37414.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

>OK, that explains it. The driver was looking for the base I/O addresses
>at (non-standard registers) 0x50 and 0x54. You have them at (standard
>registers) 0x20 and 0x24.

>I did some search and it seems that previous nforce4 devices had each
>address listed twice (once in the non-standard register and once in the
>standard register). Original nforce2 devices had only the non-standard
>ones though, which explains why the driver was using them.

>So my guess is that Nvidia tried to move to the standard register,
>which isn't a bad thing, and kept the old ones around for some times
>for compatibility purposes (not a bad idea either.) And your device is
>the first one without that compatibility measure, so the driver broke.

---clipped message and patch

>Mark (McKnight), can you please try it too? It should work for you too.

I tried it on Ubuntu 2.6.15 and it works as expected. I'm now displaying cpu temp and fan speed in the gnome panel. 

>Other users of i2c-nforce2 are invited to test that patch too, just to
>make sure I did not accidentally break the older chips.

>Thanks,
-- 
>Jean Delvare

I'd also like to thank lm-sensor developers past and present for sensors-detect. I found it a very useful utility.

Mark Mcknight

		
---------------------------------
7 bucks a month. This is Huge Yahoo! Music Unlimited  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060412/2eddacc4/attachment.html
