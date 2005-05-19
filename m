From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040220220912.5e1011da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting MDS:

> I don't think we should do a sensors release just because of
> w83l785ts.

Well, from a 2.6 kernel point of view, there's also a sysfs enabled
decode-edid.pl.

For 2.4 kernels, there is w83637hf support and some fixes to a few
drivers.

I agree that there are less changes than usual (quite normal since there
has been only 2 weeks since previous release). But is is comparable to
2.8.3, for example. From 2.0.0 to 2.5.0, most releases had far less than
we have here.

Releasing doesn't cost us much. In return, it is likely to save half a
dozen reports about w83l785ts not working in Linux 2.6.3, if nothing
else. For this reason I think we should release. And I guess Greg will
agree with me. Supporters of MDS, speak up ;)

> We also shouldn't be forcing people to upgrade i2c releases.
> The last couple of new sensors drivers have not had #ifndef
> I2C_DRIVERID_xxx in the new drivers, which forces people to upgrade
> i2c for very little reason. IMO we should always #ifndef the driverids
> in new drivers.

Correct. This is my fault. I'll try to think of it from now on.

Maybe I could fix that before the next release, so as it will work with
versions down to 2.8.0 of i2c? Doesn't cost much, and likely to save
some users (and us with them) some trouble.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
