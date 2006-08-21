From: RaphaelD@tyan.com (Raphael Deng)
Date: Mon, 21 Aug 2006 18:56:48 +0000
Subject: [lm-sensors] =?utf-8?b?562U5aSNOiAgVHlhbiBTMjcyMCBSZXZzaW9uIDIu?=
Message-Id: <3174569B9743D511922F00A0C943142310DBD905@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
References: <3174569B9743D511922F00A0C943142310DBD8AD@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C943142310DBD8AD@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

I found I make some mistake. According to lm-sensors document, the xeontemp
is "look very similar to an adm1021 or max1617". So the currently
configuration should be fine.
So I wonder the problem is BIOS doesn't switch main I2C bus to the CPU I2C
bus correctly. I think you can try the attached file, which set the GPIO to
switch i2c bus.

Best Regards
Raphael Deng

-----????-----
???: Marcus Sobchak [mailto:lists at localguru.de] 
????: 2006?8?21? 11:14
???: Raphael Deng
??: lm-sensors at lm-sensors.org
??: Re: [lm-sensors] Tyan S2720 Revsion 2.01 again

Hi,

Am Montag, den 21.08.2006, 10:24 -0700 schrieb Raphael Deng:
> Which CPU he use? FSB400 or FSB533? 

I use FSB400.

> If using FSB400, the CPU temp cannot be
> got from hardware monitor chip. You must use sensor in Intel Xeon CPU
> itself.

How do I do that?

Marcus


> -----????-----
> ???: Rudolf Marek [mailto:r.marek at sh.cvut.cz] 
> ????: 2006?8?19? 3:40
> ???: Marcus Sobchak
> ??: LM Sensors; Raphael Deng
> ??: Re: [lm-sensors] Tyan S2720 Revsion 2.01 again
> 
> Hello all,
> 
> Raphael have you please idea why he has still -1 temp? Tyan sensors.conf
> suggest
> to upgrade the bios, but it did not help in his case.
> 
> Please can you help?
> 
> Regards
> Rudolf
> 
> > adm1021-i2c-0-19
> > Adapter: SMBus I801 adapter at 0540
> > CPU 2 temp:
> >               -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)
> > 
> > adm1021-i2c-0-18
> > Adapter: SMBus I801 adapter at 0540
> > CPU 1 temp:
> >               -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)
> > 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2720sw.c
Type: application/octet-stream
Size: 184 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060821/f1c0e953/attachment.obj 
