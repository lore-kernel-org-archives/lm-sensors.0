From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Oct 2012 18:14:37 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/8] hwmon: it87 patch series
Message-Id: <20121028181437.GA13927@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1350841995-5748-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1350841995-5748-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 23, 2012 at 05:09:46PM +0200, Jean Delvare wrote:
> On Sun, 21 Oct 2012 10:53:07 -0700, Guenter Roeck wrote:
> > This series started with the idea of adding temperature offset registers.
> > It ended with fixing all checkpatch warnings and errors, and reducing
> > object file size by more than 2k on x86_64.
> > 
> > v2: Added one more patch to the series, and don't introduce has_16bit_fans
> >     flag (which was dropped in the latest patch anyway).
> 
> Do you have the hardware to test the it87 driver? I no longer do :(
> 
Update ... I got hardware with IT8728F. The offset register patch has a bug,
the rest is working. I'll send an updated patch series later today or tomorrow.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
