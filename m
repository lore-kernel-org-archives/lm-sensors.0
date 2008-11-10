From: Sergio Gutierrez Verde <513172@unizar.es>
Date: Mon, 10 Nov 2008 18:20:05 +0000
Subject: [lm-sensors] a problem with lm-sensor 2.10.7.
Message-Id: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3641324787460472480=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3641324787460472480==
Content-Type: multipart/alternative;
	boundary="_8fb21c6c-4256-4926-a54e-303bbecab9cb_"

--_8fb21c6c-4256-4926-a54e-303bbecab9cb_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


All=2C

I have a problem using a function of lm-sensors 2.10.7.

In the next extract of code I try to get the CPU TEMP of a certain chip. Bu=
t when  'sensors_get_feature' is called=2C there is a problem=2C a Segmenta=
tion fault.
I also try to use the most part of the code of lm-sensors 2.10.7 (like main=
.c=2C chips.c and so on)=2C but the problem persists.
The chip and the sensors are the right.

Could anyone find the wrong in my code?

Regards=2C
Sergio

CODE:

void init_temp (){


   FILE *config_file=3B

        sensors_cleanup()=3B
        config_file =3D fopen("/etc/sensors.conf"=2C "r")=3B
        if (config_file =3D=3DNULL){
                fprintf(stderr=2C "FAIL! reading file\n")=3B
                exit(1)=3B
        }
        else{
                if (sensors_init(config_file)!=3D0) {
                        fprintf(stderr=2C"FAIL!! sensor not init\n")=3B
                        exit(1)=3B
                }
                else{
                        fprintf(stderr=2C"OK\n")=3B
                        fclose(config_file)=3B
                }
        }
}
double read_temp (){

    sensors_chip_name chip_name=3B

        fprintf(stderr=2C"Reading temperature\n")=3B

        if(sensors_parse_chip_name("w83627thf-isa-0290"=2C&chip_name)!=3D0)=
{
                fprintf(stderr=2C "ERROR!!! chip not found\n")=3B
                exit(1)=3B
        }

        return(w83781d (&chip_name))=3B

}

double w83781d(const sensors_chip_name *name)
{

  double cur=3B

  sensors_get_feature(*chip_name=2CSENSORS_W83781D_TEMP2=2C&cur)
  return(cur)=3B
}

void main (){
   double temp=3B
   init_temp()=3B
   temp =3D read_temp()=3B
   fprintf(stderr=2C"Temp: %f\n"=2Ctemp)=3B
}
_________________________________________________________________
 Ahora con Internet Explorer 7=2C ll=E9vate gratis un gui=F1o personalizado
http://www.vivelive.com/ieak7/=

--_8fb21c6c-4256-4926-a54e-303bbecab9cb_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
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
</style>
</head>
<body class=3D'hmmessage'>
All=2C<br><br>I have a problem using a function of lm-sensors 2.10.7.<br><b=
r>In the next extract of code I try to get the CPU TEMP of a certain chip. =
But when&nbsp=3B 'sensors_get_feature' is called=2C there is a problem=2C a=
 Segmentation fault.<br>I also try to use the most part of the code of lm-s=
ensors 2.10.7 (like main.c=2C chips.c and so on)=2C but the problem persist=
s.<br>The chip and the sensors are the right.<br><br>Could anyone find the =
wrong in my code?<br><br>Regards=2C<br>Sergio<br><br>CODE:<br><br>void init=
_temp (){<br><br><br>&nbsp=3B&nbsp=3B FILE *config_file=3B<br><br>&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B sensors_cleanup()=3B<br>&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B config_file =3D fopen=
("/etc/sensors.conf"=2C "r")=3B<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B if (config_file =3D=3DNULL){<br>&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B fprintf(stderr=2C "FAIL! reading file\n")=3B<br>&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B exit(1)=3B<br>&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B }<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B else{<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B if (sensors_init(config_file)!=3D0) {<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B fprintf(stderr=2C"FAIL!! sensor not init\n")=3B<br>&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B exit(1)=3B<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B }<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B else{<br>&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B fprintf(stderr=2C"OK\n")=3B<br>&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B fclose(config_file)=3B<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B }<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 }<br>}<br>double read_temp (){<br><br>&nbsp=3B&nbsp=3B&nbsp=3B sensors_chi=
p_name chip_name=3B<br><br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B fprintf(stderr=2C"Reading temperature\n")=3B<br><br>&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B if(sensors_parse_chip_name("w83=
627thf-isa-0290"=2C&amp=3Bchip_name)!=3D0){<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B fprintf(stderr=2C "ERROR!!! chip not found\n")=3B<br>&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B exit(1)=3B<br>&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B }<br><br>&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B&nbsp=3B&nbsp=3B return(w83781d (&amp=3Bchip_name))=3B<br><br=
>}<br><br>double w83781d(const sensors_chip_name *name)<br>{<br><br>&nbsp=
=3B double cur=3B<br><br>&nbsp=3B sensors_get_feature(*chip_name=2CSENSORS_=
W83781D_TEMP2=2C&amp=3Bcur)<br>&nbsp=3B return(cur)=3B<br>}<br><br>void mai=
n (){<br>&nbsp=3B&nbsp=3B double temp=3B<br>&nbsp=3B&nbsp=3B init_temp()=3B=
<br>&nbsp=3B&nbsp=3B temp =3D read_temp()=3B<br>&nbsp=3B&nbsp=3B fprintf(st=
derr=2C"Temp: %f\n"=2Ctemp)=3B<br>}<br /><hr />Descubre durante 3 meses gra=
tis la protecci=F3n total de <a href=3D'http://www.vivelive.com/onecare/' t=
arget=3D'_new'>One Care</a></body>
</html>=

--_8fb21c6c-4256-4926-a54e-303bbecab9cb_--


--===============3641324787460472480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3641324787460472480==--
