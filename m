From: Frank Myhr <fmyhr@fhmtech.com>
Date: Wed, 17 Sep 2008 13:50:06 +0000
Subject: Re: [lm-sensors]
Message-Id: <loom.20080917T134637-748@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew Paprocki <andrew <at> ishiboo.com> writes:
> The IT8712F v0.9.1 datasheet applies to revisions >= 0x8 (J).
> The driver was incorrectly attempting to enable 16-bit fan
> readings on rev 0x7 (I) which led to incorrect RPM values.
> 
> Signed-off-by: Andrew Paprocki <andrew <at> ishiboo.com>
> Tested-by: John Gumb <john.gumb <at> tandberg.com>

The IT8712F v0.81 datasheet appears to apply to rev 0x7 (I),
and shows 16-bit fan tachs. But John's experience seems to
indicate that the datasheet is in error.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
