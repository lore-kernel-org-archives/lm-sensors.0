From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Apr 2013 15:32:42 +0000
Subject: Re: [lm-sensors] i2c-tools 'raw' i2c support
Message-Id: <20130408153242.GA2748@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 08, 2013 at 08:33:03PM -0000, Jason Morgan wrote:
> Hi
> 
> I was wondering if anybody has had a chance to review my patch?
> 
> Cheers,
> Jason.
> ----- Original Message -----
> From: Jason Morgan
> Sent: 02/04/13 02:07 PM
> To: lm-sensors@lm-sensors.org
> Subject: [lm-sensors] i2c-tools 'raw' i2c unsupported
> 
> Hi,
> 
> I notice that the lm-sensors i2c-tools don't support 'raw' I2C device file access, instead they rely on the driver supporting the smbus interface. I am working on an embedded system that does not have smbus, so I created a some patches for lm-sensors tools that add a 'r' access method. The changes support i2c-get, i2c-put and i2c-dump.
> 
> These changes allow the i2c-tools to be used without smbus support in the kernel device driver for the I2C inteface.
> 
Is this really a problem ? Usually the kernel emulates SMBus access functions
if a driver doesn't support it directly.

Guenter

> Would the developers be interested in adding my patch to the distribution?
> 
> 
> diff from r6127
> 
> regards,
> Jason
> 
> ----
> Index: tools/i2cbusses.c
> =================================> --- tools/i2cbusses.c (revision 6127)
> +++ tools/i2cbusses.c (working copy)
> @@ -415,3 +415,50 @@
> 
>  return 0;
>  }
> +
> +int i2c_read_raw_again(int file, unsigned char *buffer, unsigned int count)
> +{
> + unsigned char *ptr = buffer;
> + int res=0;
> +
> + res = read(file, ptr, count);
> + if(res<0)fprintf(stderr, "Aborting - read data failed (%d) : %s\n",errno,strerror(errno));
> +
> + return res;
> +}
> +
> +int i2c_read_raw(int file, unsigned char *buffer, int daddress, unsigned int count)
> +{
> + int res;
> + buffer[0] = (unsigned char)(daddress>>8);
> + buffer[1] = (unsigned char)daddress & 0xFF;
> +
> + res = write(file, buffer, 2);
> + if (res < 0)fprintf(stderr, "Warning - write addr failed %d : %s\n",errno,strerror(errno));
> + 
> + return i2c_read_raw_again(file,buffer,count);
> +}
> +
> +int i2c_write_raw(int file, unsigned char *buffer, int daddress, unsigned int count)
> +{
> + unsigned char *ptr;
> + int res;
> + unsigned int n;
> + 
> + ptr = malloc(count+10);
> + if(ptr=NULL)
> + {
> + fprintf(stderr, "Memory allocation error\n");
> + return -1;
> + }
> + ptr[0] = (unsigned char)(daddress>>8);
> + ptr[1] = (unsigned char)daddress & 0xFF;
> + memcpy(ptr+2,buffer,count);
> + for(n=0;n<count+2;n++)fprintf(stderr,"%hhx ",*(ptr+n));
> + fprintf(stderr,"\n");
> + res = write(file,ptr,count+2);
> + if(res<0)fprintf(stderr, "Warning: write data failed (%d) : %s\n",errno,strerror(errno));
> + 
> + free(ptr);
> + return res;
> +}
> Index: tools/i2cbusses.h
> =================================> --- tools/i2cbusses.h (revision 6127)
> +++ tools/i2cbusses.h (working copy)
> @@ -38,7 +38,9 @@
>  int parse_i2c_address(const char *address_arg);
>  int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
>  int set_slave_addr(int file, int address, int force);
> -
> +int i2c_read_raw(int file, unsigned char *buffer, int daddress, unsigned int count);
> +int i2c_write_raw(int file, unsigned char *buffer, int daddress, unsigned int count);
> +int i2c_read_raw_again(int file, unsigned char *buffer, unsigned int count);
>  #define MISSING_FUNC_FMT "Error: Adapter does not have %s capability\n"
> 
>  #endif
> Index: tools/i2cdump.c
> =================================> --- tools/i2cdump.c (revision 6127)
> +++ tools/i2cdump.c (working copy)
> @@ -33,6 +33,9 @@
>  #include "util.h"
>  #include "../version.h"
> 
> +
> +#define I2C_RAW -1
> +
>  static void help(void)
>  {
>  fprintf(stderr,
> @@ -46,6 +49,7 @@
>  " s (SMBus block)\n"
>  " i (I2C block)\n"
>  " c (consecutive byte)\n"
> + " r (i2c raw device)"
>  " Append p for SMBus PEC\n");
>  }
> 
> @@ -61,6 +65,14 @@
>  }
> 
>  switch(size) {
> + case I2C_RAW:
> + //If raw i2c is specified, use that instead of SMBus
> + if (!(funcs & I2C_FUNC_I2C)){
> + fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
> + return -1;
> + }
> + break;
> + 
>  case I2C_SMBUS_BYTE:
>  if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
>  fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive byte");
> @@ -184,8 +196,10 @@
>  } else if (!strncmp(argv[flags+3], "c", 1)) {
>  size = I2C_SMBUS_BYTE;
>  pec = argv[flags+3][1] = 'p';
> - } else if (!strcmp(argv[flags+3], "i"))
> + } else if (!strcmp(argv[flags+3], "i")) {
>  size = I2C_SMBUS_I2C_BLOCK_DATA;
> + } else if (!strcmp(argv[flags+3], "r"))
> + size = I2C_RAW;
>  else {
>  fprintf(stderr, "Error: Invalid mode!\n");
>  help();
> @@ -248,6 +262,7 @@
> 
>  /* Check mode constraints */
>  switch (size) {
> + case I2C_RAW:
>  case I2C_SMBUS_BYTE:
>  case I2C_SMBUS_BYTE_DATA:
>  break;
> @@ -285,6 +300,7 @@
>  size = I2C_SMBUS_BLOCK_DATA ? "smbus block" :
>  size = I2C_SMBUS_I2C_BLOCK_DATA ? "i2c block" :
>  size = I2C_SMBUS_BYTE ? "byte consecutive read" :
> + size = I2C_RAW ? "raw I2C consecutive read" :
>  size = I2C_SMBUS_BYTE_DATA ? "byte" : "word");
>  if (pec)
>  fprintf(stderr, "PEC checking enabled.\n");
> @@ -292,7 +308,9 @@
>  fprintf(stderr, "Only probing even register "
>  "addresses.\n");
>  if (bank) {
> - if (size = I2C_SMBUS_BLOCK_DATA)
> + if (size = I2C_RAW)
> + fprintf(stderr, "With bank offset 0x%04x\n",(bank*256));
> + else if (size = I2C_SMBUS_BLOCK_DATA)
>  fprintf(stderr, "Using command 0x%02x.\n",
>  bank);
>  else
> @@ -314,7 +332,7 @@
>  }
> 
>  /* See Winbond w83781d data sheet for bank details */
> - if (bank && size != I2C_SMBUS_BLOCK_DATA) {
> + if (bank && size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW) {
>  res = i2c_smbus_read_byte_data(file, bankreg);
>  if (res >= 0) {
>  old_bank = res;
> @@ -331,7 +349,7 @@
>  if (size != I2C_SMBUS_WORD_DATA || even) {
>  /* do the block transaction */
>  if (size = I2C_SMBUS_BLOCK_DATA
> - || size = I2C_SMBUS_I2C_BLOCK_DATA) {
> + || size = I2C_SMBUS_I2C_BLOCK_DATA || size = I2C_RAW) {
>  unsigned char cblock[288];
> 
>  if (size = I2C_SMBUS_BLOCK_DATA) {
> @@ -340,6 +358,9 @@
>  /* Remember returned block length for a nicer
>  display later */
>  s_length = res;
> + } else if(size = I2C_RAW) {
> + res = i2c_read_raw(file, cblock, (bank*256), 256);
> + s_length = res;
>  } else {
>  for (res = 0; res < 256; res += i) {
>  i = i2c_smbus_read_i2c_block_data(file,
> @@ -359,7 +380,7 @@
>  res = 256;
>  for (i = 0; i < res; i++)
>  block[i] = cblock[i];
> - if (size != I2C_SMBUS_BLOCK_DATA)
> + if (size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW)
>  for (i = res; i < 256; i++)
>  block[i] = -1;
>  }
> @@ -372,12 +393,14 @@
>  exit(1);
>  }
>  }
> -
> + 
>  printf(" 0 1 2 3 4 5 6 7 8 9 a b c d e f"
>  " 0123456789abcdef\n");
>  for (i = 0; i < 256; i+) {
>  if (size = I2C_SMBUS_BLOCK_DATA && i >= s_length)
>  break;
> + if (size = I2C_RAW && i >= s_length)
> + break;
>  if (i/16 < first/16)
>  continue;
>  if (i/16 > last/16)
> @@ -400,8 +423,7 @@
>  block[i+j] = res >  i2c_smbus_read_byte_data(file, i+j);
>  } else if (size = I2C_SMBUS_WORD_DATA) {
> - res = i2c_smbus_read_word_data(file,
> - i+j);
> + res = i2c_smbus_read_word_data(file, i+j);
>  if (res < 0) {
>  block[i+j] = res;
>  block[i+j+1] = res;
> @@ -415,7 +437,7 @@
>  } else
>  res = block[i+j];
> 
> - if (size = I2C_SMBUS_BLOCK_DATA
> + if ((size = I2C_SMBUS_BLOCK_DATA || size = I2C_RAW)
>  && i+j >= s_length) {
>  printf(" ");
>  } else if (res < 0) {
> @@ -433,7 +455,7 @@
>  printf(" ");
> 
>  for (j = 0; j < 16; j++) {
> - if (size = I2C_SMBUS_BLOCK_DATA
> + if ((size = I2C_SMBUS_BLOCK_DATA || size = I2C_RAW)
>  && i+j >= s_length)
>  break;
>  /* Skip unwanted registers */
> @@ -483,7 +505,7 @@
>  printf("\n");
>  }
>  }
> - if (bank && size != I2C_SMBUS_BLOCK_DATA) {
> + if (bank && size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW) {
>  i2c_smbus_write_byte_data(file, bankreg, old_bank);
>  }
>  exit(0);
> Index: tools/i2cget.c
> =================================> --- tools/i2cget.c (revision 6127)
> +++ tools/i2cget.c (working copy)
> @@ -38,6 +38,8 @@
> 
>  static void help(void) __attribute__ ((noreturn));
> 
> +#define I2C_RAW -1
> +
>  static void help(void)
>  {
>  fprintf(stderr,
> @@ -45,6 +47,7 @@
>  " I2CBUS is an integer or an I2C bus name\n"
>  " ADDRESS is an integer (0x03 - 0x77)\n"
>  " MODE is one of:\n"
> + " r (read byte using raw i2c device)\n"
>  " b (read byte data, default)\n"
>  " w (read word data)\n"
>  " c (write byte/read byte)\n"
> @@ -52,6 +55,7 @@
>  exit(1);
>  }
> 
> +
>  static int check_funcs(int file, int size, int daddress, int pec)
>  {
>  unsigned long funcs;
> @@ -62,8 +66,15 @@
>  "functionality matrix: %s\n", strerror(errno));
>  return -1;
>  }
> -
> + 
>  switch (size) {
> + case I2C_RAW:
> + //If raw i2c is specified, use that instead of SMBus
> + if (!(funcs & I2C_FUNC_I2C)){
> + fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
> + return -1;
> + }
> + break;
>  case I2C_SMBUS_BYTE:
>  if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
>  fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive byte");
> @@ -135,8 +146,8 @@
>  fprintf(stderr, ", using %s.\n",
>  size = I2C_SMBUS_BYTE ? (daddress < 0 ?
>  "read byte" : "write byte/read byte") :
> - size = I2C_SMBUS_BYTE_DATA ? "read byte data" :
> - "read word data");
> + (size = I2C_SMBUS_BYTE_DATA || size = I2C_RAW) ?
> + "read byte data" : "read word data");
>  if (pec)
>  fprintf(stderr, "PEC checking enabled.\n");
> 
> @@ -159,6 +170,7 @@
>  int pec = 0;
>  int flags = 0;
>  int force = 0, yes = 0, version = 0;
> + unsigned char buffer[10];
> 
>  /* handle (optional) flags first */
>  while (1+flags < argc && argv[1+flags][0] = '-') {
> @@ -208,6 +220,7 @@
>  case 'b': size = I2C_SMBUS_BYTE_DATA; break;
>  case 'w': size = I2C_SMBUS_WORD_DATA; break;
>  case 'c': size = I2C_SMBUS_BYTE; break;
> + case 'r': size = I2C_RAW; break;
>  default:
>  fprintf(stderr, "Error: Invalid mode!\n");
>  help();
> @@ -232,11 +245,14 @@
>  }
> 
>  switch (size) {
> + case I2C_RAW:
> + res = i2c_read_raw(file,buffer,daddress,1);
> + break;
>  case I2C_SMBUS_BYTE:
>  if (daddress >= 0) {
>  res = i2c_smbus_write_byte(file, daddress);
>  if (res < 0)
> - fprintf(stderr, "Warning - write failed\n");
> + fprintf(stderr, "Warning - write addr failed\n");
>  }
>  res = i2c_smbus_read_byte(file);
>  break;
> @@ -253,7 +269,13 @@
>  exit(2);
>  }
> 
> - printf("0x%0*x\n", size = I2C_SMBUS_WORD_DATA ? 4 : 2, res);
> -
> + switch(size){
> + case I2C_RAW:
> + printf("0x%04x = %02hhx\n", daddress, buffer[0]);
> + break;
> + default:
> + printf("0x%0*x\n", size = I2C_SMBUS_WORD_DATA ? 4 : 2, res);
> + }
> + 
>  exit(0);
>  }
> Index: tools/i2cset.c
> =================================> --- tools/i2cset.c (revision 6127)
> +++ tools/i2cset.c (working copy)
> @@ -35,6 +35,8 @@
> 
>  static void help(void) __attribute__ ((noreturn));
> 
> +#define I2C_RAW -1
> +
>  static void help(void)
>  {
>  fprintf(stderr,
> @@ -42,6 +44,7 @@
>  " I2CBUS is an integer or an I2C bus name\n"
>  " ADDRESS is an integer (0x03 - 0x77)\n"
>  " MODE is one of:\n"
> + " r (write byte using raw i2c device)\n"
>  " c (byte, no value)\n"
>  " b (byte data, default)\n"
>  " w (word data)\n"
> @@ -63,6 +66,13 @@
>  }
> 
>  switch (size) {
> + case I2C_RAW:
> + //If raw i2c is specified, use that instead of SMBus
> + if (!(funcs & I2C_FUNC_I2C)){
> + fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
> + return -1;
> + }
> + break;
>  case I2C_SMBUS_BYTE:
>  if (!(funcs & I2C_FUNC_SMBUS_WRITE_BYTE)) {
>  fprintf(stderr, MISSING_FUNC_FMT, "SMBus send byte");
> @@ -140,7 +150,7 @@
>  } else
>  fprintf(stderr, "data 0x%02x%s, mode %s.\n", value,
>  vmask ? " (masked)" : "",
> - size = I2C_SMBUS_BYTE_DATA ? "byte" : "word");
> + (size = I2C_SMBUS_BYTE_DATA || size = I2C_RAW) ? "byte" : "word");
>  if (pec)
>  fprintf(stderr, "PEC checking enabled.\n");
> 
> @@ -235,6 +245,7 @@
>  case 'w': size = I2C_SMBUS_WORD_DATA; break;
>  case 's': size = I2C_SMBUS_BLOCK_DATA; break;
>  case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
> + case 'r': size = I2C_RAW; break;
>  default:
>  fprintf(stderr, "Error: Invalid mode '%s'!\n", argv[argc-1]);
>  help();
> @@ -263,6 +274,7 @@
> 
>  /* read values from command line */
>  switch (size) {
> + case I2C_RAW:
>  case I2C_SMBUS_BYTE_DATA:
>  case I2C_SMBUS_WORD_DATA:
>  value = strtol(argv[flags+4], &end, 0);
> @@ -303,7 +315,7 @@
>  fprintf(stderr, "Error: Data value mask invalid!\n");
>  help();
>  }
> - if (((size = I2C_SMBUS_BYTE || size = I2C_SMBUS_BYTE_DATA)
> + if (((size = I2C_SMBUS_BYTE || size = I2C_SMBUS_BYTE_DATA || size = I2C_RAW)
>  && vmask > 0xff) || vmask > 0xffff) {
>  fprintf(stderr, "Error: Data value mask out of range!\n");
>  help();
> @@ -320,10 +332,15 @@
>  value, vmask, block, len, pec))
>  exit(0);
> 
> + //Get the old value
>  if (vmask) {
>  int oldvalue;
> 
>  switch (size) {
> + case I2C_RAW:
> + res = i2c_read_raw(file,block,daddress,1);
> + oldvalue = (unsigned int)block[0];
> + break;
>  case I2C_SMBUS_BYTE:
>  oldvalue = i2c_smbus_read_byte(file);
>  break;
> @@ -366,7 +383,12 @@
>  exit(1);
>  }
> 
> + //Do the write
>  switch (size) {
> + case I2C_RAW:
> + block[0] = value;
> + res = i2c_write_raw(file,block,daddress,1);
> + break;
>  case I2C_SMBUS_BYTE:
>  res = i2c_smbus_write_byte(file, daddress);
>  break;
> @@ -403,7 +425,11 @@
>  exit(0);
>  }
> 
> + //Verify the write
>  switch (size) {
> + case I2C_RAW:
> + i2c_read_raw(file,block,daddress,1);
> + res = (unsigned int)block[0];
>  case I2C_SMBUS_BYTE:
>  res = i2c_smbus_read_byte(file);
>  value = daddress;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
