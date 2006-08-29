From: abo_gwapo@yahoo.com (Arnold)
Date: Tue, 29 Aug 2006 01:59:31 +0000
Subject: [lm-sensors] i2c-dev driver
Message-Id: <20060829015931.95433.qmail@web55804.mail.re3.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frodol,

I'm using an omap5912 and would like to write and read
thru i2c.  Below are  the debug msg aswell as the
code. 

Debug msg:
#./i2c_test
(OJ) adapter number = OMAP I2C adapter
i: Remote I/O error
written -1 bytes

Code:

#define I2C_SLAVE     0x0703
#define BUFFER_SIZE   32


int adapter_nr = 0;

int addr = 0x40; /* The I2C address */

sprintf(filename,"/dev/i2c-%d",adapter_nr);
  if ((file = open(filename,O_RDWR)) < 0) {
    printf("Error Opening File\n");
    exit(1);
  }

  if (ioctl(file,I2C_SLAVE,addr) < 0) {
    exit(1);
  }
 
if (write(file,buffer,sizeof(char) * BUFFER_SIZE) < 0)
{
        perror("Error Writing:");
        exit(1);
  }
  printf("written %d bytes\n",i);
  memset(buffer,0,BUFFER_SIZE);

  if(read(file,buffer,sizeof(char) * BUFFER_SIZE) < 0
)     {
        perror("Error Reading:");
        exit(1);
  }
  printf("read %d bytes\n",i);
  for(i=0;i<BUFFER_SIZE;i++)
  {
     printf("%c",buffer[i]);
  }
  printf("\n");

  close(file);

I hope you could help me with my problem? 

Thanks,
OJ


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

