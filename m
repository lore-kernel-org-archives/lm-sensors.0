From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 30 Mar 2006 02:56:51 +0000
Subject: [lm-sensors] [patch] hwmon: Add support for w83791d sensor chip
Message-Id: <5bfe43f80603291856o77a2b5a5j5b6e295060bd1af2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
In-Reply-To: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 3/28/06, Jean Delvare <khali at linux-fr.org> wrote:
...
>
> This is something new, not in 2.6.16. You'll have to take a look at
> Linus' latest (2.6.16-git14 right now) or any recent -mm. There's no
> macro named SENSOR_ARRAY, by the way, but Rudolf was obviously
> referring to the possibility to define sysfs files within arrays rather
> than individually, so that they are then easier to instanciate. This is
> done using the SENSOR_ATTR and SENSOR_ATTR_2 macros. You can find
> examples of use in the following drivers:
>   f71805f
>   pc87360
>   w83627ehf
>   w83792d

Thanks! Found it (and the macro definitions in <linux/hwmon-sysfs.h>).
Will update to use these...

...
>
> >
> > Do you mean the serial bus address register (index 0x48)? Don't I
> > already know the address of the device based on the reads that I'm
> > doing? Or are you saying I should confirm that the address register
> > has an address that matches the address of the reads that I'm doing?
>
> Yes, verifying that register 0x48 holds the address is a good safety
> check. If it doesn't, then you know that it cannot be a W83791D chip,
> and this avoids a chip misdetection. Many other drivers do that
> (adm9240, it87, lm78, w83627hf, w83781d, w83792d.)

OK, will do.

