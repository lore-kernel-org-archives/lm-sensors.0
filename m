From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: i2c-2.6.3 updated in linux-2.5.24
Message-Id: <3D135C60.31D24DFB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D1337DF.BF654A31@bellsouth.net>
In-Reply-To: <3D1337DF.BF654A31@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alan,
- Are you saying that the kernel patch for i2c-2.6.3 was accepted? If so that's great - what kernel? 2.5.23?

- As you know, we have not released i2c-2.6.4 and I am in the middle of working with Intel on
  SMBus 2.0 support in i2c.h, i2c-core.c, i2c-dev.c, and i2c-dev.h. Please do not
  submit these changes to the kernel yet. I think it will be a couple of more weeks.
  I'll let everyone know. Generally I send out a 'last call for release 2.x.x' email.
  Please continue to label them 'testing' for now.


Albert Cranford wrote:
> 
> Hello all,
> Attached is a patch that brings linux-2.5.24 upto i2c-2.6.4
> Please test out the recent inclusions in the kernel that
> brought i2c upto 2.6.3 and report any discrepancies.
> Thanks,
> Albert
> 
> PS:Web page will be updated this weekend.
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> --- linux/include/linux/i2c-id.h.orig   2002-06-17 09:35:14.000000000 -0400
> +++ linux/include/linux/i2c-id.h        2002-06-17 09:48:34.000000000 -0400
> @@ -91,7 +91,7 @@
>  #define I2C_DRIVERID_SP5055    44     /* Satellite tuner               */
>  #define I2C_DRIVERID_STV0030   45     /* Multipurpose switch           */
>  #define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
> -
> +#define I2C_DRIVERID_DS1307    47     /* DS1307 real time clock        */
> 
> 
> 
> @@ -102,6 +102,8 @@
> 
>  #define I2C_DRIVERID_I2CDEV    900
>  #define I2C_DRIVERID_I2CPROC   901
> +#define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
> +#define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
> 
>  /* IDs --   Use DRIVERIDs 1000-1999 for sensors.
>     These were originally in sensors.h in the lm_sensors package */
> @@ -134,6 +136,7 @@
>  #define I2C_DRIVERID_FSCPOS 1028
>  #define I2C_DRIVERID_FSCSCY 1029
>  #define I2C_DRIVERID_PCF8591 1030
> +#define I2C_DRIVERID_SMSC47M1 1031
> 
>  /*
>   * ---- Adapter types ----------------------------------------------------
> @@ -182,9 +185,11 @@
>  #define I2C_HW_B_I810  0x0a    /* Intel I810                           */
>  #define I2C_HW_B_VOO   0x0b    /* 3dfx Voodoo 3 / Banshee              */
>  #define I2C_HW_B_PPORT  0x0c   /* Primitive parallel port adapter      */
> +#define I2C_HW_B_SAVG  0x0d    /* Savage 4                             */
>  #define I2C_HW_B_RIVA  0x10    /* Riva based graphics cards            */
>  #define I2C_HW_B_IOC   0x11    /* IOC bit-wiggling                     */
>  #define I2C_HW_B_TSUNA  0x12   /* DEC Tsunami chipset                  */
> +#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
> 
>  /* --- PCF 8584 based algorithms                                       */
>  #define I2C_HW_P_LP    0x00    /* Parallel port interface              */
> --- linux/include/linux/i2c.h.orig      2002-06-17 09:35:14.000000000 -0400
> +++ linux/include/linux/i2c.h   2002-06-17 09:48:35.000000000 -0400
> @@ -280,6 +283,9 @@
>  #define I2C_CLIENT_ALLOW_USE           0x01    /* Client allows access */
>  #define I2C_CLIENT_ALLOW_MULTIPLE_USE  0x02    /* Allow multiple access-locks */
>                                                 /* on an i2c_client */
> +#define I2C_CLIENT_PEC  0x04                   /* Use Packet Error Checking */
> +#define I2C_CLIENT_TEN 0x10                    /* we have a ten bit chip address       */
> +                                               /* Must equal I2C_M_TEN below */
> 
>  /* i2c_client_address_data is the struct for holding default client
>   * addresses for a driver and for the parameters supplied on the
> @@ -395,6 +401,8 @@
>  #define I2C_FUNC_I2C                   0x00000001
>  #define I2C_FUNC_10BIT_ADDR            0x00000002
>  #define I2C_FUNC_PROTOCOL_MANGLING     0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART} */
> +#define I2C_FUNC_SMBUS_HWPEC_CALC      0x00000008 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL 0x00008000 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_QUICK           0x00010000
>  #define I2C_FUNC_SMBUS_READ_BYTE       0x00020000
>  #define I2C_FUNC_SMBUS_WRITE_BYTE      0x00040000
> @@ -409,6 +417,8 @@
>  #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK 0x08000000 /* w/ 1-byte reg. addr. */
>  #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2         0x10000000 /* I2C-like block xfer  */
>  #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
> +#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
> 
>  #define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
>                              I2C_FUNC_SMBUS_WRITE_BYTE
> @@ -422,6 +432,8 @@
>                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
>  #define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
>                                     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
> +#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
> +                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
> 
>  #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
>                              I2C_FUNC_SMBUS_BYTE | \
> @@ -435,10 +447,14 @@
>  /*
>   * Data for SMBus Messages
>   */
> +#define I2C_SMBUS_BLOCK_MAX    32      /* As specified in SMBus standard */
> +#define I2C_SMBUS_I2C_BLOCK_MAX        32      /* Not specified but we use same structure */
>  union i2c_smbus_data {
>         __u8 byte;
>         __u16 word;
> -       __u8 block[33]; /* block[0] is used for length */
> +       __u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
> +                          /* one more for read length in block process call */
> +                                                   /* and one more for PEC */
>  };
> 
>  /* smbus_access read or write markers */
> @@ -454,6 +470,8 @@
>  #define I2C_SMBUS_PROC_CALL        4
>  #define I2C_SMBUS_BLOCK_DATA       5
>  #define I2C_SMBUS_I2C_BLOCK_DATA    6
> +#define I2C_SMBUS_BLOCK_PROC_CALL   7          /* SMBus 2.0 */
> +#define I2C_SMBUS_BLOCK_DATA_PEC    8          /* SMBus 2.0 */
> 
> 
>  /* ----- commands for the ioctl like i2c_command call:
> @@ -479,6 +497,7 @@
> 
>  #define I2C_FUNCS      0x0705  /* Get the adapter functionality */
>  #define I2C_RDWR       0x0707  /* Combined R/W transfer (one stop only)*/
> +#define I2C_PEC                0x0708  /* != 0 for SMBus PEC                   */
>  #if 0
>  #define I2C_ACK_TEST   0x0710  /* See if a slave is at a specific address */
>  #endif
> --- linux/drivers/i2c/i2c-core.c.orig   2002-06-17 09:35:14.000000000 -0400
> +++ linux/drivers/i2c/i2c-core.c        2002-06-17 09:48:30.000000000 -0400
> @@ -71,7 +71,7 @@
>  static int driver_count;
> 
>  /**** debug level */
> -static int i2c_debug=1;
> +static int i2c_debug=0;
> 
>  /* ---------------------------------------------------
>   * /proc entry declarations
> @@ -371,7 +371,7 @@
>                                 struct i2c_client *client = adap->clients[j];
>                                 if (client != NULL &&
>                                     client->driver = driver) {
> -                                       DEB2(printk("i2c-core.o: "
> +                                       DEB2(printk(KERN_DEBUG "i2c-core.o: "
>                                                     "detaching client %s:\n",
>                                                     client->name));
>                                         if ((res = driver->
> @@ -1002,6 +1000,36 @@
> 
>  /* The SMBus parts */
> 
> +#define POLY    (0x1070U << 3)
> +static u8
> +crc8(u16 data)
> +{
> +       int i;
> +
> +       for(i = 0; i < 8; i++) {
> +               if (data & 0x8000)
> +                       data = data ^ POLY;
> +               data = data << 1;
> +       }
> +       return (u8)(data >> 8);
> +}
> +
> +/* CRC over count bytes in the first array plus the bytes in the rest
> +   array if it is non-null. rest[0] is the (length of rest) - 1
> +   and is included. */
> +u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
> +{
> +       int i;
> +       u8 crc = 0;
> +
> +       for(i = 0; i < count; i++)
> +               crc = crc8((crc ^ first[i]) << 8);
> +       if(rest != NULL)
> +               for(i = 0; i <= rest[0]; i++)
> +                       crc = crc8((crc ^ rest[i]) << 8);
> +       return crc;
> +}
> +
>  extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value)
>  {
>         return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> @@ -1020,8 +1048,18 @@
> 
>  extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value)
>  {
> -       return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> -                             I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,NULL);
> +       if((client->flags & I2C_CLIENT_PEC) &&
> +          !(i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
> +               union i2c_smbus_data data;
> +               u8 d[2] = {(client->addr << 1), value};
> +               data.byte = i2c_smbus_pec(2, d, NULL);
> +               return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> +                                     I2C_SMBUS_WRITE,value,
> +                                     I2C_SMBUS_BYTE_DATA,&data);
> +       } else {
> +               return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> +                                     I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,NULL);
> +       }
>  }
> 
>  extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command)
> @@ -1085,13 +1123,24 @@
>         int i;
>         if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
>                            I2C_SMBUS_READ,command,
> -                          I2C_SMBUS_BLOCK_DATA,&data))
> +                          ((client->flags & I2C_CLIENT_PEC) ? I2C_SMBUS_BLOCK_DATA_PEC :
> +                                                              I2C_SMBUS_BLOCK_DATA),
> +                          &data))
>                 return -1;
> -       else {
> -               for (i = 1; i <= data.block[0]; i++)
> -                       values[i-1] = data.block[i];
> -               return data.block[0];
> +
> +       if((client->flags & I2C_CLIENT_PEC) &&
> +          !(i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
> +               u8 d[3] = {(client->addr << 1), command, (client->addr << 1) | 0x01};
> +               i = i2c_smbus_pec(3, d, data.block);
> +               if(i != data.block[data.block[0] + 1]) {
> +                       DEB(printk(KERN_DEBUG "i2c-core.o: Bad block read PEC 0x%02x vs. 0x%02x\n",
> +                                  i, data.block[data.block[0] + 1]));
> +                       return(-1);
> +               }
>         }
> +       for (i = 1; i <= data.block[0]; i++)
> +               values[i-1] = data.block[i];
> +       return data.block[0];
>  }
> 
>  extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
> @@ -1099,14 +1148,21 @@
>  {
>         union i2c_smbus_data data;
>         int i;
> -       if (length > 32)
> -               length = 32;
> +       if (length > I2C_SMBUS_BLOCK_MAX)
> +               length = I2C_SMBUS_BLOCK_MAX;
> +       data.block[0] = length;
>         for (i = 1; i <= length; i++)
>                 data.block[i] = values[i-1];
> -       data.block[0] = length;
> +       if((client->flags & I2C_CLIENT_PEC) &&
> +          !(i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
> +               u8 d[2] = {(client->addr << 1), command};
> +               data.block[length + 1] = i2c_smbus_pec(2, d, data.block);
> +       }
>         return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> -                             I2C_SMBUS_WRITE,command,
> -                             I2C_SMBUS_BLOCK_DATA,&data);
> +                             I2C_SMBUS_WRITE, command,
> +                             ((client->flags & I2C_CLIENT_PEC) ? I2C_SMBUS_BLOCK_DATA_PEC :
> +                                                                 I2C_SMBUS_BLOCK_DATA),
> +                             &data);
>  }
> 
>  /* Returns the number of read bytes */
> @@ -1131,8 +1187,8 @@
>  {
>         union i2c_smbus_data data;
>         int i;
> -       if (length > 32)
> -               length = 32;
> +       if (length > I2C_SMBUS_I2C_BLOCK_MAX)
> +               length = I2C_SMBUS_I2C_BLOCK_MAX;
>         for (i = 1; i <= length; i++)
>                 data.block[i] = values[i-1];
>         data.block[0] = length;
> @@ -1218,7 +1274,7 @@
>                 break;
>         case I2C_SMBUS_I2C_BLOCK_DATA:
>                 if (read_write = I2C_SMBUS_READ) {
> -                       msg[1].len = 32;
> +                       msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
>                 } else {
>                         msg[0].len = data->block[0] + 2;
>                         if (msg[0].len > 34) {
> @@ -1254,8 +1310,8 @@
>                                 break;
>                         case I2C_SMBUS_I2C_BLOCK_DATA:
>                                 /* fixed at 32 for now */
> -                               data->block[0] = 32;
> -                               for (i = 0; i < 32; i++)
> +                               data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
> +                               for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
>                                         data->block[i+1] = msgbuf1[i];
>                                 break;
>                 }
> @@ -1268,7 +1324,7 @@
>                     union i2c_smbus_data * data)
>  {
>         s32 res;
> -       flags = flags & I2C_M_TEN;
> +       flags &= I2C_M_TEN | I2C_CLIENT_PEC;
>         if (adapter->algo->smbus_xfer) {
>                 I2C_LOCK(adapter);
>                 res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
> --- linux/drivers/i2c/i2c-dev.c.orig    2002-06-17 09:35:14.000000000 -0400
> +++ linux/drivers/i2c/i2c-dev.c 2002-06-17 09:48:34.000000000 -0400
> @@ -236,6 +236,12 @@
>                 else
>                         client->flags &= ~I2C_M_TEN;
>                 return 0;
> +       case I2C_PEC:
> +               if (arg)
> +                       client->flags |= I2C_CLIENT_PEC;
> +               else
> +                       client->flags &= ~I2C_CLIENT_PEC;
> +               return 0;
>         case I2C_FUNCS:
>                 funcs = i2c_get_functionality(client->adapter);
>                 return (copy_to_user((unsigned long *)arg,&funcs,
> @@ -541,6 +547,8 @@
>         return 0;
>  }
> 
> +EXPORT_NO_SYMBOLS;
> +
>  #ifdef MODULE
> 
>  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
> --- linux/drivers/i2c/i2c-proc.c.orig   2002-06-17 09:35:14.000000000 -0400
> +++ linux/drivers/i2c/i2c-proc.c        2002-06-19 00:26:53.000000000 -0400
> @@ -60,6 +60,7 @@
>  static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
> 
>  static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
> +static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
> 
>  static ctl_table sysctl_table[] = {
>         {CTL_DEV, "dev", NULL, 0, 0555},
> @@ -188,6 +189,8 @@
>                 return id;
>         }
>  #endif                         /* DEBUG */
> +       i2c_inodes[id - 256] > +           new_header->ctl_table->child->child->de->low_ino;
>         new_header->ctl_table->child->child->de->owner = controlling_mod;
> 
>         return id;
