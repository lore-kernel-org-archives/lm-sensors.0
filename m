From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 17:06:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f71805f) Fix clamping of temperature limits
Message-Id: <20120120170619.GA1035@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120120160923.5f690806@endymion.delvare>
In-Reply-To: <20120120160923.5f690806@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 20, 2012 at 11:41:57AM -0500, Jean Delvare wrote:
> On Fri, 20 Jan 2012 07:22:29 -0800, Guenter Roeck wrote:
> > On Fri, Jan 20, 2012 at 10:09:23AM -0500, Jean Delvare wrote:
> > > Properly clamp temperature limits set by the user. Without this fix,
> > > attempts to write temperature limits above the maximum supported by
> > > the chip (255 degrees Celsius) would arbitrarily and unexpectedly
> > > result in the limit being set to 0 degree Celsius.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: stable@vger.kernel.org
> > 
> > Good catch. Applied.
> 
> Note that this patch conflicts with one of yours. For smooth
> integration in stable trees it would be best to apply mine first and
> yours on top. If you can't be bothered, you can also drop all f71805f
> patches and I'll handle them, just let me know.
> 
No problem; thanks for the note. Fixed it already, by moving your patch
to the head of my patch list.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
