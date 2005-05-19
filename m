From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 reset option
Message-Id: <20040228182758.5ba4d1c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228183508.200a8655.komoriya@paken.org>
In-Reply-To: <20040228183508.200a8655.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Takeru, hi Greg,

Sorry that I did not see it before, but I found some glitches in the
patch as I was porting it to our CVS driver.

First of all, the patch leaves all INIT macros untouched. They are not
used anywhere in the driver now, so they should go.

Then:

> +	if (reset) {
> +		/* Reset all except Watchdog values and last conversion values
> +		   This sets fan-divs to 2, among others */
> +		it87_write_value(client, IT87_REG_CONFIG, 0x80);
> +

No extra line here please.

> +	}

> +		tmp = (tmp & 0xc0) | 0x2a;
> +		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
> +	}
> +	data->sensor = tmp;

I don't think this is needed. That value will be updated in
it87_update_client, and this function will be called at least once
before you access data->sensor again.

Again, sorry for not noticing it before.

Greg, either apply Takeru's patch and I'll submit an update, or do you
prefer that Takeru resubmits an updated version?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
