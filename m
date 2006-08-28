From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Mon, 28 Aug 2006 16:54:21 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A172A8@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Thursday, August 24, 2006 3:49 AM
To: Calabro, Anthony
Cc: Mark M. Hoffman; LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

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
> sensors-detect, systool, lspci, lsmod.  Please let me know what, if 
> any other input would be helpful.  I'm going to try to find out how 
> the BIOS is reading the sensors and maybe ill have a better shot doing 
> it that way.

Can you please set the MIME type properly for text attachements next time?

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

13 voltage inputs and 5 fan inputs, while the W83627HF/HG has only 9 and 3, respectively. This suggests that there is a second hardware monitoring on your motherboard, most probably connected to the SMBus.

> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)

This is your SMBus. Support was added to the i2c-nforce2 driver in 2.6.12. I think you said you were running 2.6.9, so no surprise it doesn't work.

You may load i2c-nforce2 manually, then run the following command:
echo "10de 0052" > /sys/bus/pci/drivers/nForce2_smbus/new_id

This should enable the SMBus. If it works, you'll have to do the same after each reboot. Then you can run sensors-detect again and hopefully it will find some other chip. I suggest running the most recent version of sensors-detect, else it'll miss recent chips.

** I think we're getting somewhere.  I ran sensors-detect and got the nForce2 driver loaded, and then wrote the line into the driver.  Then ran sensors-detect again and it found a lot more sensors information.  In the end I loaded eeprom and adm1026,  on the adm1026 is all the correct values I am looking for.  Well, mostly, but in different places.  Now all I have to do is figure out which values are what and how they are ordered.  

Below is the new sensors output:

adm1026-i2c-2-2c
Adapter: SMBus nForce2 adapter at 4c40
in0:       +1.30 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
in1:       +1.30 V  (min =  +1.49 V, max =  +1.82 V)   ALARM
in2:       +1.50 V  (min =  +1.35 V, max =  +1.65 V)   
in3:       +2.64 V  (min =  +2.16 V, max =  +2.86 V)   
in4:       +2.62 V  (min =  +2.34 V, max =  +2.86 V)   
in5:       +0.00 V  (min =  +1.22 V, max =  +2.02 V)   ALARM
in6:       +1.21 V  (min =  +1.08 V, max =  +1.32 V)   
in7:       +1.19 V  (min =  +1.02 V, max =  +1.68 V)   
in8:       +0.00 V  (min =  +0.00 V, max =  +2.49 V)   
in9:       +0.16 V  (min =  +0.00 V, max =  +0.70 V)   
in10:      +3.06 V  (min =  +2.70 V, max =  +3.30 V)   
in11:      +3.40 V  (min =  +2.97 V, max =  +3.64 V)   
in12:      +3.40 V  (min =  +2.97 V, max =  +3.64 V)   
in13:      +5.10 V  (min =  +4.50 V, max =  +5.49 V)   
in14:      +1.19 V  (min =  +1.02 V, max =  +1.68 V)   
in15:     +12.06 V  (min = +10.81 V, max = +13.19 V)   
in16:     -12.10 V  (min = -13.18 V, max = -10.80 V)   
ERROR: Can't get FAN0 data!
fan1:        0 RPM  (min =    0 RPM, div = 8)   
fan2:     6750 RPM  (min =    0 RPM, div = 8)   
fan3:        0 RPM  (min =    0 RPM, div = 8)   
fan4:     7031 RPM  (min =    0 RPM, div = 8)   
fan5:        0 RPM  (min =    0 RPM, div = 8)   
fan6:        0 RPM  (min =    0 RPM, div = 8)   
fan7:        0 RPM  (min =    0 RPM, div = 8)   
temp1:       +24??C  (low  =    +0??C, high =   +72??C)  
temp2:        -1??C  (low  =    +0??C, high =   +72??C)     ALARM
temp3:       +16??C  (low  =    +0??C, high =   +72??C)  
vid:      +1.175 V  (VRM Version 2.4)

A few of the values are obvious, but others are not.  Is there any way to find out which inputs are designated as which values?


BTW I notice that this system is completely different from the one you reported for in the first place. The original one was Intel-based and this one is nVidia-based. Please make separate threads for separate issues, else it is very difficult for us to keep track of everything at once.

What motherboard is this?

***  Sorry, Im actually working on 3 or 4 different motherboards right now, all having similar problems, most of them are nVidia AMD based, but a couple are Intel Based.  The one ive been doing most of my testing on is:  http://www.supermicro.com/Aplus/motherboard/Opteron/nForce/H8DCR-3.cfm

It looks like we're very close.  Thanks for all your help...


--
Jean Delvare


