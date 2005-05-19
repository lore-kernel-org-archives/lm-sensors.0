From: skarkkai@woods.iki.fi (Samuli =?iso-8859-1?Q?K=E4rkk=E4inen?=)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Some oopsen
Message-Id: <20030928085047.GC11794@woods.iki.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030928084506.GB11794@woods.iki.fi>
In-Reply-To: <20030928084506.GB11794@woods.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

A followup to my previous mail.

> Process adjust-fan-spee (pid: 11208, stackpage=D687f000)

This program "adjust-fan-speed" that triggers most of the oopsen does,
essentially:

/usr/local/bin/sensors
echo 30 > /proc/sys/dev/sensors/w83627hf-isa-0290/pwm1
echo 30 > /proc/sys/dev/sensors/w83627hf-isa-0290/pwm2

--=20
  Samuli K?rkk?inen                   |\      _,,,---,,_
 skarkkai@woods.iki.fi ---------ZZZzz /,`.-'`'    -.  ;-;;,_------
http://www.woods.iki.fi              |,4-  ) )-,_. ,\ (  `'-'
                                     '---''(_/--'  `-'\_)
