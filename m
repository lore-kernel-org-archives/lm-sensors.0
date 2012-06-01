From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 01 Jun 2012 15:39:01 +0000
Subject: Re: [lm-sensors] Problems with SMSC EMC2103-2
Message-Id: <20120601153901.GB25384@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
In-Reply-To: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 01, 2012 at 03:50:37AM -0400, Jean Delvare wrote:
> On Thu, 31 May 2012 13:56:06 -0700, Guenter Roeck wrote:
> > On Thu, 2012-05-31 at 16:13 -0400, Jean Delvare wrote:
> > > The SMBus controller is missing (should be at 00:1f.3.) This explains
> > > why sensors-detect couldn't see the SMSC EMC2103 chip.
> > > 
> > > This is something that was often seen on ICH3/4/5/6 systems, and the
> > > kernel includes code to unhide the SMBus on these old chipsets, but I
> > > think the latest one covered is the ICH7. We'd need to do the same with
> > > the ICH9.
> > > 
> > The current version of i2c-i801.c does support ich9. Am I missing
> > something ? Is there a missing variant ?
> 
> I'm not talking about chip support, but about chip _unhiding_ support.
> This happens in drivers/pci/quirks.c, look at functions
> asus_hides_smbus_lpc and asus_hides_smbus_lpc_ich6.
> 
> So actually ICH6 is the last one handled there, not ICH7.
> 
Got it, thanks. Given the explanation in the file, I'd be a bit hesitant
to add a new entry unless we know for sure that it does not cause trouble.

On my ASUS board (P8H67-V) Linux loads the i2c-i801 driver, so I guess Asus
stopped the hiding games at some point.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
