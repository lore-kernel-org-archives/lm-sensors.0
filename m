From: "Ivo Manca" <pinkel@gmail.com>
Date: Fri, 08 Jun 2007 15:20:10 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <055101c7a9e0$848b5240$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hey Jean,

Thanks for helping out, if you need more information, just let me know

> Sensors-detect:
[root@localhost ~]# sensors-detect
# sensors-detect revision 4348 (2007-03-18 02:45:21 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis5595' for device 0000:00:01.0: Silicon Integrated Systems 
SIS5595

We will now try to load each adapter module in turn.
Module `i2c-sis5595' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus SIS5595 adapter at 0438 (i2c-0)
Do you want to scan it? (YES/no/selectively):

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National 
Semiconductor LM78' at 0x290...       Success!
    (confidence 6, driver `lm78')
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         Success!
    (confidence 9, driver `sis5595')
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `lm78' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `National Semiconductor LM78' (confidence: 6)

Driver `sis5595' (should be inserted):
  Detects correctly:
  * ISA bus
    Chip `Silicon Integrated Systems SIS5595' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# Chip drivers
modprobe lm78
modprobe sis5595
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
[root@localhost ~]#


> BIOS output:
CPU Temprature                    49` C / 120` F
CPU FAN Speed                   Disconnected
Vcc 5.0V                                5.093V
Vcc 3.3V                                3.382V
Vcc 2.5V                                2,949V
Vcore                                      2,048V

> sensors -c /dev/null
[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.75 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.62 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.62 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.63 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.62 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.86 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.62 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

[root@localhost ~]# sensors -c /dev/null
sis5595-isa-0290
Adapter: ISA adapter
in0:       +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:       +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:       +2.05 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:       +3.62 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

--
Removing sis5595 & loading lm78 also gives output?
[root@localhost ~]# rmmod sis5595
[root@localhost ~]# modprobe lm78
[root@localhost ~]# sensors
lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
VCore 2:   +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+3.3V:     +2.75 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+5V:       +3.44 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+12V:     +13.74 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      -0.00 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -0.00 V  (min =  -0.00 V, max =  -0.00 V)
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan3:       -1 RPM  (min =   -1 RPM, div = 2)
temp:     +127.0°C  (high =    +0°C, hyst =    +0°C)
vid:       +3.50 V
alarms:   Board temperature input (LM75)               ALARM

Ivo

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Ivo Manca" <pinkel@gmail.com>; "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Thursday 7 June 2007 19:40
Subject: sis5595


> Hi Ivo,
>
> Now that we got your SiS5595 to work again, maybe you want to spend
> some time finding out why the sensors output doesn't match what you
> have in your BIOS? If so, please provide the following information:
>
> * Full output of the latest version of sensors-detect (just to make
> sure you don't have a _second_ hardware monitoring chip).
> * A list of all hardware monitoring information that is listed by your
> BIOS. Labels and values, in order.
> * Several outputs of "sensors -c /dev/null", 1 minute apart or so.
>
> -- 
> Jean Delvare 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
