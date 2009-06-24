From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 24 Jun 2009 12:38:52 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <68676e00906240538s6bd5d03aoc1150ea17cf08ecd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 24, 2009 at 2:34 PM, Konstantin Kletschke<konsti@ku-gbr.de> wrote:
> Hi Luca,
>
> Am 2009-06-24 13:08 +0200 schrieb Luca Tettamanti:
>
>> > Can fan pwm value controlled with this driver?
>>
>> Not directly, the relevant ACPI method doesn't actually touch the
>> hardware. It should be possible to use Q-FAN to switch between
>> different profiles, but I've yet to RE that interface.
>
> You mean the cooling profile (actually selectable in BIOS) could be
> changed from acpi, if REed?

Yes, that's what I meant.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
