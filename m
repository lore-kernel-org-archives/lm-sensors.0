From: pierre.lamon@epfl.ch (Pierre Lamon)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Follow up for Ticket 1538
Message-Id: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

thanks a lot for your quick answer! Before following your advice I want to
make sure I understood.

>Reply from support:
>we have just submitted a new parport driver to 2.6 that consolidates
>all the previous parallel port drivers.
>You may wish to try it.
>If you want to use kernel 2.4 then you want the driver that matches
>what you built; see the info in our doc/ directory in our i2c release.
>For more info on the new driver if you can?t find it email us,
>ref. your ticket #.
>MDS 1/24/04

1) Could I take the latest cvs version of your i2c directory and copy the
files into the linux-2.6.1 directory (I'm using 2.6.1)? What is the best way
to update the kernel sources?

2) Should I use i2c-pcf-epp for the following circuit? Is this the right
driver to use? Which i2c modules should be insmoded at the same time?
http://www.voxel.at/prj/i2c/images/i2c/i2c_adap.gif

Thanks a lot for your help
~Pierre

