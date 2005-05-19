From: overridex@punkass.com (OverrideX)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Additional info for ticket #1148
Message-Id: <1055399069.17319.0.camel@nazgul>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054890869.11041.3.camel@nazgul>
In-Reply-To: <1054890869.11041.3.camel@nazgul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2003-06-12 at 02:20, Jean Delvare wrote:
> You really should stick to one given version of i2c AND lm_sensors or
> you're guaranteed to fall into death traps rather quickly. I don't know
> how you managed to reach the point you're at, but you're supposed to
> install the i2c version that matches the lm_sensors version you intend
> to use, *before* installing lm_sensors. Also, don't you forget to issue
> a "depmod -a" between the installations of i2c and lm_sensors
> .

Yeah, I upgraded both to 2.7.0 the other day -Dan

--
OverrideX <overridex@punkass.com>
GPG Key Fingerprint = 4AD5 CE9C D7C8 0069 BDD3 7F72 3AB2 642A 5A5D EB89

Perilous to all of us are the devices of an art deeper than we ourselves
possess. -- Gandalf the Grey [J.R.R. Tolkien, "Lord of the Rings"]

