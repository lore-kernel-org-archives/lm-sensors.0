From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: probable typo in i2c-amd756.c (block transfer)
Message-Id: <3CD07588.86A8F303@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c1f07a$0957f440$0700a8c0@JESTER>
In-Reply-To: <000001c1f07a$0957f440$0700a8c0@JESTER>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

definitely a typo and we also need to limit to 32 bytes.
Thanks. I'll fix it in CVS.

For block xfer, you need a chip that responds to SMBus block
transfers; most don't.

Thanks for explaining how you got the nForce working and
providing the i2cdump/i2cdetect results. I'll check in your patch
too. Great job on the reverse eng.

On RAM showing up as PCI devices, I haven't seen that before.
Probably some other devices inside the nForce misidentified as RAM
by lspci. 


Csaba Hal?sz wrote:
> 
> --- i2c-amd756.c.orig   Tue Apr 30 20:46:16 2002
> +++ i2c-amd756.c        Tue Apr 30 20:49:45 2002
> @@ -419,7 +419,7 @@
>                 data->word = inw_p(SMB_HOST_DATA);      /* TODO: endian????
> */
>                 break;
>         case AMD756_BLOCK_DATA:
> -               data->block[0] = inw_p(SMB_HOST_DATA & 63);
> +               data->block[0] = inw_p(SMB_HOST_DATA) & 63;
>                 /* i = inw_p(SMBHSTCNT); Reset SMBBLKDAT */
>                 for (i = 1; i <= data->block[0]; i++)
>                         data->block[i] = inb_p(SMB_HOST_BLOCK_DATA);
> 
> I noticed this while playing around with the driver.
> 
> As I wrote earlier, I suspect that the nVidia nForce
> is compatible with the AMD756, but the block transfer
> does not work even after I applied the patch.
> Does it work with an AMD756?
> 
> Also, the block member of the i2c_smbus_data union
> seems to be 33 bytes, so maybe that has to be handled
> as well.
> 
> Greets,
>         Csaba
