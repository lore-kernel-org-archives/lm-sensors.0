From: rhirst@levanta.com (Richard Hirst)
Date: Sun, 26 Jun 2005 14:18:30 +0000
Subject: [lm-sensors] Reading LM96000 on an Intel SE7221BK1 server board
Message-Id: <20050626121722.GH7554@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050622212816.GD7554@levanta.com>
In-Reply-To: <20050622212816.GD7554@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
  Thanks for the response.  I've made some progress...

The board has an E7221 chipset that includes a PC87431M mBMC chip.
By applying the various patches to support ipmi-smb and bmcsensors
I can now read voltages and temperatures from the mBMC via both
lm_sensors and ipmitool.

I still can't read fan speeds, as the mBMC doesn't report any
fan speed sensors.  The PC87431M datasheet claims it has a slave
i2c interface to talk to the host, and two master i2c interfaces
to talk to LMxx chips.  So maybe the LM96000 is hung off that.
The PC87431M also claims to have integral fan monitoring and control,
so I've really no idea whether the LM96000 does anything useful at
all.

Anyway, this is what I now get:

[root@localhost ~]# sensors
bmc-i2c-1-00
Adapter: IPMI adapter
1.8V:      +1.81 V  (min =  +1.61 V, max =  +1.96 V)   
5.0V:      +5.05 V  (min =  +4.55 V, max =  +5.58 V)
12V:      +12.45 V  (min = +10.78 V, max = +13.20 V)
BoardTemp: +32.0?C  (high =   +78?C, hyst =    +2?C)
CoreTemp:  +43.0?C  (high =   +88?C, hyst =    +2?C)

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (8)

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (8)

IPMI-i2c-0-42
Adapter: SMBus I801 adapter at 0400

[root@localhost ~]# ipmitool sdr
Baseboard 1.8V   | 1.81 Volts        | ok
Baseboard 5.0V   | 5.05 Volts        | ok
Baseboard 12V    | 12.45 Volts       | ok
Serverboard temp | 32 degrees C      | ok
Proc1 Core temp  | 42 degrees C      | ok
Proc IERR        | 0x00              | ok
P1 Thermal Trip  | 0x00              | ok
Interrupt Button | 0x00              | ok
ID Button        | 0x00              | ok
[root@localhost ~]# 


Device 42 on i2c bus 0 is the mBMC itself:

Jun 26 00:36:55 localhost kernel: IPMI SMB Interface driver version v33
Jun 26 00:36:55 localhost kernel: ipmi_smb: DMI specifies SSIF @ 0x42
Jun 26 00:36:55 localhost kernel: ipmi_smb: DMI specifies slave address at 0x84


which I think is good enough for now.  Would be nice to read fan
speeds, though.

Thanks,
  Richard


On Sun, Jun 26, 2005 at 11:22:42AM +0200, Jean Delvare wrote:
> Hi Richard,
> 
> > Should I expect to see a 2c, 2d, or 2e in that output?
> 
> Yup, if the LM96000 was connected to that bus.
> 
> > As I don't, what does that mean?
> 
> That the LM96000 isn't there.
> 
> > Might it mean the chip is connected to some other i2c bus I
> > havn't found yet,
> 
> Either that, or the ICH6 SMBus is multiplexed. This is common on Asus
> boards, but I don't think we ever saw an Intel board do that.
> 
> > or I need to do something else to enable it, or what?
> 
> If you do, it has to be board specific so only Intel can tell you.
> 
> > Might I have done something that made the chip invisible?
> 
> I don't think so.
> 
> > I assume I'm correct in thinking that as it doesn't show up in
> > i2cdetect output, there is no chance of the lm85 driver detecting it.
> 
> Absolutely.
> 
> > I also don't know what the i2c devices at 08, 42, 44, 60 and 69 are.
> > 50 and 52 get picked up by the eeprom driver.
> 
> 08 and 44 are special addresses for SMBus 2.0 stuff, 69 is most probably
> a clock chip you so not want to play with. Remains 42 and 60, I have no
> idea for these (except that these are not typical addresses for hardware
> monitoring chips).
> 
> > I'm running an FC3 2.6.10-1.766_FCsmp kernel atm, but I'm guessing
> > that wouldn't have an impact on i2cdetect output.
> 
> No impact, true.
> 
> > Any suggestions on how to access the LM96000 welcome.  The board
> > has a PC87427 too, and the motherboard doc suggests that has an "i2c
> > interface to LM96000 sensors", but I'm not sure I believe that;
> > the PC87427 has a SensorPath interface for talking to LMxx sensors,
> > but I don't think the LM96000 talks SensorPath.
> 
> Correct again.
> 
> > The PC87427 has an SMbus slave interface too, and I didn't see
> > anything that looked like that in the i2cdetect or i2cdump output
> > either.
> 
> True again, it would show at 30 or 6c if I trust the preliminary
> datasheet I have, and these addresses did not work in i2cdetect.
> 
> So your analysis is correct, I wouldn't have come up with a different
> conclusion. Your best chance now is probably to ask Intel themselves for
> help and details on the wiring.
> 
> Good luck,
> -- 
> Jean Delvare
