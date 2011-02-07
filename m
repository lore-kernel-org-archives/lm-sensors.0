From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 07 Feb 2011 13:56:29 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <AANLkTimmGrMEm7gpdgf+Pbz-HuskXi0PiyinqLFqCkWb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 7, 2011 at 2:33 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Sun, 6 Feb 2011 20:50:05 -0800, Guenter Roeck wrote:
>> On Sun, Feb 06, 2011 at 10:50:02PM -0500, Andy Lutomirski wrote:
>> > On 02/05/2011 12:58 PM, Guenter Roeck wrote:
>> > > Hi,
>> > >
>> > > a standalone driver for W83667HG-I (NCT6771F, NCT6775F) and NCT6776F
>> > > is available for testing at http://roeck-us.net/linux/drivers/w83627=
ehf/.
>> > >
>> > > Please test and let me know if there are any problems.
>> >
>> > It appears to mostly work on an Intel DH67GD (nct6775). =A0There are t=
wo
>> > issues:
>> >
>> > 1. The first time I ran 'sensors', my CPU fan showed 0 RPM instead of
>> > the correct value (~134). =A0Running it again shows the correct value.
>> >
>> If you check the log, you might see a notice that the fan divisors were =
modified.
>> Can you check ?

Yes, I got a message.  dmesg shows:

[51676.259546] w83627ehf: Found NCT6775 chip at 0x290
[51678.246682] w83627ehf w83627ehf.656: Increasing fan2 clock divider
from 32 to 64

The second line happens on the first call to 'sensors'.  Rebooting
triggers it again, but rmmod/insmod does not.

Should the driver just fix up the divisors on load instead of on first read?

I'm happy to test patches (especially for fan control) on my board.

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
