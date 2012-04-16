From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Apr 2012 07:35:21 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120416093521.4dd45a3f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

Please don't top-post, and please leave the list included.

On Sun, 15 Apr 2012 17:29:23 +0100, Martin Suchanek wrote:
> Hi ,
> thanks for helping me out.
> bulding for local host.

You didn't answer my question: what system (which distribution) are you
building on?

> libiconv.so.2 (libc6,x86-64) => /usr/lib/libiconv.so.2
> dpkg -l|grep libicon
> ii  libiconv-hook-dev
> 0.0.20021209-10                                        header files of libiconv-hook
> ii  libiconv-hook1
> 0.0.20021209-10                                        extension of iconv for libapache-mod-encoding

Hmm, OK, so you do have one libiconv library on the system, but I'm not
sure if you really need to link against it, as it seems to be
apache-specific (no idea why though.)

Please list all files that match /usr/lib/libiconv.so.*, and for each
of them, check which package provides it.

Then as a test you can edit prog/sensors/Module.mk, search for the
following line:

LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then echo \-liconv; else echo; fi)

Replace with:

LIBICONV := 

and try building again. Obviously this can't be a definitive fix but at
least it will tell us if you really need libiconv or not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
