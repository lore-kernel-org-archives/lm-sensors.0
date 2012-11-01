From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Nov 2012 16:37:57 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121101173757.2c071547@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 Nov 2012 06:40:51 -0700, Guenter Roeck wrote:
> On Thu, Nov 01, 2012 at 01:56:07PM +0100, Jean Delvare wrote:
> > On Mon, 29 Oct 2012 10:28:30 -0700, Guenter Roeck wrote:
> > > The BIOS, presumably. It does it on my board, but wrongly. It sets it
> > > to 97 degrees C, while the CPU's Tcrit is 105 degrees C. I fixed the
> > > offset to 105, and now the reported temperature matches the CPU temperature
> > > (and moves with it). This is how I found out about PECI support in the
> > > first place.
> > 
> > In which register is the PECI temperature offset value stored? I am
> > looking at the IT8720F datasheet and I can't find it.
>
> On IT8728F it is in the diode zero degree adjust registers.
> I found this from experiments; it is not mentioned in the datasheet.
> I would guess it is the same on the other chips, though I can not test
> it on those.

On an IT8720F chip with temp3 configured for PECI:

temp1_offset: 0
temp2_offset: 0
temp3_offset: -128000

I'm unsure how to interpret this -128000... This value is definitely
not neutral, doesn't sound very realistic. I would expect a positive
number for PECI. Maybe the offset register should be treated as
unsigned in PECI mode? Or maybe its value is irrelevant for the IT8720F
in PECI mode.

# grep . /sys/class/hwmon/hwmon2/device/temp3*
/sys/class/hwmon/hwmon2/device/temp3_alarm:0
/sys/class/hwmon/hwmon2/device/temp3_beep:1
/sys/class/hwmon/hwmon2/device/temp3_input:25000
/sys/class/hwmon/hwmon2/device/temp3_max:70000
/sys/class/hwmon/hwmon2/device/temp3_min:127000
/sys/class/hwmon/hwmon2/device/temp3_offset:-128000
/sys/class/hwmon/hwmon2/device/temp3_type:6

This is with an it87 driver including all your recent patches. It you
have ideas or theories, I'm interested.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
