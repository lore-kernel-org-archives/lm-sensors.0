From: anything@daanwillems.nl (Daan Willems)
Date: Thu, 29 Jun 2006 07:33:35 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <44A3824F.4060205@daanwillems.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Yuan,

Thanks for your quick response. I am using latest vanilla kernels from 
kernel.org (so 2.6.17.1 now). Which version will support the voltage 
stuff in the w83627 driver?
Btw I also tried some patches for the 410 chip on the nforce2 driver 
that I found in the lmsensors archive, but those didn't bring me 
anything either.

Best, Daan

Yuan Mu wrote:
> Hello Daan,
> 
>> I subscribed to the list because I am trying to configure lm-sensors 
>> for my ASUS K8N-VM motherboard, which features a nvidia nforce410 
>> chipset (the one with geforce6100 integrated). So far I have good 
>> results with the w83627ehf kernel module, yielding the following output:
>>
>> -------
>> d3vlin at arrakis ~ $ sensors
>> w83627ehf-isa-0290
>> Adapter: ISA adapter
>> Chassis Fan:  1795 RPM  (min = 1205 RPM, div = 8)
>> CPU Fan:      3245 RPM  (min = 1704 RPM, div = 8)
>> System Temp:  +28?C  (high =   +60?C, hyst =   +40?C)
>> CPU Temp:     +30.0?C  (high = +60.0?C, hyst = +40.0?C)
>> Chipset Temp: +33.0?C  (high = +60.0?C, hyst = +40.0?C)
>> d3vlin at arrakis ~ $
>> -------
>>
>> As one might notice, there is no information about VCore / 3.3V etc. 
>> displayed. I have tried some modules, i2c_nforce2 in particular, but 
>> no results. I wonder if there is support for this chipset or if anyone 
>> has better results. I have included the relevant part of my 
>> /etc/sensors.conf below.
> I think the reason is voltage support not added to the driver in your 
> kernel version.
> The feature is added to the new kernel now.
> And give us the kernel version would be useful.



