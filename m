From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Mar 2006 10:01:51 +0000
Subject: [lm-sensors] [patch] hwmon: Add support for w83791d sensor chip
Message-Id: <20060328120151.4dfa4373.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
In-Reply-To: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

> Thanks! I'll start working on an updated patch.
> 
> I think I understand most of your issues, but I do have two questions:
> 
> 1) Do you have an example of the SENSOR_ARRAY style? I grep'ed for
> SENSOR_ARRAY in the 2.6.16 kernel and didn't see anything. Is this a
> concept (i.e. use arrays) or specific macro/code? Is there sample code
> you can point me to?

This is something new, not in 2.6.16. You'll have to take a look at
Linus' latest (2.6.16-git14 right now) or any recent -mm. There's no
macro named SENSOR_ARRAY, by the way, but Rudolf was obviously
referring to the possibility to define sysfs files within arrays rather
than individually, so that they are then easier to instanciate. This is
done using the SENSOR_ATTR and SENSOR_ATTR_2 macros. You can find
examples of use in the following drivers:
  f71805f
  pc87360
  w83627ehf
  w83792d

> 2) What did you mean by:
> 
> > +       /* Determine the chip type. */
> > +       if (kind <= 0) {
> > +               /* get vendor ID */
> > +               val2 = w83791d_read(new_client, W83791D_REG_CHIPMAN);
> > +               if (val2 != 0x5c) {     /* the vendor is NOT Winbond */
> > +                       goto ERROR1;
> > +               }
> > +               val1 = w83791d_read(new_client, W83791D_REG_WCHIPID);
> > +               if (val1 = 0x71 && address >= 0x2c) {
> >
> > Maybe you check the device adr and adr reg too
> 
> Do you mean the serial bus address register (index 0x48)? Don't I
> already know the address of the device based on the reads that I'm
> doing? Or are you saying I should confirm that the address register
> has an address that matches the address of the reads that I'm doing?

Yes, verifying that register 0x48 holds the address is a good safety
check. If it doesn't, then you know that it cannot be a W83791D chip,
and this avoids a chip misdetection. Many other drivers do that
(adm9240, it87, lm78, w83627hf, w83781d, w83792d.)

Thanks,
-- 
Jean Delvare

