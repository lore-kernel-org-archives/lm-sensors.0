From: john@scl.co.uk (John Sutton)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Driver for ALi M5879
Message-Id: <02051116012900.29838@diva.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there

I sent you this message (below) a week ago but have heard nothing from
Acer Labs, not even an ACK, never mind a datasheet!

Anyway, I have to press on so I've put together a rude hack of the i2cdump
program which is able to display the CPU temperature and fan speed
presented by the M5879.  I'm attaching it to this email, maybe you could make it
available on your web site for others to use.

Thanks for lm_sensors!   Great work.

Regards
John Sutton

*************************************

FYI, copy of datasheet request submitted to:

http://www.ali.com.tw/eng/support/datasheet/datasheet_main.htm

------------------------------------------------------------------
I have Prox-1550 SBC with one of your M5879 chips and I need to run it
under linux.  Currently there is no linux driver available for this chip. 
Please see http://secure.netroedge.com/~lm78/newdrivers.html.  If you will
supply datasheet, I will write linux driver and contribute it to the linux
lm_sensors project.  This cannot but increase the sales of your product!
------------------------------------------------------------------

***************************************************
John Sutton
SCL Internet
URL http://www.scl.co.uk/
Tel. +44 (0) 1239 711 888
***************************************************
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-m5879.c
Type: text/english
Size: 7079 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020520/43271367/i2cdump-m5879.bin
