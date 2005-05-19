From: David_Papasan@Dell.com (David_Papasan@Dell.com)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: ADM1021 on Xeon ...
Message-Id: <865754A1DF262143B5B399853909426901005D8F@AUSX2KMPS308.aus.amer.dell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DCAA055.3070908@netroedge.com>
In-Reply-To: <3DCAA055.3070908@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

*found in my outbox.. Not sure if this is a duplicate..*
The actual chip is a Max 1617, I used the ADM1021 module with no errors
other than having to reset the default temps . The Defaults are/were too low
and it would cause false thermal failures due to it resetting the chip
setting.

As a note Dell doesn't read the on chip diode we read all the temps thru the
SMBus. -----Original Message-----
From: Manish Lachwani [mailto:manish@Zambeel.com] 
Sent: Wednesday, November 06, 2002 3:17 PM
To: Papasan, David; 'mds@paradyne.com'; 'sensors@Stimpy.netroedge.com'
Cc: Manish Lachwani
Subject: ADM1021 on Xeon ...

Hello,

I am making use of 2.4 GHZ Xeon CPUs. Do they have a adm1021 chip on it? I
am using a adm1021.c driver and it cannot detect the adm1021 chip on the
processor. How do I use force_adm1021 when using the adm1021.c compiled in
the kernel? 

Any help is appreciated ...

Thanks
manish
