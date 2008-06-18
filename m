From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Jun 2008 19:54:57 +0000
Subject: Re: [lm-sensors] [PATCH] thmc50: extend numbers of handled
Message-Id: <20080618215457.4699a2c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080614134129.ea9f896a.krzysztof.h1@poczta.fm>
In-Reply-To: <20080614134129.ea9f896a.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 18 Jun 2008 21:14:58 +0200, Krzysztof Helt wrote:
> On Sun, 15 Jun 2008 14:28:20 +0200, Jean Delvare wrote:
> > So I would like to suggest a different strategy which we already use in
> > many drivers: have a data->has_temp bitfield. Each bit set corresponds
> > to one temperature channel present. So, value would be 0x03 for the
> > THMC50 and ADM1022 (temp1 and temp2), 0x07 for the ADM1022 in 3-temp
> > mode (temp1, temp2 and temp3), and 0x02 for the THMC51 (temp2 only.)
> > The code will be longer.
> 
> Much longer as the reading loop has to be unrolled then. A simpler solution
> is to use a table (e.g. byte table) and set 1 for index with available temperature.
> It won't require to unroll the loop, but it will make other parts of code longer
> (when sensors are detected). I don't think it is worth effort for the thmc51 only.

No, the strategy I proposed doesn't imply to unroll any look. See this
example from the w83793 driver:

	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
		if (!(data->has_temp & (1 << i)))
			continue;
		data->temp[i][TEMP_READ] 		    w83793_read_value(client, W83793_REG_TEMP[i][TEMP_READ]);
	}

The whole point of using a bitfield is to be able to use that kind of
construct.

That being said, just do as you want, I agree it doesn't matter too
much in the case of the thmc50 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
