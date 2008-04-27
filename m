From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 27 Apr 2008 19:31:54 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon (dme1737): add support for
Message-Id: <191fb4ca0804271231x4bb9c652ncb601349f41963fb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <480EC83A.6080709@gmail.com>
In-Reply-To: <480EC83A.6080709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,


On Sun, Apr 27, 2008 at 12:25 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Sun, 27 Apr 2008 12:18:51 -0700, Juerg Haefliger wrote:
>  > >  On Tue, 22 Apr 2008 22:25:14 -0700, Juerg Haefliger wrote:
>
> > >  > @@ -565,7 +570,8 @@
>  > >  >
>  > >  >       /* Sample register contents every 1 sec */
>  > >  >       if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
>  > >  > -             data->vid = dme1737_read(client, DME1737_REG_VID) & 0x3f;
>  > >  > +             data->vid = dme1737_read(client, DME1737_REG_VID);
>  > >  > +             data->vid &= (data->type = sch5027) ? 0x38 : 0x3f;
>  > >
>  > >  This can't be correct. VID values are at least 4 bit wide and always
>  > >  right-padded. Masking with 0x38 just doesn't make sense. Can you
>  > >  explain?
>  >
>  > The sch5027 has only 3 VID inputs VID3-5. Bits0-2 of the VID register
>  > are reserved.
>
>  This doesn't make much sense. 3 high VID bits without the corresponding
>  3 low VID bits is pretty useless. I'm really curious what the designer
>  had in mind... Anyway, what you have now doesn't add any value and
>  could even be confusing. I'd rather not expose any VID value at all for
>  the SCH5027 - my random guess is that these pins won't be wired in
>  practice anyway.

So you're saying I should remove the vid & vrm sysfs attributes for this chip?

...juerg


>  --
>  Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
