From: John Tindle <jwtindle@psynapse.org>
Date: Fri, 18 May 2007 23:25:00 +0000
Subject: Re: [lm-sensors] k8temp
Message-Id: <1179530700.8209.13.camel@psynapse-desktop>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703212247.05783.tomcw@adelphia.net>
In-Reply-To: <200703212247.05783.tomcw@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Rudolph et al

Yeah,  I've finally found a thread 

http://www.silentpcreview.com/forums/viewtopic.php?t@290

which shows lots of people with the same problem with Brisbane cores.  

The only solution would be to set custom offsets for each CPU.

On the diode offset, Rudolph you are right this offset applies to an off
die sensor

Regards

John




On Fri, 2007-05-18 at 11:10 +0200, Rudolf Marek wrote:
> Hello all,
> 
> For Philip :
> >No, that command *writes* 7A to PCI space register offset E4.
> 
> Yeah of course. I was half sleeping when I wrote the mail.
> > 
> > Just to clarify, the 32 bit register at 0xE4 of the AMD64x2 is the
> > thermotrip status register:- 
> > 	
> > Bits   Function                                         R/W    Reset
> > 31     Software Thermtrip  	                         W      0
> > 30–29  reserved                                          R      0
> > 28-24  Tj Offset                                         R      0
> > 23-14  Current Temperature                               R
> > 13–8   Diode Offset                                      R
> > 7	reserved                                         R      0
> > 6      Thermal Sensor Select                           R/W      0
> > 5      Thermtrip Enabled                                 R
> > 4      Thermtrip Sense 1                                 R
> > 3      Thermtrip Sense 0                                 R
> > 2      Thermal Sensor Core Select                      R/W      0
> > 1      Thermtrip    					 R
> > 0	reserved	   				 R      0
> > 
> > So reading 0xE6 gets the current temperature from one of the four
> > sensors  selected by setting or clearing bits 2 and 6 in 0xe4
> > (the bottom two bits of the temperature, which are the high two bits in
> > 0xE5 represent fractions of a degree, but can be ignored by K8temp
> > without a problem)  
> 
> Yes this was not added yet.
> 
> > As K8temp correctly implements, the temperature is given by: (Snipped
> > from AMD documentation), 
> > 
> >        Revision F encodings bits 23-16 (ignore bits 15-14)
> >        00h = -49C
> >        01h = -48C
> >        ...
> >        ffh = 206C
> > 
> > 
> >        Revision G encodings bits 23-14
> >        000h = -49.00C
> >        001h = -48.75C
> >        002h = -48.50C
> >        003h = -48.25C
> >        004h = -48.00C
> >        ...
> >        0C4h = 0.00C
> >        ...
> >        3ffh = 206.75C
> > 
> > 
> > 
> > So the examples I gave show K8temp reporting temperatures at or below
> > 0C. Examining the register at 0xE6 confirms that K8temp is working
> > correctly.
> > 
> > Rudolph, you mention having seen this problem before.  It would
> > certainly be a hardware bug and my reason for mentioning it is so that
> > k8temp does not get a bad name with the community.
> > Have you heard whether AMD are proposing to do something about it?
> 
> Well I'm in touch with author of "coretemp" utility for windows. It seems all
> brisbane processors (same cpuid as yours) are affected. Some have offset 15-20
> (compared to diode measured temp with ext sensor) some have even more, like yours.
> 
> As for the diode offset. Your CPU has set this to 0x20 so it is
> 10000 and complement of 011111 -52+31 offset is -21C if I count correctly
> (probably not ;)  This is quite interesting because my CPU has offset 0x3 (but
> have revE must check if the bits are same)
> 
> Question is how to apply the offset? They say TMax = diode + offset;
> I still think that the offset field is for real diode only, however here it
> indicates that something went wrong...
> 
> I will think about it later, gotta go now.
> 
> Rudolf
> .
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
