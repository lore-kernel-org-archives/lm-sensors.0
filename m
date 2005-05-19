From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FCD4B51.4F5D3F54@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> > > One additional note. In sensors-detect we scan all addresses from
> > > 0x00 to 0x7F. I don't think it's correct. According to what I know,
> > > 0x00, 0x02-0x03, 0x0C and 0x7C-0x7F should not be scanned, being
> > > respectively the general call address, a reserved range, the alert
> > > response address and another reserved range. I propose to exclude
> > > these addresses from the scan. Then, all we need to do is add four
> > > addresses to the exclusion list if an IBM system is detected. This
> > > also opens a path for more addresses exclusions if this is needed
> > > later.
> >
> > agreed. this used to be on my to-do list.
> > i2c-core scans all addressess too which is even worse
> > than having userspace do it.
> 
> Does i2c-core scan anything? I thought the chip drivers were (and not
> all addresses of course, only those specified in the driver).
> 

well, i2c-core has i2c-probe(), but nobody calls it but lm92.
interesting.
i2c-proc has i2c-detect(), which all the drivers call
(including lm92... hmm...).

But the clients control the address range for both calls,
so that's OK. Although maybe i2c-core and i2c-proc shouldn't allow
scans of 0x00?


> > Actually it's not that bad to scan all the adresses,
> > it's just bad to probe them all with each of the driver tests.
> 
> What distinction do you make here between scan and probe? Not sure I get
> you.
> 

By 'scan' I meant a presence detect using write quick.
By 'probe' I meant reading registers in the device to look for device
IDs, etc.
That may not be the correct terminology.

> > the worst one is 0x00. The others shouldn't really be a problem, I
> > don't think.
> 
> Agreed, but I don't see the point in scanning addresses that cannot be
> used by valid chips.
> 
> My fear with 0x00 is that, if it really works as a broadcast address, a
> quick write on it could reach a 24RF08 chip, and break it (since the
> workaround is only enabled on addresses 0x54-0x57).
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
