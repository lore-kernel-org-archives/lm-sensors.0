From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 09 Oct 2009 15:30:00 +0000
Subject: Re: [lm-sensors] [PATCH] AGAIN: support for AMD 10H and 11H
Message-Id: <4ACF56F8.1000502@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200910041951.16102.hfvogt@gmx.net>
In-Reply-To: <200910041951.16102.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Thank you. It seems AMD fixed that. Maybe we would need to avoid the goto.
>  	if (!data->valid
>  	    || time_after(jiffies, data->last_updated + HZ)) {
> +		if (boot_cpu_data.x86 > 0xf) {
> +			pci_read_config_dword(pdev, REG_TCTL,
> +					      &data->temp[0][0]);
> +			goto update_done;
> +		}

Hm goto can be used only to jump to error paths.

> +
> +	if ((boot_cpu_data.x86 = 0x10) && (model = 2)) {
> +		/*
> +		 * AMD 10H cpus rev. B report Inaccurate Temperature
> +		 * Measurement :
> +		 * http://www.amd.com/us-
> en/assets/content_type/white_papers_and_tech_docs/41322.pdf
> +		 *     Errata #319
> +		 */
> +		dev_err(&pdev->dev, "Reported temperature may be inconsistent, "
> +			"therefore rejected here - see erratum #319\n");

Maybe the message could be - Erratum #319 detected, refusing to load.

> +		err = -ENODEV;

Thank you

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
