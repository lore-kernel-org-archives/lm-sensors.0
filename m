From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 13 Oct 2007 03:02:10 +0000
Subject: Re: [lm-sensors] [PATCH RESEND 3] hwmon/dme1737: add sch311x support
Message-Id: <191fb4ca0710122002od30fb37v980e7061da0f22f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710072127j7113780dx8a60b475d7a8f772@mail.gmail.com>
In-Reply-To: <191fb4ca0710072127j7113780dx8a60b475d7a8f772@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On 10/10/07, Mark M. Hoffman <mhoffman@lightlink.com> wrote:
> Hi:
>
> * Jean Delvare <khali@linux-fr.org> [2007-10-09 18:18:28 +0200]:
> > Hi Juerg,
> >
> > On Sun, 7 Oct 2007 21:27:35 -0700, Juerg Haefliger wrote:
> > > 3rd iteration of the patch:
> > > - fixed header comment
> > > - replaced dme1737_update_device with dev_get_drvdata in show_name
> > > - replaced class_dev with hwmon_dev
> > >
> > >
> > > This patch adds support for the SMSC SCH3112, SCH3114, and SCH3116 Super-I/O
> > > chips. These chips feature identical hardware monitoring capabilites with the
> > > exception that some of the fan inputs and pmw outputs don't exist.
> > >
> > > The hardware monitoring features of the SCH311x chips can only be accessed via
> > > the ISA bus. The driver therefore registers as a platform driver, if such a
> > > chip is detected.
> > >
> > > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> >
> > No more comments.
> >
> > Acked-by: Jean Delvare <khali@linux-fr.org>
>
> Applied to hwmon-2.6.git/testing.  Please make sure that my merge results are
> identical to yours - thanks.

I checked out a snapshot of your testing tree and diff'ed it against
my tree. It's all clean, it's all good.

...juerg



> --
> Mark M. Hoffman
> mhoffman@lightlink.com
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
