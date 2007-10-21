From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 18:43:46 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <20071021204346.2462ee8c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 21 Oct 2007 06:35:05 -0700 (PDT), JAMES SCOTT wrote:
> Jean; The abituguru3... sensors output showed 'CPU 40c' and coretemp...
> details the same CPU around '50c'.  So, I have output, it is formatted
> correctly.  However, I believe the reported value is wrong.  10c is a
> huge difference in values - which is correct?

10=B0C isn't that big, it really depends what the different sensors
measure exactly. It is possible that all temperatures are correct and
just not measuring the same thing. The coretemp driver reports the CPU
core temperature, which is presumably the hottest point of the CPU. The
abituguru driver, OTOH, may be reporting the temperature in the CPU
socket, or the temperature of a thermal diode close to the CPU or
inside the CPU but not in the core. It is expected that the reported
temperature is lower.

> I did not find the coretemp-isa-* in the sensors.conf file.  Do you
> know where the computes for this module are setup?

No computes are needed for the coretemp, the temperatures are reported
directly by the driver.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
