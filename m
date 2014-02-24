From: Leandro de Marco <leandromarco@gmail.com>
Date: Mon, 24 Feb 2014 22:14:23 +0000
Subject: [lm-sensors] BMR456/457
Message-Id: <CAFO4QpDpm2NbouBm6yhZ_eHUuAkFqOji5bqCQJOC+JNqWcfmXQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi. First I would like to thank you  in advance for your attention.

The company I work for, is developing a HW that will use the ericson
BMR456 Bus converter.

Unfortunately, this chip is not listed on the lm-sensors list of
devices supported.

It is under my responsibility to make it work, and I was studying the
pmbus kernel drivers and comparing the existing modules, as well as
taking a look on their datasheet.

I am an experienced C programmer, but new to the device driver world.
I am having some doubts, and would like to ask for some help.

I noticed that the pmbus generic driver has support for the BMR453/454 chip.

Comparing these chips, I noticed that they seem to be very similar. At
first, I saw that the BMR456/457 uses the direct data format for some
PMBUS commands. Later I realized that such commands are not classified
on any of the sensor classes (like PSC_VOLTAGE_OUT, PSC_CURRENT_OUT,
etc) that are indexes in the direct, m, b and r fields of the
pmbus_driver_info struct.

Some of these PMBUS commands that uses the direct data format on the
chip aren't even listed at pmbus.h. Anyway, I won't need those
commands.

With my limited pmbus knowledge I am starting to figure out that the
BMR456/457 can be operated with the generic pmbus driver.

As far as I understand, all I would need to do is add a bmr456 and
bmr457 to the pmbus_id struct of the pmbus.c source file.

Is this ok? Or am I missing something?

Many thanks

Leandro
--------------------------------------------------------------------------
My Mind is Not for Rent.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
