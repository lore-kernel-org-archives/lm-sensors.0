From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jul 2007 09:43:40 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <20070710114340.42f1dcbd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Mon, 9 Jul 2007 20:27:46 +0200, Jean Delvare wrote:
> On Sun, 08 Jul 2007 14:14:34 +0200, Hans de Goede wrote:
> > With this patch the abituguru refuses to load on non Abit motherboards, as
> > discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
> > 
> > Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Thanks for doing this.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Thinking about it some more... You may want to skip the DMI test if the
force module parameter is used, in case Abit stops being consistent for
the DMI board vendor name field.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
