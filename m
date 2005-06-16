From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Thu, 16 Jun 2005 17:08:15 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <20050616150744.46969.qmail@web31003.mail.mud.yahoo.com>
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
> 
> OK, this confirms that it has a hardware monitoring
> logical device at
> 0x290, like the other devices in this family. Can
> you now send the
> output of:
> 
> isadump 0x295 0x296
> 
> Then I'll send you some preliminary hacky patches to
> try.
> 
> > For some reason my posts are not being routed from
> > lm-sensors to my email address, I have noted that
> on
> > other lists.
> 
> This may be due to the way you have registered with
> each list (you
> usually can decide not to receive your own posts if
> you don't want to),
> but in the case of lm-sensors it seems to be a
> routing problem at the
> server location. I experienced the same problem a
> few days ago.
> Hopefully this will be fixed soon.
> 

Script started on Thu 16 Jun 2005 10:04:50 AM CDT
/Thu Jun 16-10:04:50HDB1# isadump 0x295 0x296
WARNING! Running this program can cause system
crashes, data loss and worse!
I will probe address register 0x295 and data register
0x296.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 00 01 00 03 00 00 00 01 01 01 01 3c 3c 0a 0a 
10: 01 00 01 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
20: 67 d0 aa b9 64 18 29 12 ff b1 ff f0 00 da 7f 5f 
30: e9 4f bf db fa bc fe ff ff ac 76 4f ef eb 00 00 
40: 01 dc 09 de ff 00 00 50 2d 02 01 44 10 15 80 5c 
50: ff ff 00 ff ff ff 00 80 90 70 ff ff 11 05 ff 05 
60: 67 d0 aa b9 64 18 29 12 ff b1 ff f0 00 da 7f 5f 
70: e9 4f bf db fa bc fe ff ff ac 76 4f ef eb 00 00 
80: 01 00 01 00 03 00 00 00 01 01 01 01 3c 3c 0a 0a 
90: 01 00 01 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
a0: 67 d0 aa b9 64 18 29 12 ff b1 ff f0 00 da 7f 5f 
b0: e9 4f bf db fa bc fe ff ff ac 76 4f ef eb 00 00 
c0: 01 00 00 de ff 00 00 50 2d 02 01 44 10 15 80 5c 
d0: ff ff 00 ff ff ff 00 80 90 70 ff ff 11 05 ff 05 
e0: 67 d0 aa b9 64 18 29 12 ff b1 ff f0 00 da 7f 5f 
f0: e9 4f bf db fa bc fe ff ff ac 76 4f ef eb 00 00 
/Thu Jun 16-10:04:55HDB1# exit

Script done on Thu 16 Jun 2005 10:05:01 AM CDT

Thanks!

Hugo



		
__________________________________ 
Discover Yahoo! 
Have fun online with music videos, cool games, IM and more. Check it out! 
http://discover.yahoo.com/online.html
