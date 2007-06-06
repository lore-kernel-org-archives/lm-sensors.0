From: "Patrick Connolly" <Patrick.Connolly@watchguard.com>
Date: Wed, 06 Jun 2007 16:39:52 +0000
Subject: [lm-sensors] SMBus busy in 82801
Message-Id: <83016ef2d6c5b96b0c5c7e258f1a7f40d71edc69@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1754331083894410990=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============1754331083894410990==
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A859.4F482961"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A859.4F482961
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We cannot get the lm-sensors user-space adapter to work on our embedded
system.  Problem seems to be localized to the Intel 82801 Southbridge.
=20
SHORT DESCRIPTION
We are trying to read an eeprom located on the SMBus ( using
i2c_smbus_read_byte_data() ).  Debug messages from the driver show that
the SMBus is busy (or not ready to Transmit).  However there is other
debug output just before the busy-check which shows some important host
registers to have all FF's in them; this seems to be abnormal.  We have
not used "sensors-detect"; it is a perlscript and getting perl onto our
embedded system would be quite ungainly. =20
=20
Any help would be appreciated.  Details, souce code, and kernel config
are below.
Thanks,
Patrick
=20
DETAILS:
=20
The fail occurs at the beginning of the following file/function:
           drivers/i2c/busses/i2c-i801.c:i801_transaction()
    Debug information shows that all five registers have FF in them and
that the SMBus is busy:
i801_smbus : Transaction (pre): CNT=3Dff, CMD=3Dff, ADD=3Dff, DAT0=3Dff, =
DAT1=3Dff
i801_smbus : SMBus busy (1f). Resetting...
i801_smbus : Failed! (1f)
=20

SOURCE CODE:
   drivers/i2c/busses/i2c-i801.c:i801_transaction() ( lines 183-206 )
=20
static int i801_transaction(void)
{
        int temp;
        int result =3D 0;
        int timeout =3D 0;
=20
        dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=3D%02x, =
CMD=3D%02x,
"
                "ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", =
inb_p(SMBHSTCNT),
                inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
                inb_p(SMBHSTDAT1));
