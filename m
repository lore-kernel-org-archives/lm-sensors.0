From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E13FD83@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > [root@gb0007 lm_sensors-2.8.1]# rmmod w83781d
> 
> That module isn't supposed to be loaded at this moment. There's
> something unclear here, the rmmod command should return an error. Can
> you test that again, checking with lsmod which modules are loaded each
> time? Don't you have some kind of module auto-loading making trouble
> here? Taking a look at dmesg while loading/unloading the modules could
> help.

I tried this again and it worked normally.  With 83781d loaded, I get nothing.  With w83627hf loaded, I see the sensors.  Maybe I cut and pasted the wrong thing in my initial email.

> 
> > 2. The max6650 fan speed measurement seems to be all or nothing.  If
> > there's a (Sunon) fan connected and operational, it reports 
> 7650RPM. 
> > If there's no fan connected, it reports 0 RPM.  If I physically slow
> > the fan down, it still report 7650 RPM.  (The tachs on the w83627hf
> > sensor do show decreased rpm when I impede their fans).

Any thoughts on this?


> > 3. The fan speeds reported (7650 or 18,000-21,000) seem to be
> > inconsistent with the advertised speeds.  Changing the divisors
> > doesn't seem to affect the reported values.

Or this?

> > 4. The speed control on the max6650 doesn't seem to work.  
> See below.
> 
> Strange. Could be because the driver assumes too much conditions that
> aren't correct for your system. The MAX6650 driver was contributed by
> John Morris. John, could you please take a look at Mark's problem?
> 
> > 5. The w83627hf's "pwm1" setting seems to have no effect:
> 
> I think that PWM needs special wiring on the motherboad in order to
> work. Could it be that your motherboard doesn't have it?
> 


Well, I've figured out part of the answer to 4 & 5.  Here's how my motherboard is set up.

Fan		Controlled by		Monitored by
J29/sys3	w83627hf pwm1		max6651 fan1
J30/sys4	w83627hf pwm1		max6651 fan2
J16/cpu1	n/a				max6651 fan3
J14/cpu2	n/a				max6651 fan4
J3/sys2	w83627hf pwm2		w83627hf fan1
J1/sys1	w83627hf pwm2		w83627hf fan2
J58/sys5	max6651 speed		w83627hf fan3


I can't begin to imagine why they have these chips cross-connected, with one chip controlling a fan and a different chip monitoring it.  The Winbond has two pwm's, each controlling two fans, and it only operates in "open loop" mode.  I read the max6651 data sheet (http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf), and it supports four modes, always on, always off, open loop (use pwm to achieve a desired voltage), and closed loop (use pwm to achieve a desired fan1 speed).  Reading the configuration register from the driver suggests that it's in closed loop mode.  

# cat /proc/sys/dev/sensors/max6650-i2c-0-1b/xdump
38 42 255 0 0 0 31 2

Bits 5 and 4 of 42 are 1 and 0

The fact that changing the "speed" setting affects the speed of the J58 fan suggests that it's actually operating in "open loop" mode.  Given that it isn't wired to monitor the fan that it's controlling, I would think there's no way that it could run in closed loop mode.

Question: Am I interpreting the xdump values correctly?

Request: How about making the xdump values easier to interpret, and making the configuration register writable in software, so that I can try things like setting it to always-off mode?

> > 6. The w83627hf's "pwm2" setting is able to reduce the 
> speed of fans 1
> > and 2, but only to about half.  I can hear them change 
> speed when I do
> > this.  I can't get them to stop completely, though.
> 
> This may be a feature more that a bug. Fully starting a fan requires a
> higher current. What's more, stopping a fan completely is somewhat
> dangerous, isn't it? Same as for PWM1, I think that PWM2 
> works thank to
> adequate wiring on your motherboard, but maybe the wiring and
> electronics are such that the W83627HF isn't allowed to lower the fan
> speed below a given threshold.

The max6651 data sheet says something about how lowering the PWM and therefore the voltage on the fan may result in odd behavior, like the fan stopping completely or the tach signal not reporting at all or reporting too many times.  I suppose that makes sense.  That doesn't explain why setting PWM to zero doesn't stop the fan, though.  If my observations are consistent with those of others, and there's no real way to stop the fans, I can live with that.  I don't really need to stop the fans.  I'm just trying to understand what's going on.  So far everything I've tried has given me a result different from what I've expected, and that makes it hard for me to have much confidence that the system is doing what I think it is.

> > 7.  Changes to the "pwm2" setting seem to be transient.  Something
> > happens to change it back to 255.
> > 
> > [root@oscarnode001 root]# cat
> > /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     0 1
> > [root@oscarnode001 root]# sleep 60
> > [root@oscarnode001 root]# cat
> > /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     255 1
> 
> Don't you by any chance have a monitoring daemon running on 
> the machine?

I'm not aware of any, but RH9 may have installed something that I don't know about.  How can I tell?  What are the names of some monitoring daemons that I could check for?

> 
> > 8. Sometimes the "lm75" module loads and detects something.  I'm not
> > aware of there being any lm75's or compatible devices on 
> this system. 
> > (...)
> > 9. The lm75's temperature readings are bogus.  At an earlier point I
> > got them to report reasonable values, but I can't get back to that
> > state.
> 
> Could you provide the output of "i2cdetect 0"? I'd also be 
> interested in
> the output of "i2cdump 0 0x1f" since you seem to have an unknown chip
> there.
> 

]# i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX 1f
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 31 XX XX 34 35 XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX UU UU XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

> Strangely, sensors-detect didn't report any client found at these
> addresses (0x48 and 0x49). Could you run sensors-detect again (unload
> all client drivers first) and see if it now does? These LM75s could
> actually be emulated by your w83627hf, although it's unusual 
> to see this
> behavior when the w83627hf itself is on the ISA (as opposed 
> to I2C) bus.
> 

I tried it again.  No lm75's.  Output below.

> > 10.  The default value for the sensor type on the  w83627hf's
> > temperature sensor, according to sensors.conf, is 
> thermistor (3435). 
> > But for me it seems to be defaulting to "1", PII/Celeron Diode.
> 
> The "defaults" might be confusing, I agree. This refers to power-up
> default for the chip. The BIOS may then reconfigure the chip 
> during the
> boot process. I believe that this is what has happened there.
> 
> If you believe that we should say the things differently in the
> configuration file, suggestions are welcome.

It would be helpful if you included your clarification about chip vs. bios defaults.

> 
> Thanks for the long and detailed report. I doubt we'll be able to
> quickly solve all the problems you encountered, since there are many,
> still this will help us if similar problems are reported in 
> the future,
> plus I hope I clarified some points.

Thanks for your help.  

This whole thing has turned out to be much more complicated and difficult than I would have expected.  I've been at it for over a week now, with thermometers, multimeters, oscilliscopes, duct tape and bailing wire.  I finally have the temperature information I want, and I can tell if my fans are running or not, but I'm still not sure if sensors is reporting the correct fan speed.

On the positive side, when I first tried lm_sensors a year or two ago, I got absolutely nowhere, so it's obviously come a long way since then.  Keep up the good work!


[root@gb0007 lm_sensors-2.8.1]# prog/detect/sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): PTLTD
 System vendor (DMI): Intel Corporation
 BIOS version (DMI): E7501CW20.86B.0023.P05.0306201836
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801CA/CAM ICH3
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 1100 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x1b
Probing for `Maxim MAX6650/MAX6651'... Success!
    (confidence 4, driver `max6650')
Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'... Failed!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x34
Client found at address 0x35
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed! (0x00)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x00)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x1b
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe max6650
modprobe eeprom
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
> 
