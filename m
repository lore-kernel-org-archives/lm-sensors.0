From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 15:59:30 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru3-detect.patch
Message-Id: <20070708155930.GD3591@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4689694A.3040708@hhs.nl>
In-Reply-To: <4689694A.3040708@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-02 23:08:26 +0200]:
> Hi All, Mark,
> 
> Mark, this fixes the abituguru3 driver not detecting the uguru3 on some 
> motherboards without the force=1 parameter, see:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id"0160
> 
> Can you apply this to your testing tree please? Thanks!
> 
> Regards,
> 
> Hans

> This patch changes the driver to also detect uguru3's which hold 0x08 at DATA
> initially, as has been reported here:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id"0160
> 
> Also when an uguru3's holds 0x0014 in the ID register it will now report 
> "Abit AB9 Pro" as motherboard identification.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to testing; thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
