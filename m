From: A.Verweij2@ewi.tudelft.nl (Arjen Verweij)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: modprobe adm1021 causes abit nf7-s to hang
Message-Id: <Pine.GHP.4.44.0401111816220.15941-300000@elektron.its.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109081153.M20913@ensicaen.ismra.fr>
In-Reply-To: <20040109081153.M20913@ensicaen.ismra.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As requested, the output from sensors-detect (CVS) and i2cdetect (2.8.2).
Please let me know if you are lacking information, that I may have to
provide still.

As for sensors-detect from 2.8.2, its output is as listed in the previous
email (and below), the duplicate i2c-nforce2 is not a pasting error.

Also, the CVS version of sensors-detect correctly identifies my chip as
W83627HF instead pf w83781d, but I read in CHANGES that this is normal
behaviour, because there didn't use to be a seperate driver for *HF.


On Fri, 9 Jan 2004, DELVARE Jean wrote:

> > I'm sorry that I cannot write you in French. I hope that English will
> > suffice. Your website lists you as an active member of the LM Sensors
> > project team. I apologize if I should have used an lmsensors ticket.
> > I could resubmit this report there if that is preferable.
>
> Prefered solution is the mailing-list, CC'd.
>
> > On Google I found this:
> > http://archives.andrew.net.au/lm-sensors/msg04624.html
> >
> > I'm experiencing the exact same problems with a 2.4.23 kernel and
> > i2c-2.8.2 + lm_sensors-2.8.2 from source. My distro is Debian sid,
> > but lm_sensors is currently at 2.8.1-2, so I tried source instead before
> > reporting a bug.
>
> Strange you have the problem with 2.8.2, since what was believed to cause the
> problem is supposed to be fixed since that version.
>
> > I have compiled and installed i2c and lm_sensors. After this I have run
> > sensors-detect. It suggests the following drivers:
> >
> > # I2C adapter drivers
> > i2c-nforce2
> > i2c-nforce2
> > i2c-isa
> > # I2C chip drivers
> > adm1021
> > eeprom
> > w83781d
>
> Does it really list i2c-nforce2 twice? How strange. Maybe we should fix that.
>
> > However, my box hangs after modprobing adm1021. I have tried your
> > suggestion in the URL at the top, to use sensors-detect from CVS. There
> > are some errors running it:
> >
> > [adapter probings]
> > ...
> >  If you found that the adapter hung after probing a certain address,
> > you can specify that address to remain unprobed. That often includes
> > address 0x69 (clock chip). Error: First argument not a number!
> > (...)
>
> The sensors-detect script from CVS currently needs i2cdetect from CVS too. You
> may be easier getting a full CVS checkout.
>
> > Can I supply you with additional information to help you help me :) ?
>
> I'd be interested in the following things:
>
> 1* A full run of sensors-detect, either 2.8.2 or CVS as long as it works, with
> no driver loaded.
>
> 2* An i2cdetect run on all your i2c busses after loading i2c-nforce2 (but
> before loading *any* chip driver).
>
> My guess is that the adm1021 driver tries to handle a device that is not
> adm1021-compatible. The requsted information should confirm or infirm this.
>
> Thanks.
>
> --
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________
>
>
-------------- next part --------------
************************************************************************************************************************
* Scanned with sensors-detect version from CVS *
************************************************

barton:/home/sphere/media/sensors-detect# ./sensors-detect 

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce2 SMBus (MCP)
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): no
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
Error: First argument not a number!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus nForce2 adapter at 5000           Non-I2C SMBus adapter           
    i2c-1       smbus           SMBus nForce2 adapter at 5100           Non-I2C SMBus adapter           

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yes
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
 this.  Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x00)
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
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x52)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa
Error: First argument not a number!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus nForce2 adapter at 5000           Non-I2C SMBus adapter           
    i2c-1       smbus           SMBus nForce2 adapter at 5100           Non-I2C SMBus adapter           

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

-------------- next part --------------
******************************************************
* Scanned with i2cdetect 2.8.2, compiled from source *
******************************************************

barton:/home/sphere/media/sensors-detect# lsmod
Module                  Size  Used by    Tainted: P  
i2c-dev                 4352   0  (unused)
i2c-nforce2             3464   0  (unused)
i2c-core               15780   0  [i2c-dev i2c-nforce2]

barton:/home/sphere/media/sensors-detect# i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 4e XX 
50: 50 XX 52 XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 

barton:/home/sphere/media/sensors-detect# i2cdetect 1
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-1
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 7f 
