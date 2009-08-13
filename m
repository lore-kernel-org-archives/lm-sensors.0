From: Juerg Haefliger <juergh@gmail.com>
Date: Thu, 13 Aug 2009 18:36:43 +0000
Subject: Re: [lm-sensors] lm-sensors for Via C7 Esther
Message-Id: <191fb4ca0908131136g76bdc732q7646b73ca396d66e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Stephane

Sorry for the late reply.


> ehlo, both ...
>
> My name is St=C3=A9phane HUC. I'm french. (and my english is poor ;-) ...)
>
> I've seeing on the page lm-sensors ( http://www.lm-sensors.org/wiki/Devic=
es
> ) that you need testers for VIA C7 platform.
>
> My server run with Debian Testing :
> - kernel 2.6.26-2-686
> - lm-sensors Version: 1:3.1.1-2
> - my platform : Via C7-D !
>
> I've launching sensors-detect ... and it appear 'c7temp' module, but it's
> not in kernel.
> How testing it ?

There are 2 drivers floating around but neither has been pushed
upstream yet. Feel free to test both of them. You can get the patches
here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-June/023456.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026037.html

> How helping you ?

Load the two drivers and report the results to the list.


> Can i recompil my kernel ?

You don't have to recompile the kernel. Apply the patches to the
source of your running kernel, compile the modules and load them.

...juerg


>
> --
> ~ " Vivre Libre ! " ~
> [ Jabber ] ste@im.apinc.org
> [ Membre ] aGeNUx (.org), linucie (.net)
> [ Auteur ] Artiste Libre ( esteban-hache.net, ecrits.net )
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
