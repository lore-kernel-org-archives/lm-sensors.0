From: pwilsmore@asi.com.au (Peter Wilsmore)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: bmcsensors and strange sensor values.
Message-Id: <45A0FF82385BEB4C8670E255530B3385ACDAE3@mssydeb.asi.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
In-Reply-To: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry, I forgot to include the bit to get rid of the warning that nonlinear function 7 is not support.

Thanks,

Peter Wilsmore
 
ASI SOLUTIONS
Direct: 1300130 837

-----Original Message-----
From: Peter Wilsmore 
Sent: Thursday, 9 September 2004 11:21 AM
To: 'Mark Studebaker'
Cc: lm78@Stimpy.netroedge.com
Subject: RE: bmcsensors and strange sensor values.

OK, I have got rid of the float stuff - it makes it much more elegant. I have also used the 'upper' limit for the lower limit and have some comments in regarding the odd values and * 2 factor that I seem to have on my M/B. Unfortunately I am on a deadline, so I haven't done any limit stuff.

Thanks for all the help.

Peter Wilsmore
 
ASI SOLUTIONS
Direct: 1300130 837

-----Original Message-----
From: Mark Studebaker [mailto:mds4@verizon.net] 
Sent: Thursday, 9 September 2004 10:22 AM
To: Peter Wilsmore
Cc: lm78@Stimpy.netroedge.com
Subject: Re: bmcsensors and strange sensor values.

