From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 07 May 2010 08:07:33 +0000
Subject: Re: [lm-sensors] asus_atk0110 Not Activated in lm_sensors-3.1.1-3
Message-Id: <w2r68676e01005070107zaee38202z10befc41ebbaef4d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <s2p68676e01004280524w93c9234az452c4e30ac73e392@mail.gmail.com>
In-Reply-To: <s2p68676e01004280524w93c9234az452c4e30ac73e392@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, May 7, 2010 at 6:48 AM, Marc <digitelp@yahoo.com> wrote:
> Thanks for the response, but fortunately, I found the solution and its one
> that your group ought to be telling others about.

It's not that we're hiding it, it's even mentioned in the FAQ.

> For later kernels, 2.6.32 the ACPI has gotten very strict and will not pe=
rmit
> older drivers to function. =C2=A0To get around all that I added acpi_enfo=
rce_resources=3Dlax
> to the kernel load and it did the trick.

Yes, I'm aware of this (I wrote the patch that enabled strict
validation by default). This is not the preferred solution though,
you'll revert to having two drivers touching the same hardware without
coordination.
The real bug here is that asus_atk0110 - which uses the monitoring
interface provided by Asus - is not working correctly on your board.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
