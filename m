From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 31 Mar 2006 06:47:31 +0000
Subject: [lm-sensors] p5gdc problems
Message-Id: <4dfa50520603302247l6da629fbv746e8279a2644440@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1143734832.11275.5.camel@localhost.localdomain>
In-Reply-To: <1143734832.11275.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Victor,

This email (and all emails) should always be sent to the lm-sensors
mailing list. Others are interested!

David

On 3/30/06, Victor de Queiroz Bertholdo <vbnet at terra.com.br> wrote:
On Qui, 2006-03-30, David Hubbard wrote:
> Hi Victor,
>
> On 3/30/06, Victor de Queiroz Bertholdo <vbnet at terra.com.br> wrote:
> > Hi... I`m Victor and I need a little help (a HOWTO, I guess).
> >         I have a P5gdc Asus, with the w83627ehf chip, but I can`t recieve any
> > feedback from any lm-sensors based programs. I want to know if I`ll be
> > able to run this programs, because I want to check my cpu temperature,
> > and that`s all. I have Ubuntu 5.10 breezy on my pc and I`ve tried all
> > procedures from the net, but all of them went wrong. Please, help me.
>
> Can you post what version of the linux kernel you are running?
>
> Can you post all the output when you run sensors-detect? And sensors?
>
> I'm part of the w83627ehf development effort, and I'd be happy to get
> feedback on how the driver works or doesn't.
>
> David
>

Hi David,
        Thanks for the answer. So, I`m working with a 2.6.12-9 kernel, Ubuntu
Breezy 5.10, lm-sensor package from the ubuntu's repository, sensors
none (but DDR memory-EEPRON-) and this is my output after I run
sensors-detect:
        -Thank you for helping me.
                Victor
Output begins here: (I usually answer the sensors-detect questions with
"yes")
-----------------------------------------------------------------------
root at victor-ubuntu:/home/victor# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): yes
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x88)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x88)
Probing for `Winbond W83627EHF Super IO Sensors'
  Success... found at address 0x0290

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
   Chip `Winbond W83627EHF Super IO Sensors' (confidence: 9)

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa
To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
eeprom
# no driver for Winbond W83627EHF Super IO Sensors yet
#----cut here----

Do you want to add these lines to /etc/modules automatically?
(yes/NO)yes
-----------------------------------------------------------------
Output ends here...

