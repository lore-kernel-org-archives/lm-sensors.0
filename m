From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 15 May 2006 20:54:49 +0000
Subject: [lm-sensors] [PATCH] hwmon sysfs documenation update
Message-Id: <4dfa50520605151354t2459f76doac906be1e1db16b7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4468E7CF.7040109@sh.cvut.cz>
In-Reply-To: <4468E7CF.7040109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

>                 However, some drivers (notably lm87 and via686a)
> -               do scale, with various degrees of success.
> +               do scale, because of internal resistors build into a chip.
>                 These drivers will output the actual voltage.
>
>                 Typical usage:
> @@ -104,15 +110,25 @@

Instead of "internal resistors build into a chip" you want to say
"internal resistors built into a chip". Sorry, I don't mean to be a
spelling nazi.

David

