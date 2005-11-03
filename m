From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Nov 2005 10:10:51 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <9JkalMvz.1131008308.7160720.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 2005-11-02, Rudolf Marek wrote:
> TYPE  FAMILY  MODEL  STEPPING
> 0       6       7       0+   this should be 85? -  EDEN ESP samuel 2
> 0       6       7       8+   VRM85 C3 EZRA
> 0       6       8       0-7  VRM85 C3 EZRA T
> 0       6       9       0+   VRM85 NEMIAH
> 0       6       9       8+  max 1718 C3-M

This table doesn't make much sense to me. Having 0+ and 8+ for the same
model is a bit weird. Isn't if rather 0-7 and 8+?

Comments on the code:

> -		                     2050 - (val) * 50);
> +			2050 - (val) * 50);

Broken whitespace change.

> +	case 1718:		/* Intel IMVP-II */

If a specification is available, please point to it in the big comment on
top of the file. If not, explain the table like was done for the Opteron
in that same comment.

> +		if (val & 0x10)
> +			return 0975 - ((val & 0xF) * 25);

That "0975" will be taken as an invalid octal value by the compiler.

> +	default:		/* report 0 for unknown */
> +		return 0;

Debug message if vrm != 0?

>  	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */

This one misses one "ANY" now.

> +			     (vrm_models[i].eff_model=ANY)) &&
> +			     (eff_stepping =< vrm_models[i].eff_stepping))

=< should be <=.

Also, you forgot to pass eff_stepping as a parameter so it's undefined
here.

It also seems that you are not handling the case
vrm_models[i].eff_stepping = ANY. I understand that ANY happens to be a
large value so it will be silently handled by the comparison test, but
this is tricky programming. The value of ANY could change in the future.

It would be great if you could at least test that your patches compile
properly before sending them.

Thanks,
--
Jean Delvare
