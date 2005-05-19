From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <20040705230052.54a29042.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Yes, it makes sense now. But I'm not sure how to handle the fact that
> the hysteresis register applies to three temperature limits in the
> LM77. Say, the register value for hysteresis is 2 degrees, T_crit=80,
> T_high`. So the driver should show T_crit_hystx, T_high_hystX.
> Now if the user changes T_crit to 90, T_crit_hyst should be still 78,
> so the hysteresis register should hold 12 now. However that would mean
> that T_high_hyst will show 68 now. Does it make sense? (I have
> doubts.) And what if T_high is changed by the user? Should the
> hysteresis be updated accordingly? Does that make sense? I don't think
> so, that would screw up the hysteresis for T_crit. What is your
> suggestion?

You're correct, there is a kind of probleme here. Don't keep searching,
this problem has no solution. This is the reason why I suggested that
temp1_min_hyst and temp1_max_hyst would be read-only. That way, it
clearly states that these are computed values and user should not assume
anything about these. Of course, having knowledge about the chip and the
way the driver is implemented helps understanding why things are that
way. But the basic rules apply:

- read-write files can be set be the user in any order (although there
may be limitations)
- nothing should be assumed about read-only files

A library or program handling the chips interfaces in a generic way
would always set base limits first and corresponding hysteresis then,
because it always works best that way.

Of course some choices (such as preferring critical limit over min or
max) are arbitrary, but that's the way it goes. You cannot define a
common interface to chips with different designs without some additional
work and limitations. All in all it is believed to be the best tradeoff.

Thanks,

--=20
Jean Delvare
http://khali.linux-fr.org/
