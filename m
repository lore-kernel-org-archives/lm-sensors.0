From: Jean-Pierre Thibert <jpthibert@eircom.net>
Date: Sun, 16 Sep 2012 06:44:58 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <5055756A.5060500@eircom.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


On 14/09/12 17:37, Guenter Roeck wrote:
> On Fri, Sep 14, 2012 at 05:14:45PM +0100, MrNice wrote:
>> On 14/09/12 12:56, Jean Delvare wrote:
>>> Sorry I forgot to reply to the list last time, adding it back...
>>>
>>> On Thu, 13 Sep 2012 15:07:30 +0100, MrNice wrote:
>>>> On 13/09/12 10:15, Jean Delvare wrote:
>>>>> On Thu, 13 Sep 2012 09:19:39 +0100, MrNice wrote:
>>>>>> Following the advice
>>>>>> http://lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors
>>>>> This doesn't apply to the NCT6776. See in the output above, there is =
no
>>>>> "div =3D" on the fan lines.
>>>>>
>>>>> Maybe the document should be clarified.
>>> I just did so [1], hopefully the updated document is clearer and users
>>> will understand whether they have to read it or not.
>>>
>>> [1] http://www.lm-sensors.org/changeset/6071
>>>
>>>> Do you know if is there any way to collect the right speeds as UEFI
>>>> values are good.
>>> No idea. Check the motherboard documentation. If the fans are really
>>> connected to the NCT6776, this may be a driver bug. BTW you said you're
>>> using the w83627ehf driver from groeck, but there is a better driver
>>> for the NCT6776 now:
>>>    https://github.com/groeck/nct6775
>>> Guenter, maybe this driver should be listed at
>>>    http://roeck-us.net/linux/drivers/
>>> so that users find it?
>>>
>>> If the new driver doesn't help, maybe the fans are connected to another
>>> monitoring chip.
>>>
>>>> Does the mean all the AMD FX CPU have the same issue? What to do? Is a
>>>> patch on the way?
>>> There's no relation between fan speed monitoring and the CPU your
>>> system is using.
>>>
>>>> Temperatures in the hardware area have a load of loose vocabulary.
>>>> I try to be accurate:
>>>> Could you confirm that CPUTIN is the temperature read by the sensor in
>>>> the socket of the motherboard called Tjunction?
>>> I don't think so. AFAIK Tjunction refers to a temperature limit inside
>>> the CPU, and it related to the digital thermal sensor in the CPU.
>>> CPUTIN OTOH is an analog thermal sensor. As it is a thermistor in your
>>> case, it is likely under the CPU, in the middle of the CPU socket.
>>>
>>>> Could you confirm that K10temp, temp1 is what AMD call Tctl (sliding
>>>> scale) accessible through D18F3xA4[CurTmp] register (from BIOS and
>>>> Kernel Developer's Guide)?
>>> Yes, this is correct.
>>>
>>>> Could you tell me what is SYSTIN (system temp input) and AUXTIN
>>>> (auxiliary temp input)?
>>> These are analog thermal sensor inputs. As already mentioned, AUXTIN is
>>> apparently not used on your board, you can ignore it. SYSTIN could be
>>> anywhere on the motherboard, we can't tell. Maybe the technical
>>> documentation for your board has the information.
>>>
>>>> Are they in the list bellow?
>>> I have no idea where this list comes from, so I can't really comment on
>>> that, sorry. Other than:
>>>
>>>> TJunction is the temperature where the pins hit the board
>>>>
>>>> TJunction is still a diode on the board, under the processor
>>> This is completely wrong. At least this is not what the rest of the
>>> world, starting with Intel technical documentation, refers to as
>>> Tjunction.
>>>
>> The new document version is now clear to understand and moreover we
>> know why we don't need the divisor in some chips.
>>
>> I installed the new driver. For around 15 minutes I had fan2 value
>> (about 1150 RPM).
>> I did some changes in the sensors3.conf file, then sensors -s, was OK.
>> After some try I have fan2 =3D 0 RPM. I did cold boot, reinstall
>> driver, reinstall lm-sensors, still 0 RPM.
>> I can't find why it's not working any more.
>> Any idea?
>>
> ASRock uses GPIO pins to multiplex multiple fan speed inputs to a single =
pin
> at the NCT6776. It might be that you somehow triggered or changed a multi=
plexer
> configuration.
>
> Do you see fan speed(s) in the BIOS ? If you do, it might well be that yo=
u have
> to do that once after powerup to connect a fan to the fan speed input of =
the
> NCT6776, and then you might see it in the driver.
>
> [ And, no, it is practically impossible to get the necessary information =
to set
> the GPIO multiplexer from the board vendor. AFAIK they are using GPIO pin=
s,
> but which ones on which board is a mystery. ]
>
> Guenter
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>
I have an ASRock 970 Extreme4 UEFI version P2.00
In the H/W Monitor page of the UEFI/BIOS, I have the following:
CPU Temperature :    36.5 =B0C
M/B Temperature :    28.0 =B0C

CPU Fan 1 Speed :    1065 RPM (this is a pwm connector with 4 pins. I=20
have a pwm fan) called CPU_FAN1 on the motherboard
CPU Fan 2 Speed :    N/A (this is a 3 pins connector. No connected fan)=20
called CPU_FAN2 on the motherboard
Chassis Fan 1 Speed :    N/A (this is a pwm connector with 4 pins. No=20
connected fan) called CHA_FAN1 on the motherboard
Chassis Fan 2 Speed :    730 RPM (this is a 3 pins connector. I have a 3=20
pins connected fan) called CHA_FAN2 on the motherboard
Chassis Fan 3 Speed :    760 RPM (this is a 3 pins connector. I have a 3=20
pins connected fan) called CHA_FAN3 on the motherboard
Power Fan Speed :    N/A (this is a 3 pins connector. No connected fan)=20
called PWR_FAN1 on the motherboard

Vcore :    +1.328 V
+ 12.00V :    +12.144 V
+ 5.00V :    +5.136 V
+ 3.30V :    +3.280 V

lm-sensors has almost all the values but no fan speed.
I don't know why I had the CPU_FAN2 for a short time and it disappeared.
I can't understand what you suggest to have the value back. Could you be=20
more accurate?
Thanks


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
