From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Oct 2005 22:14:06 +0000
Subject: [lm-sensors] PCA9539 patch to support PCA9538  - please comment
Message-Id: <4356A8F7.3050506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510080015.10318.tonu@jes.ee>
In-Reply-To: <200510080015.10318.tonu@jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for delay. We all mostly work or attending school (or both), so it is hard to reply soon.

> Did some work on adding PCA9538 support. This is again some 8-bit IO chip 
> which is nearly identical to PCA9539 whose support already exists in kernel. 
> I had just to modify slightly some stuff. I am going through it and will test 
> it with hardware tomorrow but I need your comments! Not sure if my coding 
> style etc fits your rules. So, please tell something. Patch is:
> 
> http://www.jes.ee/~tonu/pca9539.patch

Please send next time the patches inline so it is easier to commnent. You can
also read the Documetation/CodingStyle in kernel docs directory.

> --- linux-2.6.14-rc3/drivers/i2c/chips/pca9539.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/i2c/chips/pca9539.c	2005-10-08 00:01:44.000000000 +0300
> @@ -3,6 +3,10 @@
>  
>      Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
>  
> +    pca9538 - similar chip but 8-bit I/O port and different address
> +    Modified by Tonu Samuel  <tonu@spam.ee> 
> +    Copyright (C) 2005 Tonu Samuel <tonu@spam.ee>
> +    

I think is enough:
>      Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
> +    Copyright (C) 2005 Tonu Samuel <tonu@spam.ee>

>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
>      the Free Software Foundation; version 2 of the License.
> @@ -15,11 +19,24 @@
>  #include <linux/hwmon-sysfs.h>
>  
>  /* Addresses to scan */
> -static unsigned short normal_i2c[] = {0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END};
> +static unsigned short normal_i2c[] = { 

You left trailing space at the end

> +	/* pca9538 addresses */
> +	0x70, 0x71, 0x72, 0x73,
> +	/* pca9539 addresses*/
> +	0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END};
>  
>  /* Insmod parameters */
>  I2C_CLIENT_INSMOD_1(pca9539);
>  
> +enum pca9538_cmd
> +{

This should belong to one line

> +	PCA9538_INPUT		= 0,
> +	PCA9538_OUTPUT		= 1,
> +	PCA9538_INVERT		= 2,
> +	PCA9538_DIRECTION	= 3,
> +};
> +
> +

Why this extra line?

>  enum pca9539_cmd
>  {
>  	PCA9539_INPUT_0		= 0,
> @@ -47,6 +64,7 @@
>  
>  struct pca9539_data {
>  	struct i2c_client client;
> +	int is_pca9538;

I think we have a variable called "kind" read on

>  };
>  
>  /* following are the sysfs callback functions */
> @@ -89,6 +107,14 @@
>  PCA9539_ENTRY_RW(direction0, PCA9539_DIRECTION_0);
>  PCA9539_ENTRY_RW(direction1, PCA9539_DIRECTION_1);
>  
> +static struct attribute *pca9538_attributes[] = {
> +	&sensor_dev_attr_input0.dev_attr.attr,
> +	&sensor_dev_attr_output0.dev_attr.attr,
> +	&sensor_dev_attr_invert0.dev_attr.attr,
> +	&sensor_dev_attr_direction0.dev_attr.attr,
> +	NULL
> +};
> +
>  static struct attribute *pca9539_attributes[] = {
>  	&sensor_dev_attr_input0.dev_attr.attr,
>  	&sensor_dev_attr_input1.dev_attr.attr,
> @@ -101,6 +127,10 @@
>  	NULL
>  };
>  
> +static struct attribute_group pca9538_defattr_group = {
> +	.attrs = pca9538_attributes,
> +};
> +
>  static struct attribute_group pca9539_defattr_group = {
>  	.attrs = pca9539_attributes,
>  };
> @@ -136,19 +166,31 @@
>  	new_client->flags = 0;
>  
>  	/* Detection: the pca9539 only has 8 registers (0-7).
> -	   A read of 7 should succeed, but a read of 8 should fail. */
> -	if ((i2c_smbus_read_byte_data(new_client, 7) < 0) ||
> -	    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
> +	   A read of 7 should succeed, but a read of 8 should fail. 
> +           If reading 4 fails but 0..3 works, it should be pca9538,
> +	   8-bit younger brother of pca9539 */
> +
> +	/* Trying for pca9539 */
> +	if ((i2c_smbus_read_byte_data(new_client, 7) >= 0) &&
> +	    (i2c_smbus_read_byte_data(new_client, 8) < 0))
> +		strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
> +	/* Trying for pca9538 */
> +	else if ((i2c_smbus_read_byte_data(new_client, 3) >= 0) && 
> +	    (i2c_smbus_read_byte_data(new_client, 4) < 0)) {
> +	        strlcpy(new_client->name, "pca9538", I2C_NAME_SIZE);
> +		data->is_pca9538=1;
> +        } else
>  		goto exit_kfree;
>  
> -	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
> -

Please remove the is_pca9538 variable. We have  the variable called "kind" for this purpose.

This should be somewher on the top of the file:
(see for example pcf8574.c)

/* Insmod parameters */
I2C_CLIENT_INSMOD_2(pca9538, pca9539);

And this to the detect routine:
 const char *client_name = "";


	/* Determine the chip type. */
	if (kind <= 0) {
> +		/* Trying for pca9539 */
> +		if ((i2c_smbus_read_byte_data(new_client, 7) >= 0) &&
> +	    	(i2c_smbus_read_byte_data(new_client, 8) < 0))
			kind = pca9539;
	
> + 		else if ((i2c_smbus_read_byte_data(new_client, 3) >= 0) &&
> +	    		(i2c_smbus_read_byte_data(new_client, 4) < 0)) {
			kind = pca9538;
> +        	} else {
>  			goto exit_kfree;
		}
Ok I put the goto statement to { } but I think you can do without that. See the Codingstyle (I'm too tired to check)
	}

        if (kind = pca9539)
                client_name = "pca9539";
	else if (kind = pca9538)
                client_name = "pca9538";

        strlcpy(new_client->name, client_name, I2C_NAME_SIZE);

>  	/* Tell the I2C layer a new client has arrived */
>  	if ((err = i2c_attach_client(new_client)))
>  		goto exit_kfree;
>  
>  	/* Register sysfs hooks (don't care about failure) */
> -	sysfs_create_group(&new_client->dev.kobj, &pca9539_defattr_group);
> +	if(data->is_pca9538)

Put if (kind =

> +		sysfs_create_group(&new_client->dev.kobj, &pca9538_defattr_group);
> +	else
> +		sysfs_create_group(&new_client->dev.kobj, &pca9539_defattr_group);
>  
>  	return 0;
>  


> 
> Some example output:
> 
> test:/usr/src/se95 # modprobe pca9539
> test:/usr/src/se95 # !ca
> cat /sys/bus/i2c/devices/0-0073/name
> pca9538
> test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0073/
> bus/        direction0  driver/     input0      invert0     name        
> output0     power/
> test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0077/
> bus/        direction1  input0      invert0     name        output1
> direction0  driver/     input1      invert1     output0     power/
> test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0077/name
> pca9539
> test:/usr/src/se95 #         

And it works? Did you tested all cases?
If so and if you fixed everything please send it again. (read  please the SubmittingPatches)

1) inline in mail body
2) Signed-Off-By line

If others wont find anything wrong Jean will submit it into kernel.

BTW it took me 30 minutes to write this email. If you know that there are 20 emails like this waiting...

Thanks,
regards
Rudolf
