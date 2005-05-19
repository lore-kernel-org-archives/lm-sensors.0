From: boi@kbs.twi.tudelft.nl (Boi Sletterink)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Lm_sensors Support DB Entry #849
Message-Id: <20020519233411.GA13485@chrysler.kbs.twi.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

another update on my previously reported problem (Ticket # 849).

I finally got around to checking out my mainboard and it seems that it has
an ICS 94228 (rev. 8) clock generator. The good news is that you can find
the datasheet online: http://www.icst.com/products/summary/via_kt266.htm

After reading a bit, I found that it is indeed programmable through the I2C
bus. However, it is rather strange that it is supposed to be on address 0xd2
instead of 0x4e, where the non-existing lm75 was detected. Then again, I
don't know much about I2C so I might be wrong here...

Cheers,
Boi

-- 
                Predestination was doomed from the start.
 ------------------------------------------------------------------------
Support your freedom and privacy, support OpenPGP - http://www.openpgp.org/
My PGP key: http://www.kbs.twi.tudelft.nl/People/Staff/B.Sletterink/boi.pgp
