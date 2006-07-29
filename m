From: nithinkj@hcl.in (Nithin)
Date: Sat, 29 Jul 2006 10:52:19 +0000
Subject: [lm-sensors] Problem with W83792d
Message-Id: <44CB3B13.4020301@hcl.in>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CB36A9.9040502@hcl.in>
In-Reply-To: <44CB36A9.9040502@hcl.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sorry
The chip is NOT showing in /proc/sys/dev/sensors/.

>Hi,
>
>	I m working in "ASUS NCL-DE Board " in RHEL 3.0 UP5,with lmsensors-2.10.0 and i2c-2.10.0
>In this board w83792d is the health monitoring chip.
>But i am not able to get any of the values.The chip is not even detecting using sensors-detect.
>I have inserted modules i2c-i801,i2c-proc,i2c-dev,i2c-core,w83792d.But the chip is showing in
>/proc/sys/dev/sensors/.
>The reply i got from 'Asus' is, it using the slave addres as 0x5e,smbus base addres 0x400.
>But the driver for w83792d searches in 0x2c to 0x2f (static unsigned short normal_i2c_range[] = { 0x2c, 0x2f, SENSORS_I2C_END };)
>
>
>I have tried using dev-interface also.But that is giving incorrect values.
>
>#include <stdio.h>
>#include <stdlib.h>
>#include <sys/types.h>
>#include <sys/stat.h>
>#include <fcntl.h>
>#include <linux/i2c-dev.h>
>                                                                                                 
>main()
>{
>        int fp,res;
>//      int addr = 0x5E;
>        __u8 reg= 0x29;             //0x29  is the CPU fan register                                                                                                 
>        fp = open("/dev/i2c-0",O_RDWR);
>        if(fp = -1) {
>                printf("Error\n");
>                exit(0);
>        }
>        ioctl(fp,I2C_SLAVE,0x5e);  //Slave address 0x5e
>//      read(fp,res,8);  //Not working since it doesn't support i2c level transactions.
>        res = i2c_smbus_read_byte_data(fp,reg);
>                                                                                                 
>        printf("%d\n",res);
>}
>
>
>
>Then i have gone for port programming.
>This is the code i have used 
>
>#include <sys/io.h>
>#include<fcntl.h>
>#include<string.h>
>#include<stdio.h>
>                                                                                                 
>
>cpufan()
>{
>        unsigned char x,y;
>        unsigned char fandiv,fandiv2;
>//      int x;
>        FILE *fp;
>        char s[100];
>                                                                                                 
>        iopl(3);
>        outb(0xFF,0x400);   //Base address is 400
>        outb(0x29,0x403);   //0x29  is the CPU fan register
>        outb(0x5E,0x404);   //Slave addres is 0x5e
>        outb(0x48,0x402);
>        while( (inb(0x400)&0x02)!=0x02);
>        x = inb(0x405);
>                                                                                                 
>        printf("%u\n",x);
>        printf("%u\n",1350000/(x*8));
>}
>main()
>{
>        cpufan();
>}
>
>But this program is going infite while loop;
>
>Could  any one please help me to solve this issue
>
>Thanks
>Nithin
>
>
>
>
>
>
>	
>
>
>
>_______________________________________________
>lm-sensors mailing list
>lm-sensors at lm-sensors.org
>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>  
>



