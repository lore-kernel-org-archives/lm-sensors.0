From: Keith Romberg <romberg@ucar.edu>
Date: Wed, 30 May 2007 18:51:47 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <465DC7C3.7000907@ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No one has any experience with these board or the sensors on it?  I was 
kind of hoping for something....

Keith

Keith Romberg wrote:
> Hello,
> 
> I have a Quad MP Xeon Intel SRSH4 system where the motherboard has 
> BMC/IPMI onboard sensors.  I would really like to be able to monitor the 
> sensors with lm_sensors.  The system is running FC6 with all the latest 
> versions including lm_sensors.  The kernel is 2.6.20 patched with the
> 
> 'ipmisensors experimental'
> 
> kernel patch from
> 
> http://bmcsensors-26.sourceforge.net/
> 
> Running sensors-detect find these sensors, but does not know about the 
> chips.
> 
> - IPMI BMC KCS ( confidence 4, driver bmcsensors )
> - ITE ( unknown chip with ID 0xee19 )
> - PC8741x ( unknown chip with ID 0xee19 )
> - SMSC ( unknown chip with ID 0xee19 )
> - VIA/Winbond/Fintek ( unknown chip with ID 0xee19 )
> 
> After loading all the modules it says to, running sensors gives the 
> classic message that no sensors where found.  Does anyone know if the 
> sensors and/or chips are supported or ever will be?
> 
> I have also read that Xeon processors have an onboard temperature sensor 
> and that the xeontemp module could be used to read it.  Looking at my 
> kernel modules, I do not see it in the i2c directories or do I see an 
> option for it in the kernel config file.  How do I get that module?
> 
> Thanks,
> Keith
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
