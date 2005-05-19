From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] typos in linux-2.4.20/drivers/i2c/i2c-proc.c (fwd)
Message-Id: <3E6A833A.8010402@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200303021210.h22CAcAc000834@shire.frodo.local>
In-Reply-To: <200303021210.h22CAcAc000834@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you. Applied to CVS.

Frodo Looijaard wrote:
> ----- Forwarded message from Norbert Kiesel -----
> 
> Received: by morannon.frodo.local (8.11.3/8.11.3) id h22CA4W29926 ; Sun, 2 Mar 2003 13:10:04 +0100
> Return-path: <nkiesel@tbdnetworks.com>
> Received: from pop3.dds.nl [213.196.1.204]
> 	by localhost with POP3 (fetchmail-6.2.0)
> 	for frodo@localhost (single-drop); Sun, 02 Mar 2003 13:10:04 +0100 (CET)
> Received: (qmail-ldap/ctrl 30905 invoked from network); 2 Mar 2003 11:59:54 -0000
> Received: from mail.tbdnetworks.com (HELO tbdnetworks.com) ([63.209.25.99]) (envelope-sender <nkiesel@tbdnetworks.com>)
> 	         by dds.nl (qmail-ldap-1.03) with SMTP
> 	         for <frodol@dds.nl>; 2 Mar 2003 11:59:54 -0000
> Received: from defiant (defiant.tbdnetworks.com [192.168.4.126])
> 	by tbdnetworks.com (8.12.2/8.12.2) with ESMTP id h22Bxqpv029464;
> 	Sun, 2 Mar 2003 03:59:52 -0800 (PST)
> Received: from nkiesel by defiant with local (Exim 3.36 #1 (Debian))
> 	id 18pS8G-00070E-00; Sun, 02 Mar 2003 03:59:52 -0800
> Date: Sun, 2 Mar 2003 03:59:51 -0800
> To: simon@tk.uni-linz.ac.at, frodol@dds.nl
> Subject: [PATCH] typos in linux-2.4.20/drivers/i2c/i2c-proc.c
> Message-ID: <20030302115951.GA26918@defiant>
> Content-Disposition: inline
> User-Agent: Mutt/1.5.3i
> From: Norbert Kiesel <nkiesel@tbdnetworks.com>
> X-Loop-Procmail: PreventLoop
> 
> Hi,
> 
> I found small typos in this driver.
> 
> so long
> 	Norbert
> 
> --- linux-2.4.20/drivers/i2c/i2c-proc.c~	2002-03-11 01:07:21.000000000 -0800
> +++ linux-2.4.20/drivers/i2c/i2c-proc.c	2003-03-02 03:03:34.000000000 -0800
> @@ -729,7 +729,7 @@
>  			     ||
>  			     ((address_data->
>  			       ignore_range[i] =
> -			       SENSORS_ANY_I2C_BUS) & !is_isa))
> +			       SENSORS_ANY_I2C_BUS) && !is_isa))
>  			    && (addr >= address_data->ignore_range[i + 1])
>  			    && (addr <= address_data->ignore_range[i + 2])) {
>  #ifdef DEBUG
> @@ -818,7 +818,7 @@
>  		     i += 2) {
>  			if (((adapter_id = address_data->probe[i]) ||
>  			     ((address_data->
> -			       probe[i] = SENSORS_ANY_I2C_BUS) & !is_isa))
> +			       probe[i] = SENSORS_ANY_I2C_BUS) && !is_isa))
>  			    && (addr = address_data->probe[i + 1])) {
>  #ifdef DEBUG
>  				printk
> @@ -835,7 +835,7 @@
>  			    ((adapter_id = address_data->probe_range[i])
>  			     ||
>  			     ((address_data->probe_range[i] =
> -			       SENSORS_ANY_I2C_BUS) & !is_isa))
> +			       SENSORS_ANY_I2C_BUS) && !is_isa))
>  			    && (addr >= address_data->probe_range[i + 1])
>  			    && (addr <= address_data->probe_range[i + 2])) {
>  				found = 1;
> 
> ----- End of forwarded message from Norbert Kiesel -----
> 
