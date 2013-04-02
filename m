From: "Jason Morgan" <j.a.morgan@gmx.co.uk>
Date: Tue, 02 Apr 2013 13:07:50 +0000
Subject: [lm-sensors] i2c-tools 'raw' i2c unsupported
Message-Id: <20130402130750.164070@gmx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8588452095159277838=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8588452095159277838==
Content-Type: multipart/alternative;
 boundary="========GMXBoundary164071364908070625525"

--========GMXBoundary164071364908070625525
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I notice that the lm-sensors i2c-tools don't support 'raw' I2C device file access, instead they rely on the driver supporting the smbus interface. I am working on an embedded system that does not have smbus, so I created a some patches for lm-sensors tools that add a 'r' access method. The changes support i2c-get, i2c-put and i2c-dump.

These changes allow the i2c-tools to be used without smbus support in the kernel device driver for the I2C inteface.

Would the developers be interested in adding my patch to the distribution?

diff from r6127

regards,
Jason

----
Index: tools/i2cbusses.c
===================================================================
--- tools/i2cbusses.c (revision 6127)
+++ tools/i2cbusses.c (working copy)
@@ -415,3 +415,50 @@

 return 0;
 }
+
+int i2c_read_raw_again(int file, unsigned char *buffer, unsigned int count)
+{
+ unsigned char *ptr = buffer;
+ int res=0;
+
+ res = read(file, ptr, count);
+ if(res<0)fprintf(stderr, "Aborting - read data failed (%d) : %s\n",errno,strerror(errno));
+
+ return res;
+}
+
+int i2c_read_raw(int file, unsigned char *buffer, int daddress, unsigned int count)
+{
+ int res;
+ buffer[0] = (unsigned char)(daddress>>8);
+ buffer[1] = (unsigned char)daddress & 0xFF;
+
+ res = write(file, buffer, 2);
+ if (res < 0)fprintf(stderr, "Warning - write addr failed %d : %s\n",errno,strerror(errno));
+ 
+ return i2c_read_raw_again(file,buffer,count);
+}
+
+int i2c_write_raw(int file, unsigned char *buffer, int daddress, unsigned int count)
+{
+ unsigned char *ptr;
+ int res;
+ unsigned int n;
+ 
+ ptr = malloc(count+10);
+ if(ptr==NULL)
+ {
+ fprintf(stderr, "Memory allocation error\n");
+ return -1;
+ }
+ ptr[0] = (unsigned char)(daddress>>8);
+ ptr[1] = (unsigned char)daddress & 0xFF;
+ memcpy(ptr+2,buffer,count);
+ for(n=0;n<count+2;n++)fprintf(stderr,"%hhx ",*(ptr+n));
+ fprintf(stderr,"\n");
+ res = write(file,ptr,count+2);
+ if(res<0)fprintf(stderr, "Warning: write data failed (%d) : %s\n",errno,strerror(errno));
+ 
+ free(ptr);
+ return res;
+}
Index: tools/i2cbusses.h
===================================================================
--- tools/i2cbusses.h (revision 6127)
+++ tools/i2cbusses.h (working copy)
@@ -38,7 +38,9 @@
 int parse_i2c_address(const char *address_arg);
 int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
 int set_slave_addr(int file, int address, int force);
-
+int i2c_read_raw(int file, unsigned char *buffer, int daddress, unsigned int count);
+int i2c_write_raw(int file, unsigned char *buffer, int daddress, unsigned int count);
+int i2c_read_raw_again(int file, unsigned char *buffer, unsigned int count);
 #define MISSING_FUNC_FMT "Error: Adapter does not have %s capability\n"

 #endif
Index: tools/i2cdump.c
===================================================================
--- tools/i2cdump.c (revision 6127)
+++ tools/i2cdump.c (working copy)
@@ -33,6 +33,9 @@
 #include "util.h"
 #include "../version.h"

+
+#define I2C_RAW -1
+
 static void help(void)
 {
 fprintf(stderr,
@@ -46,6 +49,7 @@
 " s (SMBus block)\n"
 " i (I2C block)\n"
 " c (consecutive byte)\n"
+ " r (i2c raw device)"
 " Append p for SMBus PEC\n");
 }

