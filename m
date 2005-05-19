From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20030716145329.39a33cc3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i own an Asus Mainboard with it's infamous ASB100 Bach ASIC. I
> wanted to get it work with lm_sensors, but some part were
> behaving mysteriously (mainly the 2d fan speed and the 2nd temp).
> 
> While googling i found something that may interesst you:
> http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html
> 
> the xmbmon package which is in the following license:
>   The programs are completely free software.   Any modifications
> and changes to the programs are welcome, and they are freely
> copied and distributed.  The author is not at all responsible if
> anyone have any problems or damages when using the programs.  The
> author won't keep the development of the programs any further, at
> least now.  But if someone develops any new better programs based
> on my own, I am very glad if feedback is made to me (of course,
> it is not at all any duties!).
> 
> THis software is able to initialise correctly the ASB100 ASIC
> (since after running mbmon sensors can find the fan 2 speed, but
> not the temp2) and to read the Athlon thermal diod temperature.
> 
> Maybe some of its code can be ported to lm_sensors ?

Why not. The first step IMHO would be to have a separated prefix for the
asb100. It is currently handled as an as99127f. Then we could see what
can be done to support the asb100 better.

One of our users, Bryan Almeda,  already made some work in this
direction. His work is avilable there:
  http://tynian.net/asb100/
Please test his patch and tell us how it works for you.

You can see the original post there:
  http://archives.andrew.net.au/lm-sensors/msg03356.html

BTW you can browse the mailing list archive, there are many different
threads about the ASB100, maybe some of them may be of interest for you.

I don't plan to make the changes myself, because I don't have a
motherboard with an ASB100 on it. I know Mark Hoffman does, so I guess
it would be easier for him to do the changes. If you have sufficent
knowledge, maybe you could help too?


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
