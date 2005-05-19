From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: 2.5.x Conversion from i2c-old.h --> i2c.h (fwd)
Message-Id: <3D06ACE2.9C709D90@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206071745.g57Hj5R02846@shire.frodo.local>
In-Reply-To: <200206071745.g57Hj5R02846@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You have the right idea.
There's a lot of documentation and examples in the lm_sensors and i2c
packages.
Look at the documentation page at www.lm-sensors.nu.
As the 7110 is apparently a chip driver, you should look in
kernel/chips in lm_sensors.
Let us know if you have questions.
mds


frodol@dds.nl wrote:
> 
> Forwarded message:
> > From fdavis@si.rr.com Fri Jun  7 19:40:06 2002
> > Message-ID: <3D00EE91.5010309@si.rr.com>
> > Date: Fri, 07 Jun 2002 13:34:09 -0400
> > From: Frank Davis <fdavis@si.rr.com>
> > Reply-To: fdavis@si.rr.com
> > User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
> > X-Accept-Language: en-us, en
> > MIME-Version: 1.0
> > To: simon@tk.uni-linz.ac.at
> > CC: frodol@dds.nl
> > Subject: 2.5.x Conversion from i2c-old.h --> i2c.h
> > Content-Type: text/plain; charset=us-ascii; format=flowed
> > Content-Transfer-Encoding: 7bit
> > X-Loop-Procmail: PreventLoop
> >
> > Hello,
> >     I'm in the process of converting the drivers located in
> > drivers/media/video/ from the old i2c interface (reference to i2c-old.h
> > which no longer exists in 2.5.x) to the current i2c interface. I believe
> > to have everything in place for the current i2c interface, expect fixing
> > up the (driver)_read() and (driver)_write_block() and (driver)_write()
> > functions. I'm hoping you could provide guidance on how to convert those
> > functions over. I was thinking about removing those completely and using
> >
> > i2c_smbus_read_*() functions instead. Thoughts?
> >
> > I'm currently looking at drivers/media/video/saa7110.c (kernel version
> > 2.5.20). Thanks.
> >
> > Regards,
> > Frank
> >
> >
> 
> --
> Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
> Defenestration n. (formal or joc.):
>   The act of removing Windows from your computer in disgust, usually followed
>   by the installation of Linux or some other Unix-like operating system.
