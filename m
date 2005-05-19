From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: i2c-sis630 driver (fixed)
Message-Id: <200307302234.43914.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

the bug is fixed now... I do not know how to close the tikets. 

On Wednesday 30 July 2003 20:47, Alexander Malysh wrote:
> Hi Jean,
>
> this problem occurs only if ACPI enabled. this is because i2c register are
> in ACPI io space. I have a test version here with acpi running, but it is
> tooo ugly now. I will do cleanup of module and commit it within next 2
> weeks... Sorry but I am to busy now with my job.
>
> Thanks...
>
> Am Mittwoch, 30. Juli 2003 17:09 schrieb Jean Delvare:
> > Hi folks,
> >
> > We have been having two tickets about i2c-sis630 driver not working
> > anymore since 2.8.0.
> >
> > http://secure.netroedge.com/~lm78/readticket.cgi?ticket50
> > http://secure.netroedge.com/~lm78/readticket.cgi?ticket51
> >
> > Could you please take a look? The reports are complete but I don't know
> > where to look at (I don't know much about bus drivers).

-- 
Best regards,
Dipl.-Ing.
Alexander Malysh
