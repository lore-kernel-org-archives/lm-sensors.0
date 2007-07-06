From: "Ivo Manca" <pinkel@gmail.com>
Date: Fri, 06 Jul 2007 21:44:00 +0000
Subject: Re: [lm-sensors] Odp:  Sensors working on DL360?
Message-Id: <01f401c7c016$c49ebf60$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <468e04f3cde05@wp.pl>
In-Reply-To: <468e04f3cde05@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Bart,

>> It does not work with lmsensors 2.x, you need to download the
>> latest lmsensors 3 branch.

> I must be doing something wrong. I've retrieved the latest lm-sensors 
> code
> from SVN using
>
>    svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors

Just a wild guess, but doesn't
"svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors" 
checks out the 2.x branch?

As far as I know, you need "svn checkout 
http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0" for the 
3.0.0 branch.
Not sure if it makes a difference, but might be worth a shot :)

--
Ivo Manca

----- Original Message ----- 
From: "Bart van Kuik" <lmsensors@vankuik.nl>
To: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Cc: "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Friday 6 July 2007 15:57
Subject: Re: [lm-sensors] Odp: Sensors working on DL360?


> Hi Krzysztof,
>
>>> I'm trying to get sensor readouts on a Compaq DL360
>> My bet it uses thmc50 driver which is just being ported to 2.6.
>
> I must be doing something wrong. I've retrieved the latest lm-sensors 
> code
> from SVN using
>
>    svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors
>
> Then compiled and installed with "make user && make user_install". But 
> I
> don't get results:
>
>    # sensors -c /etc/sensors.conf "thmc-*"
>    Specified sensor(s) not found!
>
> Also, can I visually identify this chipset somehow on the motherboard?
> I've tried to look for an IC marked "TI", but couldn't find it.
>
> Output of lsmod is here:
>    http://www.vankuik.nl/download/lsmod_output
>
> Output of "uname -r" is:
>
>    2.6.18-8.1.6.el5xen
>
> Any ideas?
>
> Bart
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
