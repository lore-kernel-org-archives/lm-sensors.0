From: ovis@thecourtofeden.org (ivo)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031452420.598@shi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 3 Sep 2004, Jean Delvare wrote:

> > sensors
> > Can't access procfs/sysfs file
> > Unable to find i2c bus information;
> > For 2.6 kernels, make sure you have mounted sysfs and done
> > 'modprobe i2c_sensor'!
> > For older kernels, make sure you have done 'modprobe i2c-proc'!
> >
> > sysfs is mounted for sure
> >
> > modules loaded:
> >
> > eeprom                  6920  0
> > lm85                   21380  0
> > i2c_sensor              4096  2 eeprom,lm85
> > i2c_i801                9744  0
>
> What do you see in /sys/bus/i2c/devices/?

Sorry i made a mistake.
sys wasnt mounted but now it do:

sensors
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at d800
Unknown EEPROM type (8)

/sys/bus/i2c/devices
0-0050 -> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm85' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at d800' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `SMSC EMC6D100 or EMC6D101' (confidence: 7)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at d800' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)


mmh thats the magic but whats next
