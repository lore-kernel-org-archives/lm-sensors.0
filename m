From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Thu, 11 Feb 2010 19:17:36 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] lis3lv02d: Power management,
Message-Id: <4B7457D0.4080507@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Op 04-02-10 09:24, Samu Onkalo schreef:
> Lis3 accelerometer chip family changes for power management,
> click and threshold event handling.
>=20
> Patch set adds interrupt handlers for click/tap events and threshold
> based events. Actual configuration which events are enabled
> is done via platform data. All the features cannot be used in parallel.
> Interrupts are implemented only for 8 bit device, since I'm not familiar
> with other devices and I don't have suitable testing environment.
>=20
> Changes:
>=20
>   lis3: Add missing constants for 8bit device
> This is quite clear. Some click feature related register definitions
> were missing.
>=20
>   lis3: Separate configuration function for 8 bit device
> Move platformdata based configurations for 8 bit device to
> separate function to keep common part little bit more readable.
>=20
>   lis3: Introduce platform data for second ff / wu unit
> 8 bit device has two freefall / wakeup detection blocks. Add possibility
> to configure also the second unit. Change hipass filter configuration
> to platform data. Change is compatible with existing platform data.
>=20
>   lis3: Power control for the chip
> This kind of feature has been in the driver earlier. It was removed
> because saving was so small in laptop environment. However, in smaller
> devices, even a small saving need to be implemented. When driver detects
> that no-one is really interested about the acceleration, chip is powered =
down.
> Input device, freefall device and sysfs are controlling this. By default,
> chip is powered on to keep functionality similar to current implementatio=
n.
>=20
>   lis3: Add skeletons for interrupt handlers
> Interrupt handlers are added in two patches to keep changes cleaner.
> This first patch adds two dummy threaded interrupt handlers for 8 bit dev=
ice.=20
>=20
>   lis3: Interrupt handlers for 8bit wakeup and click events
> This patch adds content to dummy handlers. Depending on the chip configur=
ation,
> either click or ff/wu handling is called. For click event, BTN input even=
t is
> sent separately for each axes. For threshold event, coordinates are updat=
ed
> immediatelly to input device. This allows input device to be used either =
in
> polled mode and / or interrupt driven mode. Polling can stopped from user=
space
> by via input device sysfs.
>=20
> Patch set applies to 2.6.33-RC6 tree.
> Tested with 2.6.32 environment for omap3
Hello,
Sorry, I haven't had time to fully review the patches. Nevertheless,
I've tested them on my HP laptop with a 12bit device, and can confirm
it's all fine.

The only hiccup is in patch 6: it declares the joystick with 3 buttons,
although on this hardware it's impossible to have this feature. So, it
would be nice if input_set_capability() could be conditionned.

I also fully agree with the comments from others that it would be better
if it could use the special runtime power-management framework from
Rafael. BTW, what is exactly the usecase for the "active" sysfs
attribute? To me, it looks like it just prevents userspace from using
the position attribute, while the joystick interface is still
accessible, so it is not very effective!

So, for the first four patches, here is my
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

Cheers,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
