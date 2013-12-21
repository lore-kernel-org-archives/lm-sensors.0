From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Dec 2013 18:14:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Do not return -EAGAIN for low temperatures
Message-Id: <20131221191456.5b519b6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386439557-27341-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1386439557-27341-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 20 Dec 2013 07:53:11 -0800, Guenter Roeck wrote:
> On Sat, Dec 07, 2013 at 10:05:57AM -0800, Guenter Roeck wrote:
> > Some Intel CPUs do not set the 'valid' bit in IA32_THERM_STATUS if the
> > temperature is too low to be measured. This condition will not change u=
ntil
> > the CPU is hot enough for its temperature to be measured. Returning an =
error
> > in such conditions is not very useful. Drop checking the valid bit and =
just
> > return the reported temperature instead.
> >=20
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > I don't think we ever closed on this. Giving it a shot.
> >=20
> No feedback. This will go into 3.14 unless there are objections.

I have no objection, I just don't want this change to go to stable, I
believe it needs a lot of testing on a broad range of hardware before
we can even think of it.

Reviewed-by: Jean Delvare <khali@linux-fr.org>

On a related note, I think we already noticed that different CPU models
behave differently in low temperature ranges. As an additional data
point, I noticed when staring at sensord graphs that my wife's Core2
Duo E8400 does clamp at 40=B0C (which is 60=B0C below Tjmax). It never ever
reports values below this. Somehow it is a saner implementation than
clearing the valid bit. Too bad we have no way to represent this in
sysfs. Would it make sense to define for example tempX_floor (can't
remember if a better name was ever proposed) so that sensors can report
"< 40=B0C" instead of "40=B0C" in this case? The problem is that I don't
think these clamp values can be read from a register, I'm not even sure
if they are documented, so I'm not sure how useful this would be in
practice...

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
