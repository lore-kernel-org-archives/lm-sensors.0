From: mds@mds.gotdns.com (Mark Studebaker)
Date: Tue, 28 Jun 2005 17:48:44 +0000
Subject: [lm-sensors] Using the I2C kernel layer
Message-Id: <42C17137.5030606@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050622084505.76137.qmail@web32913.mail.mud.yahoo.com>
In-Reply-To: <20050622084505.76137.qmail@web32913.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the userspace eeprom writing tools in prog/eepromer may help you.
also see the documents in http://www2.lm-sensors.nu/~lm78/docs.html

Michael Rumpf wrote:
> Hi,
> 
> I have an external Hygrometer which stores temperature
> and humidity snapshots on the device and which can be
> read by a Windows software. I would like to write a
> Linux program to access the device and read the
> values.
> 
> After analyzing the Windows software I found out that
> they are using a really "simple" I2C interface to the
> device, the plain serial port. Especially the status
> lines DTR (SCL), CTS (SDA Write), DSR (SDA Read). The
> chip that stores the values is an eeprom Atmel
> AT24C128/256 (?).
> 
> After digging through the I2C/lm_sensors code/docs I
> found that much of the infrastructure for accessing
> eeproms has already been implemented in a modular way.
> 
> Unfortunately I had to read about some restrictions,
> like that eeproms with more than 256Bytes (?) capacity
> are not supported and that there is not write support
> for eeproms. The device probably needs write support
> to reset the values in the ring-buffer.
> 
> Because I'm new to I2C and kernel driver development I
> ask myself about the best approach to access the
> device, described above. There are currently too many
> unknown variables in my approach, so it would be kind
> if someone with good knowledge of the kernel I2C
> infrastructure could shortly explain what the best
> approach would be to write a driver for the device.
> Would it be possible to write a simple bus-driver,
> like the parport(-light) driver and use an extended
> version of the eeprom client driver to access the
> device?
> 
> I would prefer this approach as it would allow me to
> use all the user-space I2C tools that access the
> I2C/lm_sensors APIs. But if the effort for extending
> the eeprom driver is high I need to investigate other
> possibilities as I would like to get something working
> really fast.
> 
> Thanks in advance,
>    Michael
> 
> 
> Michael Rumpf # Meissener Str. 4 # 71065 Sindelfingen # Germany
> Tel/Fax +49 7031 415883/884
> WWW http://fsinfo.cs.uni-sb.de/~miru
>               Misraet Dir voll Dein Tagesplan,
>               sei Abends Dir als Trost bekraeftigt,
>               Du hast zwar heute nichts getan,
>               doch warst den ganzen Tag beschaeftigt.
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


