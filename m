From: madhu <madhu.chinakonda@gmail.com>
Date: Sat, 23 May 2009 08:54:38 +0000
Subject: Re: [lm-sensors] Where to download drivers?
Message-Id: <1243068607.2952.9.camel@dhcppc0>
List-Id: <lm-sensors.vger.kernel.org>
References: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
In-Reply-To: <47E375F28A0EFE4F8E3BE9D8818AA50D01FF5F07@CA1EXCLV05.adcorp.kla-tencor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Can I know which distribution you are using, are you using any custom
kernel (compiled by you),

Generally, most distribution kernels will come with these drivers
(coretemp, etc) enabled as modules.

So, lm-sensor tries to load these modules, if there is no such modules,
I think it assumes that you have compiled statically,

Also it would be useful if you send the output of the following,

1. uname -a
2. sensors

Regards,
Madhu,

On Fri, 2009-05-22 at 16:26 -0700, Zafar, Khurram wrote:
> Hi,
> 
>  
> 
> I have just downloaded and compiled the latest lm_sensors package and
> run “sensors-detect,” whose output is shown down below. My question is
> very simple:
> 
>  
> 
> Where can I obtain the following  3 drivers:
> 
>  
> 
> 1.      coretemp
> 
> 2.      ipmisensors
> 
> 3.      i5k_amb
> 
>  
> 
> Thanks,
> 
> KZ
> 
>  
> 
> ---------------- output from sensors-detect ------------------
> 
>  
> 
> Now follows a summary of the probes I have just done.
> 
> Just press ENTER to continue:
> 
>  
> 
> Driver `coretemp':
> 
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
> 
>  
> 
> Driver `ipmisensors':
> 
>   * ISA bus, address 0xca0 (Busdriver `i2c-isa')
> 
>     Chip `IPMI BMC KCS' (confidence: 4)
> 
>  
> 
> Driver `i5k_amb':
> 
>   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
> 
>  
> 
> Warning: the required module coretemp is not currently installed
> 
> on your system. If it is built into the kernel then it's OK.
> 
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> 
> driver availability.
> 
>  
> 
> Warning: the required module ipmisensors is not currently installed
> 
> on your system. If it is built into the kernel then it's OK.
> 
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> 
> driver availability.
> 
>  
> 
> Warning: the required module i5k_amb is not currently installed
> 
> on your system. If it is built into the kernel then it's OK.
> 
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> 
> driver availability.
> 
>  
> 
> No modules to load, skipping modules configuration.
> 
>  
> 
> Unloading i2c-dev... OK
> 
>  
> 
>  
> 
> KLA-TENCOR CONFIDENTIAL
> 
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error, do not use or
> review the message or any information transmitted with it, and notify
> the sender.
> 
>  
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
