From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date: Thu, 02 Jul 2009 17:59:46 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <8A42379416420646B9BFAC9682273B6D0C2497CC@limkexm3.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local> <4A4CF07B.3090600@cam.ac.uk> <8bd0f97a0907021043l30a34e6dh581ea5e96130d7eb@mail.gmail.com>
In-Reply-To: <8bd0f97a0907021043l30a34e6dh581ea5e96130d7eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Frysinger <vapier.adi@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: Chris Verges <chrisv@cyberswitching.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Robin Getz <rgetz@blackfin.uclinux.org>



>From: Mike Frysinger [mailto:vapier.adi@gmail.com]
>On Thu, Jul 2, 2009 at 13:38, Jonathan Cameron wrote:
>> One interesting thing I just came across whilst searching lkml for
>> your post to reply to, was that Mike Frysinger submited a patch
>> adding some board support for an adx34x driver to bf548-ezkit.
>> I've not seen any sign of this anywhere else as yet (it hasn't
>> hit the input list which would be the obvious place) I've copied in
>> both people who signed off. =A0Michael or Mike able to give us more info?
>
>that's because we're still in the process of making sure it is stable.
> I2C is a pita to work with.
>http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3Dcommit=
diff;hCd4cabbdeb5c24f84b159c5
>dc369c1a60844a48
>
>the advantage here is that we have been testing our driver with actual
>hardware ...
>-mike

Funny - we've been both working on a driver for the same device.
The driver is stable and from my side ready to send upstream.

Documentation can be found here:

http://docs.blackfin.uclinux.org/doku.php?id=3Dlinux-kernel:drivers:adxl34x


However we target driver/input since we targeted it for HID and gaming devi=
ces.

Best regards,
Michael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
