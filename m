From: jackie_lola@yahoo.fr (jackie)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Installation   lm_sensors-2.9.0, sur Suse 9.2 , noyau 2.6
Message-Id: <200502131340.12255.jackie_lola@yahoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502131137.43844.jackie_lola@yahoo.fr>
In-Reply-To: <200502131137.43844.jackie_lola@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Dimanche 13 F?vrier 2005 11:49, Jean Delvare a ?crit?:
> Hi Jacqueline,
>
> > Impossible to install with the two commands  make user and make
> > user_install.
> >  I have a mother board  Asus P4PE-X with Pentium Celeron 2,4 Ghz
> >
> >
> > When in the good rep :
> >
> > ip-10:/home/jackie/Documents/Paquetages/Ksensors/lm_sensors-2.9.0/lm_
> > sensors-2.9.0
> >
> > Doing :  make
> >
> > here is the second part of errors message.
>
> Hm, you are supposed to run "make user", *not* "make". What happens when
> you run "make user"?

Thank you for your answer 

 With  "make user" i  got an error...  but  i think i was was not in the good 
directory... 

I don't have any explication about "user", in man make. I dont understand what 
it is ?

jackie@ip-10:~> su root
Password:
ip-10:/home/jackie # make user
make: *** Pas de r?gle pour fabriquer la cible ? user ?. Arr?t.
ip-10:/home/jackie # make user_install
make: *** Pas de r?gle pour fabriquer la cible ? user_install ?. Arr?t.
ip-10:/home/jackie #

I hope my system is not bad now.. Is it possible to clean it, before another 
try.

 Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050213/adaa3f52/attachment.html
