From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 06 Jun 2014 08:36:28 +0000
Subject: Re: [lm-sensors] Driver for PC87372
Message-Id: <20140606103628.6e78733c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
In-Reply-To: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 6 Jun 2014 00:51:40 -0700, Guenter Roeck wrote:
> On Fri, Jun 06, 2014 at 09:23:26AM +0200, Jean Delvare wrote:
> > > Even with a board, I for my part would not have time for writing a driver.
> > > Given the age of the chip, my expectations for finding someone to write
> > > a driver would be quite low. Any chance doing it yourself ?
> > 
> > Well, before anyone spends time writing a driver, Michael should ensure
> > that such a driver is really needed. All previous investigations of
> > PC87372 user cases came to the conclusion that this chip was not used
> > for monitoring, and instead a dedicated monitoring chip was connected
> > to the SMBus.
> > 
> If I remember correctly, the chip only supports fan control, not any voltage
> or temperature monitoring, so that separate chip would be needed anyway.

Ah, right. It's odd then, sensors-detect should have probed the SMBus
already. Unless Michael explicitly refused that, or is using an old
version of the script maybe.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
