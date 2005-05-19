From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM83 driver
Message-Id: <20030708084452.733bc429.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> - You could have done one /proc callback function rather than 4

Hm, how do I know who's calling me then? Using ctl_name and the
LM83_SYSCTL_* constants defined earlier? I don't exactly see the
interest yet. Though the functions are similar, most of the code really
depend on the sensor, so I don't think we'll win in clarity nor code
size. But maybe it's just me. Where could I look at a similar situation
in our code?

Anyway, this is left for after the release.

> - This is our first chip without two limits per sensor. To maintain
> our /proc standard for temps we would need a 'dummy' second value
> between the high limit and the reading. But if National did it,
> others will too, so probably better to add to our /proc standard to
> say it could be two values instead of three. Interesting.

At least the LM84 (in our adm1021 driver) and the LM82 (support to be
added to my LM83 driver) do the same. Probably some others do. I
couldn't see any reason for adding dummy values. It's probably clearer
to the user that way. When one sees only 2 values in the temp* files,
he/she'll understand that there is only one limit, which has to be a
high one. Using a dummy value will make him/her wonder why he/she can't
set it. Since our libsensors interface is flexible enough to allow this,
let's do it. What's more, we may have sensors with 3 or 4 limits someday
(min, max, hyst-min and hyst-max) or even more (if they differenciate
max and critical for example) and we will want to have them in our
files. We can also imagine sensors that report a temperature but don't
know about limits, thus having a single value. As long as we keep things
logical (current temperature being the last value, for example) and that
a given set of values is always ordered the same way, why wouldn't we
doing it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
