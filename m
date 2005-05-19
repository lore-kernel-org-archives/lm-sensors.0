From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20030907192618.50566c64.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> I have an as99127f too, and i've found a little pb with the temp,
> on the as99127f i have the hyst and limit temp need an extra scale by
> two so i have scaled every one (in the following patch) and you need
> a compute line to restore the correct temp for the temp itself.

I'm not sure you're doing the right thing there. It is known that there
are different versions of the AS99127F, with different temp conversion
formulae. See this snippet of our default configuration file.

---
# Depending on your motherboard, you have to choose between three
# formulae for temp2. Quoting Artur Gawryszczak:
# "I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is
# correct for those Asus motherboards, which get CPU temperature from
# internal thermal diode (Pentium Coppermine, and above), and "temp2
# @*2.0, @/2.0" is correct for Athlon/Duron boards, which use a
# thermistor in the socket."
# The third formula was found and reported by Victor G. Marimon.
# Asus CUV4X, Asus A7V8X
#   compute temp2 (@*30/43)+25, (@-25)*43/30
# Asus A7V133, Asus A7M266
    compute temp2 @*2.0, @/2.0
# Asus CUSL2
#   compute temp2 (@*60/43)+25,(@-25)*43/60
---

As you can see, not *all* motherboads need the *2 scaling, so you'd
better keep the things the way they are and let the user chose using
/etc/sensors.conf.

> I've some weird pb with the in0, in1 in5 and in6 min and max value,
> too but the old w83781d driver gives the same results (ie 0.00)

The "problems" with in1, in5 and in6 are known too. Two other snippets:

---
# Dual power plane
    label in0 "VCore 1"
    label in1 "VCore 2"
# Single power plane (A7V133, A7M266)
#   label in0 "VCore"
#   ignore in1
---
# These last two may not make sense on all motherboards.
    label in5 "-12V"
    label in6 "-5V"
---

But in0 should be OK for everyone, providing that the VRM setting is OK.

> And worst of all the CPU temp of the Athlon 700 is beeping it is
> awfull i had to unplug the buzzer ... but i don't know why, since it
> gave this result:
> CPU Temp:  +32.4?C  (limit = +120?C, hysteresis = +100?C)       
> (beep) btw this beep are launched even with using  the old w83781d
> driver, and i don't know how to stop it except by rebooting the
> computer which is not a very good options since it is my gateway.

We have had many reports about beeping issues with the AS99127F, and it
turned out that a bad VRM setting and/or bad in0 limits were the cause.
Make sure it's all OK for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
