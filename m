From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: (p4s133-vm)  and intel (  D845GVSR) supported?
Message-Id: <Pine.LNX.4.58.0409072118030.19686@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello,

Answer is: "Most likely"


Software way:

Best way will be just trying to install our lm_sensors package.
It has "sensors-detect" program for detecting the chips.

Here is some guide of chips identifation
http://www2.lm-sensors.nu/~lm78/identify.html

Ways to get the package

http://www2.lm-sensors.nu/~lm78/archive/lm_sensors-2.8.7.tar.gz

1) from our web site
2) from mandrake/debian/etc as instalation package


For 2.6.x kernels and our web package:

1) decompress
2) run: make user_install
3) run: sensors-detect


For 2.4.x Kernels
0) also install http://www2.lm-sensors.nu/~lm78/archive/i2c-2.8.7.tar.gz
1) decompress
1.5) make sure that you have kernel headers installed somewhere(or kernel)
2) run: make install
3) run: sensors-detect


Generally http://www2.lm-sensors.nu/~lm78/docs.html

You will find "Quickstart" guides etc

I hope this helps.

Hardware way:

If you want hardware way you can try to look at the motherboard
and compare chips names with http://www2.lm-sensors.nu/~lm78/supported.html
this list :)

Dont forget to CC the mail to list also.

regards

Rudolf

On Tue, 7 Sep 2004, firase kaled wrote:


> hi i have asus motherboard (p4s133-vm)  and intel (  D845GVSR)  I want to know if
> chip driver and bus driver supported or not
> thanks
>
> _________________________________________________
> See cool party pictures from clubs and restaurants in Jordan, Lebanon, and Dubai. GO to Shuftek Parties now
> http://www.shuftak.com
>
>
