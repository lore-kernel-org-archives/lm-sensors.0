From: jcromie@divsol.com (Jim Cromie)
Date: Wed, 22 Jun 2005 16:50:29 +0000
Subject: [lm-sensors] Qs on chips/pc87360
Message-Id: <42B97A75.3060503@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Im working on a pc87366_gpio module, and it seems necessary
to coordinate locking in some way.

The simplest thing seems to be to EXPORT_SYMBOL the 2
semaphores in pc87360_data, but then I looked more closely,
and found something I dont understand...

/*
 * Client data (each client gets its own)
 */

struct pc87360_data {
        struct i2c_client client;
        struct semaphore lock;
        struct semaphore update_lock;


How is it possible to have each client get a separate struct
and separate locks, and still get any protection ?

Do semaphores magically interlock with other semaphores
protecting the same resource ?   And how do they know what
theyre protecting ? 

I see plenty of up/down ops on the lock, but no place where theyre
told what theyre locking access to.

Am I missing something ?


Do the earlier chips, 60, 65, etc also have a GPIO section,
or is it just the 66 ?

