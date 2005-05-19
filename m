From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client
Message-Id: <20040317222057.79f0451f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040316154454.GA13854@kroah.com>
In-Reply-To: <20040316154454.GA13854@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This topic makes me think of something _interresting_...
> 	
> According to the tests I made on my VIA Nehemiah M10k, the vt1211
> can be handled by i2c-viapro as an smbus device (via the vt596 it
> says) and via-ircc as an irda device, BUT this device can not be
> binded to both drivers at the same time : when one is loaded (and
> activated), the other finds no device (ENODEV I presume). (I wonder
> how I should use both smbus*and* irda device)...
> 
> Is this totally out of topic ?

"Off-topic" even, yes ;)

> Could a hack prevent these two drivers to be mutually exclusive?

We knew of a similar problem between i2c-viapro and via686a. I didn't
know that i2c-viapro and via-ircc had the same problem. And I guess that
i2c-viapro and vt1211 would conflict too?

Mark D. Studebaker is working on a solution for i2c-viapro and via686a.
I don't know if the same solution will apply in the other cases. Since
i2c-viapro is involved in all three conflicts, it promises to be damn
complex...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
