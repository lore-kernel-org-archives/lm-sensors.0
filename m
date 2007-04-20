From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 20 Apr 2007 04:51:59 +0000
Subject: Re: [lm-sensors] w83627hf hardware sharing
Message-Id: <462846EF.2000507@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070412121527.GA3132@sirena.org.uk>
In-Reply-To: <20070412121527.GA3132@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Mark Brown wrote:
> On Thu, Apr 12, 2007 at 01:26:55PM +0100, P=E1draig Brady wrote:
>  =20
>> Mark Brown wrote:
>>    =20
>
> [ Currently we have multiplexing problems with multiple drivers trying
>   to control SuperIO devices. ]
>
>  =20
>>> The most straightforward fix appears to be to provide a multiplexing
>>> driver for the chip.  Does this sound like a reasonable approach to
>>>      =20
>
>  =20
>> You're right.
>> Some work has been done wrt this, but I've not tried it:
>> http://marc.info/?l=3Dlinux-kernel&m=115821759424601&w=3D2
>>    =20
>
> Adding Jim Cromie who wrote the SuperIO multiplexer referenced there -
> what is the current status of that work?  It looks like exactly what I
> was after.
>
>  =20

hi Mark, Padraig,
thanks for searching, and finding something relevant.
and sorry for the delay.

$job is demanding my attention these days.
I also owe a platform_driver patch for pc87360,
which should come 1st, since its already late :-(

Ive evidently done something with the patchset since 9/14
probably as talked about in the thread.

-rw-rw-r-- 1 jimc jimc   9536 Oct  6  2006 diff.locks-superio
-rw-rw-r-- 1 jimc jimc   5739 Oct  6  2006 diff.locks-superio-usein-pc87360
-rw-rw-r-- 1 jimc jimc   6288 Oct  6  2006=20
diff.locks-superio-usein-pc8736x_gpio

in case you havent already seen it
http://search.gmane.org/?query=3Dsuperio&group=3Dgmane.linux.drivers.sensors

comments, experiments, trials welcome.
thanks
jimc



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
