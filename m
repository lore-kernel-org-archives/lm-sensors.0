From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: 2.6.4 i2c & lm_sensors tweaks for clean compile
Message-Id: <3D45F34A.EAF6672A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D45BAEF.EEB6E113@attbi.com>
In-Reply-To: <3D45BAEF.EEB6E113@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It all looks right to me.
I fixed smsc47m1 a couple of days ago.
Do you want to check in others?



Albert Cranford wrote:
> 
> Hello all,
> I tested 2.6.4, compiled into kernel and as module and had
> to make tweaks to get clean compiles.  Could you please
> comment if the module is yours.  Some are major and others
> are minor.  The changes are prefixed with ACC------
> Thanks,
> Albert
> 
> ++++++++ Compiled in kernel ++++++++
> // i2c-core.c:Line 1033
> i2c-core.c: In function `i2c_smbus_check_pec':
> i2c-core.c:1036: warning: unused variable `len'
> int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
>                         union i2c_smbus_data *data)
> {
>         u8 buf[3], rpec, cpec, len;
> ACC--------------------- Remove len.  Unused.
> 
> // chips/lm92.c: Line 396
> drivers/i2c/chips/i2c-chips.o: In function `sensors_init_all':
> drivers/i2c/chips/i2c-chips.o(.text.init+0x3d): undefined reference to
>      `sensors_lm92_init'
> make: *** [vmlinux] Error 1
> static int __init sensors_lm92_init (void)
> ACC------- remove static -------------
> {
> 
> +++++++++ Compiled as module +++++++++
> 
> // chips/pcf8574.c: Line 342
> pcf8574.c:346: warning: suggest parentheses around assignment used as truth value
> pcf8574.c:337: warning: unused variable `tmpstatus'
> void pcf8574_write(struct i2c_client *client, int operation,
>                     int ctl_name, int *nrels_mag, long *results)
> {
>         u8      tmpstatus;
> ACC-------- unused, remove -------------------
> 
>         struct pcf8574_data *data = client->data;
>         if (operation = SENSORS_PROC_REAL_INFO)
>                 *nrels_mag = 0;
>         else if (operation = SENSORS_PROC_REAL_READ) {
>                 results[0] = data->write;
>                 *nrels_mag = 1;
>         } else if (operation = SENSORS_PROC_REAL_WRITE) {
>                 if (*nrels_mag = 1) {
> ACC------------ if (*nrels_mag = 1) {
> ---change assignment to bool operator -------------
>                         data->write = results[0];
>                         i2c_smbus_write_byte(client, data->write);
>                 }
>         }
> }
> 
> //chips/maxilife.c: Line 417
> maxilife.c:422: warning: `type' might be used uninitialized in this function
> maxilife.c:424: warning: `type_name' might be used uninitialized in this function
> maxilife.c:424: warning: `client_name' might be used uninitialized in this function
> int maxi_detect(struct i2c_adapter *adapter, int address,
>                 unsigned short flags, int kind)
> {
>         struct i2c_client *new_client;
>         struct maxi_data *data;
>         enum maxi_type type = 0;
> ACC------------------------ initialize to 0 --------
>         int i, j, err = 0;
>         const char *type_name = NULL, *client_name = NULL;
> ACC------------------------- initialize both to NULL
> 
> // smsc47m1.c: Line 76
> smsc47m1.c:78: warning: function declaration isn't a prototype
> smsc47m1.c:85: warning: function declaration isn't a prototype
> smsc47m1.c:91: warning: function declaration isn't a prototype
> static inline void
> superio_select(void)
> ACC------------ added void to parameter list -------
> {
>         outb(DEV, REG);
>         outb(PME, VAL);
> }
> 
> static inline void
> superio_enter(void)
> ACC------------ added void to parameter list -------
> {
>         outb(0x55, REG);
> }
> 
> static inline void
> superio_exit(void)
> ACC------------ added void to parameter list -------
> {
>         outb(0xAA, REG);
> }
> 
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
