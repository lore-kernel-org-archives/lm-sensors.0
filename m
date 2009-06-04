From: "Zafar, Khurram" <Khurram.Zafar@kla-tencor.com>
Date: Thu, 04 Jun 2009 21:24:59 +0000
Subject: Re: [lm-sensors] Where to download drivers?
Message-Id: <47E375F28A0EFE4F8E3BE9D8818AA50D0206639F@CA1EXCLV05.adcorp.kla-tencor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
In-Reply-To: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Madhu,

After upgrading to the latest 2.6.29 kernel and re-installing
lm_sensors, everything is working fine. Thanks for your help!

Regards,
KZ

-----Original Message-----
From: Madhu [mailto:madhu.chinakonda@gmail.com] 
Sent: Monday, June 01, 2009 11:32 PM
To: Zafar, Khurram
Cc: madhu; lm-sensors@lm-sensors.org
Subject: RE: [lm-sensors] Where to download drivers?

Hi Zafar,

   Looks like 2.6.16 does not have the drivers for these modules. I see
the "coretemp" is added from 2.6.22 and "i5k_amb" is added from 2.6.24
but not sure about "ipmisensors", http://bmcsensors-26.sourceforge.net

   So please try with the latest kernel and the sensors-detect. 

Regards,
Madhu.

On Mon, 2009-06-01 at 08:56 -0700, Zafar, Khurram wrote:
> Madhu,
> 
> Here's the information you requested:
> 
> 1. uname -a
> 
> Linux myserver 2.6.16.60-0.21-smp #1 SMP Tue May 6 12:41:02 UTC 2008
> x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> 2. Run "sensors":
> 
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> 
> 
> 3. Run "sensors-detect":
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `coretemp':
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
> 
> Driver `ipmisensors':
>   * ISA bus, address 0xca0 (Busdriver `i2c-isa')
>     Chip `IPMI BMC KCS' (confidence: 4)
> 
> Driver `i5k_amb':
>   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
> 
> Warning: the required module coretemp is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability.
> 
> Warning: the required module ipmisensors is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability.
> 
> Warning: the required module i5k_amb is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability.
> 
> No modules to load, skipping modules configuration.
> 
> Unloading i2c-dev... OK
> 
> 
> 
> -----Original Message-----
> From: Zafar, Khurram 
> Sent: Monday, May 25, 2009 8:20 AM
> To: madhu
> Cc: lm-sensors@lm-sensors.org
> Subject: RE: [lm-sensors] Where to download drivers?
> 
> Madhu,
> 
> Thank you for your help. I am on holiday now for 1 week, but I want to
> resolve this problem so I'll reply as best I can.
> 
> We are using SuSE Linux Enterprise Server, SP2.
> 
> I will use VPN to log onto our network later in the day and get you
the
> specific information you requested.
> 
> When I run "sensors" I get an error message indicating that no drivers
> were found. I'll get you the exact output later as well.
> 
> Regards,
> KZ
> 
> 
> 
> -----Original Message-----
> From: madhu [mailto:madhu.chinakonda@gmail.com]
> Sent: Sat 5/23/2009 1:50 AM
> To: Zafar, Khurram
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Where to download drivers?
>  
> Can I know which distribution you are using, are you using any custom
> kernel (compiled by you),
> 
> Generally, most distribution kernels will come with these drivers
> (coretemp, etc) enabled as modules.
> 
> So, lm-sensor tries to load these modules, if there is no such
modules,
> I think it assumes that you have compiled statically,
> 
> Also it would be useful if you send the output of the following,
> 
> 1. uname -a
> 2. sensors
> 
> Regards,
> Madhu,
> 
> On Fri, 2009-05-22 at 16:26 -0700, Zafar, Khurram wrote:
> > Hi,
> > 
> >  
> > 
> > I have just downloaded and compiled the latest lm_sensors package
and
> > run "sensors-detect," whose output is shown down below. My question
is
> > very simple:
> > 
> >  
> > 
> > Where can I obtain the following  3 drivers:
> > 
> >  
> > 
> > 1.      coretemp
> > 
> > 2.      ipmisensors
> > 
> > 3.      i5k_amb
> > 
> >  
> > 
> > Thanks,
> > 
> > KZ
> > 
> >  
> > 
> > ---------------- output from sensors-detect ------------------
> > 
> >  
> > 
> > Now follows a summary of the probes I have just done.
> > 
> > Just press ENTER to continue:
> > 
> >  
> > 
> > Driver `coretemp':
> > 
> >   * Chip `Intel Core family thermal sensor' (confidence: 9)
> > 
> >  
> > 
> > Driver `ipmisensors':
> > 
> >   * ISA bus, address 0xca0 (Busdriver `i2c-isa')
> > 
> >     Chip `IPMI BMC KCS' (confidence: 4)
> > 
> >  
> > 
> > Driver `i5k_amb':
> > 
> >   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
> > 
> >  
> > 
> > Warning: the required module coretemp is not currently installed
> > 
> > on your system. If it is built into the kernel then it's OK.
> > 
> > Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> > 
> > driver availability.
> > 
> >  
> > 
> > Warning: the required module ipmisensors is not currently installed
> > 
> > on your system. If it is built into the kernel then it's OK.
> > 
> > Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> > 
> > driver availability.
> > 
> >  
> > 
> > Warning: the required module i5k_amb is not currently installed
> > 
> > on your system. If it is built into the kernel then it's OK.
> > 
> > Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> > 
> > driver availability.
> > 
> >  
> > 
> > No modules to load, skipping modules configuration.
> > 
> >  
> > 
> > Unloading i2c-dev... OK
> > 
> >  
> > 
> >  
> > 
> > KLA-TENCOR CONFIDENTIAL
> > 
> > This email and any files transmitted with it are confidential and
> > intended solely for the use of the individual or entity to whom they
> > are addressed. If you have received this email in error, do not use
or
> > review the message or any information transmitted with it, and
notify
> > the sender.
> > 
> >  
> > 
> > 
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
