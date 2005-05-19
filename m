From: tomov@molbio.mgh.harvard.edu (Vesko T. Tomov)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Help getting hardware monitoring on Intel 855PM 82801DBM
Message-Id: <1114132352.5896.5.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1114109876.6001.26.camel@localhost.localdomain>
In-Reply-To: <1114109876.6001.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks,

No there is no information about temperature in the BIOS.  However,
under Windows, I installed a program called PC Wizard, which gives me
extensive information about my hardware.  When I click the "Sensors,"
tab it says:

_Thermal Measurements_
Hard Disk Temperature ST9100823A         :	49 C

_Sensor List_
Monitoring Chip :	Winbond 
SMBus Address :	0x1400 
Support :	Intel 852/855GM 	 
Sensor :	Winbond  
Mode :	 
Configuration :	According the Motherboard 


This had encouraged me at first, even though I cannot get CPU or
motherboard temperature readings using a number of Windows monitoring
programs.  Is it possible to get at least the hard drive temperature
reported under linux?

I will try the latest lm_sensors package and report back.

Thanks!

Vesko

PS  Is it correct that I am replying to the mailing list, rather than to
your personal email address? 

On Fri, 2005-04-22 at 00:35 +0200, Rudolf Marek wrote:

> > My (ignorant) question is whether the reading at address 0x51 might mean
> > that some hardware monitoring functionality could be possible.  My guess
> > is NO, but I just wanted to be sure before I gave up all hope!  
> 
> Sorry it is just EEPROM on your RAM module. The 0x44 is from SMBUS host I think.
> So it seems there is nothing interresting. You may try our latest sensors-detect
> from CVS lm_sensors maybe you have some LPC I/O.
> 
> My question is: Can you see some temp status in bios?
> 
> 
> Thanks
> 
> Regards
> 
> Rudolf
> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050421/6e5b8198/attachment.html
