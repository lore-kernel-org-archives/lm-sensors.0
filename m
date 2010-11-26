From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 26 Nov 2010 08:18:29 +0000
Subject: Re: [lm-sensors] sensors.conf for GigaByte GA-790XTA-UD4
Message-Id: <4CEF6D55.10003@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5B8CD.4060808@chaoslayer.de>
In-Reply-To: <4CE5B8CD.4060808@chaoslayer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for submitting these configs, I've put them both on the wiki:
http://lm-sensors.org/wiki/Configurations/Gigabyte/GA-770TA-UD3
http://lm-sensors.org/wiki/Configurations/Gigabyte/GA-790XTA-UD4

Regards,

Hans


On 11/19/2010 01:08 AM, Ancoron Luciferis wrote:
> Hi *,
>
> I just want to share the configuration that works nicely for the
> mentioned motherboard:
>
> # dmidecode 2.9
> SMBIOS 2.4 present.
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>          Manufacturer: Gigabyte Technology Co., Ltd.
>          Product Name: GA-790XTA-UD4
>          Version:
>          Serial Number:
>          UUID: 36434630-3439-3533-3433-3734FFFFFFFF
>          Wake-up Type: Power Switch
>          SKU Number:
>          Family:
>
>
> The sensors.conf file is attached.
>
> Here is some sample output:
>
> it8720-isa-0228
> Adapter: ISA adapter
> Vcore:           +1.20 V  (min =  +0.78 V, max =  +1.50 V)
> Vdram:           +1.49 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:           +3.34 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:             +5.11 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:           +11.92 V  (min = +11.41 V, max = +12.62 V)
> 5VSB:            +5.08 V  (min =  +4.76 V, max =  +5.24 V)
> Vbat:            +3.26 V
> CPU Fan:         690 RPM  (min =  300 RPM)
> SYS Fan 2:       873 RPM  (min =  300 RPM)
> SYS Temp:        +43.0°C  (low  =  +0.0°C, high = +50.0°C)  sensor > thermistor
> CPU Casing Temp: +27.0°C  (low  =  +0.0°C, high = +65.0°C)  sensor > thermal diode
> NB Temp:         +37.0°C  (low  =  +0.0°C, high = +55.0°C)  sensor > thermistor
>
>
> Please feel free to upload this to the available configurations.
>
>
> Cheers,
>
> 	Ancoron
>
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
