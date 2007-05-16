From: John Tindle <jwtindle@psynapse.org>
Date: Wed, 16 May 2007 23:15:02 +0000
Subject: Re: [lm-sensors] k8temp
Message-Id: <1179357302.6202.34.camel@psynapse-desktop>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703212247.05783.tomcw@adelphia.net>
In-Reply-To: <200703212247.05783.tomcw@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Philip and Rudolf

Thanks for your swift replies, much appreciated.

Just to clarify, the 32 bit register at 0xE4 of the AMD64x2 is the
thermotrip status register:- 
	
Bits   Function                                         R/W    Reset
31     Software Thermtrip  	                         W      0
30–29  reserved                                          R      0
28-24  Tj Offset                                         R      0
23-14  Current Temperature                               R
13–8   Diode Offset                                      R
7	reserved                                         R      0
6      Thermal Sensor Select                           R/W      0
5      Thermtrip Enabled                                 R
4      Thermtrip Sense 1                                 R
3      Thermtrip Sense 0                                 R
2      Thermal Sensor Core Select                      R/W      0
1      Thermtrip    					 R
0	reserved	   				 R      0

So reading 0xE6 gets the current temperature from one of the four
sensors  selected by setting or clearing bits 2 and 6 in 0xe4
(the bottom two bits of the temperature, which are the high two bits in
0xE5 represent fractions of a degree, but can be ignored by K8temp
without a problem)  

As K8temp correctly implements, the temperature is given by: (Snipped
from AMD documentation), 

       Revision F encodings bits 23-16 (ignore bits 15-14)
       00h = -49C
       01h = -48C
       ...
       ffh = 206C


       Revision G encodings bits 23-14
       000h = -49.00C
       001h = -48.75C
       002h = -48.50C
       003h = -48.25C
       004h = -48.00C
       ...
       0C4h = 0.00C
       ...
       3ffh = 206.75C



So the examples I gave show K8temp reporting temperatures at or below
0C. Examining the register at 0xE6 confirms that K8temp is working
correctly.

Rudolph, you mention having seen this problem before.  It would
certainly be a hardware bug and my reason for mentioning it is so that
k8temp does not get a bad name with the community.
Have you heard whether AMD are proposing to do something about it?

In summary, there will be nothing that you can do about such a problem,
except perhaps record the issue in the snag list.



Again, thanks for your time and attention.  If I can do more to help,
just ask

Regards

John






On Wed, 2007-05-16 at 14:16 -0700, Philip Pokorny wrote:
> >>raw data drawn from a PCI inspection .....
> >>
> >>$ sudo setpci -s 00:18.3 e4.Bz
> >>    
> >>
> >
> >So you are not setting this as the reg value but this  is just a result (7a)
> >  
> >
> No, that command *writes* 7A to PCI space register offset E4.
> 
> >>$ sudo lspci -s 00:18.3 -xxx
> >>00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> >>e0: 00 00 00 00 7a 20 28 00 19 17 00 00 00 00 00 00
> >>    
> >>
> 
> Which values are of interest here?
> 
> Do you know that you can read PCI space using setpci like so:
> 
> [root@beluga ~]# setpci -v -s 00:18.3 e4.b e4.w e6.w
> 00:18.3:e4 = 20
> 00:18.3:e4 = 0f20
> 00:18.3:e6 = 164c
> .
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
