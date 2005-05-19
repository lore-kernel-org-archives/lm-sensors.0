From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Fwd: Problems with stability of i2c-ali1535.c
Message-Id: <41ABBF79.8090908@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks. Many others have also had problems with the 1535 driver.

Your changes (adding a delay loop composed of 30 outb() calls to many many places) is interesting...
is there any way you could get clearance to give us the ALI document?
Or can you explain what you are trying to accomplish, or what problems you've fixed
and what still remain?

For the w83781d changes to ignore bad readings, we have similar changes in other drivers,
perhaps we should port those to the winbond driver.

mds




> Subject:
> Problems with stability of i2c-ali1535.c
> From:
> "Ubel Walter" <ubel@heidenhain.de>
> Date:
> Thu, 25 Nov 2004 15:01:48 +0100
> To:
> <frodol@dds.nl>, <phil@netroedge.com>, <mdsxyz123@yahoo.com>
> 
> 
> Hallo,
> 
> I had a lot of problems with the stability of the i2c-ali1535.c
> therfore I've made some changes which I got from a confidential
> document from ali.
> 
> Maybe it helps you to improve your work.
> 
> This is still not stable but much better, I've also made some changes
> to the w83781d.c so that it takes care if the i2c-ali1535.c
> does report an error. So the aplication get only valid values.
> 
> <<i2c-ali1535.c>> <<w83781d.c>>
> 
> 
>       Mit freundlichen Gruessen / Best Regards 
>       Dr. JOHANNES HEIDENHAIN GmbH
> 
>       Walter Ubel
> 
> 
>       __________________________
>       ___mailto:_ubel_____@heidenhain.de___ <mailto:ubel@heidenhain.de>__
>       tel     +49 / 8669 / 31-1791
>       ________________________
> 
>       DR. JOHANNES HEIDENHAIN GmbH
>       Dr.-Johannes-Heidenhain-Str. 5
>       D-83301 Traunreut
> 
>       _http:\\www.heidenhain.de_**
> 
