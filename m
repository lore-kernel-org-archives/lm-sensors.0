From: Martin Hicks <mort@bork.org>
Date: Wed, 11 May 2011 14:47:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <BANLkTi=zfehx6k1xp0VAogn7Rqog1rtWOg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2011 at 10:26 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:

>> I took a quick look at the driver, and they seem fairly compatible. I
>> did not look at the datasheet.
>>
> Looking through the datasheets, the INA209 has some 22 registers,
> while the INA219 only has 6 registers. Register numbers are different too.
> That doesn't look very compatible to me. Am I missing something ?

I took a quick look at the 209 datasheet and it looked to me like the
219 contains a subset of the 209 features.  The calibration, shunt and
current LSB value would be the same, I think.

>
>> I've been maintaining my own port of the ina209 driver. Now that the
>> "in*_lcrit" interfaces are added to the sysfs-interface, we only have
>> two disagreements:
>>
>> 1) shunt voltage is reported in uV instead of mV
>>
>> This avoids losing half of the precision supported by the chip. This
>> makes a big difference for my application: I need it. IMHO, the
>> sysfs-interface was short sighted. We'll see more chips in the future
>> that are sensitive enough to report in uV.
>>
> mV seems to be pretty accurate for voltage measurements.
> The shunt voltage is really just a reflection of the voltage across
> the current shunt resistor and reflects a current, not a voltage.
>
> Sure, chips can sense voltages in the uV range, but that is typically
> not used for voltage but for current measurements. With a 0.001 Ohm
> shunt resistor, 1uV translates to 1mA. Reporting that "voltage" in mA
> makes, in my opinion, more sense than reporting it in uV and expecting
> a common library to perform a translation of a reported voltage into mA.

My driver uses the current LSB in uA, since values well below 1mA
would be common.  This value is based on the resistor used and the
full-scale bus power range that can be found on the bus.

E.g., in our particular embedded board we have a 0.01Ohm on a 5V bus
with fairly small current.  We use 250uA for the current LSB.

mh

--=20
Martin Hicks P.Eng. =A0=A0 =A0 | =A0 =A0 =A0 =A0 mort@bork.org
Bork Consulting Inc. =A0 =A0 | =A0 +1 (613) 266-2296

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
