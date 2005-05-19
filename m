From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Driver for ALi M5879
Message-Id: <3CEBFC20.5B4074FA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <02051116012900.29838@diva.localdomain>
In-Reply-To: <02051116012900.29838@diva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

temp at 27 and fan at 28 is the same as lots of other chips (lm78, w83781d, for example)

It would be better if you tried some of the other drivers
(using force_xxx parameter) and found the one with the best results,
then let us know and we could put that on our new drivers page.

Also if you email us the output of (regular) i2cdump that may be sufficient info for
us to recognize it in sensors-detect.

This would be a better approach than posting a hacked i2cdump.

mds

John Sutton wrote:
> 
> Hi there
> 
> I sent you this message (below) a week ago but have heard nothing from
> Acer Labs, not even an ACK, never mind a datasheet!
> 
> Anyway, I have to press on so I've put together a rude hack of the i2cdump
> program which is able to display the CPU temperature and fan speed
> presented by the M5879.  I'm attaching it to this email, maybe you could make it
> available on your web site for others to use.
> 
> Thanks for lm_sensors!   Great work.
> 
> Regards
> John Sutton
> 
> *************************************
> 
> FYI, copy of datasheet request submitted to:
> 
> http://www.ali.com.tw/eng/support/datasheet/datasheet_main.htm
> 
> ------------------------------------------------------------------
> I have Prox-1550 SBC with one of your M5879 chips and I need to run it
> under linux.  Currently there is no linux driver available for this chip.
> Please see http://secure.netroedge.com/~lm78/newdrivers.html.  If you will
> supply datasheet, I will write linux driver and contribute it to the linux
> lm_sensors project.  This cannot but increase the sales of your product!
> ------------------------------------------------------------------
> 
> ***************************************************
> John Sutton
> SCL Internet
> URL http://www.scl.co.uk/
> Tel. +44 (0) 1239 711 888
> ***************************************************
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                       Name: i2cdump-m5879.c
>    i2cdump-m5879.c    Type: text/english
>                   Encoding: base64
