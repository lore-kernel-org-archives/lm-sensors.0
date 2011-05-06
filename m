From: Natarajan Gurumoorthy <natg@google.com>
Date: Fri, 06 May 2011 20:00:20 +0000
Subject: Re: [lm-sensors] (no subject)
Message-Id: <BANLkTikL+HSnR2L6WKZ-QH5RieMMAdbpNA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304707960-10178-1-git-send-email-natg@google.com>
	<1304709200.31666.498.camel@groeck-laptop>
In-Reply-To: <1304709200.31666.498.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mikew@google.com" <mikew@google.com>

Guenter,
    Good catch. Forgot to checkin drivers/hwmon/it87.c. Also found a
couple of places I missed in driver/watch/it8712_wdt.c. Patch #9 will
be shipped later tonight. Got pulled off to do something else. Expect
patch late tonight.

Regards
Nat


On Fri, May 6, 2011 at 12:13 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, 2011-05-06 at 14:52 -0400, Nat Gurumoorthy wrote:
>> There are 3 different drivers that touch the it87 hardware registers.
>> The 3 drivers have been written independently and access the it87 hardwa=
re
>> registers assuming they are the only driver accessing it. This change
>> attempts to serialize access to the hardware by using
>> "request_muxed_region" macro defined by Alan Cox. Call to this macro
>> will hold off the requestor if the resource is currently busy.
>> The use of the above macro makes it possible to get rid of
>> spinlocks in it8712f_wdt.c and it87_wdt.c watchdog drivers.
>> This also greatly simplifies the implementation of it87_wdt.c driver.
>>
>> 01 - Changes to it87 watchdog driver to use "request_muxed_region"
>> =A0drivers/watchdog/it8712f_wdt.c
>> =A0drivers/watchdog/it87_wdt.c
>>
>> 02 - Chages to hwmon it87 driver to use "request_muxed_region"
>> =A0drivers/hwmon/it87.c
>>
>> =A0drivers/hwmon/it87.c =A0 =A0 =A0 =A0 =A0 | =A0 14 +++-
>> =A0drivers/watchdog/it8712f_wdt.c | =A0 60 ++++++++++----
>> =A0drivers/watchdog/it87_wdt.c =A0 =A0| =A0165 +++++++++++++++++++++++--=
--------------
>> =A03 files changed, 152 insertions(+), 87 deletions(-)
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>>
>> Signed-off-by: Nat Gurumoorthy <natg@google.com>
>>
>> Patch History:
>> v8:
>> - Return the error actually returned by superio_enter and not -EBUSY.
>
> Hi Nat,
>
> Your use of -EBUSY vs. the returned error code is still inconsistent,
> for superio_enter() as well as for other functions returning an error
> code.
>
> Also, the following line split is really unnecessary.
>
> -static inline void superio_enter(void)
> +static inline int
> +superio_enter(void)
>
> Guenter
>
>
>



--=20
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
