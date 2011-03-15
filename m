From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 14:58:27 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <20110315155827.723d1b5f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 15:01:24 +0100, Luca Tettamanti wrote:
> On Sat, Mar 12, 2011 at 11:54 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > On Sat, Mar 12, 2011 at 11:45 PM, Anders Kullenberg <akullen@swipnet.se> wrote:
> >> I have attached what I think is the DSDT, used this method:"sudo cat
> >> /sys/firmware/acpi/tables/DSDT > /tmp/DSDT" is that correct?
> >
> > Yes, that's correct. I'll take a look tomorrow.
> 
> I don't see anything suspicious in the ACPI code, but the relevant
> method (HWF1) scales the value read from the sensor using the divider
> (also read from the monitoring chip) and a built-in table.
> Can you identify the chip using sensors-detect?

He did already, before you got Cc'd:

Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found `ITE IT8712F Super IO Sensors'                        Success!
    (address 0xd00, driver `it87')


> If possible load the native driver (blacklist asus_atk0110 and boot
> with acpi_enforce_resources=lax) and compare the fan readings.

Would be interesting, yes. Some IT8712F chips support 16-bit fan speed
readings (without divisor) and others support 8-bit fan speed readings
(with divisor). Maybe the chip and its configuration disagree with what
the DSDT code expects.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
