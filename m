From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Thu, 19 Apr 2012 11:15:24 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <185823278.20120419151524@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, Jean Delvare!

> -          grep -q '^$(LIBDIR)$$' /etc/ld.so.conf || \
> -          grep -q '^$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
> -          grep -q '[[:space:]:,]$(LIBDIR)$$' /etc/ld.so.conf || \
> -          grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
> +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)$$' || \
> +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)[[:space:]:,=]' || \
> +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)$$' || \
> +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' || \
>                 ( echo '******************************************************************************' ; \
>                   echo 'Warning: Library directory $(LIBDIR) is not in /etc/ld.so.conf!' ; \
>                   echo '         Add it and run /sbin/ldconfig for the userspace tools to work.' ; \

http://en.wikipedia.org/wiki/Cat_(Unix)#Useless_use_of_cat

Move file lists to grep, save yourself a few CPU cycles.


--
WBR,
Andrey Repin (hell-for-yahoo@umail.ru) 19.04.2012, <15:08>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
