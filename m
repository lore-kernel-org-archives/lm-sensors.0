From: paubert@iram.es (Gabriel Paubert)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] Cleanups to the recent smbus functions removal
Message-Id: <20041117112646.GA29609@iram.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116223833.4fdeb1aa.khali@linux-fr.org>
In-Reply-To: <20041116223833.4fdeb1aa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

	Hi Jean,

On Tue, Nov 16, 2004 at 10:38:33PM +0100, Jean Delvare wrote:
> Hi Greg, all,
> 
> This patch cleans up the recent removal of smbus functions proposed by
> Arjan and then fixed by Gabriel. Changes are as follow:
> 
> 1* Discard i2c_smbus_block_process_call, as it isn't used anywhere
>    either. I guess that Arjan missed it because it wasn't exported.
> 
> 2* Document the functions removal, so that people have at least an idea
>    that the functions can be restored later if needed.
> 
> Maybe it would make sense to apply this before 2.6.10-rc2? Not critical
> however, I agree. But obviously safe too, huh? ;)

It seems so. BTW I hate wrong comments and happened to add one 
in my patch. To fix my blunder, can you apply the appended one 
line removal on top of Jean's patch.

	Thanks,
	Gabriel

Signed-off-by: Gabriel Paubert <paubert@iram.es> 

=== drivers/i2c/i2c-core.c 1.60 vs edited ==--- 1.60/drivers/i2c/i2c-core.c	2004-11-11 18:33:23 +01:00
+++ edited/drivers/i2c/i2c-core.c	2004-11-17 12:18:35 +01:00
@@ -1021,7 +1021,6 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
-/* Returns the number of bytes transferred */
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, u8 *values)
 {

