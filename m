From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Oct 2007 17:37:11 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: List more Winbond chips
Message-Id: <20071005193711.3637fcb2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071004183839.GH32267@greenwood>
In-Reply-To: <20071004183839.GH32267@greenwood>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

On Thu, 4 Oct 2007 20:38:39 +0200, Uwe Hermann wrote:
> here's a first patch to add some more recognized chips to the
> sensors-detect output. No new IDs, just alternate names of existing
> chips (which all have the same IDs).

Patch applied, thanks for your contribution. I only backed out:

>        {
> -	name => "Winbond W83L517D Super IO",
> +	name => "Winbond W83L517D/D-F Super IO",
>  	driver => "not-a-sensor",
>  	devid => 0x61,
>        },

this last change, as mixing slashes and dashes can become confusing,
and the -F suffix doesn't add much value IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
