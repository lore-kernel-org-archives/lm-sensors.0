From: Paul Thomas <pthomas8589@gmail.com>
Date: Mon, 18 Jul 2011 16:03:43 +0000
Subject: Re: [lm-sensors] [PATCH] iio: add support for Analog Devices ad7194
Message-Id: <CAD56B7d+rixhKSoHJ4zcKhT6xMUUZZPERoOzSO74q6ZrHS7-Sg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>
	<4E241286.3090103@cam.ac.uk>
	<4E242605.9050400@cam.ac.uk>
In-Reply-To: <4E242605.9050400@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: lm-sensors@lm-sensors.org, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

On Mon, Jul 18, 2011 at 5:24 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 07/18/11 12:01, Jonathan Cameron wrote:
>> cc'ing linux-iio and AD's driver list.
>>
>> Any particular reason for posting to lm-sensors? Now it's there we'll
>> keep them in the list though as someone might be interested.
>>
>> On 07/18/11 08:46, Paul Thomas wrote:
>>> This uses the iio sysfs interface, and inculdes gain and differential s=
ettings
>
> Hi Paul,
>
> This driver is lagging somewhat in interface terms. Having said that, it =
applies
> and compiles fine which will make catching up to current point much easie=
r.
>
> If you are short on time I'm happy to do the conversion (as it is a nice =
simple
> driver), but obviously I'll need to test it to find out what I messed up =
this
> time.
>
> Big issues:
>
> 1) iio_dev->dev_data is going away, so please use the iio_priv stuff.
> 2) interface is not terribly close the abi spec.
> 3) use chan_spec based registration. Actually that'll clean up the abi
> issues as well and give you much shorter code.
> 4) differential channels are treated as separate channels (with appropria=
te
> numbering). =A0This is easy here as there are no nasty constraints on cha=
nnel
> combinations (it only reads one at a time anyway!).
>
> Various nitpicks inline. =A0Though the above seems like a lot, you have d=
one
> all the fiddly stuff about actually talking the the chips. Cleaning up
> interfaces is relatively straight forward! =A0Lots of fun stuff to add to=
 this
> chip at a later date, but in the spirit of your driver, lets keep it simp=
le
> for now!
>
> As long as you are happy to do a couple of rounds of testing, we could me=
rge
> this as is and do the abi work as a series of small steps on top of it?
>
> Thanks,
>
> Jonathan

Hi Jonathan, I'd be happy to do the fixing. Is there an existing
multi-channel driver that might be helpful to reference here?

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
