From: Crazy Casta <crazycasta@gmail.com>
Date: Wed, 02 Nov 2011 21:24:02 +0000
Subject: [lm-sensors] Fix for ASUS Rampage II GENE
Message-Id: <CABpR-zTSu4OByNwt_4Muv3s6cS3jf2F5BhWmSPLM6AkVpLCKNg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7834538954455283652=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7834538954455283652==
Content-Type: multipart/alternative; boundary=bcaec5015da3425c1104b0c71745

--bcaec5015da3425c1104b0c71745
Content-Type: text/plain; charset=ISO-8859-1

To all who might come across this in the future:

I have an ASUS Rampage II GENE motherboard. Contrary to other postings I
found, the adt7475, i2c-i801 and w83627ehf modules are not sufficient to
get anything out of this motherboard. You almost must compile the
asus_atk0110 module (near the bottom of the compile list in the kernel).
I'm writing this simply so it gets in the archive and google can find it in
case anyone has a similar issue.

P.S. If anyone know what the modules needed for fan control on this
motherboard are I'd sure like to know :)

--bcaec5015da3425c1104b0c71745
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

To all who might come across this in the future:<br><br>I have an ASUS Ramp=
age II GENE motherboard. Contrary to other postings I found, the adt7475, i=
2c-i801 and w83627ehf modules are not sufficient to get anything out of thi=
s motherboard. You almost must compile the asus_atk0110 module (near the bo=
ttom of the compile list in the kernel). I&#39;m writing this simply so it =
gets in the archive and google can find it in case anyone has a similar iss=
ue.<br>
<br>P.S. If anyone know what the modules needed for fan control on this mot=
herboard are I&#39;d sure like to know :)<br>

--bcaec5015da3425c1104b0c71745--


--===============7834538954455283652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7834538954455283652==--
