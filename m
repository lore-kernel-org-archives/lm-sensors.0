From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 19:24:05 +0000
Subject: Re: [lm-sensors] [PATCH v1 01/01] hwmon: (w83627ehf) Add fan
Message-Id: <20110307192405.GA14221@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79C9F834B6F9462F9F9E4C4E42A973A5@portable2>
In-Reply-To: <79C9F834B6F9462F9F9E4C4E42A973A5@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Mon, Mar 07, 2011 at 01:55:56PM -0500, Ian Dobson wrote:
> Hello,
> 
> The nct6776f and nct6775f support debouncing the fan RPM signal, this can 
> help improve the stability of th RPM signal for some fans (Arctic cooling 
> fans for example).
> This patch adds a module parameter fan_debounce, which when set to 1 enables 
> debounce for all fans that the chip supports.
> I've based this diff on the standalone w83627ehf driver from 7.3.2011 09:54, 
> using diff -uN standardversion  myversion
> 
> Regards
> Ian Dobson
> 
> 
> --- w83627ehf.c.std	2011-03-04 17:01:18.630954100 +0100
> +++ w83627ehf.c	2011-03-07 18:22:33.878852000 +0100
> @@ -79,6 +79,10 @@
>  module_param(force_id, ushort, 0);
>  MODULE_PARM_DESC(force_id, "Override the detected device ID");
> 
> +static unsigned short fan_debounce;
> +module_param(fan_debounce, ushort, 0);
> +MODULE_PARM_DESC(fan_debounce, "Enable de-bouncing for fan RPM signal");
> +

I wanted to ask you to document the module parameter in Documentation/hwmon/w83627ehf,
but turns out force_id isn't documented there either. So I'll leave it up to you
to decide if you want to spend the effort.

>  #define DRVNAME "w83627ehf"
> 
>  /*
> @@ -236,6 +240,7 @@
>  static const u16 NCT6775_REG_FAN_STEP_OUTPUT[] = { 0x10b, 0x20b, 0x30b };
>  static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
>  static const u16 NCT6776_REG_FAN_MIN[] = { 0x63a, 0x63c, 0x63e, 0x640, 
> 0x642};
> +static const u8 NCT6776_REG_FAN_DEBOUNCE = 0xf0;
> 
You don't need a variable here; a define is good enough. Variables are only necessary
for arrays. I would suggest to use

#define NCT6775_REG_FAN_DEBOUNCE	0xf0

May seem odd, but the convention I used is to name registers after the first chip
supporting it. In this case, that would be NCT6775.

>  static const u16 NCT6775_REG_TEMP[]
>  	= { 0x27, 0x150, 0x250, 0x73, 0x75, 0x77, 0x62b, 0x62c, 0x62d };
> @@ -2297,6 +2302,7 @@
>  	static const char __initdata sio_name_NCT6776[] = "NCT6776F";
> 
>  	u16 val;
> +	u8 tmp;

Declare tmp where you need it, ie after the if() below.

>  	const char *sio_name;
> 
>  	superio_enter(sioaddr);
> @@ -2369,6 +2375,22 @@
>  	pr_info("Found %s chip at %#x\n", sio_name, *addr);
>  	sio_data->sioreg = sioaddr;
> 
Can you move the code below a little further up, just ahead of the previous
superio_exit() ?
This way you don't have to call superio_enter() and superio_exit() again.

> +	if ( fan_debounce = 1 && (sio_data->kind = nct6775
> +			|| sio_data->kind = nct6776 )) {

	if (fan_debounce &&
	    (sio_data->kind = nct6775 || sio_data->kind = nct6776)) {

should be good enough.

> +		superio_enter(sio_data->sioreg);
> +		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> +		tmp = superio_inb(sio_data->sioreg, NCT6776_REG_FAN_DEBOUNCE );
> +		if ( sio_data->kind = nct6776 ) {

Blanks after ( and before ) will cause checkpatch warnings. Please run the patch
through scripts/checkpatch.pl to make sure it is clean.

> +			superio_outb(sio_data->sioreg, NCT6776_REG_FAN_DEBOUNCE,
> +				0x3e | tmp );
> +		} else {
> +			superio_outb(sio_data->sioreg, NCT6776_REG_FAN_DEBOUNCE,
> +				0x1e | tmp );
> +		}

	The { } are not needed here.

> +		superio_exit(sio_data->sioreg);
> +		pr_info("Enabling fan debounce for chip %s\n", sio_name);

		Strictly speaking, that would be "Enabled" ;)
 
> +	}
> +
The semantics is that you can turn debounce on, but you can not turn it off. 
Is this intentional ? [ ok with me, and I think it makes sense - just asking ]

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
