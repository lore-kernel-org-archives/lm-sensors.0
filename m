From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Oct 2010 07:41:31 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101025094131.04b32ef3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 25 Oct 2010 00:10:32 +0200, Karsten de Freese wrote:
> .. in addition to the below, I should have mentioned that
> 'sudo dmidecode' gave me
> 
> Handle 0x001B, DMI type 38, 18 bytes
> IPMI Device Information
>          Interface Type: KCS (Keyboard Control Style)
>          Specification Version: 2.0
>          I2C Slave Address: 0x10
>          NV Storage Device: Not Present
>          Base Address: 0x0000000000000000 (Memory-mapped)
>          Register Spacing: Successive Byte Boundaries
> 
> so there is really something....
> Based on this, I also tried 'sudo modprobe ipmi_si type=kcs ports=0x10 
> regspacings=1', but to no avail..
> 
> thanks for your patience reading all this frustrated stuff...

The base address of 0 is suspicious. I used to have this on my Asus
board but a BIOS update fixed it. You may want to look for a BIOS
update for your system or a BIOS option to enable the IPMI controller.

Note that I did not manage to get IPMI to work on my system either so
far, I really don't know much about it so I am probably not the best
advice provider in this area.

If you have technical documentation for your system, it would be
interesting to see if they mention anything about IPMI or about the
SMBus being multiplexed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
