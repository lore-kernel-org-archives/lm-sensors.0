From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Tue, 08 Jul 2008 23:24:16 +0000
Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <4873F720.10105@kenm.demon.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <486F7926.6000304@kenm.demon.co.uk>
In-Reply-To: <486F7926.6000304@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


George Joseph wrote:
> We still need to read it at least once because it has the pwm auto zone
> assignments I let the first default 0 in the msb or lsb arrays take care
> of it.  If you dump the array after it's loaded you'll see 0x20, 0x13
> (in0) then 0x00 (because it's the default of the unused msb/lsb) then
> 0x21, 0x18 (in1), etc.  That's the only place 0x00 appears.
>=20
> Am I missing something?

No, you're not missing anything. :-)  I understand now, but see below.

> When I started the driver last year, I cloned one of the LM* drivers and
> it worked just fine for the basic stuff just by modifying the chip and
> manfacturer id.  Then I thought if I'm going to do a driver for this
> thing, I probably should expose as much of the chip's functionality as I
> could.   With 98 registers to read and 160+ sysfs entries to create
> though, =EF=BB=BFI quickly realized it would be impossible to code and ma=
intain
> the driver using the existing paradigms.  Hence the table driven
> approach.  The details of the registers and sysfs entries are all in one
> easy-to-read table.

It isn't your big table of constants in the code (asc7621_params) that I=20
have the problem with, it is the need to reverse-index this table at=20
runtime which I am calling into question.

I can see why you want to do it this way.  You have a many-to-many=20
mapping between device registers and sysfs entries, which is expressed=20
in the main table.  You could just walk down that table and read the=20
device registers as required, but this would mean reading some registers=20
more than once.  Indeed, some of the flags registers would be read many=20
times.  And each read over I2C is *very* time-costly.  So you need=20
separate lists of all the registers to be read, with duplicates removed=20
so that each is only read once.  No controversy there.

What I'm having trouble with is why these lists (of low and high=20
priority registers) need to be generated at runtime.  It would certainly=20
be nice and elegant if this information could be obtained directly from=20
the main asc7621_params table, without iterative re-indexing, but I=20
can't think of a way to do it other than by re-designing the driver.=20
That's why I suggested simply hard-coding the lists.

I realise you may think that this would wreck the maintainability of=20
your main table, but its not as bad as it sounds!  After all, from the=20
table I failed to notice where register zero appears in the read lists;=20
it is added as a kind of "side effect".  That ambiguity wouldn't have=20
arisen if the lists had been in front of me in the source!  And you get=20
to save on half a kilobyte of unnecessary array space into the bargain...

Anyway, if I have failed to dissuade you, and you still really, really=20
want to persist with the dynamic list creation, then you might want to=20
look at the following further points:

1.  Declaring a u8[256] as an automatic array on the rather small kernel=20
stack is probably a bad idea.

2.  C doesn't initialise automatic data to zero so you will have to=20
memset the asc7621_register_priorities array before use.  (I suspect you=20
have been lucky here with the specificity of your "!=3D 1" check on the=20
array contents!)

3.  You could save a bit of space by putting both the high and low=20
priority lists into the same array:  The size of both lists together=20
cannot exceed 256.  This doesn't really matter, though.

> I think at this point the approach will have to stand unless it's going
> to prevent acceptance of the driver.  If it is going to be an issue I
> think I'm just going to have to give up on it for a while.  I only have
> limited windows of time to work on it.

Fair enough.  I don't have any say in the matter, nor would I want to.=20
I'm only expressing opinions, which you can take or leave.  Open debate=20
applied to open source development.  Thanks for listening! ;-)

Kind regards,

Ken.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
