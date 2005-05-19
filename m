From: frank@vfx.to (Frank Hellmann)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1834 Update
Message-Id: <41B25B6E.1070702@vfx.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean!

Jean Delvare wrote:

>>The chip on the MSI KT8 Neo is actually a Winbond w83697hf and is not 
>>detected correctly during sensors-detect.
>>    
>>
>
>What was sensors-detect detecting? Please attach the complete log.
>
>  
>
Log is attached...

>>pwmconfig can't detect a usable a correlation:
>>
>>Testing pwm control 1-0290/fan1_pwm ...
>>  1-0290/fan1_input ... speed was 3229 now 0
>>    It appears that fan 1-0290/fan1_input
>>    is controlled by pwm 1-0290/fan1_pwm
>>Would you like to generate a detailed correlation (y)?
>>    PWM 255 FAN 3229
>>    PWM 240 FAN 3214
>>    PWM 225 FAN 3214
>>    PWM 210 FAN 3229
>>    PWM 195 FAN 3229
>>    PWM 180 FAN 3229
>>    PWM 165 FAN 3229
>>    PWM 150 FAN 3229
>>    PWM 135 FAN 3229
>>    PWM 120 FAN 3229
>>    PWM 105 FAN 3214
>>    PWM 90 FAN 3214
>>    PWM 75 FAN 3229
>>    PWM 60 FAN 3214
>>    PWM 45 FAN 3214
>>    PWM 30 FAN 3214
>>    PWM 15 FAN 3169
>>    PWM 0 FAN 0
>>    Fan Stopped at PWM = 0
>>    
>>
>
>This is admittedly a strange behavior, I can't remember of a similar
>report. Maybe you need to adjust the PWM clock. This is done by register
>0 of the chip (which you can write to by running "isaset 0x295 0x296 0
><value>" as root). Default value is 1 and results in a 125kHz clock. You
>can increase the value up to 127, resulting frequency being
>125kHz/value. If you set the MSB to 1, the base clock changes from
>125kHz to 1MHz (and again you can divide it by changing the 7 other
>bits). I'd suggest you try this 
>
>I doubt it'll really help, but if you have some spare time and really
>want it to work, you may want to give it a try.
>
>  
>
Actually this works great! I have set it to 25 and it scales good now.

isaset 0x295 0x296 0 25

Here the pwmconfig output:

Testing pwm control 1-0290/fan1_pwm ...
  1-0290/fan1_input ... speed was 2777 now 0
    It appears that fan 1-0290/fan1_input
    is controlled by pwm 1-0290/fan1_pwm
Would you like to generate a detailed correlation (y)?
    PWM 255 FAN 3245
    PWM 240 FAN 3245
    PWM 225 FAN 3214
    PWM 210 FAN 3199
    PWM 195 FAN 3183
    PWM 180 FAN 3154
    PWM 165 FAN 3139
    PWM 150 FAN 3110
    PWM 135 FAN 3082
    PWM 120 FAN 3082
    PWM 105 FAN 3040
    PWM 90 FAN 3013
    PWM 75 FAN 2960
    PWM 60 FAN 2922
    PWM 45 FAN 2824
    PWM 30 FAN 2755
    PWM 15 FAN 0
    Fan Stopped at PWM = 15

What would be the "nicest" way of setting these values? I would suggest 
putting it into /etc/modules.conf:

post-install w83627hf /usr/sbin/isaset -y 0x295 0x296 0 25 > /dev/null 
2> /dev/null

Ok? Or is there a better/safer way?

Thanks a lot. Cheers,

                Frank...


-------------- next part --------------
sandman:/home/frank# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South BridgeProbe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

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

Next adapter: SMBus Via Pro adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client found at address 0x69
Client found at address 0x6a

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
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
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x60)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x60)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# I2C chip drivers
w83627hf
#----cut here----

Do you wan't to add these lines to /etc/modules automatically? (yes/NO)
