From: Tony Mozi <spooflinux@hotmail.fr>
Date: Fri, 02 Jul 2010 09:39:49 +0000
Subject: [lm-sensors] Add an ADC with I2C interface on ARM
Message-Id: <SNT129-W61DE5562B64ECD434E5D25B9CE0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6394409677560542047=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6394409677560542047==
Content-Type: multipart/alternative;
	boundary="_9bd5f356-248a-4840-bf1b-b614d35f6bf5_"

--_9bd5f356-248a-4840-bf1b-b614d35f6bf5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all=2C
I try to enable the communication between an ADC (ADS7823) and a board with=
 an ARM chip.

In /dev=2C I have i2c-0=2C... i2c-3. So=2C I suppose that it is not necessa=
ry to add another.
The board has already an internal ADC and I communicate with it without pro=
blem.
When I start my program=2C there is no activity on SCL and SDA.
I use a loop when I write on the I2C bus but I see nothing.
Regarding the electronic part=2C it's ok=2C supply enables.
Have you got ideas?
BR


This is the program :=20


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <i2c-dev.h>
#include <errno.h>


int main(void)=20
{
  int file=3B
  char filename[20]=3B
  int i2caddrslave =3D 0x48=3B             // factory pre-set to 10010=2C A=
1=3DA0=3DGND
                                                // b'1001000'=2C 0x48

  int Read_Addressing_Byte =3D 0x91=3B
  int Write_Addressing_Byte =3D 0x90=3B
  int Command_Byte =3D 0x00=3B
  int DeviceAddress=2Ci2cWrite=3B

  int adapter_nr =3D 0=3B
=20
  sprintf(filename=2C"/dev/i2c-%d"=2Cadapter_nr)=3B
  printf("Device File: %s\n\n"=2Cfilename)=3B

  //**************************************
  //Opening the device =3D> NO Problem
  //**************************************
  if ((file =3D open(filename=2CO_RDWR)) < 0) {=20
            printf("Error Occured while opening Device File!!\n")=3B
            exit(1)=3B
  } else {
                printf("Device File Opened Successfully !!\n")=3B
  }


  //*************************************
  //I2C under control =3D> NO Problem
  //*************************************
  DeviceAddress =3D ioctl(file=2CI2C_SLAVE_FORCE=2Ci2caddrslave)=3B //I2C_S=
LAVE
  if (DeviceAddress < 0) {
        printf("Error Occrued inside IOCTL!! : devadd =3D 0x%x\n\n"=2CDevic=
eAddress)=3B
        printf("error no=3D %d\n\n"=2Cerrno)=3B
        perror("Error Reason: ")=3B
        exit(1)=3B
  } else {
        printf("Device slave address OK : 0x%x\n\n"=2C i2caddrslave)=3B
  }


  //**************************************
  //I2C Write Register=20
  //**************************************

while(1){
 =20
  i2cWrite =3D i2c_smbus_write_byte_data(file=2CWrite_Addressing_Byte=2CCom=
mand_Byte)=3B

  if (i2cWrite < 0) {
            printf("Failed to write 0x%x to device: 0x%x\n"=2CCommand_Byte=
=2CWrite_Addressing_Byte)=3B
          } else {
              printf("Write register OK : write 0x%x to device 0x%x\n"=2CCo=
mmand_Byte=2CWrite_Addressing_Byte)=3B
  }
}

  close(file)=3B
  return 0=3B
}
 		 	   		 =20
_________________________________________________________________
Messenger arrive enfin sur iPhone ! Venez le t=E9l=E9charger gratuitement !
http://www.messengersurvotremobile.com/?d=3DiPhone=

--_9bd5f356-248a-4840-bf1b-b614d35f6bf5_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi all=2C<br>I try to enable the communication between an ADC (ADS7823) and=
 a board with an ARM chip.<br><br>In /dev=2C I have i2c-0=2C... i2c-3. So=
