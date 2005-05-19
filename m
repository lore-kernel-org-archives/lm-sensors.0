From: peterm@remware.demon.co.uk (Peter Milne)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [Fwd: New bus driver: XSCALE iop3xx]
Message-Id: <3EC9E7B2.6000300@remware.demon.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Phil et al

I've recently implemented a combined algo/adapter driver for the Intel 
Xscale IOP321 (IOP3xx family) processor.

The IOP321 features a two channel i2c controller, so this is an "on chip 
peripheral" in the sense of

I2C_ALGO_OCP/I2C_HW_OCP.

There are other IOP3xx chips that should share the same algorithm, but 
have different adaptors.
I would like you please to allocate me an algorithm and an adapter number:

suggest:

#define I2C_ALGO_OCP_IOP3XX  0x140000 /* XSCALE IOP3XX On-chip I2C alg */

and

/* --- XSCALE on-chip adapters                          */
#define I2C_HW_IOP321 0x00

If that's ok, should I submit a patch for i2c-id.h with the right values 
and appropriate comments.

The driver comprises two files drivers/i2c/i2c-iop3xx.[ch]

Although they are only of use to someone building for this specific processor arch,
would it be appropriate for me to submit the files to you for inclusion in the
i2c package?.



Thanks!.

ps: hooking up to your framework was a snap, now I'm looking forward to 
leveraging some of those chip drivers,
and maybe even contributing a couple back.

Best regards

Peter





