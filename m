From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 07 Feb 2011 19:53:51 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <AANLkTinkAfhyA-58aAkmOF3pa7+EyQyrKk3ah_Foezh8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 7, 2011 at 1:48 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Mon, Feb 07, 2011 at 01:20:22PM -0500, Andrew Lutomirski wrote:
>> On Mon, Feb 7, 2011 at 12:58 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > Hi all,
>> >
>> > I published a new version of the standalone driver for W83667HG-I (NCT=
6771F, NCT6775F)
>> > and NCT6776F at http://roeck-us.net/linux/drivers/w83627ehf/.
>> >
>> > Key changes are listed in the README file. Most of the reported bugs h=
ave been fixed,
>> > though I am not sure about PWM configuration on NCT6775F and fan min l=
imits on NCT6776F.
>> >
>>
>> I don't see a README. =A0What's w83627ehf.c.18?
>>
> Sorry, it is there now. w83627ehf.c.18 is a port of rev1 to 2.6.18.

Thanks!  FWIW, it's invisible in the directory listing, though.

>
> Anyway, please try again. I updated the code to fix the pwmX_enable bug.

Mostly works.

If I set pwm2_enable to 1, then pwm2 controls the fan.

If I try to set pwm2_enable to 5, I get:

# echo 5 >pwm2_enable
bash: echo: write error: Invalid argument

which means I can't undo what I just did.  (If I patch the driver to
accept '5', then it works.)

Are there docs (e.g. a patch to Documentation/hwmon/w83627ehf, but an
email explanation would do) for how SmartFan works, or, more
generally, for how to program the various modes?  If you have a link
to a datasheet, I can try to write something.

In BIOS, I have settings related to target temperatures, minimum pwm
output, etc.

Thanks for working on this driver!  I'd be happy to add my Tested-by:
if you submit it upstream.

--Andy

>
> Thanks,
> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
