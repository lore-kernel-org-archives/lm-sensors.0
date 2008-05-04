From: achim <achim@ag-web.biz>
Date: Sun, 04 May 2008 12:03:32 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209902612.3448.4.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-NptBgzUY8z8MHFI23G/g"
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
To: lm-sensors@vger.kernel.org


--=-NptBgzUY8z8MHFI23G/g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 04.05.2008, 13:42 +0200 schrieb achim:
> Am Sonntag, den 04.05.2008, 09:41 +0200 schrieb Jean Delvare:
> > Hi Achim,
> >=20
> > On Sun, 04 May 2008 01:24:19 +0200, Achim Gottinger wrote:
> > > I took a picture of the board and numbered the chips.
> > > http://www.abload.de/image.php?img=3Dimg_6532l9j.jpg
> > >=20
> > > Chip 1-2 are the two NIC chips. Chip three is interesting.
> > > It was hard to read but i found that chip ICS9LPRS477BKL
> > >=20
> > > I found that article later explaining that chip as an clock generat=
or.
> > > http://www.planet3dnow.de/vbulletin/showthread.php?t=3D330028&garpg=
=3D6
> > >=20
> > > Here are specs for a chip with an very similar number which is a cl=
ock=20
> > > generator chip.
> > > http://www.idt.com/?genID=3D9LPRS478
> >=20
> > There's also this one:
> > http://www.idt.com/?genID=3D9LPRS471
> >=20
> > Maybe you misread the last 1 as a 7?
> I misread nearly all characters in the first place ~0.5 mm text height
> is adveturous reading. Panet3dNow made a very clear picture of the chip
> I already posted a link to their webpage.
>=20
> 9LPRS471 and 9LPRS478 where clock generator chips for the 690G chipset.
> Googling for 9LPRS478 shows a link to the IDT page where you can
> download a datasheet. Fortunately I have such a board here.
>=20
> i2cdetect -l shows the PIIX4 adapter
> i2cdetect 0 shows there is someting at 0x50,0x51 and 0x69
> none of those adddresses can be dumped. I Tried each one after a cold
> start, because as you expected this was required on the sapphire board
> to get the dump work again.
>=20
> I also have an Gigabyte 780G board and an Asus M3A board (770 chipset)
> here.
> =EF=BB=BF
> The gigabyte has an 9LPRS477CKL chip and the M3A uses also the
> 9LPRS477BKL.=20
>=20
> 780G=20
> =EF=BB=BFi2cdetect -l shows the PIIX4 adapter
> i2cdetect 0 shows there is someting at 0x50,0x51,0x52,0x53, 0x38,0x69
>=20
> I attached the dumps of 0x38 and 0x69 to that mail.
>=20
M3A-770
=EF=BB=BF=EF=BB=BFi2cdetect -l shows the PIIX4 adapter
i2cdetect 0 shows there is someting at 0x52,0x53, 0x38,0x69

=EF=BB=BFI attached the dumps of 0x38 and 0x69 to that mail.

PS: Also added the dumps of the gbt board i forgott in the last mail.
I'll try to modify a few frequencies and compare the dumps of 0x38 and
0x69 now.

>=20
> >=20
> > Both chips have an SMBus interface so most certainly at least one of
> > the addresses of i2cdetect corresponds to this chip. We'd need a
> > datasheet but it doesn't seem to be available for download :(
> >=20
> > >=20
> > > Chip four is something like ICS 7714084.
> >=20
> > Couldn't find anything about this one.
> Same here but this chips is also very hard to read and the numbers migh=
t
> be similar looking characters like those i noted.
>=20
> BTW: Both DFI Lanparty boards have a feature in common "CPU Overheat
> Protection function monitors CPU temperature during system boot-up"
>=20
> Can be they use an separate chip for that, that is located below the
> chipset heatpipes.
>=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--=-NptBgzUY8z8MHFI23G/g
Content-Disposition: attachment; filename=i2cdump-gbt780g-0x38.txt
Content-Type: text/plain; name=i2cdump-gbt780g-0x38.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
10: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
20: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
30: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
40: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
50: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
60: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
70: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
80: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
90: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
a0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
b0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
c0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
d0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
e0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..
f0: 01 00 00 00 00 50 ac 14 81 b4 08 10 7c 04 00 00    ?....P??????|?..

--=-NptBgzUY8z8MHFI23G/g
Content-Disposition: attachment; filename=i2cdump-gbt780g-0x69.txt
Content-Type: text/plain; name=i2cdump-gbt780g-0x69.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20    X               
10: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20                    
20: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20                    
30: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20                    
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX 7f ff ef ef 10 d0 75 31 08 cf 20 a5 00 00 00    X?.????u1?? ?...
90: 7a 3a f2 3b 00 8d 71 00 3c 06 0a 58 86 4d 71 06    z:?;.?q.<??X?Mq?
a0: 0a 0a 0a 71 71 71 71 71 71 00 3c ee 00 c0 00 fe    ???qqqqqq.<?.?.?
b0: 00 40 06 df 06 df 66 ff 00 45 66 a6 00 71 58 3a    .@????f..Ef?.qX:
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

--=-NptBgzUY8z8MHFI23G/g
Content-Disposition: attachment; filename=i2cdump-M3A-0x38.txt
Content-Type: text/plain; name=i2cdump-M3A-0x38.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
10: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
20: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
30: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
40: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
50: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
60: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
70: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
80: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
90: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
a0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
b0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
c0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
d0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
e0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
f0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..

--=-NptBgzUY8z8MHFI23G/g
Content-Disposition: attachment; filename=i2cdump-M3A-0x69.txt
Content-Type: text/plain; name=i2cdump-M3A-0x69.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    X!!!!!!!!!!!!!!!
10: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
20: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
30: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX ff ff ef ef 0f 0f 75 21 07 ef 2b e5 00 00 40    X..????u!??+?..@
90: bf 5e 00 3c 01 d3 a5 00 3c 86 d3 a5 86 8d 71 06    ?^.<???.<?????q?
a0: 0f 0f 0f 71 71 71 71 71 71 00 3c 74 00 c0 00 fe    ???qqqqqq.<t.?.?
b0: 00 40 06 df 06 df 66 fa 00 53 66 a6 00 a5 a5 5e    .@????f?.Sf?.??^
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

--=-NptBgzUY8z8MHFI23G/g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-NptBgzUY8z8MHFI23G/g--

