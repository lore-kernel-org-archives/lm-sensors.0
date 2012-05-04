From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 May 2012 13:34:19 +0000
Subject: Re: [lm-sensors] [PATCH, v2] hwmon: coretemp: use list instead of fixed size array for temp
Message-Id: <20120504133419.GA20602@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335971436-13903-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1336043936-11105-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120504054122.GA19334@ericsson.com>
 <20120504064606.GA11744@otc-wbsnb-06>
In-Reply-To: <20120504064606.GA11744@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Durgadoss R <durgadoss.r@intel.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, May 04, 2012 at 02:46:06AM -0400, Kirill A. Shutemov wrote:
> On Thu, May 03, 2012 at 10:41:22PM -0700, Guenter Roeck wrote:
> > On Thu, May 03, 2012 at 07:18:56AM -0400, Kirill A. Shutemov wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Let's rework code to allow arbitrary number of cores on a CPU, not
> > > limited by hardcoded array size.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  v2:
> > >    - fix NULL pointer dereference. Thanks to R, Durgadoss;
> > >    - use mutex instead of spinlock for list locking.
> > > ---
> > >  drivers/hwmon/coretemp.c |  178 +++++++++++++++++++++++++++++++++-------------
> > >  1 files changed, 129 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index 54a70fe..1c66131 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -36,6 +36,8 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/smp.h>
> > > +#include <linux/list.h>
> > > +#include <linux/kref.h>
> > >  #include <linux/moduleparam.h>
> > >  #include <asm/msr.h>
> > >  #include <asm/processor.h>
> > > @@ -52,11 +54,9 @@ module_param_named(tjmax, force_tjmax, int, 0444);
> > >  MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
> > > 
> > >  #define BASE_SYSFS_ATTR_NO     2       /* Sysfs Base attr no for coretemp */
> > > -#define NUM_REAL_CORES         16      /* Number of Real cores per cpu */
> > >  #define CORETEMP_NAME_LENGTH   17      /* String Length of attrs */
> > >  #define MAX_CORE_ATTRS         4       /* Maximum no of basic attrs */
> > >  #define TOTAL_ATTRS            (MAX_CORE_ATTRS + 1)
> > > -#define MAX_CORE_DATA          (NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> > > 
> > >  #define TO_PHYS_ID(cpu)                (cpu_data(cpu).phys_proc_id)
> > >  #define TO_CORE_ID(cpu)                (cpu_data(cpu).cpu_core_id)
> > > @@ -82,6 +82,9 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
> > >   * @valid: If this is 1, the current temperature is valid.
> > >   */
> > >  struct temp_data {
> > > +       struct list_head list;
> > > +       struct kref refcount;
> > 
> > Hi,
> > 
> > the kref is not needed. The attribute access functions don't
> > need to be protected since the attributes for a core are deleted
> > before the core data itself is deleted. So it is not neccessary 
> > to hold a lock while accessing/using temp_data in the attribute
> > access functions. All you need is to hold a mutex while you are
> > manipulating or walking the list.
> 
> Without kref, what prevents following situation:
> 
> 		CPU-A				CPU-B
> 	tdata = get_temp_data();
> 					coretemp_remove_core() {
> 					    device_remove_file();
> 					    kfree(tdata);
> 					}
> 	<tdata dereference>
> 
The remove function requires a semaphore which is held by the access function,
so device_remove_file() will only proceed after CPU-A is done with the sysfs access.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
