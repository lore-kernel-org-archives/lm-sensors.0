From: mds@mds.gotdns.com (Mark Studebaker)
Date: Mon, 29 Jan 2007 21:34:25 +0000
Subject: [lm-sensors] [PATCH] bmcsensors / get partial SDR
Message-Id: <45BE6861.5030406@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <002d01c741a9$fae35770$8101a8c0@PERF.PERFORMANCESOFTWARE>
In-Reply-To: <002d01c741a9$fae35770$8101a8c0@PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks charles for tracking down and fixing yet another 0xCA problem
mds

Charles Grant wrote:
> Here's another patch I made to get bmcsensors working on our dual-core Xeon
> ATCA carrier (Kontron 8020).  
> 
> When retrieving partial buffers for an SDR, the request for the last buffer
> would return completion code 0xCA (cannot return number of requested data
> bytes), causing the code to half its buffer size, try again, and ultimately
> give up.  To get around this, I modified bmcsensors_get_sdr() and
> bmcsensors_rcv_sdr_msg() to never request more than the known number of
> remaining bytes.
> 
> 
> --- old/bmcsensors.c	2007-01-10 11:13:47.353446400 -0700
> +++ new/bmcsensors.c	2007-01-26 16:12:50.925455100 -0700
> @@ -72,5 +72,5 @@
>  			int ctl_name, int *nrels_mag, long *results);
>  #endif
> -static void bmcsensors_get_sdr(u16 resid, u16 record, u8 offset);
> +static void bmcsensors_get_sdr(u16 resid, u16 record, u8 offset, u8 count);
>  static void bmcsensors_get_reading(struct i2c_client *client, int i);
>  
> @@ -459,4 +459,5 @@
>  	unsigned char * data;
>  	u8 id[SDR_MAX_UNPACKED_ID_LENGTH];
> +	int bytesleft;
>  
>  
> @@ -472,5 +473,5 @@
>  		printk(KERN_INFO "bmcsensors.o: Reducing SDR request size to
> %d\n", ipmi_sdr_partial_size);
>  #endif
> -		bmcsensors_get_sdr(0, 0, 0);
> +		bmcsensors_get_sdr(0, 0, 0, 0);
>  		return STATE_SDR;
>  	}
> @@ -483,14 +484,20 @@
>  			rx_msg_data_offset += ipmi_sdr_partial_size;
>  		}
> -		if(rx_msg_data_offset > rx_msg_data[7] + 7) {
> -			/* got last chunk */
> -			rx_msg_data_offset =  0;
> -			data = rx_msg_data;
> -		} else {
> +
> +		/* compute total bytes remaining based on sensor record
> bytes remaining */
> +		bytesleft = (int)rx_msg_data[7] + 8 - rx_msg_data_offset;
> +
> +		if (bytesleft > 0) {
>  			/* get more */
>  			record = (rx_msg_data[4] << 8) | rx_msg_data[3];
> -			bmcsensors_get_sdr(resid, record, rx_msg_data_offset
> - 3);
> +			bmcsensors_get_sdr(resid, record, rx_msg_data_offset
> - 3, bytesleft);
>  			return STATE_SDR;
>  		}
> +		else {
> +			/* got last chunk */
> +			rx_msg_data_offset = 0;
> +			data = rx_msg_data;
> +		}
> +
>  	} else {
>  		data = msg->data;	/* got it in one chunk */
> @@ -631,5 +638,5 @@
>  	} else {
>  
> -		bmcsensors_get_sdr(0, nextrecord, 0);
> +		bmcsensors_get_sdr(0, nextrecord, 0, 0);
>  	}
>  	return rstate;
> @@ -647,5 +654,5 @@
>  			printk(KERN_DEBUG "bmcsensors.o: Got first resid
> 0x%.4x\n", resid);
>  #endif
> -			bmcsensors_get_sdr(0, 0, 0);
> +			bmcsensors_get_sdr(0, 0, 0, 0);
>  			state = STATE_SDR;
>  			break;
> @@ -677,5 +684,5 @@
>  #endif
>  			rx_msg_data_offset = 0;
> -			bmcsensors_get_sdr(0, nextrecord, 0);
> +			bmcsensors_get_sdr(0, nextrecord, 0, 0);
>  			state = STATE_SDR;
>  			break;
> @@ -755,12 +762,17 @@
>  
>  /* Componse and send a "get SDR" message */
> -static void bmcsensors_get_sdr(u16 res_id, u16 record, u8 offset)
> +static void bmcsensors_get_sdr(u16 res_id, u16 record, u8 offset, u8 count)
>  {
>  #ifdef DEBUG
> -	printk(KERN_DEBUG "bmcsensors.o: Get SDR 0x%x 0x%x 0x%x\n",
> -		       res_id, record, offset);
> +	printk(KERN_DEBUG "bmcsensors.o: Get SDR 0x%x 0x%x 0x%x 0x%x\n",
> +		       res_id, record, offset, count);
>  #endif
>  	tx_message.netfn = IPMI_NETFN_STORAGE;
>  	tx_message.cmd = IPMI_GET_SDR;
> +
> +	/* Reset count to default value if necessary */
> +	if (count = 0 || count > ipmi_sdr_partial_size)
> +		count = ipmi_sdr_partial_size;
> +
>  	tx_message.data_len = 6;
>  	tx_message.data = tx_msg_data;
> @@ -770,5 +782,5 @@
>  	tx_msg_data[3] = record >> 8;
>  	tx_msg_data[4] = offset;
> -	tx_msg_data[5] = ipmi_sdr_partial_size;
> +	tx_msg_data[5] = count;
>  	bmcsensors_send_message(&tx_message);
>  }
> 
> 
> --------------------
> Chuck Grant
> Performance Software
> 
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

