From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Apr 2015 03:36:19 +0000
Subject: Re: [lm-sensors] [PATCH] (gpio-fan): Move the thermal registration after registration is complete
Message-Id: <5525F3B3.2000208@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428535432-8153-1-git-send-email-nm@ti.com>
In-Reply-To: <1428535432-8153-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On 04/08/2015 04:23 PM, Nishanth Menon wrote:
> Thermal framework may already be ready and cooling policies might
> already be functional when we are attempting to register gpio fan as
> a cooling device. This can be reproduced by changing probe order in
> which registration of various modules are done in a system. In such
> a case, kernel generates an oops since the data structures are not
> completely populated with the wrong assumption that thermal framework
> is not yet ready. Fix this by reordering the thermal framework
> registration to occur after hwmon registration of the fan is complete.
>
> Example kernel oops:
> [  149.005828] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000008c
> [  149.014369] pgd =3D ecf48000
> [  149.017204] [0000008c] *pgd=AC065831, *pte=00000000, *ppte=00000000
> [  149.023820] Internal error: Oops: 17 [#1] SMP ARM
> [  149.028745] Modules linked in: gpio_fan(+) cpufreq_dt ipv6 evdev leds_=
gpio led_class omap_wdt phy_omap_usb2 rtc_palmas palmas_pwrbutton tmp102 ti=
_soc_thermal dwc3_omap thermal_sys extcon rtc_omap rtc_ds1307 hwmon
> [  149.048629] CPU: 1 PID: 1183 Comm: modprobe Not tainted 4.0.0-rc7-next=
-20150407-00002-g7a82da074c99 #3
> [  149.058383] Hardware name: Generic DRA74X (Flattened Device Tree)
> [  149.064763] task: edec1240 ti: ec0e0000 task.ti: ec0e0000
> [  149.070421] PC is at dev_driver_string+0x0/0x38
> [  149.075165] LR is at __dev_printk+0x24/0x70
> [  149.079540] pc : [<c03d6cd0>]    lr : [<c03d72c4>]    psr: 20000013
> [  149.079540] sp : ec0e1c28  ip : edec1240  fp : 00000000
> [  149.091568] r10: edf3eee0  r9 : 00000000  r8 : ffffffff
> [  149.097040] r7 : edf3eea0  r6 : 00000034  r5 : 00000010  r4 : ec0e1c44
> [  149.103871] r3 : ec0e1c4c  r2 : ec0e1c44  r1 : c079d800  r0 : 00000010
> [  149.110709] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
> [  149.118182] Control: 10c5387d  Table: acf4806a  DAC: 00000015
> [  149.124198] Process modprobe (pid: 1183, stack limit =3D 0xec0e0218)
> [  149.130673] Stack: (0xec0e1c28 to 0xec0e2000)
> [  149.135235] 1c20:                   60000013 c05e2ae0 00000000 edf3ec0=
0 ec934a10 c03d73d4
> ...
> [  149.392230] 1fe0: befe1888 befe1878 00019418 b6ea08f0 80000010 0000000=
3 00000000 00000000
> [  149.400798] [<c03d6cd0>] (dev_driver_string) from [<c03d72c4>] (__dev_=
printk+0x24/0x70)
> [  149.409193] [<c03d72c4>] (__dev_printk) from [<c03d73d4>] (dev_warn+0x=
34/0x48)
> [  149.416767] [<c03d73d4>] (dev_warn) from [<bf0f54fc>] (get_fan_speed_i=
ndex+0x94/0xa4 [gpio_fan])
> [  149.425980] [<bf0f54fc>] (get_fan_speed_index [gpio_fan]) from [<bf0f5=
524>] (gpio_fan_get_cur_state+0x18/0x30 [gpio_fan])
> [  149.437476] [<bf0f5524>] (gpio_fan_get_cur_state [gpio_fan]) from [<bf=
02767c>] (thermal_zone_trip_update+0xe8/0x2a4 [thermal_sys])
> [  149.449794] [<bf02767c>] (thermal_zone_trip_update [thermal_sys]) from=
 [<bf027844>] (step_wise_throttle+0xc/0x74 [thermal_sys])
> [  149.461832] [<bf027844>] (step_wise_throttle [thermal_sys]) from [<bf0=
24ff4>] (handle_thermal_trip+0x5c/0x188 [thermal_sys])
> [  149.473603] [<bf024ff4>] (handle_thermal_trip [thermal_sys]) from [<bf=
0256c4>] (thermal_zone_device_update+0x94/0x108 [thermal_sys])
> [  149.486104] [<bf0256c4>] (thermal_zone_device_update [thermal_sys]) fr=
om [<bf026470>] (__thermal_cooling_device_register+0x2e8/0x374 [thermal_sys=
])
> [  149.499956] [<bf026470>] (__thermal_cooling_device_register [thermal_s=
ys]) from [<bf0f58e4>] (gpio_fan_probe+0x350/0x4d0 [gpio_fan])
> [  149.512438] [<bf0f58e4>] (gpio_fan_probe [gpio_fan]) from [<c03db8a0>]=
 (platform_drv_probe+0x48/0x98)
> [  149.522109] [<c03db8a0>] (platform_drv_probe) from [<c03da30c>] (drive=
r_probe_device+0x1b0/0x26c)
> [  149.531399] [<c03da30c>] (driver_probe_device) from [<c03da45c>] (__dr=
iver_attach+0x94/0x98)
> [  149.540238] [<c03da45c>] (__driver_attach) from [<c03d8bb0>] (bus_for_=
each_dev+0x54/0x88)
> [  149.548814] [<c03d8bb0>] (bus_for_each_dev) from [<c03d9a34>] (bus_add=
_driver+0xdc/0x1d4)
> [  149.557381] [<c03d9a34>] (bus_add_driver) from [<c03dac30>] (driver_re=
gister+0x78/0xf4)
> [  149.565765] [<c03dac30>] (driver_register) from [<c0009784>] (do_one_i=
nitcall+0x80/0x1d8)
> [  149.574340] [<c0009784>] (do_one_initcall) from [<c00c2278>] (do_init_=
module+0x5c/0x1b8)
> [  149.582833] [<c00c2278>] (do_init_module) from [<c00c3bbc>] (load_modu=
le+0x1720/0x1dcc)
> [  149.591212] [<c00c3bbc>] (load_module) from [<c00c43d0>] (SyS_finit_mo=
dule+0x68/0x6c)
> [  149.599418] [<c00c43d0>] (SyS_finit_module) from [<c000f3c0>] (ret_fas=
t_syscall+0x0/0x4c)
> [  149.607994] Code: 15830000 e1a00006 e28dd008 e8bd8070 (e590307c)
>
> Cc: Eduardo Valentin <edubezval@gmail.com>
>
> Fixes: b5cf88e46bad ("(gpio-fan): Add thermal control hooks")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
