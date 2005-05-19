From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: call for 2.6.6
Message-Id: <20021116172035.36f510c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DD5999A.49A03347@paradyne.com>
In-Reply-To: <3DD5999A.49A03347@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Let's set a deadline of Sunday night 11/24 to get stuff checked in.
> Then a couple of days to look for problems.
> Then Phil can release sometime over the long Thanksgiving weekend?
> (11/28-12/1)

It's OK for me.

> I want to again raise the question of dependency on i2c-2.6.6 because
> of SENSORS_INSMOD_8 in adm1021. If we leave this in, we will require
> users to upgrade i2c as well which will lead to more support issues.
> We can attempt to minimize by putting big fat warnings on the home
> page and download page. We may also wish to bump up to 2.7.0 instead
> of 2.6.6?
> 
> The advantage is we can remove some #ifndef cruft in the drivers.
> Our current dependency is on i2c-2.6.1 which is 15 months old.
> 
> Would like to hear opinions on these issues.

I don't know about the adm1021 module. What would it cost not to use the
SENSORS_INSMOD_8 thing?

I don't think we have to care about the dependency issue. 15 months is
really much, there were many fixes to i2c since, and having people
upgrade can't hurt. If for any reason they don't want to, 2.6.3 to 2.6.5
are working for almost everyone (at least, one of these is working for
each one).

Does 2.7.0 mean "developement/unstable tree" for you? I think it will
sound like that for almost everyone, including me. And if this means
less support issues, it also means less feedback IMHO, so it's worth
discussing.

I am not actively maintaining any driver, nor am I answering tickets, so
I can't really say.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
