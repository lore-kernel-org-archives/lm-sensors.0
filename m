From: hcs@ics2.ics.tvnet.hu (=?iso-8859-1?Q?Csaba_Hal=E1sz?=)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: probable typo in i2c-amd756.c (block transfer)
Message-Id: <000001c1f07a$0957f440$0700a8c0@JESTER>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- i2c-amd756.c.orig   Tue Apr 30 20:46:16 2002
+++ i2c-amd756.c        Tue Apr 30 20:49:45 2002
@@ -419,7 +419,7 @@
                data->word = inw_p(SMB_HOST_DATA);      /* TODO: endian????
*/
                break;
        case AMD756_BLOCK_DATA:
-               data->block[0] = inw_p(SMB_HOST_DATA & 63);
+               data->block[0] = inw_p(SMB_HOST_DATA) & 63;
                /* i = inw_p(SMBHSTCNT); Reset SMBBLKDAT */
                for (i = 1; i <= data->block[0]; i++)
                        data->block[i] = inb_p(SMB_HOST_BLOCK_DATA);

I noticed this while playing around with the driver.

As I wrote earlier, I suspect that the nVidia nForce
is compatible with the AMD756, but the block transfer
does not work even after I applied the patch.
Does it work with an AMD756?

Also, the block member of the i2c_smbus_data union
seems to be 33 bytes, so maybe that has to be handled
as well.

Greets,
	Csaba
