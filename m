From: tparcina@lama.hr (=?iso-8859-2?Q?Tomislav_Par=E8ina?=)
Date: Wed, 09 Aug 2006 07:34:17 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <79337FA3BA80774F9FE87BF809C9F3564309C5@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg!

Can you send me pre-compiled vt1211.ko driver? Can I put your pre-compiled driver to 
/lib/modules/2.6.11-1.1369_FC4/kernel/drivers/i2c/chips and execute "depmod -a"?

Will that work? Because I have tried to recompile kernel several times and I still haven't managed to install driver. And kernel compilation on VIA EPIA motherboard lasts forever...

Tomislav


> -----Original Message-----
> From: Juerg Haefliger [mailto:juergh at gmail.com] 
> Sent: 8. kolovoz 2006 16:55
> To: Tomislav Par?ina
> Cc: lm-sensors at lm-sensors.org
> Subject: Re: [lm-sensors] Vt1211
> 
> Hi Tomislav,
> 
> Yes, you need to patch the kernel to get the vt1211 module.
> 
> 1) Download the vanilla 2.6.17.8 kernel from www.kernel.org
> 2) Get the most recent vt1211 patch from here:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016329.html
> 3) Patch, recompile and install the new kernel and modules 
> (make sure to enable the vt1211 under 'device 
> drivers/hardware monitoring
> support')
> 4) Reboot using the new kernel and modprobe the vt1211 module
> 
> ...juerg

