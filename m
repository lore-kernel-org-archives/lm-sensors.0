From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 14 May 2006 08:01:03 +0000
Subject: [lm-sensors] Support for Fintek F71872F
Message-Id: <20060514100103.f9671055.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464D0B8.8070203@drzukov.is-a-geek.org>
In-Reply-To: <4464D0B8.8070203@drzukov.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jure,

> I have an Epox 9NPA7I board that uses the F71872F chip. The CVS version 
> of sensors-detect returns:
> 
> Driver `f71805f' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0295 (Busdriver `i2c-isa')
>     Chip `Fintek F71872F/FG Super IO Sensors' (confidence: 9)
> 
> However I am unable to successfully insert the f71805f module for the 
> 2.6.16 kernel. How much work still has to be done to support the F71872F 
> chip? I'd be willing to program the support myself, but I would need a 
> few pointers and the necessary documentation.

No surprise here. I listed the Fintek F71872F chip as supported by the
f71805f driver in sensors-detect because I know that the F71805F and
F71872F are essentially compatible. However, the driver currently
doesn't have actual support for your chip.

I have an F71872F datasheet, which I can send to you. You are welcome to
work on this. Adding support for the F71872F chip should be easy. First
thing to do is to add the F71872F chip ID (definition and use in
f71805f_find()). This will let the driver load and detect your chip. If
I remember correctly, the additional features of the F71872F over the
F71805F are:
* Three more voltage inputs
* VID pins
So you can then add support for this in the driver. You'll have to keep
track of the chip type somehow, so that you don't create sysfs
interface files for features which do not exist in a given chip. Don't
forget to update the documentation (Documentation/hwmon/f71805f). When
done, please submit your work as a patch against the latest -mm kernel.

When you're done with the driver, you'll have to update the user-space
part. Here again it should be really simple, mostly copy-n-paste work.
See how the F71805F is supported in libsensors (lib subdirectory in
lm_sensors) and do the same for the F71872F. Please reuse the F71805F
constants wherever possible. Same for the sensors program (prog/sensors
subdirectory in lm_sensors.) You should be able to keep most code in
common here. Last is the configuration file (etc/sensors.conf.eg). When
done, please submit your work as a patch against lm_sensors CVS.

Once you're done with all this, you may notice that the driver lacks
support for fan speed control, while both the F71805F and the F71872F
chips do support this. I didn't have the time to implement it when
writing the driver in the first place. If you want to work on this,
you're welcome.

If you have any problem or question, just ask and I'll try to help.

Thanks,
-- 
Jean Delvare

