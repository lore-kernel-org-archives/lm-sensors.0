From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Nov 2009 18:52:17 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <20091122195217.0777b1fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Nov 2009 08:57:18 -0800, Allen Edwards wrote:
> On Sun, Nov 22, 2009 at 8:35 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > You forgot to install flex and bison, and our build system isn't
> > exactly user-friendly. After you do, run "make clean" then "make" again.
> >
> > That being said... pwmconfig is a shell script, it doesn't need to be
> > built.
>
> Actually, I did install both of these programs as the documentation is
> pretty clear on that.
> 
> dad@myth_desktop:~/lm_sensors-3.1.1$ bison --version
> bison (GNU Bison) 2.3
> Written by Robert Corbett and Richard Stallman.
> 
> Copyright (C) 2006 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> dad@myth_desktop:~/lm_sensors-3.1.1$ flex  --version
> flex 2.5.34

Did you run "make clean" before running "make" again after installing
flex and bison? This is required.

If you did and it did not help, please provide a full build log and
I'll look at it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
