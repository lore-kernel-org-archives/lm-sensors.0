From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Mar 2006 08:33:56 +0000
Subject: [lm-sensors] i2c-core error messages
Message-Id: <SOnpL3fC.1141634036.8395030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060306071543.GE16281@six.research.nokia.com>
In-Reply-To: <20060306071543.GE16281@six.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Kay,

On 2006-03-06, Kai Svahn wrote:
> I was just wondering is there a reason that in i2c.core.c file, i2c_probe
> function returns 0 when there is an error? I changed the code a bit for
> my own chip driver to know that we fail and then I return
> negative value.

Which version of the i2c-core.c file are you referring to, please? The
file Linux 2.6.16-rc5 has an i2c_probe function which properly returns
errors.

Thanks,
--
Jean Delvare

