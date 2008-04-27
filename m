From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Apr 2008 19:46:09 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon (dme1737): add support for
Message-Id: <20080427214609.57c281d0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <480EC83A.6080709@gmail.com>
In-Reply-To: <480EC83A.6080709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Apr 2008 12:31:54 -0700, Juerg Haefliger wrote:
> On Sun, Apr 27, 2008 at 12:25 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sun, 27 Apr 2008 12:18:51 -0700, Juerg Haefliger wrote:
> >  > The sch5027 has only 3 VID inputs VID3-5. Bits0-2 of the VID register
> >  > are reserved.
> >
> >  This doesn't make much sense. 3 high VID bits without the corresponding
> >  3 low VID bits is pretty useless. I'm really curious what the designer
> >  had in mind... Anyway, what you have now doesn't add any value and
> >  could even be confusing. I'd rather not expose any VID value at all for
> >  the SCH5027 - my random guess is that these pins won't be wired in
> >  practice anyway.
> 
> So you're saying I should remove the vid & vrm sysfs attributes for this chip?

Yes, this is what I'm suggesting.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
