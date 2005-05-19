From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Oops: i2c-proc.c
Message-Id: <3E7E50AB.3090300@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030130235623.A4057@earth.solarsys.net>
In-Reply-To: <20030130235623.A4057@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
how does this compare to the much more elaborate fix in 2.5.64?

http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-proc.c@1.17?nav=index.html|src/.|src/drivers|src/drivers/i2c|hist/drivers/i2c/i2c-proc.c

Is your change below sufficient?

Mark M. Hoffman wrote:
> Hello everyone:
> 
> Some weeks ago, I reported an oops while inserting w83781d.  Neither
> could I insert eeprom - that caused the same oops in the same place:
> near the bottom of i2c_register_entry() in i2c-proc.  I'm using tag
> lk2-4 for i2c and HEAD for lm_sensors2.
> 
> The details are here:
> http://archives.andrew.net.au/lm-sensors/msg01907.html
> 
> With the patch below I can insert and use eeprom.  But now w83781d freezes
> modprobe when I try to insert it (no oops though).  I'll continue to look
> at this as I find time...
> 
> I would appreciate some feedback on this patch.  In particular, compare
> the relevant parts of 2.7.0 (i2c-proc.c 1.14) to the result of this patch.
> 
> Index: i2c-proc.c
> =================================> RCS file: /home/cvs/i2c/kernel/i2c-proc.c,v
> retrieving revision 1.15.2.4
> diff -u -2 -r1.15.2.4 i2c-proc.c
> --- i2c-proc.c	22 Jan 2003 21:48:13 -0000	1.15.2.4
> +++ i2c-proc.c	7 Mar 2003 07:06:08 -0000
> @@ -159,8 +159,8 @@
>  
>  	memcpy(new_table, sysctl_table, sizeof(sysctl_table));
> -	tbl = new_table; /* sys/ */
> -	tbl = tbl->child = tbl + 2; /* dev/ */
> -	tbl = tbl->child = tbl + 2; /* sensors/ */	
> -       	client_tbl = tbl->child = tbl + 2; /* XX-chip-YY-ZZ/ */
> +	tbl = new_table; /* dev/ */
> +	tbl = tbl->child = tbl + 2; /* sensors/ */
> +	tbl = tbl->child = tbl + 2; /* XX-chip-YY-ZZ/ */
> +	client_tbl = tbl; 
>  
>  	client_tbl->procname = name;
> 