=20
        /* Make sure the SMBus host is ready to start transmitting */
        /* 0x1f =3D Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
        if ((temp =3D (0x1f & inb_p(SMBHSTSTS))) !=3D 0x00) {
                dev_dbg(&I801_dev->dev, "SMBus busy (%02x).
Resetting...\n",
                        temp);
                outb_p(temp, SMBHSTSTS);
                if ((temp =3D (0x1f & inb_p(SMBHSTSTS))) !=3D 0x00) {
                        dev_dbg(&I801_dev->dev, "Failed! (%02x)\n",
temp);
                        return -1;
                } else {
                        dev_dbg(&I801_dev->dev, "Successfull!\n");
                }
        }
=20
   ...
=20
KERNEL CONFIGURATION   (using 2.6.14.1)
   Since we need to reduce the size of the kernel, we've tried to
eliminate any unnecessary drivers. We've followed the 2.6 Kernel
Configuration instructions at:
      http://www.lm-sensors.org/wiki/Kernel2.6
<http://www.lm-sensors.org/wiki/Kernel2.6>=20
   ...with the following exceptions:
  * Under I2C_support>I2C_Algorithms : all 3 drivers are configured as
built-in instead of modules
  * Under I2C_support>I2C_Hardware_Bus_Support : Intel 82801 is
configured as "built-in" and the remaining 20 drivers are excluded
  * Under I2C_support>Misc_I2C_Chip_support : EEPROM reader and the 3
Phillips drivers are included; remaining 4 drivers are excluded.
  * Under Hardware Monitoring support:  "Hardware Monitoring Support" is
included as a module but all 27 drivers under it are excluded


------_=_NextPart_001_01C7A859.4F482961
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3086" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>We cannot get the lm-sensors user-space =
adapter to=20
work on our embedded system.&nbsp; Problem seems to be localized to the =
Intel=20
82801 Southbridge.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>SHORT DESCRIPTION<BR>We are trying to =
read an=20
eeprom located on the SMBus ( using i2c_smbus_read_byte_data() ).&nbsp; =
Debug=20
messages from the driver show that the SMBus is busy (or not ready to=20
Transmit).&nbsp; However there is other debug output just before the =
busy-check=20
which shows some important host registers to have all FF's in them; this =
seems=20
to be abnormal.&nbsp; We have not used "sensors-detect"; it is a =
perlscript and=20
getting perl onto our embedded system would be quite ungainly.&nbsp;=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any help would be appreciated.&nbsp; =
Details, souce=20
code, and kernel config are below.<BR>Thanks,<BR>Patrick</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DETAILS:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The fail occurs at the beginning of the =
following=20
file/function:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
drivers/i2c/busses/i2c-i801.c:i801_transaction()<BR>&nbsp;&nbsp;&nbsp; =
Debug=20
information shows that all five registers have FF in them and that the =
SMBus is=20
busy:<BR>i801_smbus : Transaction (pre): CNT=3Dff, CMD=3Dff, ADD=3Dff, =
DAT0=3Dff,=20
DAT1=3Dff<BR>i801_smbus : SMBus busy (1f). Resetting...<BR>i801_smbus : =
Failed!=20
(1f)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><BR><FONT face=3DArial size=3D2>SOURCE CODE:<BR>&nbsp;&nbsp;=20
drivers/i2c/busses/i2c-i801.c:i801_transaction() ( lines 183-206 =
)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>static int=20
i801_transaction(void)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 int=20
temp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D=20
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int timeout =3D =
0;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
dev_dbg(&amp;I801_dev-&gt;dev, "Transaction (pre): CNT=3D%02x, =
CMD=3D%02x,=20
"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n",=20
inb_p(SMBHSTCNT),<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
inb_p(SMBHSTCMD), inb_p(SMBHSTADD),=20
inb_p(SMBHSTDAT0),<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
inb_p(SMBHSTDAT1));</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Make=20
sure the SMBus host is ready to start transmitting=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 0x1f =3D Failed, =
Bus_Err,=20
Dev_Err, Intr, Host_Busy =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=20
((temp =3D (0x1f &amp; inb_p(SMBHSTSTS))) !=3D 0x00)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
dev_dbg(&amp;I801_dev-&gt;dev, "SMBus busy (%02x).=20
Resetting...\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
temp);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
outb_p(temp,=20
SMBHSTSTS);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
if ((temp =3D (0x1f &amp; inb_p(SMBHSTSTS))) !=3D 0x00)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
dev_dbg(&amp;I801_dev-&gt;dev, "Failed! (%02x)\n",=20
temp);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
return=20
-1;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
} else=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
dev_dbg(&amp;I801_dev-&gt;dev,=20
"Successfull!\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp; ...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>KERNEL CONFIGURATION<SPAN=20
class=3D584313116-06062007>&nbsp; </SPAN>&nbsp;(using =
2.6.14.1)<BR>&nbsp;&nbsp;=20
Since we need to reduce the size of the kernel, we've tried to eliminate =
any=20
unnecessary drivers. We've followed the 2.6 Kernel Configuration =
instructions=20
at:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT><A=20
href=3D"http://www.lm-sensors.org/wiki/Kernel2.6"><FONT face=3DArial=20
size=3D2>http://www.lm-sensors.org/wiki/Kernel2.6</FONT></A><BR><FONT =
face=3DArial=20
size=3D2>&nbsp;&nbsp; ...with the following exceptions:<BR>&nbsp; * =
Under=20
I2C_support&gt;I2C_Algorithms : all 3 drivers are configured as built-in =
instead=20
of modules<BR>&nbsp; * Under I2C_support&gt;I2C_Hardware_Bus_Support : =
Intel=20
82801 is configured as "built-in" and the remaining 20 drivers are=20
excluded<BR>&nbsp; * Under I2C_support&gt;Misc_I2C_Chip_support : EEPROM =
reader=20
and the 3 Phillips drivers are included; remaining 4 drivers are=20
excluded.<BR>&nbsp; * Under Hardware Monitoring support:&nbsp; "Hardware =

Monitoring Support" is included as a module but all 27 drivers under it =
are=20
excluded<BR></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C7A859.4F482961--


--===============1754331083894410990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1754331083894410990==--
