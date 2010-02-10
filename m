From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Feb 2010 19:40:57 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100210204057.2ca95b0d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On 10 February 2010 20:01, Darrick J. Wong <djwong@us.ibm.com> wrote:
> > You might also try the i2c-scmi driver.... if the BIOS is set up correctly.
> > I don't remember when it went in the kernel other than it was in the
> > 2.6.32/33
> > timeframe.

The i2c-scmi driver was added in the 2.6.32 kernel.

On Wed, 10 Feb 2010 20:07:44 +0200, D. Can Celasun wrote:
> I can load the i2c-scmi driver, here is the relevant kernel log:
> 
> Feb 10 20:04:52 dcclinux kernel: i2c /dev entries driver

This message is from i2c-dev, not i2c-scmi.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
