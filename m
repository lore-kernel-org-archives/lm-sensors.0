From: <samu.p.onkalo@nokia.com>
Date: Fri, 06 Nov 2009 11:55:54 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <62697B07E9803846BC582181BD6FB6B8256DBE0CDB@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

=20

>-----Original Message-----
>From: ext =C9ric Piel [mailto:eric.piel@tremplin-utc.net]=20
>Sent: 03 November, 2009 15:25
>To: Daniel Mack
>Cc: Onkalo Samu.P (Nokia-D/Tampere); kalhan.trisal@intel.com;=20
>lm-sensors@lm-sensors.org
>Subject: Re: [RFC PATCH 09/10] lis3: Scale output values to mg
>
>Op 03-11-09 13:32, Daniel Mack schreef:
>> On Tue, Nov 03, 2009 at 01:30:07PM +0100,=20
>samu.p.onkalo@nokia.com wrote:
>>>> On Tue, Nov 03, 2009 at 02:09:44PM +0200, Samu Onkalo wrote:
>>>>> Report output values as 1/1000 of earth gravity.
>>>> Without having tried that, I assume that changes the=20
>values for all=20
>>>> events reported? That would break all userspace clients of this=20
>>>> device, right?
>>>>
>>> Yes. That is one thing which need to agreed here. One=20
>possibility is=20
>>> to implement this as a configurable feature for example=20
>using platform data.
>>> In that kind of solution default value must be the old way.
>>=20
>> Yes please :)
>>=20
>Hello,
>Actually we had already briefly discussed this with Samu. And=20
>I had given my green light because:
> * I don't know any userspace program which would be affected=20
>by this change (they only rely on the relative difference).=20
>Arguably, I know only few programs.
> * Eventually, we should converge to a userspace API=20
>compatible with any accelerometer device and exposed by all=20
>the accelerometer drivers. So for now I consider the userspace=20
>interface of the lis3 driver quite "soft", and any move toward=20
>this goal good.
> * Having platform data to select between old unit/new unit=20
>will add complexity to the driver, which should be avoided=20
>whenever possible.
>
>Of course, if you come and tell me that you know some=20
>userspace programs which will be affected by this change, this=20
>blows away the first point.
>Then I'd be much more willing to have a configurable option.=20
>But be aware that these programs would then blow away=20
>themselves if, for example, they expect a LIS302DL and the=20
>actual sensor is a LIS3LV02DL.
>So simply fixing these programs and moving to mG might be a=20
>better option.
>

It is relatively simple to keep also non-scaled output. Scaling factor just=
 need to
be set to a neutral value. Selection could be done via platform data.
Question is that what do we want to do?=20

-Samu



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
