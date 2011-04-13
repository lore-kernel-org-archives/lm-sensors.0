From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 13 Apr 2011 17:59:45 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTimhUd9+QmLh-fSjwDO5c_vRH+kktA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<4DA547CD.60406@redhat.com>
	<BANLkTikfuvvujTi6i2MUGOHgNLZCqcouJQ@mail.gmail.com>
	<20110413103409.47638b72@endymion.delvare>
In-Reply-To: <20110413103409.47638b72@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>

John,
      Unfortunately you are right. After grepping though drivers/hwmon
and drivers/watchdog I realize the ugliness is fairly deep rooted. All
of the following drivers need to be cleaned up as far as the
"superio_enter" "superio_exit" operation is concerned if we want this
stuff to be SMP clean and allow multiple drivers to coexist.

drivers/watchdog
f71808e_wdt.c
it8712f_wdt.c
it87_wdt.c
sch311x_wdt.c
iTCO_vendor_support.c
ibmasr.c
w83697hf_wdt.c
w83697ug_wdt.c:


drivers/hwmon
dme1737.c:1935:static inline void dme1737_sio_enter(int sio_cip)
f71805f.c:100:superio_enter(int base)
f71882fg.c:196:static inline int superio_enter(int base);
it87.c:112:superio_enter(void)
pc87360.c:1009:	/* No superio_enter */
sch5627.c:118:static inline int superio_enter(int base)
smsc47b397.c:75:static inline void superio_enter(void)
smsc47m1.c:77:superio_enter(void)
vt1211.c:223:static inline void superio_enter(int sio_cip)
w83627ehf.c:135:superio_enter(int ioreg)
w83627hf.c:134:superio_enter(struct w83627hf_sio_data *sio)

Have I missed any other drivers that also need to be cleaned. Even if
I got my boss to sign up to clean this I can only test the it8712f
drivers and thats it.

Regards
Nat

On Wed, Apr 13, 2011 at 1:34 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 13 Apr 2011 01:05:33 -0700, Natarajan Gurumoorthy wrote:
>> Hans,
>> =A0 =A0 =A0 Comments below
>>
>> On Tue, Apr 12, 2011 at 11:50 PM, Hans de Goede <hdegoede@redhat.com> wr=
ote:
>> >
>> > You shouldn't (void) this, there is a reason you get a warning
>> > otherwise! request_muxed_region can still fail if some other driver
>> > has done a none muxed request_region on the same region, and in that
>> > case you should not continue with accessing the io-ports.
>> There are 3 it87 drivers and they all have to do the exact same
>> sequence to put the chip into a mode where they can modify its state.
>> The sequences involve non atomic sequences that write locations 0x2e
>> and 0x2f. When they are done they write a different sequence to these
>> 2 locations. The entry routine is superio_enter and exit is
>> superio_exit. All the it87 drivers reserve these 2 locations before
>> they start manipulating the chip. This macro will hold off requestors
>> if the resource is busy because one of the other drivers is
>> manipulating the chip. Once the =A0an it87 driver is done it calls
>> superio_exit which will release the reservation on those 2 locations
>> letting any other driver on the wait queue to now gain access two
>> locations.
>>
>> Please read code in kernel/resource.c function "__request_region".
>> "request_muxed_region" turns on IORESOURCE_MUXED bit and that means
>> that only =A0way an it87 driver will get back from a call to
>> "request_muxed_region" is when it gets hold of the region.
>>
>> The scenario you mention above can never happen.
>
> Let me be straight clear, as apparently you have difficulties
> understanding Hans's simple request:
>
> You do not get to (void) the return of request_muxed_region(), period.
> This is _not_ negotiable.
>
> What other it87 drivers currently in the tree do or don't do is totally
> irrelevant. There can be new it87 drivers added later, there can be
> out-of-tree it87 drivers (including old copies of in-tree ones), and
> there can be non-it87 drivers accessing the I/O ports (or at least
> attempting to.) So the scenario mentioned by Hans can very well happen,
> and you have to deal with it.
>
> Thanks,
> --
> Jean Delvare
>



--=20
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
