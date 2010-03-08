From: Sean Fidler <fidlersean@gmail.com>
Date: Mon, 08 Mar 2010 07:26:26 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <a663a1a81003072326u20ca557fp6b2b71f9983be9a2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi, Jean,

I've run into a problem with the driver you wrote, smsc47m1.c
(http://khali.linux-fr.org/devel/misc/smsc47m1/). The server has been
moved from Ubuntu 9.10 to 8.04 (same hardware, Compaq Presario
S4000NX). When running "make" the following errors occur:

CC [M]  /home/sean/smsc47m1.o
/home/sean/smsc47m1.c: In function ‚Äòsmsc47m1_handle_resources‚Äô:
/home/sean/smsc47m1.c:558: error: implicit declaration of function
‚Äòacpi_check_region‚Äô
make[2]: *** [/home/sean/smsc47m1.o] Error 1
make[1]: *** [_module_/home/sean] Error 2
make: *** [modules] Error 2

The steps (i.e. isaset…) that were indicated in this thread work
correctly, as before.

—Sean—

On Fri, Feb 12, 2010 at 3:42 AM, Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Sean,
>
> Please keep the list in the loop.
>
> On Thu, 11 Feb 2010 19:25:49 -0500, Sean Fidler wrote:
> > The driver unloaded and loaded again without issue.
> > /proc/ioports output:
> > (...)
> > 0600-067f : smsc47m1
> >   0604-0604 : smsc47m1
> >   0633-0636 : smsc47m1
> >   0656-065c : smsc47m1
>
> OK, looks very good.
>
> > I have a question regarding sensors.conf, I updated the file with the text
> > from the configuration you posted, however, when I run sensors I see the
> > same information as before (i.e. sensors.conf not being used). If I run
> > sensors -c /etc/sensors.conf then the output is as expected. Just wanted to
> > confirm that this is correct functionality.
>
> Maybe you have /etc/sensors3.conf too? It takes precedence
> over /etc/sensors.conf for lm-sensors 3.x. If you are using lm-sensors
> 3.x then you want to edit /etc/sensors3.conf, not /etc/sensors.conf.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
