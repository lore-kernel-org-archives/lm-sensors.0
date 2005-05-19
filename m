From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #: 758, ITE IT8712F-A not detected, and not
Message-Id: <3C371F15.D5CA067F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
On ticket 780, thanks for the contribution.
Do you have a proposal for where we should put it?
Also, can you give us a little more background
on the need for 'SySV compliant init scripts',
I'm not really familiar with them.
Also is there any problem with calling it 'sensors'
when we already have a 'sensors' program?
mds






Jakub Narebski wrote:
> 
> On Fri, 4 Jan 2002, Mark Studebaker wrote:
> 
> > please rerun with the correct arguments
> > 'isadump 0x295 0x296'
> 
> Here you have it:
> 
> [root@localhost root]# isadump 0x295 0x296
>   WARNING! Running this program can cause system crashes, data loss and worse!
>   I will probe address register 0x0295 and data register 0x0296.
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 26 e4 00 00 00 00 00 00 00 03 09 00 71 ff ff
> 10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 6d 9a cb b9 ce 3a 43 5d c1 1f 29 21 00 00 00 00
> 30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
> 40: 28 14 2d 19 3c 14 00 00 2d 00 00 00 00 00 00 00
> 50: ff 38 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
> 60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> 70: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 11 20 00 00 00 00 00 00 00 00 03 09 00 71 ff ff
> 90: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 6d 9a cb b9 ce 3a 43 5d c1 1f 29 21 00 00 00 00
> b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
> c0: 28 14 2d 19 3c 14 00 00 2d 00 00 00 00 00 00 00
> d0: ff 38 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
> e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
> f0: 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 00
> 
> --
> Jakub Nar?bski
>     Poland
