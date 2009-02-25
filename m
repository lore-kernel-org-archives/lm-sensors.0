From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Feb 2009 15:22:11 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <20090225162211.40ada518@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Gong Jun,

On Wed, 25 Feb 2009 17:13:05 +0800, JGong@nuvoton.com wrote:
> Dear all,
> 
> >I suggest that you make a patch implementing what was said above. Then
> >Michael will test it and we'll see which of in6 or temp3 will be
> >created on his board. If in6 the problem is solved (as far as Michael's
> >system is concerned, at least.) If the incorrect temp3 is displayed
> >then we will have to think of a workaround. Either we check the
> >temperature value and discard it if it looks unreasonable, or we let
> >the user override the configuration manually as I initially proposed. I
> >think I prefer the second option. Choosing the configuration based on
> >the monitored values somehow voids the point of monitoring.
> >Please make sure you include my fan fixes into your patch:
> >http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025232.html
> 
> I've made the patch out with what we discussed above (including the fan fix from Jean). It has been tested on my ASUS P5QL PRO.
> 
> w83667hg-isa-0290
> Adapter: ISA adapter
> in0:         +1.01 V  (min =  +0.00 V, max =  +1.74 V)
> in1:         +1.69 V  (min =  +1.64 V, max =  +2.00 V)
> in2:         +3.33 V  (min =  +3.14 V, max =  +3.47 V)
> in3:         +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> in4:         +1.68 V  (min =  +0.02 V, max =  +0.35 V)   ALARM
> in5:         +2.04 V  (min =  +0.26 V, max =  +1.03 V)   ALARM
> in7:         +3.39 V  (min =  +3.14 V, max =  +3.47 V)
> in8:         +3.28 V  (min =  +3.14 V, max =  +3.47 V)
> fan1:          0 RPM  (min = 1318 RPM, div = 128)  ALARM
> fan2:       1875 RPM  (min = 1704 RPM, div = 8)
> fan3:          0 RPM  (min =    0 RPM, div = 128)  ALARM
> fan4:          0 RPM  (min = 5273 RPM, div = 128)  ALARM
> fan5:          0 RPM  (min = 10546 RPM, div = 128)  ALARM
> temp1:       +40.0°C  (high = +45.0°C, hyst = +40.0°C)  sensor = thermistor
> temp2:       +36.5°C  (high = +45.0°C, hyst = +40.0°C)  sensor = diode
> temp3:       +21.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> cpu0_vid:   +1.038 V
> 
> 
> To Michael:
> 	Please try it on your platform. I am looking forward to your response.
> 
> Best regards,
> Gong Jun

First of all, in order to make reviewing of future changes easier, I
think I will apply your initial patch now, except for the special
handling of in6. Then we can add a patch fixing the handling of in6, it
will be much smaller and thus much easier to review.

Some comments on your code:

