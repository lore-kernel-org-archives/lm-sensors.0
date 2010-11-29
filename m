From: no tellin <no.tellin@gmail.com>
Date: Mon, 29 Nov 2010 18:48:27 +0000
Subject: Re: [lm-sensors] Nuvoton W83677HG-I
Message-Id: <AANLkTimJ6j1UtRKc8BYQNu4oSbiiqoLec0VZR__mJh94@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101127155903.GB26489@hamsu.tarvainen.info>
In-Reply-To: <20101127155903.GB26489@hamsu.tarvainen.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm sorry, I just realized I left out an essential part of what I
wanted to post.

I chose to link to a specific example post of mine not only as a
general example, but as a specific example regarding Winbond and fans.

It's my personal experience and observation that with Winbond, lm
sensors will usually display some reasonable values. In those cases
where all the fan values are 0, it usually seems to be a matter of
using the correct divisor.

I especially chose the Asus K8N-DL as the eample because of this very
issue. The generic values {without a motherboard specific
configuration file} displays a default divisor of 2 for all fans and a
value of 0 for same. The K8N-DL not only has a different default
divisor for all fans {4 instead of 2}, but also has a single fan with
an exception {divisor of 1} and also requires further calculation.

I'd suggest you create a motherboard specific configuration file (like
in the example I gave) and try different divisor values.




On Mon, Nov 29, 2010 at 12:29 AM, Tapani Tarvainen
<lmsensors@tapanitarvainen.fi> wrote:
> On Sat, Nov 27, 2010 at 09:25:24AM -0800, Guenter Roeck (guenter.roeck@ericsson.
>> On Sat, Nov 27, 2010 at 10:59:03AM -0500, Tapani Tarvainen wrote:
>
>> > where does one get specs for these things?
>
>> For Nuvoton, you send a request to ComputerIC@nuvoton.com and ask nicely.
>> The datasheet to ask for is probably NCT6776F (it used to be
>> NCT6775F, but it looks like they added another variant).
>
> Thank you! Let's see if I managed to ask nicely enough. :-)
>
> --
> Tapani Tarvainen
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
