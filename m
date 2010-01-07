From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jan 2010 08:44:39 +0000
Subject: Re: [lm-sensors] SMSC SCH5147-NW not detected / supported
Message-Id: <20100107094439.5def4318@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
In-Reply-To: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Jan 2010 09:25:35 +1100, Marcus Vogt wrote:
> Hi Juerg,
> 
> Unfortunately that didn't work:
> 
> root@ythekshri:~# modprobe  dme1737 force_id=0x7c
> FATAL: Error inserting dme1737
> (/lib/modules/2.6.31-16-generic-pae/kernel/drivers/hwmon/dme1737.ko):
> Device or resource busy
> root@ythekshri:~#
> 
> dmesg reports:
> 
> [ 1793.870444] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with
> ACPI region RNTR [0xa00-0xa7f]
> [ 1793.870448] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver

This means that ACPI claimed the whole chip for its own use, preventing
native drivers (dme1737 in your case) from using it.

You can bypass this check by booting with acpi_enforce_resources=lax,
for testing purpose. I wouldn't recommend it as a permanent solution
though, because if ACPI is really using the chip, the concurrent
accesses are likely to conflict at some point with unpredictable (but
generally bad) results.

> root@ythekshri:~# cat /proc/ioports | grep a7
> 0a00-0a7f : pnp 00:09
> root@ythekshri:~#

> On Tue, Jan 5, 2010 at 3:51 AM, Juerg Haefliger <juergh@gmail.com> wrote:
> > Hi Marcus,
> >
> >
> >>> Hi guys,
> >>>
> >>> I have a HP EX490 and it has a SMSC SCH5147-NW for monitoring (found
> >>> via visual inspection of the board).  The vendor URL for this chip is
> >>> http://www.smsc.com/index.php?tid%4&pid1
> >>>
> >>> This does not appear to be detected or supported via lm-sensors -
> >>> though it does identify that there is a Super I/O SMSC device - the
> >>> trimmed information from sensors-detect is as follows:
> >>>
> >>>       Probing for Super-I/O at 0x2e/0x2f
> >>>       Trying family `SMSC'...                                     Yes
> >>>       Found unknown chip with ID 0xc101

Juerg, can you please add the chip to sensors-detect so that it is
properly identified?

> >>> Unfortunately, google does not appear to be able to find the data
> >>> sheet for this chip and the only other references are for some Lenovo
> >>> gear that use them.
> >>>
> >>> Any ideas on how I'd progress with this?  I'm happy to do testing and
> >>> a bit of coding.
> >>
> >> I'll ask my contact at SMSC if he can provide a datasheet.
> >
> > The chip seems to be close to a SCH311x. Try loading the dme1737
> > module with 'force_id=0x7c' module load parameter and report your
> > results.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
