From: jcromie@divsol.com (Jim Cromie)
Date: Sat, 13 Aug 2005 05:55:03 +0000
Subject: [lm-sensors] pc87360  voltage reference constants
Message-Id: <42FD6F06.7040202@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FCC357.1000802@divsol.com>
In-Reply-To: <42FCC357.1000802@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>  
>
>>Im looking to understand why my temps are so high,
>>esp in comparison to values from my soekris as obtained from
>>http://phk.freebsd.dk/soekris/env4801/
>>
>>    VREF = 1.214  V245 = 2.450
>>    Temp 2 (status=0x81)   54 C
>>
>>in your code,
>>
>>        data->in_vref = (i&0x02) ? 3025 : 2966;
>>        dev_dbg(&new_client->dev, "Using %s reference voltage\n",
>>            (i&0x02) ? "external" : "internal");
>>
>>youve got 2 magical constants,  where are they from ?
>>I cant find mention of them in the pdf,
>>    
>>
>
>3.025 is 1.235 * 2.45. Page 227 of the datasheet mentions internal Vref
>= 1.235V, and at page 180, section 11.3.2 has: "Analog input voltage is
>measured relative to 2.45 * Vref".
>
>In section 14.4.1, external Vref is given at 1.211V, and full scale is
>given at 2.097, which happens to be 1.211 * 2.45.
>
>This is where the numbers are coming from. 
>
thanks for the (patient) orientation.  Theres a lot to miss/get in a 230 
page spec.
(Ill admit, I did a literal search.)

>Now I always found it strange
>that you could pick an external voltage with a *lower* value than the
>internale voltage, and not much lower at that. Remember that I do not
>have a PC87366 chip myself, so had no chance to measure the physical
>values at a chip's pins to confirm that the driver does the right thing.
>  
>
>If you are using an external reference, and it is NOT 1.211 volt, then I
>am not surprised if your voltages are not correct.
>  
>
Ahh.  I believe Ive found a bug.
the ? : assignment above chooses the larger number for the external vref,
which disagrees with your explanation, and the doc refs.

So attached patch fixes that,
and adds 3 module_params
    vrefext   allows changes to accommodate different boards
    vrefscale   allows +/-50mv around nominal 2450 mv
    vrefint    - not entirely necessary, for real tweakers.

BTW, board uses external ref, and is 1.211v (per PHK's measures)
I havent checked vrefext for myself.  Im getting numbers in close 
correspondence
with PHKs.

I'll trim it back (the params) to suit.

FWIW, this module-side tweak could be avoided by hacking sensors.conf
but its ugly to work vref scaling into ALL the voltage formulas,
and thermistors too.

I gather one can use inputs as factors in computations too, but the man-page
shows no way of adding new symbolic constants. (I added this as a 
support ticket
so it doent get lost b4 the libsensors rewrite)

other thought was to add a new sysfs node - a vref-set-point.
This makes it easy to tweak the scaling/calcs done by the drivers,
so is transparent to sensors.conf, keeping it less cluttered than constants.
But perhaps this is too available for disciplined use;
the mod-param can be set once in /etc/modprobe.d/sensors, and forgotten.


>Note that the reference voltage is used to compute the voltages and the
>thermistor-based temperatures, NOT the diode-based temperatures. The TMS
>logical device is influenced by the reference voltage, but the value
>isn't used in computations AFAIR.
>
>  
>
yes - thats what I meant by saying:
    I think my temp answers lie elsewhere (perhaps a cast to s8 for the 
register value),

BTW, you recall correctly;
for thermistors:
#define IN_FROM_REG(val,ref)            (((val) * (ref) + 128) / 256)
for diodes:
#define TEMP_FROM_REG(val)              ((val) * 1000)

but that still leave me with an impossibly high value for a low-power, 
fanless cpu

>>BTW, (since Im writing),  my patchset for pc87366 sensors-dev-attrs
>>(done against rc4-mm1), also applies (clean, iirc) to rc5-mm1, and
>>works  there.
>>    
>>
>
>I'm sorry, I didn't have the time to look at it yet. I'm currently busy
>with i2c core changes and other drivers (i2c-viapro and it87.) Please be
>patient.
>
>  
>
I can see youre busy, I hope my update wasnt an annoyance, however 
momentary.
In any case, I gather that 13-rcX is closed for all new features, so I 
regard it was info only.
Ill revalidate when 13-final is out, and update if needed.
-------------- next part --------------
diff -ruNp -X exclude-diffs ../linux-2.6.13-rc5-mm1/drivers/hwmon/pc87360.c vref-option/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc5-mm1/drivers/hwmon/pc87360.c	2005-08-07 13:17:29.000000000 -0600
+++ vref-option/drivers/hwmon/pc87360.c	2005-08-12 20:35:55.000000000 -0600
@@ -60,6 +60,26 @@ MODULE_PARM_DESC(init,
  " 2: Forcibly enable all voltage and temperature channels, except in9\n"
  " 3: Forcibly enable all voltage and temperature channels, including in9");
 
+static int vrefint = 1235;
+module_param(vrefint, int, 0);
+MODULE_PARM_DESC(vrefint,
+		 " Internal Voltage Reference, specd at 1235 mV\n"
+		 "   Do not change unless you know what you're doing\n");
+
+static int vrefext = 1211;
+module_param(vrefext, int, 0);
+MODULE_PARM_DESC(vrefext,
+		 " External Voltage Reference, specd at 1211 mV\n"
+		 "   measure your actual value before changing!\n");
+
+static int vrefscale = 2450;
+module_param(vrefscale, int, 0);
+MODULE_PARM_DESC(vrefscale,
+		 " Voltage Reference Scale (2450mV nominal +/- 50mV)\n"
+		 "   overridden values are clamped: 2400mV .. 2500mV\n");
+
+#define VREFSCALE 1000	/* mV per volt, */
+
 /*
  * Super-I/O registers and operations
  */
@@ -798,7 +818,11 @@ static int pc87360_detect(struct i2c_ada
 			i &= pc87360_read_value(data, LD_TEMP, NO_BANK,
 						PC87365_REG_TEMP_CONFIG);
 		}
-		data->in_vref = (i&0x02) ? 3025 : 2966;
+		data->in_vref = ((i&0x02) /* vrefs are in milliVolts */
+				 ? (vrefext * vrefscale)
+				 : (vrefint * vrefscale)
+				 ) / VREFSCALE; /* avoided rounding errs */
+
 		dev_dbg(&new_client->dev, "Using %s reference voltage\n",
 			(i&0x02) ? "external" : "internal");
 
@@ -1301,6 +1325,10 @@ static int __init pc87360_init(void)
 {
 	int i;
 
+	/* clamp vrefscale 2450mV +- 50mV */
+	vrefscale = (vrefscale<2400) ? 2400 : vrefscale;
+	vrefscale = (vrefscale>2500) ? 2500 : vrefscale;
+
 	if (pc87360_find(0x2e, &devid, extra_isa)
 	 && pc87360_find(0x4e, &devid, extra_isa)) {
 		printk(KERN_WARNING "pc87360: PC8736x not detected, "
