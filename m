From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Thu, 23 Oct 2008 12:15:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Allow it87.c to handle IT8720
Message-Id: <79c9d4530810230515t2b2a4e19ifcf2850d633a4200@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FF7DA8.3020902@Spaggiari.org>
In-Reply-To: <48FF7DA8.3020902@Spaggiari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2008/10/23 Jean Delvare <khali@linux-fr.org>:
> Hi Jean-Marc,
>
> Thanks for the update.
>
> On Wed, 22 Oct 2008 15:23:20 -0400, Jean-Marc Spaggiari wrote:
>> Allow it87.c to handle IT8720 chipset like IT8718 in order to
>> retrieve voltage, temperatures and fans speed from sensors
>> tools. Also updating the related documentation.
>>
>>
>> Signed-off-by: Jean-Marc Spaggiari <jean-marc@spaggiari.org>
>>
>> --- ./drivers/hwmon/it87.c.orig       2008-10-18 13:57:22.000000000 -0400
>> +++ ./drivers/hwmon/it87.c    2008-10-22 08:38:18.000000000 -0400
>> @@ -14,6 +14,7 @@
>>                IT8712F  Super I/O chip w/LPC interface
>>                IT8716F  Super I/O chip w/LPC interface
>>                IT8718F  Super I/O chip w/LPC interface
>> +           IT8720F  Super I/O chip w/LPC interface
>>                IT8726F  Super I/O chip w/LPC interface
>>                Sis950   A clone of the IT8705F
>>
>> @@ -52,7 +53,7 @@
>>
>>  #define DRVNAME "it87"
>>
>> -enum chips { it87, it8712, it8716, it8718 };
>> +enum chips { it87, it8712, it8716, it8718, it8720 };
>>
>>  static unsigned short force_id;
>>  module_param(force_id, ushort, 0);
>> @@ -113,6 +114,7 @@ superio_exit(void)
>>  #define IT8705F_DEVID 0x8705
>>  #define IT8716F_DEVID 0x8716
>>  #define IT8718F_DEVID 0x8718
>> +#define IT8720F_DEVID 0x8720
>>  #define IT8726F_DEVID 0x8726
>>  #define IT87_ACT_REG  0x30
>>  #define IT87_BASE_REG 0x60
>> @@ -984,6 +986,9 @@ static int __init it87_find(unsigned sho
>>       case IT8726F_DEVID:
>>               sio_data->type = it8716;
>>               break;
>> +     case IT8720F_DEVID:
>> +             sio_data->type = it8720;
>> +             break;
>>       case IT8718F_DEVID:
>>               sio_data->type = it8718;
>>               break;
>> @@ -1017,7 +1022,8 @@ static int __init it87_find(unsigned sho
>>               int reg;
>>
>>               superio_select(GPIO);
>> -             if (chip_type = it8718)
>> +             if ((chip_type = it8718) ||
>> +                 (chip_type = it8720))
>>                       sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
>>
>>               reg = superio_inb(IT87_SIO_PINX2_REG);
>> @@ -1063,6 +1069,7 @@ static int __devinit it87_probe(struct p
>>               "it8712",
>>               "it8716",
>>               "it8718",
>> +             "it8720",
>>       };
>>
>>       res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> @@ -1603,7 +1610,7 @@ static void __exit sm_it87_exit(void)
>>
>>  MODULE_AUTHOR("Chris Gauthron, "
>>             "Jean Delvare <khali@linux-fr.org>");
>> -MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
>> +MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8720F/8726F, SiS950 driver");
>>  module_param(update_vbat, bool, 0);
>>  MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
>>  module_param(fix_pwm_polarity, bool, 0);
>
> I am surprised. Compared to the previous version of your patch, some
> occurrences of the data->type = it8720 test have been _removed_. For
> example, in has_16bit_fans(), and also once in it87_probe(). You did
> not really mean to revert these changes, did you?
>


Hum. I'm surprised. I have not expected to remove anything. I think I
did something wrong when I move from 2.6.27-rcx to 2.6.27.2. I will
double check today the entire file just to be sure, and repost an
updated version. Sorry.

JM

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
