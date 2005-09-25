From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 23:33:15 +0000
Subject: [lm-sensors] [PATCH] fix functionality constant for read_byte_pec
Message-Id: <20050925233239.0322d88f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> Implementing read_byte_pec using read_byte_data is impossible.
> 
> SMBus read byte with PEC:
>     S Addr Rd [A] [Data] A [PEC] NA P
> 
> SMBus read byte data:
>     S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P

You're right once again... Impressive how our code is broken, and
nobody ever noticed before.

> Index: i2c/kernel/i2c.h
> =================================> RCS file: /home/cvs/i2c/kernel/i2c.h,v
> retrieving revision 1.95
> diff -u -r1.95 i2c.h
> --- i2c/kernel/i2c.h	6 Sep 2005 20:08:39 -0000	1.95
> +++ i2c/kernel/i2c.h	24 Sep 2005 02:36:03 -0000
> @@ -397,6 +397,7 @@
>  #define I2C_FUNC_10BIT_ADDR		0x00000002
>  #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
>  #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_READ_BYTE_PEC	0x00000400 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
> @@ -435,12 +436,12 @@
>                                         I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
>  #define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
>                                         I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
> +#define I2C_FUNC_SMBUS_BYTE_PEC (I2C_FUNC_SMBUS_READ_BYTE_PEC | \
> +                                 I2C_FUNC_SMBUS_WRITE_BYTE_PEC)
>  
> -#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>  #define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
> -#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
>  #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
>  
>  #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \

Everyone:

This bug report (and the other ones Hideki sent before) made me look at
the PEC-related code more carefully. I had never actually looked at it
before. I don't much like the way it was implemented, it is awfully
complex, which must explain why it has so many bugs, and why PEC is
almost unused while the feature was implemented more than 3 years ago.

I think this is the right time to analyze the situation, and rework the
whole PEC implementation to make it better. I think I understand that
the current implementation was made with in a "do as much as we can on
every hardware combination" perspective. While this was a noble
intention, I don't think this was the right thing to do. Given that PEC
is optional in almost all cases (the only exception being ARP), I would
prefer a much simpler, more robust and less buggy implementation.

Let me summarize what I understood from the current implementation:

(1) Bus drivers are supposed to explicitely list all SMBus transactions
they are able to do with PEC, in addition to all transactions they can
do without PEC (using the "functionality" bitfield). Clients can check
for PEC support on individual transactions.

(2) Clients can explicitely ask for PEC on every transaction.

(3) Clients can declare themselves PEC-capable, letting bus drivers use
the PEC-version of each transaction without explicitely requesting it.

(4) For non-SMBus I2C adapters, PEC is implemented in software by
i2c-core.

(5) For SMBus adapters, PEC can be implemented in hardware. If it is
not, i2c-core attempts to do as much as possible, using the fact that
some non-PEC transactions can be used to emulate some PEC transactions.
This results in a partial PEC support on these adapters, and tricky
code (my opinion at least).

Additionally, my reading of the SMBus 2.0 specification is that:

(6) PEC is always optional, except for ARP. This means that a client
should never ask explicitely for a PEC transaction. Instead, it should
declare itself PEC-capable, ask for a standard transaction and let the
bus driver decide whether or not to use PEC depending on its own
capabilities.

Finally, my knowledge of the various hardware SMBus chips (masters and
slaves) suggests that:

(7) SMBus slaves will support PEC on all transactions they use, or none.

(8) SMBus masters will support PEC an all transactions they support, or
none. Not sure it actually matters though.

My conclusions are:

(6) implies that (1) is not needed for SMBus masters. Clients do not
need to be aware of PEC support for individual transactions. It's
actually questionable whether they need to know about the bus PEC
capabilities at all (except for ARP, maybe.) They certainly don't need
to know whether PEC support is hardware or software.

(5) is what makes (1) needed in the current implementation, but I do
not this it is worth the additional code and complexity. Software PEC
support on non-PEC SMBus masters is partial by construction, and has
proven to be broken.

(6) implies that (2) is not wanted. Clients ask for a normal
transaction, PEC or not is the master's decision.

(6) and (7) imply that (3) is wanted. That's what I2C_CLIENT_PEC is for.

(4) looks sane to me. We can add PEC support to any transaction in I2C
emulation mode, it's only a matter of writing the code.

Which leads me to the point that we should consider dropping (1), (2)
and (5). This would make the i2c-core smaller and faster, more readable
and less buggy as a consequence, for almost no functionality loss if
any. I wouldn't expect SMBus slaves which can do PEC connected to SMBus
masters which cannot. If it happens, this means that the designer did
not think PEC was required, so we are most certainly fine without it.

The good thing here is that PEC is not used right now. Just consider
the number of bugs Hideki reported these last few days, anyone actually
using PEC would have reported at least one of them. So nobody tried to
use it, or they all gave up quickly (understandably). I searched the
kernel source and couldn't find any real use case, neither in 2.4 nor
2.6, except for smbus-arp in lm_sensors CVS. In user-space, the only
user seems to be i2cdump. This means that we can probably change the
way PEC works without affecting anyone. Let's just hope that such a
cleanup would invite people to use PEC in chip drivers, and implement
it in bus drivers where hardware can do it, once it is properly
implemented.

Hideki:

You seem to have read the code in great details. Can you comment on it?
Does the PEC implementation look OK to you? How does my simplification
proposal sound to you? Do you have a immediate need for PEC support
yourself?

Arigato,
-- 
Jean Delvare
