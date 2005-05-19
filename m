From: karl@unfiw.com (Karl Kopper)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Newbie questions about sensors-detect and sensors output.
Message-Id: <OJEKLLDJMPFGONMBIJEFIEHBCEAA.karl@unfiw.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OJEKLLDJMPFGONMBIJEFMEHACEAA.karl@unfiw.com>
In-Reply-To: <OJEKLLDJMPFGONMBIJEFMEHACEAA.karl@unfiw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your reply!

The output looks the same from sensors-detect in the distro. I modprobed -r
all of the modules then ran it:

bash-2.05a# pwd
/usr/local/src/lm-sensor/lm_sensors-2.6.3/prog/detect
bash-2.05a# ./sensors-detect
<snip>
Client found at address 0x61
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Use of uninitialized value in concatenation (.) or string at
./sensors-detect li
ne 1617, <STDIN> line 3.
Probing for `SMBus 2.0 ARP-Capable Device??'... Success!
    (confidence 1, driver `')                              <----- ???
Use of uninitialized value in string eq at ./sensors-detect line 1393,
<STDIN> l
ine 3.
Use of uninitialized value in string eq at ./sensors-detect line 1393,
<STDIN> l
ine 3.

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
<snip>

Can I tell from this output what the missing driver name is?

Thanks again for your help.

--Karl

> -----Original Message-----
> From: phil@netroedge.com [mailto:phil@netroedge.com]
> Sent: Tuesday, July 02, 2002 12:35 PM
> To: Karl Kopper
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: Newbie questions about sensors-detect and sensors output.
>
>
>
> A couple oddities I noticed: errors in the sensors-detect script, and
> mixed versions of lm-sensors in your dmesg.
>
> The modules you are using look reasonable (i2c-proc, i2c-dev, eeprom,
> i2c-piix4, i2c-core, i2c-isa).  You need another driver to run your
> sensors chip, though (an appropriate module for your hardware in
> lm-sensors/kernel/chips).
>
> I suggest using the latest versions of lm-sensors and i2c, and try not
> to mix them with older code.  Run the sensors-detect script in the
> distro (lm-sensors/detect/sensors-detect) and not the (apparently bad)
> one in /usr/local/sbin.  You may also have an issue with your Perl
> install (sensors-detect is a perl script) which is causing the errors.
>
>
> Phil
>
> On Tue, Jul 02, 2002 at 12:13:14PM -0700, Karl Kopper wrote:
> >
> > The faq says to post at: http://www.netroedge.com/~lm78/support.html but
> > this link is broken so I hope good old-fashioned E-mail is okay.
> >
> > When I run sensors-detect
> >
> > The output looks like this...
> >
> > <snip>
> > Client found at address 0x61
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83783S'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F'... Failed!
> > Probing for `Winbond W83L784R/AR'... Failed!
> > Use of uninitialized value in concatenation (.) or string at
> > /usr/local/sbin/sen
> > sors-detect line 1617, <STDIN> line 4.
> > Probing for `SMBus 2.0 ARP-Capable Device??'... Success!
> >     (confidence 1, driver `')
> > Use of uninitialized value in string eq at
> /usr/local/sbin/sensors-detect
> > line 1
> > 393, <STDIN> line 4.
> >
> >  Some chips are also accessible through the ISA bus. ISA probes are
> >  typically a bit more dangerous, as we have to write to I/O ports to do
> >  this.  Do you want to scan the ISA bus? (YES/no):
> > <snip>
> >
> > Notice the success "driver" appears to be blank.
> >
> > This is the output near the end of the script:
> >
> > <snip>
> >  Now follows a summary of the probes I have just done.
> >  Just press ENTER to continue:
> >
> > Driver `thmc50' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus PIIX4 adapter at fc00' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-piix4', I2C address 0x2c
> >     Chip `Analog Devices ADM1022' (confidence: 8)
> > Use of uninitialized value in concatenation (.) or string at
> > /usr/local/sbin/sen
> > sors-detect line 2781, <STDIN> line 6.
> >
> > Driver `' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus PIIX4 adapter at fc00' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-piix4', I2C address 0x61
> >     Chip `SMBus 2.0 ARP-Capable Device??' (confidence: 1)
> > <snip>
> >
> > Notice again the blank driver. Now the modprobe lines I'm supposed to
> > insert:
> >
> > <snip>
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-piix4
> > # I2C chip drivers
> > modprobe thmc50
> > modprobe
> > #----cut here----
> >
> > To make the sensors modules behave correctly, add these lines to either
> > /etc/modules.conf or /etc/conf.modules:
> >
> > #----cut here----
> > # I2C module options
> > alias char-major-89 i2c-dev
> > <snip>
> >
> > Looks like a blank modprobe line?? Is this right?
> >
> > bash-2.05a#lsmod
> > Module                  Size  Used by    Not tainted
> > i2c-dev                 4704   0
> > eeprom                  4736   0  (unused)
> > thmc50                  5600   0  (unused)
> > i2c-proc                8128   0  [eeprom thmc50]
> > i2c-piix4               4772   0
> > i2c-core               19264   0  [i2c-dev eeprom thmc50
> i2c-proc i2c-piix4]
> >
> > Is this output correct? I'm trying to find temperature information??
> >
> > bash-2.05a# sensors -f
> > eeprom-i2c-0-50
> > Adapter: SMBus PIIX4 adapter at fc00
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            SDRAM DIMM SPD
> > SDRAM Size (MB):        128
> >
> > eeprom-i2c-0-51
> > Adapter: SMBus PIIX4 adapter at fc00
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            SDRAM DIMM SPD
> > SDRAM Size (MB):        256
> >
> > eeprom-i2c-0-52
> > Adapter: SMBus PIIX4 adapter at fc00
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            SDRAM DIMM SPD
> > SDRAM Size (MB):        128
> >
> > Here's dmesg output:
> > <snip>
> > i2c-core.o: i2c core module
> > i2c-piix4.o version 2.6.3 (20020322)
> > i2c-piix4.o: Found OSB4 device
> > i2c-core.o: adapter SMBus PIIX4 adapter at fc00 registered as adapter 0.
> > i2c-piix4.o: SMBus detected and initialized
> > i2c-proc.o version 2.6.1 (20010825)
> > thmc50.o version 2.6.3 (20020322)
> > i2c-core.o: driver THMC50 sensor chip driver registered.
> > eeprom.o version 2.6.3 (20020322)
> > i2c-core.o: driver EEPROM READER registered.
> > i2c-core.o: client [EEPROM chip] registered to adapter [SMBus
> PIIX4 adapter
> > at f
> > c00](pos. 0).
> > i2c-core.o: client [EEPROM chip] registered to adapter [SMBus
> PIIX4 adapter
> > at f
> > c00](pos. 1).
> > i2c-core.o: client [EEPROM chip] registered to adapter [SMBus
> PIIX4 adapter
> > at f
> > c00](pos. 2).
> > send_arp uses obsolete (PF_INET,SOCK_PACKET)
> > i2c-isa.o version 2.6.3 (20020322)
> > i2c-core.o: adapter ISA main adapter registered as adapter 1.
> > i2c-isa.o: ISA bus access for i2c modules initialized.
> > i2c-core.o: adapter unregistered: ISA main adapter
> > i2c-dev.o: i2c /dev entries driver module
> > i2c-core.o: driver i2c-dev dummy driver registered.
> > i2c-dev.o: Registered 'SMBus PIIX4 adapter at fc00' as minor 0
> >
> > Not knowing what I was doing I stuck i2c-isa in then removed it. ??
> >
> > Thanks for your help.
> >
> > --Karl
> >
> >
>
> --
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