your code looks functionally correct
since from your previous dmesg output we know m) and k2=9 (i.e. k2=-7 signed)
a raw limit reading of 1 yields a limit of 1/((29 * 1 * 10**-7) = 344827.

The fan readings look too high by a factor of 2 but that again could be a mistake in the BMC SDR.

So again, as with the voltage limits, I don't think the limits are set correctly in the BMC.
Perhaps other limits (non-critical?) are set correctly. You may want to try one of the SDR dumper tools out there,
or add more printk's to the driver to see what they are.
I think the IPMI site may have some pointers to tools.

For coding style, you'll of course want to get rid of the duplicate code.
Floating point is also not allowed in the kernel.
As a way around it, when the function is 1/x, it may be safe to assume that 10**k2 is a very small number
and do 1/x of it separately by flipping the exponent (k2 = 16- k2).

If you're quite ambitious you could try implement limit setting, if of course your BMC supports it.

mds




Peter Wilsmore wrote:
> Thanks for the suggestions. I am trying to hack the changes into bmcsensors as you suggested:
>  
>  
> static long conv_val(int value, struct sdrdata *sd)
> {
>         u8 k1, k2;
>         long r;
>         float temp;
>         r = value * sd->m;
>         k1 = sd->k & 0x0f;
>         k2 = sd->k >> 4;
>         if(k1 < 8)
>                 r += sd->b * exps[k1];
>         else
>                 r += sd->b / exps[16 - k1];
>         r *= exps[decplaces(sd)];
>         if(k2 < 8)
>                 r *= exps[k2];
>         else
>                 r /= exps[16 - k2];
>         if(sd->linear = 7) {
>                 temp = value * sd->m;
>                 k1 = sd->k & 0x0f;
>                 k2 = sd->k >> 4;
>                 if(k1 < 8)
>                         temp += sd->b * exps[k1];
>                 else
>                         temp += sd->b / exps[16 - k1];
>                 temp *= exps[decplaces(sd)];
>                 if(k2 < 8)
>                         temp *= exps[k2];
>                 else
>                         temp /= exps[16 - k2];
>                 r = 1 / temp;
>         }
>         return r;
> }
>  
> The temp variable probibly isn't necessary but I didn't want to have any acuracy loss from using float and coverting to int on the other sensors. After these changes though, I still seem to be getting odd results on the fan speed (at least I am getting something now though)
>  
> output from sensors (the rest is irrelivent - its all working properly from the looks of it.):
>  
> fan1:     9852 RPM  (min = 344827 RPM)
> fan2:     11494 RPM  (min = 344827 RPM)
> fan3:     6896 RPM  (min = 344827 RPM)
> fan4:     11494 RPM  (min = 344827 RPM)
> fan5:     11123 RPM  (min = 344827 RPM)
>  
> Slap me with a wet fish and call me stupid, but I don't think 344627 RPM is the minumium speed for the fans ;P, the chassis would take off if they were running at that speed. Not to mention the actual reading seem a little high (half that maybe?). Am I missing something here? From what I have been able to understand of my reading of the APMI spec fans do sometimes use an upper and lower threshold but the bmcsensors code seems to ingore that. Could that be what is going wrong?
>  
> thanks,
>   Peter
> 
>  
> ________________________________
> 
> From: Mark Studebaker [mailto:mds4@verizon.net]
> Sent: Wed 8/09/2004 9:38 AM
> To: Peter Wilsmore
> Cc: lm78@Stimpy.netroedge.com
> Subject: Re: bmcsensors and strange sensor values.
> 
> 
> 
> your modules are fine.
> 
> Non-linear function 7 is 1/x, according to the IPMI spec, which can be handled without floating point, so
> support could be added. Feel free to send a patch. You'll need the IPMI spec for reference.
> You're the first to report this.
> 
> The voltages look fine. the voltage limits are too far away from the nominal to be useful but that
> may just be the way the BMC is programmed. Perhaps the 'non-critical thresholds' would be better for you.
> That would take a bmcsensors.c mod.
> 
> The temp. hysteresis value isn't present, I don't think (the module looks for this first), so the module is using the lower temperature limit,
> but the 'sensors' program is reporting it as a hysteresis (it assumes the vaule will be a hysteresis value).
> You'll have to change 'sensors' to report it correctly.
> 
> mds
> 
> 
> Peter Wilsmore wrote:
> 
>>Hi,
>>
>>I have been struggling with patching RHEL kernel 2.4.21 with lm-sensors so I can read the temperature/fan/voltage readings from a MSI-9549 M/B which according to a spec sheet from MSI uses IPMI1.5 with a bmc chip with all the standard values. I have finnally managed to get lm-sensors to compile against 2.4.21-EL. I have loaded all the drivers that are recommended from sensors-detect and a few others that I have read are required for the bmcsensors module to work:-
>>
>>The relivent bits from sensors-detect are:
>>
>>Driver `bmcsensors' (should be inserted):
>>  Detects correctly:
>>  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
>>    Chip `IPMI BMC KCS' (confidence: 4)
>>
>>#----cut here----
>># I2C adapter drivers
>>modprobe i2c-amd756
>>modprobe i2c-isa
>># I2C chip drivers
>>modprobe eeprom
>>modprobe bmcsensors
>># sleep 2 # optional
>>/usr/local/bin/sensors -s # recommended
>>
>>So I have loaded the following modules:
>>
>>bmcsensors
>>i2c-proc
>>ipmi_kcs_drv
>>i2c-isa
>>i2c-ipmi
>>ipmi_msghandler
>>i2c-dev
>>i2c-amd756
>>i2c-core
>>
>>but /var/log/messages reports:
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 14: nonlinear function 0x07 unsupported, expect bad results
>>
>>for all the fan sensors, and comes back with strange results for most of the rest of the values:
>>
>>bmc-ipmi-0000
>>Adapter: Dummy adapter
>>in1:       +8.00 V  (min =  +2.02 V, max = +14.11 V)
>>in2:       +1.52 V  (min =  +0.38 V, max =  +2.69 V)
>>in3:       +1.65 V  (min =  +0.42 V, max =  +2.91 V)
>>in4:       +3.30 V  (min =  +0.83 V, max =  +5.82 V)
>>in5:       +1.52 V  (min =  +0.38 V, max =  +2.69 V)
>>in6:       +2.57 V  (min =  +0.42 V, max =  +2.91 V)
>>in7:       +5.07 V  (min =  +0.83 V, max =  +5.82 V)
>>fan1:        0 RPM  (min =    0 RPM)
>>fan2:        0 RPM  (min =    0 RPM)
>>fan3:        0 RPM  (min =    0 RPM)
>>fan4:        0 RPM  (min =    0 RPM)
>>fan5:        0 RPM  (min =    0 RPM)
>>temp1:      +0.0?C  (high =   +48?C, hyst =    +5?C)
>>temp2:     +20.0?C  (high =   +48?C, hyst =    +5?C)
>>temp3:     +46.0?C  (high =   +97?C, hyst =    +5?C)
>>temp4:     +49.0?C  (high =   +97?C, hyst =    +5?C)
>>
>>I have tried both lm-sensors 2.8.7 and the cvs version from the web site.
>>
>>I am wondering if anyone can suggest how I can get lm-sensors to properly detect the values. Is there a module I am missing or some way of reading the values using the i2c-ipmb module? The sensors.conf file says that I don't need compute lines for bmcsensors, but do I need to add them? Can I include support for nonlinear functions on the bmcsensors modules easily? I have a pdf called MSI9549_IPMI_Spec from MSI if that might help, but it doesn't seem to have any details about the sensor values and it's 78 pages and a few meg so I haven't attached it..
>>
>>Any suggestions would be greatly appreciated.
>>
>>thanks,
>>
>>Peter
>>
>>
>>------------------------------------------------------------------------
>>
>>Sep  6 03:51:43 compute-0-0 kernel: i2c-amd756.o version 2.8.7 (20040611)
>>Sep  6 03:51:43 compute-0-0 kernel: bmcsensors.o: attach_adapter...
>>Sep  6 03:51:43 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x40000
>>Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: i2c /dev entries driver module version 2.8.7 (20040611)
>>Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'ISA main adapter' as minor 0
>>Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'IPMI adapter' as minor 1
>>Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'SMBus AMD756 adapter at 80e0' as minor 2
>>Sep  6 03:54:50 compute-0-0 kernel: bmcsensors.o sleeping a while
>>Sep  6 03:54:52 compute-0-0 kernel: bmcsensors.o sleeping again
>>Sep  6 03:54:54 compute-0-0 kernel: bmcsensors.o i2c cleanup
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o version 2.8.7 (20040611)
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x50000
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: Registered client, scanning for sensors...
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: reserve_sdr...
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
>>Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x40000
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: all sensors detected
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: building proc table
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 0: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp1 "TMP_S1"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 1: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp2 "TMP_S2"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 2: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp3 "TMP_P1"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 3: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp4 "TMP_P0"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 4: (type 0x02) (fmt=0; mc; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in1 "VLT12"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 5: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in2 "P1Vcpp"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 6: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in3 "P1V2.5"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 7: (type 0x02) (fmt=0; m&; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in4 "VSB5.0"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 8: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in5 "P0Vcpp"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 9: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in6 "P0V2.5"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 10: (type 0x02) (fmt=0; m&; b=0; k1=0; k2; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in7 "VLT5.0"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 11: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan1 "FAN_S2"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 11: nonlinear function 0x07 unsupported, expect bad results
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 12: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan2 "FAN_S4"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 12: nonlinear function 0x07 unsupported, expect bad results
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 13: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan3 "FAN_S1"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 13: nonlinear function 0x07 unsupported, expect bad results
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 14: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan4 "FAN_S3"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 14: nonlinear function 0x07 unsupported, expect bad results
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 15: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan5 "FAN_S5"
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 15: nonlinear function 0x07 unsupported, expect bad results
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: 0 reservations cancelled
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registered 4 temp, 7 volt, 0 current, 5 fan sensors
>>Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: bmcsensor thread done
>>
> 
> 
> 
> 
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: bmcsensors.patch
Type: application/octet-stream
Size: 1295 bytes
Desc: bmcsensors.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040909/05f9abec/bmcsensors.obj
