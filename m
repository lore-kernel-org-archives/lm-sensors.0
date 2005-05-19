From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: libsensors completed for 2.6
Message-Id: <20031120063916.GB30286@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FBADC0E.6C375D56@paradyne.com>
In-Reply-To: <3FBADC0E.6C375D56@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-11-18 21:57:18 -0500]:

> except for those drivers with non-standard feature names in lib/chips.c.
> 
> I wrote a conversion function that converts all standard libsensors
> feature names
> (i.e. those that match the /proc names documented in
> doc/developers/proc) to
> the standard sysfs file names
> (i.e. those that are documented in Documentation/i2c/sysfs_interface),
> and the standard magnitudes documented there.
> 
> This saves about as much typing in lib/chips.c as I know how to save.
> 
> I know that Khali is working on additional standardization and changes.
> These will have to be reflected in the function getsysname() in
> lib/proc.c.
> 
> What's remaining is typing in the sysfs names for those features using
> non-standard names (e.g. "3.3V").
> 
> But the majority of chips should just magically work now. Please test.
> I'll announce it on the home page later in the week.
> 
> Thanks to Danny for the great patch which got me started.

Again, just a quick smoke test... more to come later.  ASB100 (w83781d)
works mostly, with this output:

as99127f-i2c-0-2d
Adapter: SiS96x SMBus adapter at 0xe600
Algorithm: Unavailable from sysfs
VCore 1:   +1.52 V  (min =  +1.42 V, max =  +1.57 V)              
VCore 2:   +1.52 V  (min =  +1.42 V, max =  +1.57 V)              
+3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.46 V)              
+5V:       +5.03 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:     +11.13 V  (min = +10.82 V, max = +13.19 V)              
-12V:     -11.63 V  (min =  -0.00 V, max =  -0.00 V)              
-5V:       -4.41 V  (min =  -0.00 V, max =  -0.00 V)              
fan1:     2689 RPM  (min = 3000 RPM, div = 2)                     
fan2:     4655 RPM  (min = 3000 RPM, div = 2)                     
fan3:     4560 RPM  (min = 3000 RPM, div = 2)                     
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
vid:      +1.500 V
alarms:   
beep_enable:
          Sound alarm enabled

I tested against 2.6.0-test9 with Khali's recent patch applied - I assume
for now that this is the cause of the temp errors (looking for min instead
of hyst).

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
