From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Jul 2015 16:07:29 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON:  FTW Extensions for NCT6683
Message-Id: <55BA4BC1.3020301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2015 08:45 AM, Todd Sperry wrote:
> This patch contains extensions for the NCT6683 hwmon driver for Ethernet Bypass, sometimes referred
> to as Fail To Wire (FTW).  FTW is a new feature on SuperMicro motherboards supported by the Nuvoton
> NCT6683D SuperIO chip.  The NCT6683D supports controlling a set of motherboard relays that open or
> close pairs of Ethernet ports.  The extensions found here have been shipping in productions systems for
> at least the last 18 months.
>
> Signed-off-by:  Todd Sperry <todd.sperry@outlook.com <mailto:todd.sperry@outlook.com>>
>

Todd,

I don't necessarily object to moving the driver into its own subdirectory. If you do so,
please to it in two steps, one to move the driver and one with your additions.

That is a minor problem, however. Checkpatch reports

total: 405 errors, 78 warnings, 3175 lines checked

NOTE: Whitespace errors detected.
       You may wish to use scripts/cleanpatch or scripts/cleanfile

checkpatch --strict reports another 56 check messages.

Please fix this up before resubmitting. Documentation/hwmon/submitting-patches
might be quite useful to provide guidelines.

Note that it may make more sense to separate the guide-to-wire code into a completely
separate driver (possibly by converting the driver into an mfd driver, with hwmon
and guide-to-wire slave drivers). That is also secondary, though; first your code
will have to be in a shape that lets us review it without getting stuck with coding
stye problems.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