> 
> 
> ---
>  w83627ehf.c |  150 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 99 insertions(+), 51 deletions(-)
> ---
> --- w83627ehf.c.orig	2009-02-25 00:07:24.000000000 +0800
> +++ w83627ehf.c	2009-02-26 00:41:58.000000000 +0800
> @@ -36,6 +36,7 @@
>      w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
>                                                 0x8860 0xa1
>      w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
> +    w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
>  */
>  
>  #include <linux/module.h>
> @@ -51,12 +52,13 @@
>  #include <asm/io.h>
>  #include "lm75.h"
>  
> -enum kinds { w83627ehf, w83627dhg };
> +enum kinds { w83627ehf, w83627dhg, w83667hg};
>  
>  /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
>  static const char * w83627ehf_device_names[] = {
>  	"w83627ehf",
>  	"w83627dhg",
> +	"w83667hg",
>  };
>  
>  static unsigned short force_id;
> @@ -70,6 +72,7 @@ MODULE_PARM_DESC(force_id, "Override the
>   */
>  
>  #define W83627EHF_LD_HWM	0x0b
> +#define W83667HG_LD_VID 	0x0d
>  
>  #define SIO_REG_LDSEL		0x07	/* Logical device select */
>  #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
> @@ -82,6 +85,7 @@ MODULE_PARM_DESC(force_id, "Override the
>  #define SIO_W83627EHF_ID	0x8850
>  #define SIO_W83627EHG_ID	0x8860
>  #define SIO_W83627DHG_ID	0xa020
> +#define SIO_W83667HG_ID 	0xa510
>  #define SIO_ID_MASK		0xFFF0
>  
>  static inline void
> @@ -288,6 +292,7 @@ struct w83627ehf_data {
>  	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
>  	u8 pwm_enable[4]; /* 1->manual
>  			     2->thermal cruise (also called SmartFan I) */
> +	u8 pwm_num;		/* number of pwm */
>  	u8 pwm[4];
>  	u8 target_temp[4];
>  	u8 tolerance[4];
> @@ -297,6 +302,8 @@ struct w83627ehf_data {
>  
>  	u8 vid;
>  	u8 vrm;
> +
> +	u8 en_temp3;
>  };
>  
>  struct w83627ehf_sio_data {
> @@ -1180,6 +1187,8 @@ static void w83627ehf_device_remove_file
>  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
>  		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
>  	for (i = 0; i < data->in_num; i++) {
> +		if ((i = 6) && (!strcmp(data->name, "w83667hg")) && !data->en_temp3)
> +			continue;

Using strcmp should be avoided, as it's relatively slow. You should
either keep the chip type in struct data, or use a dedicated field (for
example data->skip_in6).

>  		device_remove_file(dev, &sda_in_input[i].dev_attr);
>  		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
>  		device_remove_file(dev, &sda_in_min[i].dev_attr);
> @@ -1191,15 +1200,19 @@ static void w83627ehf_device_remove_file
>  		device_remove_file(dev, &sda_fan_div[i].dev_attr);
>  		device_remove_file(dev, &sda_fan_min[i].dev_attr);
>  	}
> -	for (i = 0; i < 4; i++) {
> +	for (i = 0; i < data->pwm_num; i++) {
>  		device_remove_file(dev, &sda_pwm[i].dev_attr);
>  		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
>  		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
>  		device_remove_file(dev, &sda_target_temp[i].dev_attr);
>  		device_remove_file(dev, &sda_tolerance[i].dev_attr);
>  	}
> -	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
> +	for (i = 0; i < ARRAY_SIZE(sda_temp); i++) {
> +		if (strstr(sda_temp[i].dev_attr.attr.name, "temp3")
> +                	&& (!strcmp(data->name, "w83667hg")) && data->en_temp3)
> +			continue;
>  		device_remove_file(dev, &sda_temp[i].dev_attr);
> +	}
>  
>  	device_remove_file(dev, &dev_attr_name);
>  	device_remove_file(dev, &dev_attr_cpu0_vid);
> @@ -1219,6 +1232,8 @@ static inline void __devinit w83627ehf_i
>  
>  	/* Enable temp2 and temp3 if needed */
>  	for (i = 0; i < 2; i++) {
> +		if (!strcmp(data->name, "w83667hg") && (i = 1))
> +			continue;
>  		tmp = w83627ehf_read_value(data,
>  					   W83627EHF_REG_TEMP_CONFIG[i]);
>  		if (tmp & 0x01)
> @@ -1271,8 +1286,10 @@ static int __devinit w83627ehf_probe(str
>  	data->name = w83627ehf_device_names[sio_data->kind];
>  	platform_set_drvdata(pdev, data);
>  
> -	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
> -	data->in_num = (sio_data->kind = w83627dhg) ? 9 : 10;
> +	/* 627EHG and 627EHF have 10 voltage inputs; DHG and 667HG have 9 */
> +	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
> +	/* 667HG has 3 pwms */
> +	data->pwm_num = (sio_data->kind = w83667hg) ? 3 : 4;
>  
>  	/* Initialize the chip */
>  	w83627ehf_init_device(data);
> @@ -1280,44 +1297,60 @@ static int __devinit w83627ehf_probe(str
>  	data->vrm = vid_which_vrm();
>  	superio_enter(sio_data->sioreg);
>  	/* Read VID value */
> -	superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> -	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
> -		/* Set VID input sensibility if needed. In theory the BIOS
> -		   should have set it, but in practice it's not always the
> -		   case. We only do it for the W83627EHF/EHG because the
> -		   W83627DHG is more complex in this respect. */
> -		if (sio_data->kind = w83627ehf) {
> -			en_vrm10 = superio_inb(sio_data->sioreg,
> -					       SIO_REG_EN_VRM10);
> -			if ((en_vrm10 & 0x08) && data->vrm = 90) {
> -				dev_warn(dev, "Setting VID input voltage to "
> -					 "TTL\n");
> -				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
> -					     en_vrm10 & ~0x08);
> -			} else if (!(en_vrm10 & 0x08) && data->vrm = 100) {
> -				dev_warn(dev, "Setting VID input voltage to "
> -					 "VRM10\n");
> -				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
> -					     en_vrm10 | 0x08);
> -			}
> -		}
> -
> -		data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
> -		if (sio_data->kind = w83627ehf) /* 6 VID pins only */
> -			data->vid &= 0x3f;
> -
> +	if (sio_data->kind = w83667hg) {
> +		/* W83667HG has different pins for VID input and output, so 
> + 		we can get the VID input values directly at logical device D
> +		0xe3. */
> +		superio_select(sio_data->sioreg, W83667HG_LD_VID);
> +		data->vid = superio_inb(sio_data->sioreg, 0xe3);
>  		err = device_create_file(dev, &dev_attr_cpu0_vid);
>  		if (err)
>  			goto exit_release;
>  	} else {
> -		dev_info(dev, "VID pins in output mode, CPU VID not "
> -			 "available\n");
> +		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> +		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
> +			/* Set VID input sensibility if needed. In theory the BIOS
> +			   should have set it, but in practice it's not always the
> +			   case. We only do it for the W83627EHF/EHG because the
> +			   W83627DHG is more complex in this respect. */
> +			if (sio_data->kind = w83627ehf) {
> +				en_vrm10 = superio_inb(sio_data->sioreg,
> +						       SIO_REG_EN_VRM10);
> +				if ((en_vrm10 & 0x08) && data->vrm = 90) {
> +					dev_warn(dev, "Setting VID input voltage to "
> +						 "TTL\n");
> +					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
> +						     en_vrm10 & ~0x08);
> +				} else if (!(en_vrm10 & 0x08) && data->vrm = 100) {
> +					dev_warn(dev, "Setting VID input voltage to "
> +						 "VRM10\n");
> +					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
> +						     en_vrm10 | 0x08);
> +				}
> +			}
> +
> +			data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
> +			if (sio_data->kind = w83627ehf) /* 6 VID pins only */
> +				data->vid &= 0x3f;
> +
> +			err = device_create_file(dev, &dev_attr_cpu0_vid);
> +			if (err)
> +				goto exit_release;
> +		} else {
> +			dev_info(dev, "VID pins in output mode, CPU VID not "
> +				 "available\n");
> +		}
>  	}
>  
>  	/* fan4 and fan5 share some pins with the GPIO and serial flash */
>  
> -	fan5pin = superio_inb(sio_data->sioreg, 0x24) & 0x2;
> -	fan4pin = superio_inb(sio_data->sioreg, 0x29) & 0x6;
> +	if (sio_data->kind = w83667hg) {
> +		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
> +		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
> +	} else {			
> +		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
> +		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
> +	}
>  	superio_exit(sio_data->sioreg);
>  
>  	/* It looks like fan4 and fan5 pins can be alternatively used
> @@ -1328,9 +1361,9 @@ static int __devinit w83627ehf_probe(str
>  
>  	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
>  	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
> -	if ((i & (1 << 2)) && (!fan4pin))
> +	if ((i & (1 << 2)) && fan4pin)
>  		data->has_fan |= (1 << 3);
> -	if (!(i & (1 << 1)) && (!fan5pin))
> +	if (!(i & (1 << 1)) && fan5pin)
>  		data->has_fan |= (1 << 4);
>  
>  	/* Read fan clock dividers immediately */
> @@ -1343,23 +1376,29 @@ static int __devinit w83627ehf_probe(str
>  			goto exit_remove;
>  
>  	/* if fan4 is enabled create the sf3 files for it */
> -	if (data->has_fan & (1 << 3))
> +	if ((sio_data->kind != w83667hg) && 
> +		(data->has_fan & (1 << 3)))
>  		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
>  			if ((err = device_create_file(dev,
>  				&sda_sf3_arrays_fan4[i].dev_attr)))
>  				goto exit_remove;
>  		}
> +	
> +	data->en_temp3 = w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[1]) & 0x01;

If bit 0 is set it means that temp3 is _disabled_, so the field name
(en_temp3) is confusing. You should either negate the expression or
rename the field to temp3_disabled.

>  
> -	for (i = 0; i < data->in_num; i++)
> -		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
> -			|| (err = device_create_file(dev,
> -				&sda_in_alarm[i].dev_attr))
> -			|| (err = device_create_file(dev,
> -				&sda_in_min[i].dev_attr))
> -			|| (err = device_create_file(dev,
> -				&sda_in_max[i].dev_attr)))
> -			goto exit_remove;
> -
> +	for (i = 0; i < data->in_num; i++) {
> +		if ((i = 6) && (sio_data->kind = w83667hg) && !data->en_temp3) 
> +			continue;
> +		else
> +			if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
> +				|| (err = device_create_file(dev,
> +					&sda_in_alarm[i].dev_attr))
> +				|| (err = device_create_file(dev,
> +					&sda_in_min[i].dev_attr))
> +				|| (err = device_create_file(dev,
> +					&sda_in_max[i].dev_attr)))
> +				goto exit_remove;
> +		}
>  	for (i = 0; i < 5; i++) {
>  		if (data->has_fan & (1 << i)) {
>  			if ((err = device_create_file(dev,
> @@ -1371,8 +1410,8 @@ static int __devinit w83627ehf_probe(str
>  				|| (err = device_create_file(dev,
>  					&sda_fan_min[i].dev_attr)))
>  				goto exit_remove;
> -			if (i < 4 && /* w83627ehf only has 4 pwm */
> -				((err = device_create_file(dev,
> +	if(i < data->pwm_num &&
> +			((err = device_create_file(dev,
>  					&sda_pwm[i].dev_attr))
>  				|| (err = device_create_file(dev,
>  					&sda_pwm_mode[i].dev_attr))
> @@ -1386,9 +1425,13 @@ static int __devinit w83627ehf_probe(str
>  		}
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
> +	for (i = 0; i < ARRAY_SIZE(sda_temp); i++) {
> +		if (strstr(sda_temp[i].dev_attr.attr.name, "temp3")

strstr() is relatively slow, so it should be avoided. It would be
better to split sda_temp into sub-arrays, as we already have for
voltages and fans, so that we can easily access the attributes by
index. Or you can test for "i % 3 = 2", which corresponds to all temp3
attributes in the current array. This approach is a little fragile
though.

> +			&& (sio_data->kind = w83667hg) && data->en_temp3) 
> +			continue;
>  		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
>  			goto exit_remove;
> +	}
>  
>  	err = device_create_file(dev, &dev_attr_name);
>  	if (err)
> @@ -1441,6 +1484,7 @@ static int __init w83627ehf_find(int sio
>  	static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
>  	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
>  	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
> +	static const char __initdata sio_name_W83667HG[] = "W83667HG";
>  
>  	u16 val;
>  	const char *sio_name;
> @@ -1465,6 +1509,10 @@ static int __init w83627ehf_find(int sio
>  		sio_data->kind = w83627dhg;
>  		sio_name = sio_name_W83627DHG;
>  		break;
> +	case SIO_W83667HG_ID:
> +		sio_data->kind = w83667hg;
> +		sio_name = sio_name_W83667HG;
> +		break;
>  	default:
>  		if (val != 0xffff)
>  			pr_debug(DRVNAME ": unsupported chip ID: 0x%04x\n",


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
