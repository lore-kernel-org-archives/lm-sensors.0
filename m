From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 05 Oct 2007 04:15:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/3 RESEND 2] hwmon/dme1737: cleanups
Message-Id: <191fb4ca0710042115k35f0ac5bu3de9e3802bb853fc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710012119s713699efhd479c6326c9dbcb@mail.gmail.com>
In-Reply-To: <191fb4ca0710012119s713699efhd479c6326c9dbcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 10/4/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 1 Oct 2007 21:19:04 -0700, Juerg Haefliger wrote:
> > This patch cleans up and prepares the dme1737 driver for support of the sch311x
> > chips. (Almost) no functional changes.
> >
> > - Replaced whitespaces with tabs.
> > - Removed empty lines.
> > - Added _i2c_ to names of functions that are strictly I2C related.
> > - Added 4 new functions: dme1737_create_files, dme1737_remove_files,
> >  dme1737_sio_enter, and dme1737_sio_exit.
> > - Added error messages in case client attach/detach fails.
>
> Not really, as you backed up (most of) these changes. Anyway...
>
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Acked-by: Jean Delvare <khali@linux-fr.org>
>
> Note that I had to replace all occurrences of "class_dev" to
> "hwmon_dev", otherwise this patch doesn't apply on top of "hwmon:
> Convert from class_device to device" in Mark's tree.

Ok. How can I create patches against the (latest) hwmon tree? Do I
need to git-clone it? If yes, how?
git-clone git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git doesn't
seem to give me the latest and greatest.

Thanks
...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