@@ -61,6 +65,14 @@
 }

 switch(size) {
+ case I2C_RAW:
+ //If raw i2c is specified, use that instead of SMBus
+ if (!(funcs & I2C_FUNC_I2C)){
+ fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
+ return -1;
+ }
+ break;
+ 
 case I2C_SMBUS_BYTE:
 if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
 fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive byte");
@@ -184,8 +196,10 @@
 } else if (!strncmp(argv[flags+3], "c", 1)) {
 size = I2C_SMBUS_BYTE;
 pec = argv[flags+3][1] == 'p';
- } else if (!strcmp(argv[flags+3], "i"))
+ } else if (!strcmp(argv[flags+3], "i")) {
 size = I2C_SMBUS_I2C_BLOCK_DATA;
+ } else if (!strcmp(argv[flags+3], "r"))
+ size = I2C_RAW;
 else {
 fprintf(stderr, "Error: Invalid mode!\n");
 help();
@@ -248,6 +262,7 @@

 /* Check mode constraints */
 switch (size) {
+ case I2C_RAW:
 case I2C_SMBUS_BYTE:
 case I2C_SMBUS_BYTE_DATA:
 break;
@@ -285,6 +300,7 @@
 size == I2C_SMBUS_BLOCK_DATA ? "smbus block" :
 size == I2C_SMBUS_I2C_BLOCK_DATA ? "i2c block" :
 size == I2C_SMBUS_BYTE ? "byte consecutive read" :
+ size == I2C_RAW ? "raw I2C consecutive read" :
 size == I2C_SMBUS_BYTE_DATA ? "byte" : "word");
 if (pec)
 fprintf(stderr, "PEC checking enabled.\n");
@@ -292,7 +308,9 @@
 fprintf(stderr, "Only probing even register "
 "addresses.\n");
 if (bank) {
- if (size == I2C_SMBUS_BLOCK_DATA)
+ if (size == I2C_RAW)
+ fprintf(stderr, "With bank offset 0x%04x\n",(bank*256));
+ else if (size == I2C_SMBUS_BLOCK_DATA)
 fprintf(stderr, "Using command 0x%02x.\n",
 bank);
 else
@@ -314,7 +332,7 @@
 }

 /* See Winbond w83781d data sheet for bank details */
- if (bank && size != I2C_SMBUS_BLOCK_DATA) {
+ if (bank && size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW) {
 res = i2c_smbus_read_byte_data(file, bankreg);
 if (res >= 0) {
 old_bank = res;
@@ -331,7 +349,7 @@
 if (size != I2C_SMBUS_WORD_DATA || even) {
 /* do the block transaction */
 if (size == I2C_SMBUS_BLOCK_DATA
- || size == I2C_SMBUS_I2C_BLOCK_DATA) {
+ || size == I2C_SMBUS_I2C_BLOCK_DATA || size == I2C_RAW) {
 unsigned char cblock[288];

 if (size == I2C_SMBUS_BLOCK_DATA) {
@@ -340,6 +358,9 @@
 /* Remember returned block length for a nicer
 display later */
 s_length = res;
+ } else if(size == I2C_RAW) {
+ res = i2c_read_raw(file, cblock, (bank*256), 256);
+ s_length = res;
 } else {
 for (res = 0; res < 256; res += i) {
 i = i2c_smbus_read_i2c_block_data(file,
@@ -359,7 +380,7 @@
 res = 256;
 for (i = 0; i < res; i++)
 block[i] = cblock[i];
- if (size != I2C_SMBUS_BLOCK_DATA)
+ if (size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW)
 for (i = res; i < 256; i++)
 block[i] = -1;
 }
@@ -372,12 +393,14 @@
 exit(1);
 }
 }
-
+ 
 printf(" 0 1 2 3 4 5 6 7 8 9 a b c d e f"
 " 0123456789abcdef\n");
 for (i = 0; i < 256; i+=16) {
 if (size == I2C_SMBUS_BLOCK_DATA && i >= s_length)
 break;
+ if (size == I2C_RAW && i >= s_length)
+ break;
 if (i/16 < first/16)
 continue;
 if (i/16 > last/16)
@@ -400,8 +423,7 @@
 block[i+j] = res =
 i2c_smbus_read_byte_data(file, i+j);
 } else if (size == I2C_SMBUS_WORD_DATA) {
- res = i2c_smbus_read_word_data(file,
- i+j);
+ res = i2c_smbus_read_word_data(file, i+j);
 if (res < 0) {
 block[i+j] = res;
 block[i+j+1] = res;
@@ -415,7 +437,7 @@
 } else
 res = block[i+j];

- if (size == I2C_SMBUS_BLOCK_DATA
+ if ((size == I2C_SMBUS_BLOCK_DATA || size == I2C_RAW)
 && i+j >= s_length) {
 printf(" ");
 } else if (res < 0) {
@@ -433,7 +455,7 @@
 printf(" ");

 for (j = 0; j < 16; j++) {
- if (size == I2C_SMBUS_BLOCK_DATA
+ if ((size == I2C_SMBUS_BLOCK_DATA || size == I2C_RAW)
 && i+j >= s_length)
 break;
 /* Skip unwanted registers */
@@ -483,7 +505,7 @@
 printf("\n");
 }
 }
- if (bank && size != I2C_SMBUS_BLOCK_DATA) {
+ if (bank && size != I2C_SMBUS_BLOCK_DATA && size != I2C_RAW) {
 i2c_smbus_write_byte_data(file, bankreg, old_bank);
 }
 exit(0);
Index: tools/i2cget.c
===================================================================
--- tools/i2cget.c (revision 6127)
+++ tools/i2cget.c (working copy)
@@ -38,6 +38,8 @@

 static void help(void) __attribute__ ((noreturn));

+#define I2C_RAW -1
+
 static void help(void)
 {
 fprintf(stderr,
@@ -45,6 +47,7 @@
 " I2CBUS is an integer or an I2C bus name\n"
 " ADDRESS is an integer (0x03 - 0x77)\n"
 " MODE is one of:\n"
+ " r (read byte using raw i2c device)\n"
 " b (read byte data, default)\n"
 " w (read word data)\n"
 " c (write byte/read byte)\n"
@@ -52,6 +55,7 @@
 exit(1);
 }

+
 static int check_funcs(int file, int size, int daddress, int pec)
 {
 unsigned long funcs;
@@ -62,8 +66,15 @@
 "functionality matrix: %s\n", strerror(errno));
 return -1;
 }
-
+ 
 switch (size) {
+ case I2C_RAW:
+ //If raw i2c is specified, use that instead of SMBus
+ if (!(funcs & I2C_FUNC_I2C)){
+ fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
+ return -1;
+ }
+ break;
 case I2C_SMBUS_BYTE:
 if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
 fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive byte");
@@ -135,8 +146,8 @@
 fprintf(stderr, ", using %s.\n",
 size == I2C_SMBUS_BYTE ? (daddress < 0 ?
 "read byte" : "write byte/read byte") :
- size == I2C_SMBUS_BYTE_DATA ? "read byte data" :
- "read word data");
+ (size == I2C_SMBUS_BYTE_DATA || size == I2C_RAW) ?
+ "read byte data" : "read word data");
 if (pec)
 fprintf(stderr, "PEC checking enabled.\n");

@@ -159,6 +170,7 @@
 int pec = 0;
 int flags = 0;
 int force = 0, yes = 0, version = 0;
+ unsigned char buffer[10];

 /* handle (optional) flags first */
 while (1+flags < argc && argv[1+flags][0] == '-') {
@@ -208,6 +220,7 @@
 case 'b': size = I2C_SMBUS_BYTE_DATA; break;
 case 'w': size = I2C_SMBUS_WORD_DATA; break;
 case 'c': size = I2C_SMBUS_BYTE; break;
+ case 'r': size = I2C_RAW; break;
 default:
 fprintf(stderr, "Error: Invalid mode!\n");
 help();
@@ -232,11 +245,14 @@
 }

 switch (size) {
+ case I2C_RAW:
+ res = i2c_read_raw(file,buffer,daddress,1);
+ break;
 case I2C_SMBUS_BYTE:
 if (daddress >= 0) {
 res = i2c_smbus_write_byte(file, daddress);
 if (res < 0)
- fprintf(stderr, "Warning - write failed\n");
+ fprintf(stderr, "Warning - write addr failed\n");
 }
 res = i2c_smbus_read_byte(file);
 break;
@@ -253,7 +269,13 @@
 exit(2);
 }

- printf("0x%0*x\n", size == I2C_SMBUS_WORD_DATA ? 4 : 2, res);
-
+ switch(size){
+ case I2C_RAW:
+ printf("0x%04x = %02hhx\n", daddress, buffer[0]);
+ break;
+ default:
+ printf("0x%0*x\n", size == I2C_SMBUS_WORD_DATA ? 4 : 2, res);
+ }
+ 
 exit(0);
 }
Index: tools/i2cset.c
===================================================================
--- tools/i2cset.c (revision 6127)
+++ tools/i2cset.c (working copy)
@@ -35,6 +35,8 @@

 static void help(void) __attribute__ ((noreturn));

+#define I2C_RAW -1
+
 static void help(void)
 {
 fprintf(stderr,
@@ -42,6 +44,7 @@
 " I2CBUS is an integer or an I2C bus name\n"
 " ADDRESS is an integer (0x03 - 0x77)\n"
 " MODE is one of:\n"
+ " r (write byte using raw i2c device)\n"
 " c (byte, no value)\n"
 " b (byte data, default)\n"
 " w (word data)\n"
@@ -63,6 +66,13 @@
 }

 switch (size) {
+ case I2C_RAW:
+ //If raw i2c is specified, use that instead of SMBus
+ if (!(funcs & I2C_FUNC_I2C)){
+ fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");
+ return -1;
+ }
+ break;
 case I2C_SMBUS_BYTE:
 if (!(funcs & I2C_FUNC_SMBUS_WRITE_BYTE)) {
 fprintf(stderr, MISSING_FUNC_FMT, "SMBus send byte");
@@ -140,7 +150,7 @@
 } else
 fprintf(stderr, "data 0x%02x%s, mode %s.\n", value,
 vmask ? " (masked)" : "",
- size == I2C_SMBUS_BYTE_DATA ? "byte" : "word");
+ (size == I2C_SMBUS_BYTE_DATA || size == I2C_RAW) ? "byte" : "word");
 if (pec)
 fprintf(stderr, "PEC checking enabled.\n");

@@ -235,6 +245,7 @@
 case 'w': size = I2C_SMBUS_WORD_DATA; break;
 case 's': size = I2C_SMBUS_BLOCK_DATA; break;
 case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
+ case 'r': size = I2C_RAW; break;
 default:
 fprintf(stderr, "Error: Invalid mode '%s'!\n", argv[argc-1]);
 help();
@@ -263,6 +274,7 @@

 /* read values from command line */
 switch (size) {
+ case I2C_RAW:
 case I2C_SMBUS_BYTE_DATA:
 case I2C_SMBUS_WORD_DATA:
 value = strtol(argv[flags+4], &end, 0);
@@ -303,7 +315,7 @@
 fprintf(stderr, "Error: Data value mask invalid!\n");
 help();
 }
- if (((size == I2C_SMBUS_BYTE || size == I2C_SMBUS_BYTE_DATA)
+ if (((size == I2C_SMBUS_BYTE || size == I2C_SMBUS_BYTE_DATA || size == I2C_RAW)
 && vmask > 0xff) || vmask > 0xffff) {
 fprintf(stderr, "Error: Data value mask out of range!\n");
 help();
@@ -320,10 +332,15 @@
 value, vmask, block, len, pec))
 exit(0);

+ //Get the old value
 if (vmask) {
 int oldvalue;

 switch (size) {
+ case I2C_RAW:
+ res = i2c_read_raw(file,block,daddress,1);
+ oldvalue = (unsigned int)block[0];
+ break;
 case I2C_SMBUS_BYTE:
 oldvalue = i2c_smbus_read_byte(file);
 break;
@@ -366,7 +383,12 @@
 exit(1);
 }

+ //Do the write
 switch (size) {
+ case I2C_RAW:
+ block[0] = value;
+ res = i2c_write_raw(file,block,daddress,1);
+ break;
 case I2C_SMBUS_BYTE:
 res = i2c_smbus_write_byte(file, daddress);
 break;
@@ -403,7 +425,11 @@
 exit(0);
 }

+ //Verify the write
 switch (size) {
+ case I2C_RAW:
+ i2c_read_raw(file,block,daddress,1);
+ res = (unsigned int)block[0];
 case I2C_SMBUS_BYTE:
 res = i2c_smbus_read_byte(file);
 value = daddress;

--========GMXBoundary164071364908070625525
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D'font-family:Verdana'><span style=3D'font-size:12px'>Hi,<br /=
><br />I notice that the lm-sensors i2c-tools don't support 'raw' I2C devic=
e file access, instead they rely on the driver supporting the smbus interfa=
ce.&nbsp; I am working on an embedded system that does not have smbus, so I=
 created a some patches for lm-sensors tools that add a 'r' access method. =
&nbsp; The changes support i2c-get, i2c-put and i2c-dump.<br /><br />These =
changes allow the i2c-tools to be used without smbus support in the kernel =
device driver for the I2C inteface.<br /><br />Would the developers be inte=
rested in adding my patch to the distribution?<br /><br />diff from r6127<b=
r /><br />regards,<br />Jason<br /><br />----<br />Index: tools/i2cbusses.c=
<br />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />--- tools/i2=
cbusses.c&nbsp;&nbsp;&nbsp; (revision 6127)<br />+++ tools/i2cbusses.c&nbsp=
;&nbsp;&nbsp; (working copy)<br />@@ -415,3 +415,50 @@<br />&nbsp;<br />&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br />&nbsp;}<br />+<br />+int i2c_read_raw_=
again(int file, unsigned char *buffer, unsigned int count)<br />+{<br />+&n=
bsp;&nbsp;&nbsp; unsigned char *ptr =3D buffer;<br />+&nbsp;&nbsp;&nbsp; in=
t res=3D0;<br />+<br />+&nbsp;&nbsp;&nbsp; res =3D read(file, ptr, count);<=
br />+&nbsp;&nbsp;&nbsp; if(res&lt;0)fprintf(stderr, "Aborting - read data =
failed (%d) : %s\n",errno,strerror(errno));<br />+<br />+&nbsp;&nbsp;&nbsp;=
 return res;<br />+}<br />+<br />+int i2c_read_raw(int file, unsigned char =
*buffer, int daddress, unsigned int count)<br />+{<br />+&nbsp;&nbsp;&nbsp;=
 int res;<br />+&nbsp;&nbsp;&nbsp; buffer[0] =3D (unsigned char)(daddress&g=
t;&gt;8);<br />+&nbsp;&nbsp;&nbsp; buffer[1] =3D (unsigned char)daddress &a=
mp; 0xFF;<br />+<br />+&nbsp;&nbsp;&nbsp; res =3D write(file, buffer, 2);<b=
r />+&nbsp;&nbsp;&nbsp; if (res &lt; 0)fprintf(stderr, "Warning - write add=
r failed %d : %s\n",errno,strerror(errno));<br />+&nbsp;&nbsp;&nbsp;<br />+=
&nbsp;&nbsp;&nbsp; return i2c_read_raw_again(file,buffer,count);<br />+}<br=
 />+<br />+int i2c_write_raw(int file, unsigned char *buffer, int daddress,=
 unsigned int count)<br />+{<br />+&nbsp;&nbsp;&nbsp; unsigned char *ptr;<b=
r />+&nbsp;&nbsp;&nbsp; int res;<br />+&nbsp;&nbsp;&nbsp; unsigned int n;<b=
r />+&nbsp;&nbsp;&nbsp;<br />+&nbsp;&nbsp;&nbsp; ptr =3D malloc(count+10);<=
br />+&nbsp;&nbsp;&nbsp; if(ptr=3D=3DNULL)<br />+&nbsp;&nbsp;&nbsp; {<br />=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Memory allocation e=
rror\n");<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br />+&nbs=
p;&nbsp;&nbsp; }<br />+&nbsp;&nbsp;&nbsp; ptr[0] =3D (unsigned char)(daddre=
ss&gt;&gt;8);<br />+&nbsp;&nbsp;&nbsp; ptr[1] =3D (unsigned char)daddress &=
amp; 0xFF;<br />+&nbsp;&nbsp;&nbsp; memcpy(ptr+2,buffer,count);<br />+&nbsp=
;&nbsp;&nbsp; for(n=3D0;n&lt;count+2;n++)fprintf(stderr,"%hhx ",*(ptr+n));<=
br />+&nbsp;&nbsp;&nbsp; fprintf(stderr,"\n");<br />+&nbsp;&nbsp;&nbsp; res=
 =3D write(file,ptr,count+2);<br />+&nbsp;&nbsp;&nbsp; if(res&lt;0)fprintf(=
stderr, "Warning: write data failed (%d) : %s\n",errno,strerror(errno));<br=
 />+&nbsp;&nbsp;&nbsp;<br />+&nbsp;&nbsp;&nbsp; free(ptr);<br />+&nbsp;&nbs=
p;&nbsp; return res;<br />+}<br />Index: tools/i2cbusses.h<br />=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />--- tools/i2cbusses.h&nbsp;=
&nbsp;&nbsp; (revision 6127)<br />+++ tools/i2cbusses.h&nbsp;&nbsp;&nbsp; (=
working copy)<br />@@ -38,7 +38,9 @@<br />&nbsp;int parse_i2c_address(const=
 char *address_arg);<br />&nbsp;int open_i2c_dev(int i2cbus, char *filename=
, size_t size, int quiet);<br />&nbsp;int set_slave_addr(int file, int addr=
ess, int force);<br />-<br />+int i2c_read_raw(int file, unsigned char *buf=
fer, int daddress, unsigned int count);<br />+int i2c_write_raw(int file, u=
nsigned char *buffer, int daddress, unsigned int count);<br />+int i2c_read=
_raw_again(int file, unsigned char *buffer, unsigned int count);<br />&nbsp=
;#define MISSING_FUNC_FMT&nbsp;&nbsp;&nbsp; "Error: Adapter does not have %=
s capability\n"<br />&nbsp;<br />&nbsp;#endif<br />Index: tools/i2cdump.c<b=
r />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />--- tools/i2=
cdump.c&nbsp;&nbsp;&nbsp; (revision 6127)<br />+++ tools/i2cdump.c&nbsp;&nb=
sp;&nbsp; (working copy)<br />@@ -33,6 +33,9 @@<br />&nbsp;#include "util.h=
"<br />&nbsp;#include "../version.h"<br />&nbsp;<br />+<br />+#define I2C_R=
AW -1<br />+<br />&nbsp;static void help(void)<br />&nbsp;{<br />&nbsp;&nbs=
p;&nbsp;&nbsp; fprintf(stderr,<br />@@ -46,6 +49,7 @@<br />&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; s (SMBus block)\n"<br />&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; i (I2C block)\=
n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; c (=
consecutive byte)\n"<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nb=
sp;&nbsp; r (i2c raw device)"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; "&nbsp;&nbsp;&nbsp; Append p for SMBus PEC\n");<br />&nbsp;}<br />&nbsp=
;<br />@@ -61,6 +65,14 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;<br />=
&nbsp;&nbsp;&nbsp;&nbsp; switch(size) {<br />+&nbsp;&nbsp;&nbsp; case I2C_R=
AW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //If raw i2c is specified, =
use that instead of SMBus<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!=
(funcs &amp; I2C_FUNC_I2C)){<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; fprintf(stderr, MISSING_FUNC_FMT, "Raw I2C");<br />+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br />+&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; break;<br />+&nbsp;&nbsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SM=
BUS_BYTE:<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!(funcs &amp=
; I2C_FUNC_SMBUS_READ_BYTE)) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive by=
te");<br />@@ -184,8 +196,10 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; } else if (!s=
trncmp(argv[flags+3], "c", 1)) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; size =3D I2C_SMBUS_BYTE;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; pec =3D argv[flags+3][1] =3D=3D 'p';<br />-&nbsp;&nbsp;&nbsp; } else =
if (!strcmp(argv[flags+3], "i"))<br />+&nbsp;&nbsp;&nbsp; } else if (!strcm=
p(argv[flags+3], "i")) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; s=
ize =3D I2C_SMBUS_I2C_BLOCK_DATA;<br />+&nbsp;&nbsp;&nbsp; } else if (!strc=
mp(argv[flags+3], "r"))<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size =
=3D I2C_RAW;<br />&nbsp;&nbsp;&nbsp;&nbsp; else {<br />&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Error: Invalid mode!\n");<br />&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; help();<br />@@ -248,6 +262,7 @@<b=
r />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Check mode c=
onstraints */<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch (size=
) {<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case I2C_RAW:<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE:<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE_DATA:<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />@@ -285,6 +30=
0,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
size =3D=3D I2C_SMBUS_BLOCK_DATA ? "smbus block" :<br />&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size =3D=3D I2C_SMBUS_I2C_BLOCK=
_DATA ? "i2c block" :<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; size =3D=3D I2C_SMBUS_BYTE ? "byte consecutive read" :<br />=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size =3D=3D I2C_R=
AW ? "raw I2C consecutive read" :<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; size =3D=3D I2C_SMBUS_BYTE_DATA ? "byte" : "word=
");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (pec)<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "PEC=
 checking enabled.\n");<br />@@ -292,7 +308,9 @@<br />&nbsp;&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Only probing eve=
n register "<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; "addresses.\n");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; if (bank) {<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; if (size =3D=3D I2C_SMBUS_BLOCK_DATA)<br />+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (size =3D=3D I2C_RAW)<br />+&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; f=
printf(stderr, "With bank offset 0x%04x\n",(bank*256));<br />+&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else if (size =3D=3D I2C_SMBUS_=
BLOCK_DATA)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Using command 0x%02x.\n",<br />&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; bank);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; else<br />@@ -314,7 +332,7 @@<br />&nbsp;&nbsp;&nbsp=
;&nbsp; }<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; /* See Winbond w83781d =
data sheet for bank details */<br />-&nbsp;&nbsp;&nbsp; if (bank &amp;&amp;=
 size !=3D I2C_SMBUS_BLOCK_DATA) {<br />+&nbsp;&nbsp;&nbsp; if (bank &amp;&=
amp; size !=3D I2C_SMBUS_BLOCK_DATA &amp;&amp; size !=3D I2C_RAW) {<br />&n=
bsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbus_read_byte_data(=
file, bankreg);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (res &g=
t;=3D 0) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; old_bank =3D res;<br />@@ -331,7 +349,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp=
; if (size !=3D I2C_SMBUS_WORD_DATA || even) {<br />&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; /* do the block transaction */<br />&nbsp;&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; if (size =3D=3D I2C_SMBUS_BLOCK_DATA<br />-&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;|| size =3D=3D I2C_SMBUS_I2C_BLOCK_DA=
TA) {<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;|| size =3D=3D I2C_=
SMBUS_I2C_BLOCK_DATA || size =3D=3D I2C_RAW) {<br />&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unsigned char cblock[288];<br />&nb=
sp;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if =
(size =3D=3D I2C_SMBUS_BLOCK_DATA) {<br />@@ -340,6 +358,9 @@<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /=
* Remember returned block length for a nicer<br />&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; displ=
ay later */<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; s_length =3D res;<br />+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; } else if(size =3D=3D I2C_RAW) {<br />+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =
=3D i2c_read_raw(file, cblock, (bank*256), 256);<br />+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; s_length =3D res;<b=
r />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else {=
<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; for (res =3D 0; res &lt; 256; res +=3D i) {<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; i =3D i2c_smbus_read_i2c_block_data(file,<br />@@ -359,7 +380,=
7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; res =3D 256;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res; i++)<br />&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; block[i] =
=3D cblock[i];<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; if (size !=3D I2C_SMBUS_BLOCK_DATA)<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; if (size !=3D I2C_SMBUS_BLOCK_DATA &amp;&amp; si=
ze !=3D I2C_RAW)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; for (i =3D res; i &lt; 256; i++)<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; block[i] =3D -1;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; }<br />@@ -372,12 +393,14 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit(1);<br />&nbsp;&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; }<br />-<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("&nbsp;&nbsp;=
&nbsp;&nbsp; 0&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5&nbsp; 6&nbsp; 7&nbsp=
; 8&nbsp; 9&nbsp; a&nbsp; b&nbsp; c&nbsp; d&nbsp; e&nbsp; f"<br />&nbsp;&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "&n=
bsp;&nbsp;&nbsp; 0123456789abcdef\n");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; for (i =3D 0; i &lt; 256; i+=3D16) {<br />&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (size =3D=3D I2C_SMBUS_BLOCK_=
DATA &amp;&amp; i &gt;=3D s_length)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />+&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (size =3D=3D I2C_RAW &amp;&am=
p; i &gt;=3D s_length)<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; if (i/16 &lt; first/16)<br />&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;=
<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (i/=
16 &gt; last/16)<br />@@ -400,8 +423,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bl=
ock[i+j] =3D res =3D<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; i2c_smbus_read_b=
yte_data(file, i+j);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else if (size =3D=3D I2C_SMBUS_WORD_DATA=
) {<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbus_read_word_data(file,<br />-=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i+j);<br />+&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =
=3D i2c_smbus_read_word_data(file, i+j);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if =
(res &lt; 0) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; block[i+j]=
 =3D res;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; block[i+j+1] =
=3D res;<br />@@ -415,7 +437,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else<br />&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; res =3D block[i+j];<br />&nbsp;<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (size =3D=3D I2C_SMBUS_B=
LOCK_DATA<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; if ((size =3D=3D I2C_SMBUS_BLOCK_DATA || size =3D=3D I2C_R=
AW)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;&amp;&amp; i+j &gt;=3D s_length) {<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; printf("&nbsp;&nbsp; ");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else if (res &lt; 0) {<=
br />@@ -433,7 +455,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; printf("&nbsp;&nbsp; ");<br />&nbsp;<br />&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; 16; j+=
+) {<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; if (size =3D=3D I2C_SMBUS_BLOCK_DATA<br />+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ((size =3D=3D I2=
C_SMBUS_BLOCK_DATA || size =3D=3D I2C_RAW)<br />&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&amp;&amp; i+j=
 &gt;=3D s_length)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Ski=
p unwanted registers */<br />@@ -483,7 +505,7 @@<br />&nbsp;&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("\n");<br />&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp;&nbsp; }<br />-&nbsp=
;&nbsp;&nbsp; if (bank &amp;&amp; size !=3D I2C_SMBUS_BLOCK_DATA) {<br />+&=
nbsp;&nbsp;&nbsp; if (bank &amp;&amp; size !=3D I2C_SMBUS_BLOCK_DATA &amp;&=
amp; size !=3D I2C_RAW) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
i2c_smbus_write_byte_data(file, bankreg, old_bank);<br />&nbsp;&nbsp;&nbsp;=
&nbsp; }<br />&nbsp;&nbsp;&nbsp;&nbsp; exit(0);<br />Index: tools/i2cget.c<=
br />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />--- tools/i2=
cget.c&nbsp;&nbsp;&nbsp; (revision 6127)<br />+++ tools/i2cget.c&nbsp;&nbsp=
;&nbsp; (working copy)<br />@@ -38,6 +38,8 @@<br />&nbsp;<br />&nbsp;static=
 void help(void) __attribute__ ((noreturn));<br />&nbsp;<br />+#define I2C_=
RAW -1<br />+<br />&nbsp;static void help(void)<br />&nbsp;{<br />&nbsp;&nb=
sp;&nbsp;&nbsp; fprintf(stderr,<br />@@ -45,6 +47,7 @@<br />&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp; I2CBUS is an integer or an I2C bus nam=
e\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp; ADDRESS is an=
 integer (0x03 - 0x77)\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
"&nbsp; MODE is one of:\n"<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nb=
sp;&nbsp;&nbsp; r (read byte using raw i2c device)\n"<br />&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; b (read byte data, default)=
\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; w =
(read word data)\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp=
;&nbsp;&nbsp; c (write byte/read byte)\n"<br />@@ -52,6 +55,7 @@<br />&nbsp=
;&nbsp;&nbsp;&nbsp; exit(1);<br />&nbsp;}<br />&nbsp;<br />+<br />&nbsp;sta=
tic int check_funcs(int file, int size, int daddress, int pec)<br />&nbsp;{=
<br />&nbsp;&nbsp;&nbsp;&nbsp; unsigned long funcs;<br />@@ -62,8 +66,15 @@=
<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "funct=
ionality matrix: %s\n", strerror(errno));<br />&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; return -1;<br />&nbsp;&nbsp;&nbsp;&nbsp; }<br />-<br />+&nb=
sp;&nbsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (size) {<br />+&nbsp;&=
nbsp;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //If =
raw i2c is specified, use that instead of SMBus<br />+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; if (!(funcs &amp; I2C_FUNC_I2C)){<br />+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, MISSING_FUNC_FMT, "R=
aw I2C");<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; re=
turn -1;<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />+&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS=
_BYTE:<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!(funcs &amp; I=
2C_FUNC_SMBUS_READ_BYTE)) {<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; fprintf(stderr, MISSING_FUNC_FMT, "SMBus receive byte"=
);<br />@@ -135,8 +146,8 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, "=
, using %s.\n",<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size =3D=
=3D I2C_SMBUS_BYTE ? (daddress &lt; 0 ?<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; "read byte" : "write byte/read byte") :<br />-&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; size =3D=3D I2C_SMBUS_BYTE_DATA ? "read byte data" :=
<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "read word data");<br />+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (size =3D=3D I2C_SMBUS_BYTE_DATA || size =
=3D=3D I2C_RAW) ?<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "read byte da=
ta" : "read word data");<br />&nbsp;&nbsp;&nbsp;&nbsp; if (pec)<br />&nbsp;=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "PEC checking enabled=
.\n");<br />&nbsp;<br />@@ -159,6 +170,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; i=
nt pec =3D 0;<br />&nbsp;&nbsp;&nbsp;&nbsp; int flags =3D 0;<br />&nbsp;&nb=
sp;&nbsp;&nbsp; int force =3D 0, yes =3D 0, version =3D 0;<br />+&nbsp;&nbs=
p;&nbsp; unsigned char buffer[10];<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp=
; /* handle (optional) flags first */<br />&nbsp;&nbsp;&nbsp;&nbsp; while (=
1+flags &lt; argc &amp;&amp; argv[1+flags][0] =3D=3D '-') {<br />@@ -208,6 =
+220,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 'b': size =
=3D I2C_SMBUS_BYTE_DATA; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; case 'w': size =3D I2C_SMBUS_WORD_DATA; break;<br />&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; case 'c': size =3D I2C_SMBUS_BYTE; break;<br />+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 'r': size =3D I2C_RAW; break;<br=
 />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; default:<br />&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Error: In=
valid mode!\n");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; help();<br />@@ -232,11 +245,14 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; =
}<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (size) {<br />+&nbsp;&nb=
sp;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D=
 i2c_read_raw(file,buffer,daddress,1);<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE:<br />&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (daddress &gt;=3D 0) {<br />&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbu=
s_write_byte(file, daddress);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; if (res &lt; 0)<br />-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Warning - wr=
ite failed\n");<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Warning - write addr failed\n");<br=
 />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbus_read_byte(file);<br />&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />@@ -253,7 +269,13 @@<br />&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit(2);<br />&nbsp;&nbsp;&nbsp;&nbs=
p; }<br />&nbsp;<br />-&nbsp;&nbsp;&nbsp; printf("0x%0*x\n", size =3D=3D I2=
C_SMBUS_WORD_DATA ? 4 : 2, res);<br />-<br />+&nbsp;&nbsp;&nbsp; switch(siz=
e){<br />+&nbsp;&nbsp;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; printf("0x%04x =3D %02hhx\n", daddress, buffer[0]);<br />+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />+&nbsp;&nbsp;&nbsp; default:<b=
r />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("0x%0*x\n", size =3D=3D I=
2C_SMBUS_WORD_DATA ? 4 : 2, res);<br />+&nbsp;&nbsp;&nbsp; }<br />+&nbsp;&n=
bsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; exit(0);<br />&nbsp;}<br />Index: =
tools/i2cset.c<br />=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
 />--- tools/i2cset.c&nbsp;&nbsp;&nbsp; (revision 6127)<br />+++ tools/i2cs=
et.c&nbsp;&nbsp;&nbsp; (working copy)<br />@@ -35,6 +35,8 @@<br />&nbsp;<br=
 />&nbsp;static void help(void) __attribute__ ((noreturn));<br />&nbsp;<br =
/>+#define I2C_RAW -1<br />+<br />&nbsp;static void help(void)<br />&nbsp;{=
<br />&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr,<br />@@ -42,6 +44,7 @@<br />=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp; I2CBUS is an integer or=
 an I2C bus name\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp=
; ADDRESS is an integer (0x03 - 0x77)\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; "&nbsp; MODE is one of:\n"<br />+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; "&nbsp;&nbsp;&nbsp; r (write byte using raw i2c device)\n"<br />=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&nbsp; c (byte, no=
 value)\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "&nbsp;&nbsp;&n=
bsp; b (byte data, default)\n"<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; "&nbsp;&nbsp;&nbsp; w (word data)\n"<br />@@ -63,6 +66,13 @@<br />&nbs=
p;&nbsp;&nbsp;&nbsp; }<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (si=
ze) {<br />+&nbsp;&nbsp;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; //If raw i2c is specified, use that instead of SMBus<br />+&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!(funcs &amp; I2C_FUNC_I2C)){<br />=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, M=
ISSING_FUNC_FMT, "Raw I2C");<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; return -1;<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<b=
r />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />&nbsp;&nbsp;&nbsp;&n=
bsp; case I2C_SMBUS_BYTE:<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
if (!(funcs &amp; I2C_FUNC_SMBUS_WRITE_BYTE)) {<br />&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, MISSING_FUNC_FMT, =
"SMBus send byte");<br />@@ -140,7 +150,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; =
} else<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "da=
ta 0x%02x%s, mode %s.\n", value,<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; vmask ? " (masked)" : "",<br />-&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size =3D=3D I2C_SMBUS_BYTE_DATA ? "=
byte" : "word");<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; (size =3D=3D I2C_SMBUS_BYTE_DATA || size =3D=3D I2C_RAW) ? "byte" : "w=
ord");<br />&nbsp;&nbsp;&nbsp;&nbsp; if (pec)<br />&nbsp;&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; fprintf(stderr, "PEC checking enabled.\n");<br />&nbsp;=
<br />@@ -235,6 +245,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
case 'w': size =3D I2C_SMBUS_WORD_DATA; break;<br />&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; case 's': size =3D I2C_SMBUS_BLOCK_DATA; break;<br />&=
nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 'i': size =3D I2C_SMBUS_I2C=
_BLOCK_DATA; break;<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 'r': s=
ize =3D I2C_RAW; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; de=
fault:<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
fprintf(stderr, "Error: Invalid mode '%s'!\n", argv[argc-1]);<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; help();<br />@@ -263=
,6 +274,7 @@<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; /* read values from =
command line */<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (size) {<br />+&nbsp;&=
nbsp;&nbsp; case I2C_RAW:<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE=
_DATA:<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS_WORD_DATA:<br />&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; value =3D strtol(argv[flags+4], &amp;e=
nd, 0);<br />@@ -303,7 +315,7 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Error: Data value mask invalid!\=
n");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; he=
lp();<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br />-&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; if (((size =3D=3D I2C_SMBUS_BYTE || size =3D=3D I=
2C_SMBUS_BYTE_DATA)<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (((size =
=3D=3D I2C_SMBUS_BYTE || size =3D=3D I2C_SMBUS_BYTE_DATA || size =3D=3D I2C=
_RAW)<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp; &amp;&amp; vmask &gt; 0xff) || vmask &gt; 0xffff) {<br />&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stderr, "Error: D=
ata value mask out of range!\n");<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; help();<br />@@ -320,10 +332,15 @@<br />&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp; value, vmask, block, len, pec))<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; exit(0);<br />&nbsp;<br />+&nbsp;&nbsp;&nbsp; //Get the old valu=
e<br />&nbsp;&nbsp;&nbsp;&nbsp; if (vmask) {<br />&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; int oldvalue;<br />&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; switch (size) {<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; res =3D i2c_read_raw(file,block,daddress,1);<br />+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; oldvalue =3D (unsigned int)block[0];=
<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />&nbsp;&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE:<br />&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; oldvalue =3D i2c_smbus_read_byte(fi=
le);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; br=
eak;<br />@@ -366,7 +383,12 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; exit(1);<br />&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;<br />+&nbsp;&nbsp=
;&nbsp; //Do the write<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (size) {<br />+=
&nbsp;&nbsp;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; block[0] =3D value;<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i=
2c_write_raw(file,block,daddress,1);<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; break;<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS_BYTE:<br />&nbsp;=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbus_write_byte(file, da=
ddress);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br />@@ -4=
03,7 +425,11 @@<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit(0);<b=
r />&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;<br />+&nbsp;&nbsp;&nbsp; //Verif=
y the write<br />&nbsp;&nbsp;&nbsp;&nbsp; switch (size) {<br />+&nbsp;&nbsp=
;&nbsp; case I2C_RAW:<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i2c_read_=
raw(file,block,daddress,1);<br />+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res=
 =3D (unsigned int)block[0];<br />&nbsp;&nbsp;&nbsp;&nbsp; case I2C_SMBUS_B=
YTE:<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; res =3D i2c_smbus_rea=
d_byte(file);<br />&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; value =3D da=
ddress;<br />=C2=A0</span></span>

--========GMXBoundary164071364908070625525--


--===============8588452095159277838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8588452095159277838==--
