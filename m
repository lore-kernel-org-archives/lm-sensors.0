From: Hubert Kario <hka@qbs.com.pl>
Date: Sat, 29 Aug 2009 08:30:25 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <200908291030.25637.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Saturday 29 August 2009 07:24:13 Tech2009 wrote:
> I am using an x86 ethernet NAS device with a preloaded custom Linux
> distribution.
>
> I replaced the OS with a stock debian kernel from another machine.
>
> Linux debian 2.6.26-2-686 #1 SMP Sun Jul 26 21:25:33 UTC 2009 i686
> GNU/Linux.
>
> Everything works minus the temperature sensors and LED control, both
> worked using the original proprietary software interface.
>
> The manual indicates the following fan controller is used:
> SMSC SCH5027D
>
>
> sensors-detect apparently finds this chip, and modprobe is able to load
> the dme1737 driver. (see attachments). Syslog shows nothing exceptional.

and what shows dmesg?

>
> "Probing for `SMSC SCH5027D-NW'...Success!
>     (confidence 6, driver `dme1737')"
>
> It's not until "sensors" that I see a problem:
> "No sensors found! Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are."
>
> Now my question is, is this user error, or is there an incompatibility
> in the sensors program with the dme1737 driver?
>
> I'm not afraid to try and debug the code myself if someone could set me
> on the right path.
--=20
Hubert Kario
QBS - Quality Business Software
02-656 Warszawa, ul. Ksawer=F3w 30/85
tel. +48 (22) 646-61-51, 646-74-24
www.qbs.com.pl

System Zarz=B1dzania Jako=B6ci=B1
zgodny z norm=B1 ISO 9001:2000

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
