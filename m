From: Vadim Zeitlin <vz-sensors@zeitlins.org>
Date: Sat, 14 Jul 2007 15:00:34 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <loom.20070714T164807-527@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede <j.w.r.degoede <at> hhs.nl> writes:

> I assume this means sofar you've only been testing by catting sysfs files? In 
> that case it is a good idea to test with the 3.0.0 branch of lm_sensors, which 
> on longer needs support code for each chip, instead it "queries" sysfs to find 
> out what features a chip has.

 Hello again,

 I've just tried to do this with rev 4608 and I was getting a lot of errors like
this:

libsensors error, more sensors of one type then MAX_SENSORS_PER_TYPE, ignoring
feature: temp32_alarm

and the AMB sensors 2 and 3 were not being taken into account. Without knowing
anything about libsensors I thought it was because the file names in
/sys/devices/platform/i5k_amb.0 were named {temp0,temp16,temp32,temp48}_xxx and
not temp[1234] as usual and so I tested this trivial patch:

--- i5k_amb.c.orig      2007-07-14 16:52:42.000000000 +0200
+++ i5k_amb.c   2007-07-14 16:54:36.000000000 +0200
@@ -219,5 +219,5 @@
 static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
 {
-   int i, j, k;
+   int i, j, k, d = 0;
    u16 c;
    char *n;
@@ -250,7 +250,9 @@
                continue;

+           ++d;
+
            /* Temperature sysfs knob */
            n = kmalloc(13, GFP_KERNEL);
-           sprintf(n, "temp%d_input", k);
+           sprintf(n, "temp%d_input", d);
            data->attrs[data->num_attrs].dev_attr.attr.name = n;
            data->attrs[data->num_attrs].dev_attr.attr.mode @@ -267,5 +269,5 @@
            /* Temperature min sysfs knob */
            n = kmalloc(13, GFP_KERNEL);
-           sprintf(n, "temp%d_min", k);
+           sprintf(n, "temp%d_min", d);
            data->attrs[data->num_attrs].dev_attr.attr.name = n;
            data->attrs[data->num_attrs].dev_attr.attr.mode @@ -284,5 +286,5 @@
            /* Temperature mid sysfs knob */
            n = kmalloc(13, GFP_KERNEL);
-           sprintf(n, "temp%d_mid", k);
+           sprintf(n, "temp%d_mid", d);
            data->attrs[data->num_attrs].dev_attr.attr.name = n;
            data->attrs[data->num_attrs].dev_attr.attr.mode @@ -301,5 +303,5 @@
            /* Temperature max sysfs knob */
            n = kmalloc(13, GFP_KERNEL);
-           sprintf(n, "temp%d_max", k);
+           sprintf(n, "temp%d_max", d);
            data->attrs[data->num_attrs].dev_attr.attr.name = n;
            data->attrs[data->num_attrs].dev_attr.attr.mode @@ -318,5 +320,5 @@
            /* Temperature alarm sysfs knob */
            n = kmalloc(13, GFP_KERNEL);
-           sprintf(n, "temp%d_alarm", k);
+           sprintf(n, "temp%d_alarm", d);
            data->attrs[data->num_attrs].dev_attr.attr.name = n;
            data->attrs[data->num_attrs].dev_attr.attr.mode 
and now everything seems to work fine for me except for the 2 problems mentioned
in my previous message (long delay when accessing the sensors and manifestly
incorrect values for temp[256]):

% sensors3
adt7470-i2c-0-2e
Adapter: SMBus I801 adapter at 18c0
fan1:       2015 RPM  (min =    0 RPM)
fan2:          0 RPM  (min =    0 RPM)
fan3:       1704 RPM  (min =    0 RPM)
fan4:       1545 RPM  (min =    0 RPM)
temp1:        +1.0 C  (low  = +129.0 C, high = +127.0 C)
temp2:      +229.0 C  (low  = +129.0 C, high = +127.0 C)
temp3:       +59.0 C  (low  = +129.0 C, high = +127.0 C)
temp4:       +54.0 C  (low  = +129.0 C, high = +127.0 C)
temp5:      +227.0 C  (low  = +129.0 C, high = +127.0 C)
temp6:      +228.0 C  (low  = +129.0 C, high = +127.0 C)
temp7:       +59.0 C  (low  = +129.0 C, high = +127.0 C)
temp8:       +55.0 C  (low  = +129.0 C, high = +127.0 C)
temp9:       +50.0 C  (low  = +129.0 C, high = +127.0 C)
temp10:      +49.0 C  (low  = +129.0 C, high = +127.0 C)

i5k_amb-isa-0000
Adapter: ISA adapter
temp1:       +78.5 C  (low  = +106.0 C, high = +124.0 C)
temp2:       +75.0 C  (low  = +106.0 C, high = +124.0 C)
temp3:       +64.5 C  (low  = +106.0 C, high = +124.0 C)
temp4:       +63.5 C  (low  = +106.0 C, high = +124.0 C)

 I hope this information can be useful,
VZ


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
