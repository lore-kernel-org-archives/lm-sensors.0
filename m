From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: ...no subject...
Message-Id: <200301261540.h0QFeENU001922@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

WHarms@bfs.de wrote:
> hi frodo,
> i coudnt reach pelican,

True. I have had problems too.

Try sensors@Stimpy.netroedge.com for now (I've cc-ed this).
 
> <linux-i2c@pelican.tk.uni-linz.ac.at>... Deferred: Connection timed out with pelican.tk.uni-linz.ac.at. 
> 
> because you are mentioned as i2c maintainer this is of
> interessed for you also.
> 
> 	walter
> 
> 
> 
> Hi, 
> i was looking into the i2c code and found that some 
> sprintf() statement simply print without any 
> range restictions. 
> I dont thing this is a security problem but an buffer overflow is basicly possible. 
> e.g. 
> /* from i2c-core.c */ 
> if (i2cproc_initialized) { 
> char name[8]; 
> struct proc_dir_entry *proc_entry; 
> 
> -> sprintf(name,"i2c-%d", i); 
> 
> 
> In this example i=1..I2C_ADAP_MAX what is now 16 but 
> sprintf(name,"i2c-%02d", i); is a simple solution that 
> secures agains any accidentle overflow. 
> 
> 
> hope that helps, 
> walter 
> 
> ps: if you like i can send a patch 
> 

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
