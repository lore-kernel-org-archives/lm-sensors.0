From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jan 2010 13:15:42 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20100120141542.4b28103d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jan 2010 09:20:19 +0100, Gabriel C wrote:
> On 20.01.2010 05:30, b13johnson@comcast.net wrote:
> 
> Hello,
> 
> ...
> > [root@Backup-P4 smsc47m1_driver]# modprobe smsc47m1 
> > FATAL: Error inserting smsc47m1 (/lib/modules/2.6.31.9-174.fc12.i686.PAE/kernel/drivers/hwmon/smsc47m1.ko): Device or resource busy 
> > ---------------------------------------------------------- 
> > 
> > The log file "messages" has the following: 
> > 
> > ---------------------------------------------------------- 
> > Jan 18 23:06:51 localhost kernel: i2c /dev entries driver 
> > Jan 18 23:07:05 localhost kernel: smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997 
> > Jan 18 23:07:05 localhost kernel: ACPI: I/O resource smsc47m1 [0x604-0x604] conflicts with ACPI region SMC_ [0x600-0x65f] 

Unfortunately, in your case ACPI reserved the whole port range. It may
or may not need all these ports, one would have to disassemble the DSDT
to tell. I changed the smsc47m1 driver to play fair and only request
the ports it needs, but if ACPI on its side isn't fair, it doesn't help
at all.

> > Jan 18 23:07:05 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead 
> > of the native driver 
> > ---------------------------------------------------------- 
> > 
> > I'm running Fedora Core kernel 2.6.31.9-174.fc12.i686.PAE 
> > 
> > Do you have any ideas? I really appreciate your help. 
> >
> 
> 
> I guess you have to boot your kernel with :
> 
> acpi_enforce_resources=no

This will certainly work, but if ACPI really accesses these ports, you
might get in trouble (although the smsc47m1 case is probably one of the
least dangerous, thanks to the flat I/O access model.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
