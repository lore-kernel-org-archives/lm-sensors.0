From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <427B69E0.4010307@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[snip]
> No idea, most probably because nobody updated the dev-interface document
> since the i2c-dev header file was split. If you submit a patch updating
> it, I'll review it and have it applied.

i am happy to submit an update patch for the dev-interface document, but 
at the moment i still have too many errors - i assume not many people 
use /dev from user-space in 2.6.x anymore ?

so far :

(i) use lm_sensors i2c-dev.h instead of kernel header file
#include <linux/i2c.h>
#include "i2c-dev.h" /* lm_sensors header file */

causes compile errors due to <linux/i2c.h>

(ii)
putting some #ifdef __KERNEL__ back into <linux/i2c.h> helps.
two errors remain:

i2c-dev.h:39: error: redefinition of `struct i2c_msg'
i2c-dev.h:123: error: redefinition of `union i2c_smbus_data'

(iii)
commenting out the above definitions in "i2c-dev.h"
helps compiling, but i am not sure it should be done...

any suggestions anyone ?

regards

   nils roeder
