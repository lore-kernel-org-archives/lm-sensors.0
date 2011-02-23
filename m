From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Feb 2011 20:36:57 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110223213657.6abebb11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Feb 2011 17:20:09 -0500, Lennart Sorensen wrote:
> On Tue, Feb 22, 2011 at 11:10:44PM +0100, Jean Delvare wrote:
> > Yes and no. 4 bits for the device ID is weak, especially when in a
> > random register (which is why I insisted in using the whole 8 bits,
> > including the revision.) "Good" devices have 8 bits of vendor ID + 8
> > bits of device ID at semi-standard addresses, and even this is not
> > bullet proof.
> 
> Given they support 16 bit register on the LM75 already, I must admit I
> am amazed they didn't do an 8 bit ID and 8 bit revision using a 16bit
> register.

True. And they could have put an 8-bit manufacturer ID register at 0x06
too. But I guess it would have been too simple and straightforward and
they preferred to have some fun with us :/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
