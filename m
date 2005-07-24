From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Jul 2005 20:09:18 +0000
Subject: [lm-sensors] I2C support oddities
Message-Id: <20050724200911.5b733de7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <PFEDLPHCOBHEOIOMGBIECEKGCAAA.david.vanhoose@comcast.net>
In-Reply-To: <PFEDLPHCOBHEOIOMGBIECEKGCAAA.david.vanhoose@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I stumbled across what looks to be a couple of bugs and flaws in the
> I2C code. The biggest issue being swapped parameter values in the
> smbus_xfer functions. You might look at it and check to see if I'm
> right.

No, it doesn't work that way. If you think you found bugs, please point
us to them and explain in detail why you think these are bugs, and if
possible propose a patch fixing them. Don't just claim you found bugs
and let us blindly search for them, it's inefficient.

> Also, I believe that the write functions need to have their
> data parameter be constant. I get some warnings about using
> decoder_init::data with smbus_write_block_data. None of the write
> functions employ constant data pointers. Do you think that the
> non-constant pointers should be changed to constant pointers?

"write functions" is a bit vague. "some warnings" is a bit vague.
"decoder_init::data" is something we don't know about. If you really
need help, please describe your problem precisely, show us some code,
tell us the exact warnings you get. I'm sorry but we can't help you if
you don't provide the information we need to do so.

-- 
Jean Delvare
