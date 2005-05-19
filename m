From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BUG] i2c-viapro oops on bad SMBus Block Read
Message-Id: <20030806025020.GA2371@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805210754.457c1946.vsu@altlinux.ru>
In-Reply-To: <20030805210754.457c1946.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Sergey Vlasov <vsu@altlinux.ru> [2003-08-05 21:07:54 +0400]:
> Hello!
> 
> I have found a reproducible bug in i2c-viapro (lm_sensors-2.8.0). When
> the device replies to SMBus Block Read with an absurdly large length,
> this driver accepts it without checking and overruns the data buffer.
> Tried with VT8325 and VT82C686.

<snip>

Are you interested in CVS commit privileges?  You'll certainly get my vote.
Of course we could use the help especially now (upcoming sync w/ 2.4, 
driver porting and userspace re-write for 2.6, etc.)  Please contact 
Philip Edelbrock <phil@netroedge.com> privately for username/password,
and also to join the mailing list if you haven't already.

> --- lm_sensors-2.8.0/kernel/busses/i2c-viapro.c.viapro-buffer-overrun	2003-07-03 05:30:13 +0400
> +++ lm_sensors-2.8.0/kernel/busses/i2c-viapro.c	2003-08-05 20:46:25 +0400
> @@ -271,6 +271,8 @@
>  		break;
>  	case VT596_BLOCK_DATA:
>  		data->block[0] = inb_p(SMBHSTDAT0);
> +		if (data->block[0] > 32)
> +			data->block[0] = 32;
>  		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
>  		for (i = 1; i <= data->block[0]; i++)
>  			data->block[i] = inb_p(SMBBLKDAT);

I'll commit this patch now.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