=2C I suppose that it is not necessary to add another.<br>The board has alr=
eady an internal ADC and I communicate with it without problem.<br>When I s=
tart my program=2C there is no activity on SCL and SDA.<br>I use a loop whe=
n I write on the I2C bus but I see nothing.<br>Regarding the electronic par=
t=2C it's ok=2C supply enables.<br>Have you got ideas?<br>BR<br><br><br>Thi=
s is the program : <br><br><br>#include &lt=3Bstdio.h&gt=3B<br>#include &lt=
=3Bstdlib.h&gt=3B<br>#include &lt=3Bsys/types.h&gt=3B<br>#include &lt=3Bsys=
/stat.h&gt=3B<br>#include &lt=3Bfcntl.h&gt=3B<br>#include &lt=3Bunistd.h&gt=
=3B<br><br>#include &lt=3Bi2c-dev.h&gt=3B<br>#include &lt=3Berrno.h&gt=3B<b=
r><br><br>int main(void) <br>{<br>&nbsp=3B int file=3B<br>&nbsp=3B char fil=
ename[20]=3B<br>&nbsp=3B int i2caddrslave =3D 0x48=3B &nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B // factory pre-set to=
 10010=2C A1=3DA0=3DGND<br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B //=
 b'1001000'=2C 0x48<br><br>&nbsp=3B int Read_Addressing_Byte =3D 0x91=3B<br=
>&nbsp=3B int Write_Addressing_Byte =3D 0x90=3B<br>&nbsp=3B int Command_Byt=
e =3D 0x00=3B<br>&nbsp=3B int DeviceAddress=2Ci2cWrite=3B<br><br>&nbsp=3B i=
nt adapter_nr =3D 0=3B<br>&nbsp=3B<br>&nbsp=3B sprintf(filename=2C"/dev/i2c=
-%d"=2Cadapter_nr)=3B<br>&nbsp=3B printf("Device File: %s\n\n"=2Cfilename)=
=3B<br><br>&nbsp=3B //**************************************<br>&nbsp=3B //=
Opening the device =3D&gt=3B NO Problem<br>&nbsp=3B //*********************=
*****************<br>&nbsp=3B if ((file =3D open(filename=2CO_RDWR)) &lt=3B=
 0) { <br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=
=3B&nbsp=3B printf("Error Occured while opening Device File!!\n")=3B<br>&nb=
sp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B exi=
t(1)=3B<br>&nbsp=3B } else {<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B printf("Device File Opened Successfully !!\n")=3B<br>&nbsp=3B }<br><br>=
<br>&nbsp=3B //*************************************<br>&nbsp=3B //I2C unde=
r control =3D&gt=3B NO Problem<br>&nbsp=3B //******************************=
*******<br>&nbsp=3B DeviceAddress =3D ioctl(file=2CI2C_SLAVE_FORCE=2Ci2cadd=
rslave)=3B //I2C_SLAVE<br>&nbsp=3B if (DeviceAddress &lt=3B 0) {<br>&nbsp=
=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B printf("Error Occrued inside I=
OCTL!! : devadd =3D 0x%x\n\n"=2CDeviceAddress)=3B<br>&nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B printf("error no=3D %d\n\n"=2Cerrno)=3B<br>&nb=
sp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B perror("Error Reason: ")=3B<=
br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B exit(1)=3B<br>&nbsp=3B=
 } else {<br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B printf("Devi=
ce slave address OK : 0x%x\n\n"=2C i2caddrslave)=3B<br>&nbsp=3B }<br><br><b=
r>&nbsp=3B //**************************************<br>&nbsp=3B //I2C Write=
 Register <br>&nbsp=3B //**************************************<br><br>whil=
e(1){<br>&nbsp=3B <br>&nbsp=3B i2cWrite =3D i2c_smbus_write_byte_data(file=
=2CWrite_Addressing_Byte=2CCommand_Byte)=3B<br><br>&nbsp=3B if (i2cWrite &l=
t=3B 0) {<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=
=3B&nbsp=3B&nbsp=3B printf("Failed to write 0x%x to device: 0x%x\n"=2CComma=
nd_Byte=2CWrite_Addressing_Byte)=3B<br>&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B &n=
bsp=3B&nbsp=3B&nbsp=3B } else {<br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B &nbsp=
=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B printf("Write register OK : wr=
ite 0x%x to device 0x%x\n"=2CCommand_Byte=2CWrite_Addressing_Byte)=3B<br>&n=
bsp=3B }<br>}<br><br>&nbsp=3B close(file)=3B<br>&nbsp=3B return 0=3B<br>}<b=
r> 		 	   		  <br /><hr />Envie de nouveaut=E9 ? <a href=3D'http://www.wind=
owslive.fr/nouveau-hotmail/' target=3D'_new'>Le nouveau Hotmail arrive bien=
t=F4t ! Pr=E9parez-vous !</a></body>
</html>=

--_9bd5f356-248a-4840-bf1b-b614d35f6bf5_--


--===============6394409677560542047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6394409677560542047==--
