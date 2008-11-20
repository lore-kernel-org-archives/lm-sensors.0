From: David Brownell <david-b@pacbell.net>
Date: Thu, 20 Nov 2008 22:56:36 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <200811201456.36551.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com> <20081119161632.2d0bde9e@hyperion.delvare> <Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811201354310.11673-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Thursday 20 November 2008, Trent Piepho wrote:
> >
> > Did you actually check the size increase? struct i2c_driver is added
> > one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
> > i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
> > increase of less than 6%. Is this really such a big issue? I doubt it.
> > You don't have that many i2c_adapters registered on any given system
> > for it to really matter, methinks.
>=20
> Except every other subsystem in the kernel does the same thing. =A0Each r=
elease
> of 2.6 is significantly more bloated than the last and this is how it hap=
pens.=20
> One "it's not that much wasted" change at a time.

I do recall the "4 MByte performance problem" morphing into the "8 MByte"
problem, and then into the "16 MByte" version then "32 MByte" -- for UNIX
workstations, including GUI.  Today's handhelds are more powerful than
those!  And the embedded boards I get lately have 128 MB of RAM.

The real counter-argument is that memory isn't *that* tight, especially
since the hardware capacity is growing.


That said, maybe you have a patch to propose which would address the
problem of how to *cleanly* make this infrastructure optional?

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
