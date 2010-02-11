From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Feb 2010 08:17:43 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100211091743.287030b0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
In-Reply-To: <d35bed621002100300n23e6b881yfa80b9b1eb7d061d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On 11 February 2010 03:21, Darrick J. Wong <djwong@us.ibm.com> wrote:
> > Does sensors-detect/i2cdetect find anything on either i2c controller?

On Thu, 11 Feb 2010 09:33:06 +0200, D. Can Celasun wrote:
> Relevant sensors-detect output:
> 
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
> Sorry, no supported PCI bus adapters found.
> Module i2c-dev loaded successfully.

At that time, the i2c-i801 driver was loaded but not the i2c-scmi
driver. The i2c-i801 driver is hopeless (can't bind to the device). You
could try loading the i2c-scmi driver manually and running
sensors-detect again.

Darrick, any chance we could get the i2c-scmi driver to load
automatically on systems which need it?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
