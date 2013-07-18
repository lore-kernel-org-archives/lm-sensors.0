From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 18 Jul 2013 16:15:47 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] eeprom: Add a MODULE_DEVICE_TABLE
Message-Id: <CALCETrX9Et-D+C9qJ9Ou46UyuWdqD6SN+PSu6RKDwnVogE=jZQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net> <5661ebb4676a4d20678f369df3a2da5d587e9100.1374093761.git.luto@amacapital.net>
 <20130718091116.6757e088@endymion.delvare>
In-Reply-To: <20130718091116.6757e088-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Thu, Jul 18, 2013 at 12:11 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Andy,
>
> On Wed, 17 Jul 2013 13:53:08 -0700, Andy Lutomirski wrote:
>> The new DIMM-bus code can detect eeproms, so give the eeprom driver
>> an appropriate modalias.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>>  drivers/misc/eeprom/eeprom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
>> index c169e07..1ec85b8 100644
>> --- a/drivers/misc/eeprom/eeprom.c
>> +++ b/drivers/misc/eeprom/eeprom.c
>> @@ -215,6 +215,7 @@ static const struct i2c_device_id eeprom_id[] = {
>>       { "eeprom", 0 },
>>       { }
>>  };
>> +MODULE_DEVICE_TABLE(i2c, eeprom_id);
>>
>>  static struct i2c_driver eeprom_driver = {
>>       .driver = {
>
> Nack. The eeprom driver will eventually die, I don't want to see
> anything like that added to it. Please use the at24 driver for anything
> new.

at24 doesn't have .class=I2C_CLASS_SPD (and I still am not really a
fan of the i2c class mechanism).  Shall I play with ways to get known
DIMM-only busses to probe these things directly and instantiate with
i2c_new_device(..., .type="spd")?  Do you have other plans for how
probing should work?

(For background in case you haven't been following the rest of the
thread: the Intel iMC (integrated memory controller) bus appears to
have only DIMMs attached, so everything on the bus is either the host
or is something attached to a DIMM.  The latter devices have
well-defined addresses: four bits of type and three bits of slot
number.  This makes it easy to probe accurately.  I'm not sure that
the i2c core class mechanism is well-suited to this, it's easy to do
manually.)

--Andy

>
> Thanks,
> --
> Jean Delvare



-- 
Andy Lutomirski
AMA Capital Management, LLC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
