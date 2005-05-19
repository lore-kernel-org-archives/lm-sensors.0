From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Call for 2.9.0
Message-Id: <20041228174044.3fbf8342.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

> Unfortunately, Red Hat 2.1 Advanced Server uses a derivative of the
> 7.1  kernel: 2.4.9-e.24 (in Update 2).
> 
> So if we drop 2.4.9, then I think we need to test the Red Hat
> Advanced Server kernel.  (Which I will volunteer to do...)

I don't think we *need* to. You might want to, but that's different.

It is Red Hat's decision to stick to a 2.4.9 kernel. This means that
they are probably putting a lot of efforts in porting tons of fixes back
to it. Then they can do the same with lm_sensors, i.e. stick to 2.7.0
and backport whatever they like. This is certainly what they do already.

Frankly, who with a 2.4.9 kernel would really need what is in lm_sensors
2.9.0 and wasn't in 2.7.0, and dare to complain that lm_sensors 2.9.0
doesn't work?

> Depending on the result of that test, I would suggest that we mention
> what distro kernels are not supported (*initial* 7.1 kernel, etc.).

We support vanilla kernels, not vendor ones (Red Hat or others) and have
always claimed so. We are not going to list all (un)supported vendor
kernels, as such a list would obviously be unmaintainable.

Please keep in mind that i2c & lm_sensors 2.8.x were not compatible with
any kernel older than 2.4.17 (although we claimed 2.4.9 compatibility),
and nobody complained. This is certainly a good proof that people with
these old kernels are still using lm_sensors 2.7.0 and are happy with
that.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
