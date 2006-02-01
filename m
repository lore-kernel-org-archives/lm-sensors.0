From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 01 Feb 2006 20:11:07 +0000
Subject: [lm-sensors] "Lacking functionality" of i2c EEPROM driver
Message-Id: <20060201211107.4af1863d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Konstantin,

Don't bother CC'ing Frodo, he is retired. CC'ing the lm-sensors list,
OTOH, would have been a good idea. Doing it now.

> Recently I started to use Linux kernel 2.6.15 and was unpleasantly
> surprised to find some "Lacking functionality" which presented in
> earlier versions. I am talking about I2C EEPROM write support.

The eeprom driver as found in the Linux tree never ever had write
support.

The eeprom driver as found in the lm_sensors CVS repository used to
have some write support code, but it was ifdef'd out. So this version
of the driver never really had write support either.

> (...) I found
> especially frustrating comment in Documentation about why this
> functionality is suddenly lacking. I admit that I did have problem with
> DIMM module that I made unusable by mistakenly rewritten EEPROM. But I
> still think that it is not reason at all to remove code for i2c EEPROM
> write from kernel sources. It is not technically difficult for me to
> restore this code. But I took some time and caused frustration in people
> who used new kernel when applications which worked perfectly before
> failed with new kernel.

Again, it was not removed. It was never there in the first place, at
least not without you manually editing the code. So the story you're
telling here is simply not true.

> Sincerely, I do not see technical reason at all for removing this
> functionality from sources (as I don't for removing ANY functionality).
> If you were such concerned that it "makes it easy to disable the DIMMs",
> you could make this functionality optional, but do not remove it at all.

Write support could be *added* to the eeprom driver. As you found out,
it would have to be an option, not the default. But even then, it
wouldn't be very convenient for EEPROMs larger than 2 kb as they appear
as separate devices. The eeprom driver also doesn't support EEPROMs
using two-byte addressing, so even more work would be needed to support
these devices.

Write support for EEPROMs is available in user-space (using the i2c-dev
driver). See the directory prog/eepromer in the lm_sensors package.
There are different tools for various EEPROM sizes, including 2-byte
addressed devices. This is the recommended way to write to EEPROMs, and
it works just fine, which is the reason why no efforts were made to
improve the eeprom driver.

> I would suggest to do that if ,of cause, M$ Windows approach to
> implement security through obscurity (I would say "through absurdity")
> is not more preferable for you.

Off topic. First, it's a matter of safety, not security. Second, the
code is open for everyone to read and modify, so where is the obscurity?

> Disclaimer: The information contained in this transmission, including any 
> attachments, may contain confidential information of Panasonic Avionics
> Corporation.  This transmission is intended only for the use of the 
> addressee(s) listed above.  Unauthorized review, dissemination or other use 
> of the information contained in this transmission is strictly prohibited. 
> If you have received this transmission in error or have reason to believe 
> you are not authorized to receive it, please notify the sender by return 
> email and promptly delete the transmission.

Can you please remove this functionality?

Thanks,
-- 
Jean Delvare

