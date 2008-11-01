From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 01 Nov 2008 17:33:19 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081101183319.3330c73a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 1 Nov 2008 18:11:26 +0100, Markus Rechberger wrote:
> On Sat, Nov 1, 2008 at 5:14 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sat, 1 Nov 2008 16:28:40 +0100, Markus Rechberger wrote:
> >> http://mcentral.de/hg/~mrec/em28xx-new/file/ca209b1d4076/cx25843/em28xx-cx25843.c
> >
> > This driver only attaches to (7-bit) address 0x44, while the lm90
> > driver probes for devices at 0x4c and 0x4d. So I have to admit I am
> > surprised that loading both drivers leads to the same result.
> 
> is there some debug that can be enabled in the i2c framework which
> might help you forward?

I don't think so. Let's wait for Peter to do the tests I suggested
first.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
