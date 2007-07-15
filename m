From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jul 2007 08:34:58 +0000
Subject: Re: [lm-sensors] fintek f71806f "support"
Message-Id: <20070715103458.271a8aa1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46913350.70300@hhs.nl>
In-Reply-To: <46913350.70300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 10 Jul 2007 23:44:24 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > As said above, the f71805f driver does not use these offset registers.
> > If said offset registers are read-only on the F71806F, that would be a
> > way to differentiate between both chips (arguably ugly, but...)
> 
> Yes, but then again the F71806F may have those registers too.

I've asked my Fintek contact about this, waiting for him to answer. He
already confirmed that the F71806F/FG and F71872F/FG really had the
same chip ID and it wasn't an error in the datasheet.

> > Now, the f71805f driver (and documentation) would need to be updated to
> > list the F71806F/FG as supported. Can you please submit such a patch,
> > or do you want me to do it?
> 
> Well since you are the maintainer of the f71805f driver, I think its best and 
> easiest if you do it.

OK, I'll post a patch in a few minutes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
