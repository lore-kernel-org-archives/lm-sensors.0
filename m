From: mmbdr5729@yahoo.com (mohan)
Date: Wed, 27 Sep 2006 17:42:11 +0000
Subject: [lm-sensors] question regarding lm-sensors.org - LTC1760
Message-Id: <20060927174211.39745.qmail@web30610.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <451A1681.7090404@assembler.cz>
In-Reply-To: <451A1681.7090404@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes I have the driver which works ok.
Since I am using this in a propietary embedded system, it may not be appropriate for general use.  
The big issue is bus arbitration. At present I simply ignore it.

At present I simply read and control the registers of LTC1760
and use the "smartbatt" module to read the battery info.

Mohan

Jean Delvare <khali at linux-fr.org> wrote: > > I have to work with the LTC1760 chip of Linear Technology. In the 
> > drivers table I could read the following:
> >  
> > Manufacturer  Chip  Detected  Driver                     Status, Comments 
> > Linear       LTC1760  no      Dual battery controller.   (2005-01-17) Under
> > Technology                                               development by 
> >                                                          Mohan Mistry 
> >  
> > My question is how can I contact Mohan Mistry, to ask him how his 
> > development is going. perhaps he is done with the driver, and it is not 
> > written on the lm-sensors page yet. Or is the driver already written, 
> > but not published yet?
> 
> I dont know. Btw good question. I have found only this ticket entry 
> http://www.lm-sensors.org/ticket/1790 This has been imported from old system
> and it seems there is no contact info.
> 
> Phil, is there a way to find an email of Mohan?

Let's ask the interested directly. Hi Mohan :) Any news from the driver?

-- 
Jean Delvare


 		
---------------------------------
Get your email and more, right on the  new Yahoo.com 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060927/8c9c123a/attachment-0001.html 
