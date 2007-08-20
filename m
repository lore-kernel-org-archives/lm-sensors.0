From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 20 Aug 2007 17:49:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070820174952.GA4603@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Aug 2007, Jean Delvare wrote:
> On Mon, 20 Aug 2007 09:46:56 -0300, Henrique de Moraes Holschuh wrote:
> > I was not really thinking about exporting labels, but rather to export
> > something that can be a match key in the libsensors config file.
> 
> Except that libsensors4 is totally chip-agnostic by design, and I'd
> like it to stay that way. We already have two mechanisms to label the
> inputs (label files in sysfs and sensors.conf), I'd rather not add a
> 3rd one.

Well, as long as we can have different configurations for libsensors on
different thinkpad models, I don't really care :-)

> > > ISA port numbers and PCI IDs are unrelated. It's more PCI device number
> > 
> > I know.  I was trying to convey the idea that what comes after the "name"
> > for BUS_HOST could be DMI data, instead of ISA port numbers (used in ISA
> > stuff) or PCI IDs (used in PCI stuff), or I2C IDs (used in I2C/smbus)...
> 
> And I was trying to explain why using the "address" field of
> libsensors' chip name wasn't a good idea, because this field is there
> to differentiate between similar chips on a given machine, and not to
> identify a unique chip configuration. Using one field for different
> purposes could quickly lead to confusion IMHO.

I see.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
