From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Tue, 15 Mar 2011 19:39:12 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <000001cbe348$a960b970$fc222c50$@se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> Från: Luca Tettamanti [mailto:kronos.it@gmail.com]
> Skickat: den 15 mars 2011 17:01
> Till: Jean Delvare
> Kopia: Anders Kullenberg; LM Sensors
> Ämne: Re: [lm-sensors] extreme fan rpms with atk0110
> 
> On Tue, Mar 15, 2011 at 3:58 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > On Tue, 15 Mar 2011 15:01:24 +0100, Luca Tettamanti wrote:
> [cut]
> > Found `ITE IT8712F Super IO Sensors'                        Success!
> >    (address 0xd00, driver `it87')
> >
> >> If possible load the native driver (blacklist asus_atk0110 and boot
> >> with acpi_enforce_resources=lax) and compare the fan readings.

Blacklisting is done in "/usr/src/linux-headers-2.6.35-27-server/.config" correct?
In the ACPI drivers section I have:
CONFIG_SENSORS_ATK0110=m
CONFIG_SENSORS_LIS3LV02D=m

Should I comment both those out?

Where do I put the "acpi_enforce_resources=lax"

Thanks


> > Would be interesting, yes. Some IT8712F chips support 16-bit fan
> speed
> > readings (without divisor) and others support 8-bit fan speed
> readings
> > (with divisor). Maybe the chip and its configuration disagree with
> what
> > the DSDT code expects.
> 
> I've cross checked and the DSDT matches the code from it87 for 8 bit
> readings.
> 
> Luca


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
