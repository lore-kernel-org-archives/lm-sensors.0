From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Acquiring an i2c adapter.
Message-Id: <20040222092246.56202315.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4037FB21.20701@linuxmail.org>
In-Reply-To: <4037FB21.20701@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> We've been wondering over here at sensors what the point was of unique
> IDs. nobody seemed to use them.

I think we have to make a difference between adapters and chips here. It
looks quite obvious that adapters' IDs may have a use (as this is the
case now). What I think Greg was suggesting is that we could drop IDs of
_chip_ drivers, because those will hardly ever get used.

Although, I don't think was thinking of deleting the id field in the
structure definition, only not to fill them when we don't need to. As
time passes, I tend to agree more and more. I just have some
difficulties submitting a driver with no ID, because they all have one
in both 2.4 and 2.6 so it feels strange to change now. But I admit it
isn't rational.

I think it would be acceptable to stop filling the id field by default,
and only fill them when we need them to be filled.

> Your application is an obvious example of their purpose.
> On the Voodoo, the DDC bus should have a separate ID from the I2C bus.
> Then you could distinguish them without a strcmp.

Correct.

> Perhaps we should add IDs to 2.6?

And have 2 different IDs in the 2.4 driver as well, for we want to be
consistent.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
