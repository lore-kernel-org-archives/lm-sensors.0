From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: [Fwd: support for SIS 648 - hint for starting]
Message-Id: <200301022026.25500.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jakob, List,

I believe , that you chip supported by us. If you willing , then:
1. try to load i2c-sis630 module with force=1 (pls look in doc directory for 
details!)
2. if i2c-sis630 does not work for you , try i2c-sis645 module (pls contact 
the autor of this module , before you try this. Or you can just hack the 
module for your PCI_ID).

If you have more quastions , pls contact me...


Am Samstag, 28. Dezember 2002 18:03 schrieben Sie:
> >Hi Jakob,
> >
> >can you please send lspci -vvv -xxx ?
> >We will see , if your chip supported ...
>
> I enclose /attach the output of lspci. Sorry I did not answer earlier
> but during the holidays I had no access to the machine.
>
> Yours,
> Jakob Curdes
>
> >Am Donnerstag, 19. Dezember 2002 12:40 schrieb Jakob Curdes:
> >>Hi,
> >>
> >>I found that the SiS 648 is not supported yet.
> >>Although I have some programming skills, I have no experience with
> >>mainboard sensors. What should I read for a start to determine if I
> >
> >can
> >
> >>develop a driver for this chip ??
> >>
> >>Yours,
> >>Jakob Curdes
> >>iS information Systems oHG
> >>
> >>
> >>
> >> ------------------------------------------------------------------------
> >>
> >> Subject:
> >> Re: support for SIS 648 - hint for starting
> >> From:
> >> Alexander Malysh <amalysh@web.de>
> >> Date:
> >> Thu, 19 Dec 2002 14:56:16 +0100
> >> To:
> >> Jakob Curdes <jc@info-systems.de>, sensors@Stimpy.netroedge.com
> >>
> >>
> >>Hi Jakob,
> >>
> >>can you please send lspci -vvv -xxx ?
> >>We will see , if your chip supported ...
> >>
> >>Am Donnerstag, 19. Dezember 2002 12:40 schrieb Jakob Curdes:
> >>>Hi,
> >>>
> >>>I found that the SiS 648 is not supported yet.
> >>>Although I have some programming skills, I have no experience with
> >>>mainboard sensors. What should I read for a start to determine if I can
> >>>develop a driver for this chip ??
> >>>
> >>>Yours,
> >>>Jakob Curdes
> >>>iS information Systems oHG
