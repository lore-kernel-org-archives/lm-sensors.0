From: manish@Zambeel.com (Manish Lachwani)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ADM1021 on Xeon ...
Message-Id: <233C89823A37714D95B1A891DE3BCE5202AB1B2B@xch-a.win.zambeel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DCAA055.3070908@netroedge.com>
In-Reply-To: <3DCAA055.3070908@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
I have fixed this problem and everything is working fine. Thanks for the
response ...

Manish

-----Original Message-----
From: David_Papasan@Dell.com
To: manish@Zambeel.com; mds@paradyne.com; sensors@Stimpy.netroedge.com
Sent: 12/12/02 6:22 AM
Subject: RE: ADM1021 on Xeon ...

*found in my outbox.. Not sure if this is a duplicate..*
The actual chip is a Max 1617, I used the ADM1021 module with no errors
other than having to reset the default temps . The Defaults are/were too
low
and it would cause false thermal failures due to it resetting the chip
setting.

As a note Dell doesn't read the on chip diode we read all the temps thru
the
SMBus. -----Original Message-----
From: Manish Lachwani [mailto:manish@Zambeel.com] 
Sent: Wednesday, November 06, 2002 3:17 PM
To: Papasan, David; 'mds@paradyne.com'; 'sensors@Stimpy.netroedge.com'
Cc: Manish Lachwani
Subject: ADM1021 on Xeon ...

Hello,

I am making use of 2.4 GHZ Xeon CPUs. Do they have a adm1021 chip on it?
I
am using a adm1021.c driver and it cannot detect the adm1021 chip on the
processor. How do I use force_adm1021 when using the adm1021.c compiled
in
the kernel? 

Any help is appreciated ...

Thanks
manish
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021217/d0adc380/attachment.html
