From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH][2.5] Support for W83627THF sensor chip (Was Re: [2.5]
Message-Id: <3EEE6992.2010309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055807044.7227.7.camel@nosferatu.lan>
In-Reply-To: <1055807044.7227.7.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

About a week ago I worked with
  Matthias Hentges <matthias@hentges.net>
to determine the device ID for this chip, and he supplied a patch which
I worked into CVS, into the w83627hf driver and into sensors-detect.
It was checked in last week.

This driver is designed for Super I/O chips and includes detection
and activation. It uses ISA accesses.

I would rather not keep adding to the w83781d cruft, especially
for Super I/O chips. Not only is the
driver quite unwieldy already, but people have had lots of trouble
with the Winbond Super I/O chips because they often aren't
initialzed by the bios so the w83781d driver can't find them.
ISA accesses are also much more reliable.

Please test the w83627hf driver in CVS and give us some feedback.

P.S. I try and keep the 'new drivers' page updated with info on new drivers.
It also has info on the best way to investigate and test new chips with
existing drivers.

thanks
mds



Martin Schlemmer wrote:
> Hi
> 
> Ok, I was wrong in assuming that the W83627THF was on the I2C bus.
> It is on the ISA bus, id 0x90 (thanks to Alex Van Kaam author of
> MBM who corrected my assumption).
> 
> Attached is two patches .. one against sources without my previous
> broken patch, and one that will revert the broken one.
> 
