From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 18 Jul 2013 20:44:43 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] eeprom: Add a MODULE_DEVICE_TABLE
Message-Id: <CALCETrX0Uk9Dbjdw3LDLFAooRQXwf2yvsqioMz3MBp3DEG9b+Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net> <5661ebb4676a4d20678f369df3a2da5d587e9100.1374093761.git.luto@amacapital.net>
 <20130718091116.6757e088@endymion.delvare> <CALCETrX9Et-D+C9qJ9Ou46UyuWdqD6SN+PSu6RKDwnVogE=jZQ@mail.gmail.com>
 <20130718223125.63e03635@endymion.delvare>
In-Reply-To: <20130718223125.63e03635-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Thu, Jul 18, 2013 at 1:31 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 18 Jul 2013 09:15:47 -0700, Andy Lutomirski wrote:
>> at24 doesn't have .class=I2C_CLASS_SPD (and I still am not really a
>> fan of the i2c class mechanism).
>
> The class-based auto-detection has its merits but it's not the solution
> to all problems.
>
> .class=I2C_CLASS_SPD could be added to the at24 driver. If we ever want
> to kill the legacy eeprom driver, we will have to do exactly that.
>
> That being said this won't help in your case, as your bus driver does
> not support the SMBus transaction (Receive Byte) used to probe for
> EEPROM chips in address range 0x50-0x57.
>
>> Shall I play with ways to get known
>> DIMM-only busses to probe these things directly and instantiate with
>> i2c_new_device(..., .type="spd")?  Do you have other plans for how
>> probing should work?
>
> You could indeed call i2c_new_probed_device() on addresses 0x50-0x57
> at the end of your new i2c bus driver's probe function, in order to
> instantiate spd devices. This function takes a probe function as a
> parameter so you could use a transaction type supported (Read Byte.)
>

Can you take a look at patch v4 1/2 and let me know if you think it's
any good?  It does more or less that, albeit using i2c_new_device and
a bit fancier logic.  It's also factored out to make it (in theory)
reusable by any other bus with similar properties, but I can easily
move it somewhere else.

http://news.gmane.org/find-root.php?message_id=%3c0087fdcb080b40f5eaf3abbfd35ee107ca713d52.1374171757.git.luto%40amacapital.net%3e

(And apologies for my newbishness in poking around the i2c code.)

>> (For background in case you haven't been following the rest of the
>> thread: the Intel iMC (integrated memory controller) bus appears to
>> have only DIMMs attached, so everything on the bus is either the host
>> or is something attached to a DIMM.  The latter devices have
>> well-defined addresses: four bits of type and three bits of slot
>> number.  This makes it easy to probe accurately.  I'm not sure that
>> the i2c core class mechanism is well-suited to this, it's easy to do
>> manually.)
>
> Ideally the BIOS/firmware/whatever would tell the OS which memory slots
> are used so that the kernel can instantiate all I2C/SMBus slave devices
> without even probing for them. I really wonder how many decades it will
> take to Intel and co to come up with a complete device typology
> description on the PC/x86_64 platfor, so that probing is finally
> history.

Intel almost did it.  They give status bits indicating whether they
(where "they" means either BIOS or the chipset -- I'm not sure) think
that a given slot contains a TSOD.  I think that those bits actually
control the periodic hardware TSOD polling.  On my i7 Extreme, they're
all zero.

I suppose that one could query the EDAC infrastructure to see which
slots are mapped to which RAM addresses, but that would be a giant
mess.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
