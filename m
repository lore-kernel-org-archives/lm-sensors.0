From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 15 Oct 2007 05:35:19 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520710142235kacf8e99sdc4e454ede4229@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On 10/14/07, Jim Cromie <jim.cromie@gmail.com> wrote:
> 05 - use superio-locks in rest of drivers/hwmon/*.c
>
> this patch is compile-tested only, please review for sanity before you
> try running them.  Things to look for - missing superio_release(),
> opportunities to use superio_devid(), superio_inw(), etc.
>
>
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> ---
> hwmon-superio-others
>  Kconfig      |    6 +++
>  f71805f.c    |   86 +++++++++++++++-------------------------------
>  it87.c       |   80 +++++++++++++++---------------------------
>  smsc47b397.c |   63 ++++++++++++---------------------
>  smsc47m1.c   |   69 +++++++++++++------------------------
>  vt1211.c     |   70 +++++++++++++------------------------
>  w83627ehf.c  |  110 +++++++++++++++++++++++++----------------------------------

I'll test on w83627ehf hardware and report.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
