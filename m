From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Sun, 07 Mar 2010 10:20:13 +0000
Subject: Re: [lm-sensors] Andigilog asc7621 driver: Temperature scaling
Message-Id: <4B937DDD.7070006@kenm.demon.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B930BB3.6030201@kenm.demon.co.uk>
In-Reply-To: <4B930BB3.6030201@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

Regarding the scale factors, I think you'll find that those given for=20
the 2.5V, 3.3V and 5V ranges are far enough wrong introduce a 2-bit=20
error in the 10-bit values.  The driver goes to some trouble to get the=20
full 10 bit precision by combining both the MSB and LSB registers, then=20
throws that precision away in the calculations!

You really do need to use the 3/4 scale voltage values, or some=20
equivalent rational scaling, to get the right answers here.  That's why=20
Andigilog provide them in the data sheet! :-)

I will try and get a patch together as soon as time permits.

Regards,

Ken.


On 07/03/10 07:53, Jean Delvare wrote:
> Hi Ken,
>
> On Sun, 07 Mar 2010 02:13:07 +0000, Ken Milmore wrote:
>> Hi George et al,
>>
>> Its great to see the aSC7621 driver being resurrected, but I notice in
>> the patches flying about recently (see LKML 22 Feb 2010 in particular)
>> that the voltage calculation is a bit off, as I already pointed out in a
>> previous review.  To get the correct results, it is much easier to use
>> the 3/4 scale values given in the data sheet, and also be careful to do
>> the multiplication before the division to avoid loss of precision (Hint:
>> The BSD version of the driver does it correctly!).
>
> The patch is already committed upstream:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=D58de038728221f780e11d50b32aa40d420c1150
> Any further change must be provided as an incremental patch on top of
> that.
>
>>
>> See below:
>>
>>
>> static int asc7621_in_scaling[] =3D {
>>       2500, 2250, 3300, 5000, 12000
>> };
>>
>>
>> For the 10-bit voltage registers, do something like this:
>>
>> long regval >>       (data->reg[param->msb[0]]<<  8) |
>>       (data->reg[param->lsb[0]]);
>> regval =3D (regval>>  6) * asc7621_in_scaling[index] / (192<<  2);
>>
>>
>> And for the 8-bit registers:
>>
>> long regval =3D data->reg[param->msb[0]];
>> regval =3D regval * asc7621_in_scaling[index] / 192;
>
> Looking at the current code, show_in8() looks OK to me. Multiplication
> happens before division. It uses a 256 scaling factor instead of 192
> but that shouldn't make a difference because the per-channel scale
> values have been adjusted meanwhile.
>
> show_in10(), OTOH, indeed suffers from the problem you describe: the
> divisions happens before the multiplication, leading to loss of
> accuracy.
>
> Care to send a patch fixing this issue?
>
>> I've not yet checked the code thoroughly to look for any of the other
>> fixes which were put in during our previous discussions, but I suspect
>> that some of the other minor fixes which were discussed on the mailing
>> list may have been left out.
>
> Feel free to send patches fixing them.
>
>> This was a very ambitious driver in that it included all the fancy
>> thermal management features of the aSC7621, and a complete review and
>> testing of everything in the driver was a lot more than I had the
>> stomach for.  I'm glad to see others have now picked it up though!
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
