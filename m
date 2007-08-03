From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 03 Aug 2007 02:58:24 +0000
Subject: Re: [lm-sensors] [PATCH] [RESEND #8] f75375s driver
Message-Id: <20070803025824.GA6221@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F7C18.80200@movial.fi>
In-Reply-To: <469F7C18.80200@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Riku:

* Riku Voipio <riku.voipio@movial.fi> [2007-08-02 15:36:27 +0300]:
> Mark M. Hoffman wrote:
> >Comments are inline...
> >  
> Thanks for review, fixing most issues was straightforward
> for all except:
> >>+static inline u16 f75375_read16(struct i2c_client *client, u8 reg)
> >>+{
> >>+	return ((i2c_smbus_read_byte_data(client, reg) << 8)
> >>+		| i2c_smbus_read_byte_data(client, reg + 1));
> >>+}
> >>+
> >>    
> >
> >This is horrible hardware design.  A single _read_word_data() would be much
> >better here, but the datasheet apparently doesn't allow for it.  Neither 
> >does
> >the datasheet give advice for how to read the word-sized values coherently.
> >
> >E.g. it's common in such situations for the hardware to lock the second 
> >byte
> >from updating for some time after the first byte is read.  That's what I 
> >was
> >looking for in the datasheet to make sure you did the accesses in the right
> >order.  AFAICT, nothing - so it's possible this thing is inherently racy.
> >
> >  
> 
> I could use the update_mutex to avoid reading words when they are being
> updated,

yes... s/could/should/

> but that does not protect from the chip modifying the values 
> itself?

IIRC the datasheet did not mention it... so yes, we can't rule it out.  Is
there a bit in somewhere that can completely stop the chip from updating?  If
so, then we could set it at the start of an update and clear it at the end.
Otherwise, I don't think there's anything we can do about it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
