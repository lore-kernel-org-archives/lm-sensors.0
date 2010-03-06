From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sat, 06 Mar 2010 00:02:03 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <68676e01003051602o64a68c91q5e26c8ee29206139@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 5, 2010 at 11:20 PM, Phillip Pi <ant@zimage.com> wrote:
> This morning, I rebooted my old Debian box to start using its new Kernel
> 2.6.32 from 2.6.30, but I noticed my lm_sensors didn't show everything
> (voltages, fan RPMs, etc.) anymore compared to 2.6.30 and earlier. I am
> using a MSI K8N NEO4-F (MS-7125) motherboard.
[...]
> I looked at the FAQ and saw
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
> which look like my issue and matches dmesg: http://pastie.org/856424 ...
>
> I am scared to use the lax method since it is not recommended. Is there
> another way to show the datas safely? Or do I have to use this trick or
> live without them?

Asus provides an ACPI interface for accessing the sensors in a safe
way; I don't know what it's used on MSI boards, but I can take a look:
please send me a dump of the DSDT table
(/sys/firmware/acpi/tables/DSDT).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
