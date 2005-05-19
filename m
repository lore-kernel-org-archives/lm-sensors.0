From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <20040705192241.7ca6ad78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Well, I read 0 (that was 32 degrees), heated up the sensor with a
> lighter and then read 6, 7 and 0, one straightaway after the other. 6
> and 7 returned 32, 0 returned 40 (and after that, 6 and 7 returned
> 40). Of course this is by no means a scientific proof, but should be
> enough I assume.

Certainly, I'm myself completely convinced ;)

> Okay, I concede that consistency is more important than my nitpicking
> regarding definitions. But I cannot resist one more comment :-) Here
> you are saying that hysteresis should be an absolute value (regarding
> its content):
>=20
> > So, absolute limits for everyone, including hysteresis limits.
>=20
> Whereas here:
>=20
> > Setting the critical limit should preserve (from the user's absolute
> > point of view) the associated hysteresis limit (i.e. change the
> > hysteresis register value).=20
>=20
> you are saying that hysteresis should be relative (regarding its
> nature), since it's not the absolute value of it that should be
> preserved when a limit is  modified, but its difference to them.
> I do not see how this makes more sense than storing the hysteresis as
> a relative value (since that is its nature), but I stop arguing here
> and accept the fact that this has already been decided, as I agree
> that consistency is the most important factor.

This simply proves that I misexpressed myself (though reading myself
again I find it clear ;)). When I say "setting the critical limit should
preserve the associated hysteresis limit", I mean that the user should
not see it change, which precisely means that the register value should
be updated. As a concrete example, let's consider that the critical
limit is set to 80 degree and the hysteresis register holds 5. From the
user's point of view, we have temp_crit=80 and temp_crit_hystu. Now if
the user asks for temp_crit=85, it should *not* seem to affect
temp_crit_hyst which should stay at 75, which means that the driver
would have to both write 85 to crit register and 10 to hyst register. Is
it clearer now?

Anyway I'm almost sure we agree and it was just a matter of expressing
the idea.

Thanks,

--=20
Jean Delvare
http://khali.linux-fr.org/
