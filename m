From: Fubo Chen <fubo.chen@gmail.com>
Date: Tue, 28 Jun 2011 17:50:38 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <BANLkTim=9ygJScqy12PQXNPBStSgPbpedQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
	<BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
	<6E4D2678AC543844917CA081C9D6B33F04CF4FFC@XMB-AMS-103.cisco.com>
In-Reply-To: <6E4D2678AC543844917CA081C9D6B33F04CF4FFC@XMB-AMS-103.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com

On Mon, Jun 27, 2011 at 9:04 AM, Stijn Devriendt (sdevrien)
<sdevrien@cisco.com> wrote:
>> On Mon, Jun 6, 2011 at 12:40 PM, =A0<sdevrien@cisco.com> wrote:
>> > + =A0 =A0 =A0 } else
>> > + =A0 =A0 =A0 if (man_id =3D 0xA1) { /* =A0NXP Semiconductor/Philips */
>>
>> No kernel coder writes like this. Has this ever been run through
>> checkpatch ?
> It has. Unfortunately this is just the coding style in the whole
> driver. I believe it's better to have a consistent file rather
> than 3 different styles.

Makes sense to me. By the way, it's not forbidden to clean up unusual
coding style from other developers.

Fubo.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
