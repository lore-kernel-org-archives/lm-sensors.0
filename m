From: Justin Maggard <jmaggard10@gmail.com>
Date: Wed, 05 Aug 2015 20:50:17 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (it87) Add support for IT8732F
Message-Id: <CAKgsxVQdDvU+UUm6A4+PY9aO2Gua6+07t-MW7ux+9auvx6ie3g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438804388-21266-1-git-send-email-jmaggard@netgear.com>
In-Reply-To: <1438804388-21266-1-git-send-email-jmaggard@netgear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 5, 2015 at 1:36 PM, Phil Perry <phil@elrepo.org> wrote:
> On 05/08/15 20:53, Justin Maggard wrote:
>> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
>> with the main difference being that the ADC LSB is 10.9 mV instead of
>> 12 mV.
>>
>> Signed-off-by: Justin Maggard <jmaggard@netgear.com>
>> ---
>>  Documentation/hwmon/it87 | 35 ++++++++++++++++++++++-------------
>>  drivers/hwmon/Kconfig    |  4 ++--
>>  drivers/hwmon/it87.c     | 43 ++++++++++++++++++++++++++++++++++++-------
>>  3 files changed, 60 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
>> index e872948..733296d 100644
>> --- a/Documentation/hwmon/it87
>> +++ b/Documentation/hwmon/it87
>> @@ -38,6 +38,10 @@ Supported chips:
>>      Prefix: 'it8728'
>>      Addresses scanned: from Super I/O config space (8 I/O ports)
>>      Datasheet: Not publicly available
>> +  * IT8732F
>> +    Prefix: 'it8732'
>> +    Addresses scanned: from Super I/O config space (8 I/O ports)
>> +    Datasheet: Not publicly available
>>    * IT8771E
>>      Prefix: 'it8771'
>>      Addresses scanned: from Super I/O config space (8 I/O ports)
>> @@ -111,9 +115,9 @@ Description
>>  -----------
>>
>>  This driver implements support for the IT8603E, IT8620E, IT8623E, IT8705F,
>> -IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
>> -IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and SiS950
>> -chips.
>> +IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8732F,
>> +IT8758E, IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and
>> +SiS950 chips.
>>
>>  These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
>>  joysticks and other miscellaneous stuff. For hardware monitoring, they
>> @@ -137,10 +141,10 @@ The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E and later IT8712F revisions
>>  have support for 2 additional fans. The additional fans are supported by the
>>  driver.
>>
>> -The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8781F, IT8782F, IT8783E/F,
>> -and late IT8712F and IT8705F also have optional 16-bit tachometer counters
>> -for fans 1 to 3. This is better (no more fan clock divider mess) but not
>> -compatible with the older chips and revisions. The 16-bit tachometer mode
>> +The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8732F, IT8781F, IT8782F,
>> +IT8783E/F, and late IT8712F and IT8705F also have optional 16-bit tachometer
>> +counters for fans 1 to 3. This is better (no more fan clock divider mess) but
>> +not compatible with the older chips and revisions. The 16-bit tachometer mode
>>  is enabled by the driver when one of the above chips is detected.
>>
>>  The IT8726F is just bit enhanced IT8716F with additional hardware
>> @@ -159,6 +163,9 @@ IT8728F. It only supports 16-bit fan mode.
>>
>>  The IT8790E supports up to 3 fans. 16-bit fan mode is always enabled.
>>
>> +The IT8732F supports a closed-loop mode for fan control, but this is not
>> +currently implemented by the driver.
>> +
>>  Temperatures are measured in degrees Celsius. An alarm is triggered once
>>  when the Overtemperature Shutdown limit is crossed.
>>
>> @@ -173,12 +180,14 @@ is done.
>>  Voltage sensors (also known as IN sensors) report their values in volts. An
>>  alarm is triggered if the voltage has crossed a programmable minimum or
>>  maximum limit. Note that minimum in this case always means 'closest to
>> -zero'; this is important for negative voltage measurements. All voltage
>> -inputs can measure voltages between 0 and 4.08 volts, with a resolution of
>> -0.016 volt (except IT8603E, IT8721F/IT8758E and IT8728F: 0.012 volt.) The
>> -battery voltage in8 does not have limit registers.
>> -
>> -On the IT8603E, IT8721F/IT8758E, IT8781F, IT8782F, and IT8783E/F, some
>> +zero'; this is important for negative voltage measurements. On most chips, all
>> +voltage inputs can measure voltages between 0 and 4.08 volts, with a resolution
>> +of 0.016 volt.  IT8603E, IT8721F/IT8758E and IT8728F can measure between 0 and
>> +3.06 volts, with a resolution of 0.012 volt.  IT8732F can measure between 0 and
>> +2.8 volts with a resolution of 0.0109 volt.  The battery voltage in8 does not
>> +have limit registers.
>> +
>> +On the IT8603E, IT8721F/IT8758E, IT8732F, IT8781F, IT8782F, and IT8783E/F, some
>>  voltage inputs are internal and scaled inside the chip:
>>  * in3 (optional)
>>  * in7 (optional for IT8781F, IT8782F, and IT8783E/F)
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 7c65b73..500b262 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -609,8 +609,8 @@ config SENSORS_IT87
>>       depends on !PPC
>>       select HWMON_VID
>>       help
>> -       If you say yes here you get support for ITE IT8705F, IT8712F,
>> -       IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
>> +       If you say yes here you get support for ITE IT8705F, IT8712F, IT8716F,
>> +       IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8732F, IT8758E,
>>         IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E,
>>         IT8603E, IT8620E, and IT8623E sensor chips, and the SiS950 clone.
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index d0ee556..3ed6663 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -21,6 +21,7 @@
>>   *            IT8721F  Super I/O chip w/LPC interface
>>   *            IT8726F  Super I/O chip w/LPC interface
>>   *            IT8728F  Super I/O chip w/LPC interface
>> + *            IT8732F  Super I/O chip w/LPC interface
>>   *            IT8758E  Super I/O chip w/LPC interface
>>   *            IT8771E  Super I/O chip w/LPC interface
>>   *            IT8772E  Super I/O chip w/LPC interface
>> @@ -69,8 +70,9 @@
>>
>>  #define DRVNAME "it87"
>>
>> -enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
>> -          it8772, it8781, it8782, it8783, it8786, it8790, it8603, it8620 };
>> +enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8732,
>> +          it8771, it8772, it8781, it8782, it8783, it8786, it8790, it8603,
>> +          it8620 };
>>
>>  static unsigned short force_id;
>>  module_param(force_id, ushort, 0);
>> @@ -147,6 +149,7 @@ static inline void superio_exit(void)
>>  #define IT8720F_DEVID 0x8720
>>  #define IT8721F_DEVID 0x8721
>>  #define IT8726F_DEVID 0x8726
>> +#define IT8732F_DEVID 0x8732
>>  #define IT8728F_DEVID 0x8728
>
> Nit-picking, but shouldn't these be kept in numerical order?
>

Oops...  yes, I'll fix that.

Anything else for v4? :-)

-Justin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
