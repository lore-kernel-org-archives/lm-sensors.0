From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 07:49:01 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060824094901.051bfb42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anthony,

> > The Winbond (sensor) chip is supported including access by ISA bus...
> > so you don't need any other bus driver to get that working.
> 
> The 83627HG uses the same drivers as the 83627HF???

Yes. The "HG" variant is lead-free, but otherwise it's the same chip.

> Ok,  I went into BIOS and read the output of the sensors it is reading,
> and compared it with the lm_sensors output.   Below is what BIOS is
> reading, and attached is the output of sensors, as well as a few other
> programs to give input on what is going on the system, including
> sensors-detect, systool, lspci, lsmod.  Please let me know what, if any
> other input would be helpful.  I'm going to try to find out how the BIOS
> is reading the sensors and maybe ill have a better shot doing it that
> way.

Can you please set the MIME type properly for text attachements next
time?

> BIOS INFO:
> 
> CPU1 VCore:			1.19V
> CPU2 VCore:			1.19V
> CPU1 DIMM Volt:		2.62V
> CPU2 DIMM Volt:		2.63V
> 1.2V Hyper-Transport:	1.21V
> 1.5V:				1.50V
> 2.5V:				2.63V
> 3.3V VCC:			3.44V
> 3.3V SB:			3.44V
> 5Vin:				5.10V
> 12Vin:			12.06V
> -12V Vcc:			-12.09V
> Vbatt:			3.07V
> 
> CPU1:				17 C
> CPU2:				0 C
> SYS Temp:			25 C
> 
> FAN1:				NA (not attached)
> FAN2:				~7000
> FAN3:				NA (not attached)
> FAN4:				6750
> FAN5:				NA (not attached)

13 voltage inputs and 5 fan inputs, while the W83627HF/HG has only 9
and 3, respectively. This suggests that there is a second hardware
monitoring on your motherboard, most probably connected to the SMBus.

> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)

This is your SMBus. Support was added to the i2c-nforce2 driver in
2.6.12. I think you said you were running 2.6.9, so no surprise it
doesn't work.

You may load i2c-nforce2 manually, then run the following command:
echo "10de 0052" > /sys/bus/pci/drivers/nForce2_smbus/new_id

This should enable the SMBus. If it works, you'll have to do the same
after each reboot. Then you can run sensors-detect again and hopefully
it will find some other chip. I suggest running the most recent version
of sensors-detect, else it'll miss recent chips.

BTW I notice that this system is completely different from the one you
reported for in the first place. The original one was Intel-based and
this one is nVidia-based. Please make separate threads for separate
issues, else it is very difficult for us to keep track of everything at
once.

What motherboard is this?

-- 
Jean Delvare

