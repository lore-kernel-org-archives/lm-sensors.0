From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 May 2009 11:08:19 +0000
Subject: Re: [lm-sensors] TI TMP421 chip address
Message-Id: <4A1D1F23.3000702@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090527091514.GB4422@ubuntu>
In-Reply-To: <20090527091514.GB4422@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 05/27/2009 11:15 AM, Andre Prendel wrote:
> Hi Hans,
>
> looking in the datasheet of the TMP421 sensor chip
>
> http://focus.ti.com/docs/prod/folders/print/tmp421.html,
>
> I saw the following addresses.
>
> TMP421  100 11xx
> TMP422  100 11xx
> TMP423A 100 1100
> TMP423B 100 1101
>
> But the preliminary driver of your students uses 0x2a.
>
>   /* Addresses to scan */
>   static unsigned short normal_i2c[] = { 0x2a, I2C_CLIENT_END };
>
> 0x2a = 010 1010b, right?
>

Right.

> Do I misunderstand something?

No, what my students did in there was wrong, they only put the
address in there to which the sample I gave them is wired

The addresses to scan should be:
static unsigned short normal_i2c[] = { 0x1c, 0x1d, 0x1e, 0x1f,
   0x2a, 0x4c, 0x4d, 0x4e, 0x4f, I2C_CLIENT_END };

But we better run those past Jean, to see if any of
those are dangerous to scan by default, Jean ?

> And what means the xx in the address of TMP421/422?

This means that the address is configurable by hooking up
the IC in different ways, see table 9 and 10 at page 17 of
the data sheet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
