From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: LM83 driver
Message-Id: <20030721121217.1c28ef16.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Of course with libsensors apps you don't care about /proc standards.
> 
> The benefit is in writing simple non-libsensors scripts, etc.
> (see our new prog/pwm/pwmconfig) which are only feasible if we follow
> consistent standards for /proc.

I read that script and fancontrol too, and I admit fancontrol wouldn't
work if there were 2-values temp files. It's really easy to fix though.
Just replace "cut -d' ' -f3" with "sed -e 's/^.* \(.*\)$/\1/'" and it's
done (I think awk would be better to do that, but unfortunately I don't
know awk at all).

Having 2-temp files (or 1-temp, or 4-temp) causes IMHO far less problems
than other differences we already have. This can always be workarounded
in scripts, as long as the first temp is the high limit, and the last
one is the current value (and my driver respects that). The fact that
some drivers output values that are *not* the real temps and that a
conversion formula is required is much more trouble, and that's the way
our drivers work however (or what would be sensors.conf for?) so the
non-libsensors scripts already have to handle that.

Maybe there will be some script to fix if we decide to allow
non-3-values temperature files, but I really think it will always be
easy and it makes the drivers easier to write, maintain and in some
cases even use.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
