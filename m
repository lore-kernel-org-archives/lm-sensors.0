From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Porting the fscpos driver to 2.6
Message-Id: <20041219112753.76574df5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041217184827.36da6d90@bart.desire.ch>
In-Reply-To: <20041217184827.36da6d90@bart.desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

> Well, meanwhile I somehow managed to get a working driver based on the
> old fscpos code, ported the way lm78 was ported and added a real lot
> of code from the new fscher driver. It's read-only, as the only write
> function I implemented crashed my system (maybe I should listen to
> GCC's warnings) :). I don't think write support is extremely important
> - most users only want to see how how their CPU is - but as I get more
> familiar with C and the sensors world I'll add it.

Write support is important. Sometimes the chip defaults don't fit your
needs. Sometimes the BIOS messes with the chip configuration and limits
are less than usable.

By looking at how the fscher driver handles writes to the interface
files you should be able to get it working in fscpos. It's really the
same.

> The code is still messy, especially as I couldn't figure out how to
> add additional arguments to the functions (eg. a "nr" argument for the
> show_fan_status in order to have one function for all three fans - not
> a function per fan). As time passes, I might find out more about C and
> do it right.

Sysfs callback functions have a fixed propotype, which doesn't include
any additional data. This is a significant difference (regression) with
the older procfs interface drivers had in Linux 2.4, where you could
have one callback function for several files.

This is the reason why you will see an import use of the preprocessor in
the newer drivers. It is frequent to define the callback functions as
preprocessor macros, which you then call as many times as needed. This
duplicates some code, of course. If the callback functions are small and
called frequently (typically read functions) we don't care much. If the
callback functions are larger and called less frequently (typically
write functions) we usually have only one real function with all the
code, and an extra parameter, and sysfs callback functions are
one-liners calling with one real function with the relevant extra
parameter.

You can find example of this in almost all the i2c chip drivers in Linux
2.6.

> There are also some masked bits in the fscher code which were
> different in the old fscpos driver. I'm going to contact the original
> fscpos author to find out where he got those values from and then
> probably use them.

Masks are very chip-dependent. You should keep the masks as they were in
the original fscpos driver.

BTW, if you find bugs in the original fscpos driver, please let us know
and we'll fix them.

> One issue I couldn't fix is the following: My code seems to get the
> temperatures right (the temp1_input and temp2_input files contain the
> correct values) but tools which rely on the sensors library keep
> getting wrong values ("sensors" shows 0.04?C instead of 39?C - a
> factor 1000 missing?). As I took that code (TEMP_FROM_REG) from the
> old fscpos driver I'm really puzzled. Do you have a clue?

I guess you didn't read i2c/sysfs-interface ;)

In Linux 2.6, sysfs files used by the i2c chip drivers use standardized
units and integer values (or actually fixed point). In Linux 2.4 we were
using floating point and magnitude was driver-dependant.

The units and magnitudes in 2.6 are as follow:
Temperatures: 0.001 degree C / bit (42 degrees C -> 42000)
Voltages: 0.001 V / bit (1.8 V -> 1800)

You have to respect this in your new driver.

Also note that libsensors may need to be instructed about the new fscpos
driver, or it might miss some interface files. The library has some code
to guess the new names from the old ones, but depending on how standard
the old ones were, it might be more or less efficient.

BTW, which 2.6 kernel are you using? There have been changes made to the
code very recently, which implied changes (simplifications actually) to
all chip drivers. So you would want to base your work on 2.6.10-rc3 if
you want us to integrate it in the main tree when you're done. The most
significant change I can think of is that normal_i2c_range and
normal_isa_range are gone (your driver wouldn't use it but still declare
them as empty - these declations must be removed.)

-- 
Jean Delvare
http://khali.linux-fr.org/
